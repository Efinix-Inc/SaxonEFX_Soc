package saxon.board.efinix


import spinal.core._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4CC, Axi4Config, Axi4Shared, Axi4SharedArbiter, Axi4SharedCC, Axi4Upsizer}
import spinal.lib.bus.misc.{AddressMapping, SizeMapping}
import spinal.lib.com.i2c.I2cSlaveMemoryMappedGenerics
import spinal.lib.com.spi.ddr.SpiXdrMasterCtrl
import spinal.lib.com.uart.UartCtrlMemoryMappedConfig
import spinal.lib.generator._
import spinal.lib.io.Gpio
import spinal.lib._
import spinal.lib.bus.bmb
import spinal.lib.bus.bmb.{BmbParameter, BmbToAxi4SharedBridge}



case class TrionDdrGenerator(addressWidth : Int, dataWidth : Int, mapping: AddressMapping)(implicit interconnect: BmbInterconnectGenerator) extends Generator{

  val systemClockDomain = createDependency[ClockDomain]
  val memoryClockDomain = createDependency[ClockDomain]

  val ddrMasters = createDependency[Seq[DdrMasterSpec]]
  val ddrAConfig = createDependency[Axi4Config]


  val requirements = createDependency[BmbParameter]
  val bmb = produce(systemLogic.bmbToAxiBridge.io.input)

  interconnect.addSlave(
    capabilities = BmbParameter(
      addressWidth  = addressWidth,
      dataWidth     = dataWidth,
      lengthWidth   = log2Up(dataWidth/8*256),
      sourceWidth   = Int.MaxValue,
      contextWidth  = Int.MaxValue,
      canRead       = true,
      canWrite      = true,
      alignment = BmbParameter.BurstAlignement.BYTE,
      maximumPendingTransactionPerId = Int.MaxValue
    ),
    requirements = requirements,
    bus = bmb,
    mapping = mapping
  )

  val systemLogic = add task new ClockingArea(systemClockDomain){
    val bmbToAxiBridge = BmbToAxi4SharedBridge(
      bmbConfig = requirements,
      pendingMax = 7
    )
  }

  val ddrLogic = add task new ClockingArea(memoryClockDomain){
    val io = new Bundle {
      val ddrA = master(Axi4Shared(ddrAConfig))
      val ddrA_w_payload_id = out UInt(ddrAConfig.idWidth bits) //AXI3 requirement
    }

    val systemToMemoryBridge = Axi4SharedCC(
      axiConfig = Axi4Config(32, ddrAConfig.dataWidth, 2),
      inputCd = systemClockDomain ,
      outputCd = memoryClockDomain,
      arwFifoSize = 16,
      rFifoSize = 64,
      wFifoSize = 64,
      bFifoSize = 16
    )
    systemToMemoryBridge.io.input << systemLogic.bmbToAxiBridge.io.output

    val cpuAccess = Axi4Shared(systemToMemoryBridge.axiConfig)
    //Heavy pipelining
    systemToMemoryBridge.io.output.sharedCmd.s2mPipe().m2sPipe().m2sPipe() >> cpuAccess.sharedCmd
    systemToMemoryBridge.io.output.writeData.s2mPipe().m2sPipe().m2sPipe() >> cpuAccess.writeData
    systemToMemoryBridge.io.output.writeRsp  <-/< cpuAccess.writeRsp
    systemToMemoryBridge.io.output.readRsp   <-/< cpuAccess.readRsp

    //Arbiter used to connect cpuAccess and all user's masters
    val arbiter = Axi4SharedArbiter(
      outputConfig = ddrAConfig,
      readInputsCount = 0,
      writeInputsCount = 0,
      sharedInputsCount = 1 + ddrMasters.length,
      routeBufferSize = 4,
      routeBufferLatency = 0,
      routeBufferS2mPipe = true,
      routeBufferM2sPipe = true
    )

    arbiter.io.sharedInputs(0) << cpuAccess

    //Adapt the user AXI config into the DDR axi config : [upsize]
    val userAdapters = for((spec, i) <- ddrMasters.zipWithIndex) yield new Area{
      val userShared = Axi4Shared(spec.axiConfig.copy(dataWidth = ddrAConfig.dataWidth))

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
        bridge.io.input.aw << userAxi.aw.halfPipe()
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
        logic.io.output.toShared() >> userShared
      }
      if(spec.axiConfig.dataWidth == ddrAConfig.dataWidth){
        bridge.io.output.toShared() >> userShared
      }

      val pipeline = cloneOf(userShared)
      pipeline.arw << userShared.arw.halfPipe()
      pipeline.w <-/< userShared.w
      pipeline.r >/-> userShared.r
      pipeline.b.halfPipe() >> userShared.b

      arbiter.io.sharedInputs(i+1) << pipeline
    }

    val ddrA = Axi4Shared(ddrAConfig)
    ddrA.arw << arbiter.io.output.arw.halfPipe()
    ddrA.w << arbiter.io.output.w.stage()
    ddrA.r >> arbiter.io.output.r
    ddrA.b.halfPipe() >> arbiter.io.output.b

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
    val ddrAToAxi3 = new ClockingArea(ClockDomain(memoryClockDomain.clock, ddrAReset.reset, config = ClockDomainConfig(resetKind = ASYNC))) {
      val ioArw, patchArw = cloneOf(ddrA.arw)

      //Token less fork to ensure wid stream is only pushed when a arw is pushed too
      ioArw.payload := ddrA.arw
      patchArw.payload := ddrA.arw
      ioArw.valid := ddrA.arw.fire
      patchArw.valid := ddrA.arw.fire
      ddrA.arw.ready := ioArw.ready && patchArw.ready

      //Generate the address to write context stream
      case class A2WPayload() extends Bundle {
        val id = ddrA.config.idType
        val len = ddrA.config.lenType
      }
      val a2wPayload = A2WPayload()
      a2wPayload.id := patchArw.id
      a2wPayload.len := patchArw.len
      val widStream = patchArw.translateWith(a2wPayload).throwWhen(!patchArw.write).queueLowLatency(size = 4, latency = 0).s2mPipe().m2sPipe()
      widStream.ready := ddrA.w.fire && ddrA.w.last

      //When a reset occure, fill pending write request with dummy write transaction to avoid dead locks
      val ddrA_wCounter = Reg(ddrA.config.lenType) init(0)
      when(ddrA.w.fire){
        ddrA_wCounter := ddrA_wCounter + 1
        when(ddrA.w.last){
          ddrA_wCounter := 0
        }
      }
      when((RegNext(memoryClockDomain.isResetActive) init(False)) && widStream.valid){
        ddrA.w.valid := True
        ddrA.w.last := widStream.len === ddrA_wCounter
      }

      //Generate write stream joining both ddrA.w and widStream
      case class WPayload() extends Bundle {
        val w = cloneOf(ddrA.w.payload)
        val id = cloneOf(widStream.payload.id)
      }
      val ddrA_wPayload = WPayload()
      ddrA_wPayload.w := ddrA.w.payload
      ddrA_wPayload.id := widStream.payload.id
      val ddrA_wStreamPipelied = ddrA.w.translateWith(ddrA_wPayload).haltWhen(!widStream.valid).m2sPipe().s2mPipe().m2sPipe()

      //Pipelined connection to the DDR controller
      ioArw.halfPipe() >> io.ddrA.arw
      ddrA_wStreamPipelied.translateWith(ddrA_wStreamPipelied.payload.w) >> io.ddrA.w
      ddrA_wStreamPipelied.id <> io.ddrA_w_payload_id
      ddrA.r <-< io.ddrA.r
      ddrA.b << io.ddrA.b.halfPipe()

      (List(io.ddrA.arw.valid) ++ io.ddrA.arw.payload.flatten).foreach(s => KeepAttribute(s.getDrivingReg))
      (List(ddrA.r.valid) ++ ddrA.r.payload.flatten).foreach(s => KeepAttribute(s.getDrivingReg))
    }
  }
}


