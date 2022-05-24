package saxon.board.efinix


import spinal.core._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4CC, Axi4Config, Axi4ReadOnlyArbiter, Axi4Shared, Axi4SharedArbiter, Axi4SharedCC, Axi4Upsizer, Axi4WriteOnlyArbiter}
import spinal.lib.bus.misc.{AddressMapping, SizeMapping}
import spinal.lib.com.i2c.I2cSlaveMemoryMappedGenerics
import spinal.lib.com.spi.ddr.SpiXdrMasterCtrl
import spinal.lib.com.uart.UartCtrlMemoryMappedConfig
import spinal.lib.generator._
import spinal.lib.io.Gpio
import spinal.lib._
import spinal.lib.bus.bmb
import spinal.lib.bus.bmb.{BmbAccessCapabilities, BmbAccessParameter, BmbCcFifo, BmbInterconnectGenerator, BmbParameter, BmbToAxi4SharedBridge}
import spinal.core.fiber._



case class TrionDdrGenerator(addressWidth : Int, dataWidth : Int, mapping: AddressMapping, withAxi4 : Boolean)(implicit interconnect: BmbInterconnectGenerator) extends Generator{
  val withAxi3 = !withAxi4
  val systemClockDomain = createDependency[ClockDomain]
  val memoryClockDomain = createDependency[ClockDomain]

  val ddrMasters = createDependency[Seq[DdrMasterSpec]]
  val ddrAConfig = createDependency[Axi4Config]



  val bmb = produce(ddrLogic.cc.io.input)

  val accessSource = Handle[BmbAccessCapabilities]
  val accessRequirements = createDependency[BmbAccessParameter]
  interconnect.addSlave(
    accessSource = accessSource,
    accessCapabilities = BmbAccessCapabilities(
      addressWidth  = addressWidth,
      dataWidth     = dataWidth,
      lengthWidthMax   = log2Up(dataWidth/8*256),
      alignment = BmbParameter.BurstAlignement.BYTE
    ),
    accessRequirements = accessRequirements,
    bus = bmb,
    mapping = mapping
  )


  val ddrLogic = add task new ClockingArea(memoryClockDomain){
    val io = new Bundle {
      val ddrA_axi3 = withAxi3 generate master(Axi4Shared(ddrAConfig)).setName("io_ddrA")
      val ddrA_axi4 = withAxi4 generate master(Axi4(ddrAConfig)).setName("io_ddrA")
      val ddrA_w_payload_id = withAxi3 generate (out UInt(ddrAConfig.idWidth bits)) //AXI3 requirement
    }

    val cc = BmbCcFifo(
      p =  accessRequirements.toBmbParameter(),
      cmdDepth = 64,
      rspDepth = 64,
      inputCd = systemClockDomain,
      outputCd = memoryClockDomain
    )

    val bmbToAxiBridge = BmbToAxi4SharedBridge(
      bmbConfig = accessRequirements.toBmbParameter(),
      pendingMax = 63,
      halfRateAw = false
    )
    bmbToAxiBridge.io.input << cc.io.output.pipelined(cmdValid = true, rspValid = true)


    val cpuAccess = Axi4Shared(bmbToAxiBridge.axiConfig)
    //Heavy pipelining
    bmbToAxiBridge.io.output.sharedCmd.s2mPipe().m2sPipe().m2sPipe() >> cpuAccess.sharedCmd
    bmbToAxiBridge.io.output.writeData.s2mPipe().m2sPipe().m2sPipe() >> cpuAccess.writeData
    bmbToAxiBridge.io.output.writeRsp  <-/< cpuAccess.writeRsp
    bmbToAxiBridge.io.output.readRsp   <-/< cpuAccess.readRsp

    //Arbiter used to connect cpuAccess and all user's masters
    val arbiterAxi3Shared = withAxi3 generate Axi4SharedArbiter(
      outputConfig = ddrAConfig,
      readInputsCount = 0,
      writeInputsCount = 0,
      sharedInputsCount = 1 + ddrMasters.length,
      routeBufferSize = 4,
      routeBufferLatency = 0,
      routeBufferS2mPipe = true,
      routeBufferM2sPipe = true
    )
    val arbiterAxi4Read = withAxi4 generate Axi4ReadOnlyArbiter(
      outputConfig = ddrAConfig,
      inputsCount = 1 + ddrMasters.length
    )
    val arbiterAxi4Write = withAxi4 generate Axi4WriteOnlyArbiter(
      outputConfig = ddrAConfig,
      inputsCount = 1 + ddrMasters.length,
      routeBufferSize = 4,
      routeBufferLatency = 0,
      routeBufferS2mPipe = true,
      routeBufferM2sPipe = true
    )

    if(withAxi3) {
      arbiterAxi3Shared.io.sharedInputs(0) << cpuAccess
    }
    if(withAxi4){
      val axi4 = cpuAccess.toAxi4()
      arbiterAxi4Read.io.inputs(0) << axi4.toReadOnly()
      arbiterAxi4Write.io.inputs(0) << axi4.toWriteOnly()
    }

    //Adapt the user AXI config into the DDR axi config : [upsize]
    val userAdapters = for((spec, i) <- ddrMasters.zipWithIndex) yield new Area{
      val userAxi3Shared = withAxi3 generate Axi4Shared(spec.axiConfig.copy(dataWidth = ddrAConfig.dataWidth))
      val userAxi4 = withAxi4 generate Axi4(spec.axiConfig.copy(dataWidth = ddrAConfig.dataWidth))

      val userAxi = slave(Axi4(spec.axiConfig)).setName(spec.name)
      val userClk = in.Bool().setName(spec.name + "_clk")
      val userReset = out.Bool().setName(spec.name + "_reset")
      val userCd = ClockDomain(userClk, userReset)

      userReset := userCd(BufferCC(memoryClockDomain.isResetActive))

      val bridge = Axi4CC(
        axiConfig = spec.axiConfig,
        inputCd = userCd,
        outputCd = ClockDomain.current,
        arFifoSize = 16,
        awFifoSize = 16,
        rFifoSize = 16,
        wFifoSize = 16,
        bFifoSize = 16
      )

      userCd {
        bridge.io.input.aw << userAxi.aw.s2mPipe().m2sPipe()
        bridge.io.input.ar << userAxi.ar.halfPipe()
        bridge.io.input.w << userAxi.w.s2mPipe().m2sPipe()
        bridge.io.input.r.m2sPipe() >> userAxi.r
        bridge.io.input.b.s2mPipe().m2sPipe() >> userAxi.b
      }

      val upsizer = if(spec.axiConfig.dataWidth < ddrAConfig.dataWidth) new Area {
        val logic = Axi4Upsizer(
          inputConfig = spec.axiConfig,
          outputConfig = spec.axiConfig.copy(dataWidth = ddrAConfig.dataWidth),
          readPendingQueueSize = 4
        )
        logic.io.input << bridge.io.output
        if(withAxi3) logic.io.output.toShared() >> userAxi3Shared
        if(withAxi4) logic.io.output >> userAxi4
      }
      if(spec.axiConfig.dataWidth == ddrAConfig.dataWidth){
        if(withAxi3) bridge.io.output.toShared() >> userAxi3Shared
        if(withAxi4) bridge.io.output >> userAxi4
      }

      val pipelineAxi3 = withAxi3 generate cloneOf(userAxi3Shared)
      val pipelineAxi4 = withAxi4 generate cloneOf(userAxi4)
      if(withAxi3) {
        pipelineAxi3.arw << userAxi3Shared.arw.halfPipe()
        pipelineAxi3.w <-/< userAxi3Shared.w
        pipelineAxi3.r >/-> userAxi3Shared.r
        pipelineAxi3.b.halfPipe() >> userAxi3Shared.b
        arbiterAxi3Shared.io.sharedInputs(i+1) << pipelineAxi3
      }
      if(withAxi4) {
        pipelineAxi4.ar << userAxi4.ar.halfPipe()
        pipelineAxi4.aw << userAxi4.aw.halfPipe()
        pipelineAxi4.w <-/< userAxi4.w
        pipelineAxi4.r >/-> userAxi4.r
        pipelineAxi4.b.halfPipe() >> userAxi4.b
        arbiterAxi4Read.io.inputs(i+1) << pipelineAxi4.toReadOnly()
        arbiterAxi4Write.io.inputs(i+1) << pipelineAxi4.toWriteOnly()
      }
    }

    val ddrAAxi3 = withAxi3 generate Axi4Shared(ddrAConfig)
    val ddrAAxi4 = withAxi4 generate Axi4(ddrAConfig)
    if(withAxi3) {
      ddrAAxi3.arw <-/< arbiterAxi3Shared.io.output.arw
      ddrAAxi3.w << arbiterAxi3Shared.io.output.w.stage()
      ddrAAxi3.r >> arbiterAxi3Shared.io.output.r
      ddrAAxi3.b >/-> arbiterAxi3Shared.io.output.b
    }
    if(withAxi4) {
      ddrAAxi4.aw <-/< arbiterAxi4Write.io.output.aw
      ddrAAxi4.ar <-/< arbiterAxi4Read.io.output.ar
      ddrAAxi4.w << arbiterAxi4Write.io.output.w.stage()
      ddrAAxi4.r >> arbiterAxi4Read.io.output.r
      ddrAAxi4.b >/-> arbiterAxi4Write.io.output.b
    }

    //Bridge adding the AXI3 WID and completting pending write transactions durring memory reset
    val ddrAResetCd = ClockDomain(
      clock = memoryClockDomain.clock,
      config = ClockDomainConfig(
        resetKind = BOOT //Bitstream reseted clockdomain
      )
    )
    val ddrAReset = new ClockingArea(ddrAResetCd) {
      val counter = Reg(UInt(5 bits)) init(0)
      val resetUnbuffered = False
      when(counter =/= U(counter.range -> true)){
        counter := counter + 1
        resetUnbuffered := True
      }

      val reset = RegNext(resetUnbuffered) init(True)
    }

    val ddrAToAxi3 = withAxi3 generate new ClockingArea(ClockDomain(memoryClockDomain.clock, ddrAReset.reset, config = ClockDomainConfig(resetKind = ASYNC))) {
      val ioArw, patchArw = cloneOf(ddrAAxi3.arw)

      //Token less fork to ensure wid stream is only pushed when a arw is pushed too
      ioArw.payload := ddrAAxi3.arw
      patchArw.payload := ddrAAxi3.arw
      ioArw.valid := ddrAAxi3.arw.fire
      patchArw.valid := ddrAAxi3.arw.fire
      ddrAAxi3.arw.ready := ioArw.ready && patchArw.ready

      //Generate the address to write context stream
      case class A2WPayload() extends Bundle {
        val id = ddrAAxi3.config.idType
        val len = ddrAAxi3.config.lenType
      }
      val a2wPayload = A2WPayload()
      a2wPayload.id := patchArw.id
      a2wPayload.len := patchArw.len
      val widStream = patchArw.translateWith(a2wPayload).throwWhen(!patchArw.write).queueLowLatency(size = 4, latency = 0).s2mPipe().m2sPipe()
      widStream.ready := ddrAAxi3.w.fire && ddrAAxi3.w.last

      //When a reset occure, fill pending write request with dummy write transaction to avoid dead locks
      val ddrA_wCounter = Reg(ddrAAxi3.config.lenType) init(0)
      when(ddrAAxi3.w.fire){
        ddrA_wCounter := ddrA_wCounter + 1
        when(ddrAAxi3.w.last){
          ddrA_wCounter := 0
        }
      }
      when((RegNext(memoryClockDomain.isResetActive) init(False)) && widStream.valid){
        ddrAAxi3.w.valid := True
        ddrAAxi3.w.last := widStream.len === ddrA_wCounter
      }

      //Generate write stream joining both ddrA.w and widStream
      case class WPayload() extends Bundle {
        val w = cloneOf(ddrAAxi3.w.payload)
        val id = cloneOf(widStream.payload.id)
      }
      val ddrA_wPayload = WPayload()
      ddrA_wPayload.w := ddrAAxi3.w.payload
      ddrA_wPayload.id := widStream.payload.id
      val ddrA_wStreamPipelied = withAxi3 generate (ddrAAxi3.w.translateWith(ddrA_wPayload).haltWhen(!widStream.valid).m2sPipe().s2mPipe().m2sPipe())

      //Pipelined connection to the DDR controller
      ioArw >/-> io.ddrA_axi3.arw
      ddrA_wStreamPipelied.translateWith(ddrA_wStreamPipelied.payload.w) >> io.ddrA_axi3.w
      ddrA_wStreamPipelied.id <> io.ddrA_w_payload_id
      ddrAAxi3.r <-< io.ddrA_axi3.r
      ddrAAxi3.b <-/< io.ddrA_axi3.b

      (List(io.ddrA_axi3.arw.valid) ++ io.ddrA_axi3.arw.payload.flatten).foreach(s => KeepAttribute(s.getDrivingReg))
      (List(ddrAAxi3.r.valid) ++ ddrAAxi3.r.payload.flatten).foreach(s => KeepAttribute(s.getDrivingReg))
    }

    val ddrAToAxi4 = withAxi4 generate new ClockingArea(ClockDomain(memoryClockDomain.clock, ddrAReset.reset, config = ClockDomainConfig(resetKind = ASYNC))) {
      val ioAw, patchAw = cloneOf(ddrAAxi4.aw)

      //Token less fork to ensure wid stream is only pushed when a arw is pushed too
      ioAw.payload := ddrAAxi4.aw
      patchAw.payload := ddrAAxi4.aw
      ioAw.valid := ddrAAxi4.aw.fire
      patchAw.valid := ddrAAxi4.aw.fire
      ddrAAxi4.aw.ready := ioAw.ready && patchAw.ready

      //Generate the address to write context stream
      case class A2WPayload() extends Bundle {
        val len = ddrAAxi4.config.lenType
      }
      val a2wPayload = A2WPayload()
      a2wPayload.len := patchAw.len
      val widStream = patchAw.translateWith(a2wPayload).queueLowLatency(size = 4, latency = 0).s2mPipe().m2sPipe()
      widStream.ready := ddrAAxi4.w.fire && ddrAAxi4.w.last

      //When a reset occure, fill pending write request with dummy write transaction to avoid dead locks
      val ddrA_wCounter = Reg(ddrAAxi4.config.lenType) init(0)
      when(ddrAAxi4.w.fire){
        ddrA_wCounter := ddrA_wCounter + 1
        when(ddrAAxi4.w.last){
          ddrA_wCounter := 0
        }
      }
      when((RegNext(memoryClockDomain.isResetActive) init(False)) && widStream.valid){
        ddrAAxi4.w.valid := True
        ddrAAxi4.w.last := widStream.len === ddrA_wCounter
      }

      //Pipelined connection to the DDR controller
      ioAw >/-> io.ddrA_axi4.aw
      ddrAAxi4.ar >/-> io.ddrA_axi4.ar
      ddrAAxi4.w >> io.ddrA_axi4.w
      ddrAAxi4.r <-< io.ddrA_axi4.r
      ddrAAxi4.b <-/< io.ddrA_axi4.b
    }
  }
}


