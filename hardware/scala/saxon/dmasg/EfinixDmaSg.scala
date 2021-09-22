package saxon.dmasg

import java.io.FileInputStream
import java.util

import saxon.SpinalRtlConfig
import spinal.core._
import spinal.core.sim.SimConfig
import spinal.core.fiber._
import spinal.lib._
import spinal.lib.bus.amba3.apb
import spinal.lib.bus.amba3.apb.sim.Apb3Driver
import spinal.lib.bus.amba3.apb.{Apb3, Apb3CC, Apb3SlaveFactory}
import spinal.lib.bus.amba4.axi.sim.{Axi4ReadOnlySlaveAgent, Axi4WriteOnlyMonitor, Axi4WriteOnlySlaveAgent}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Arw, Axi4Config, Axi4ReadOnly, Axi4Shared, Axi4SpecRenamer, Axi4ToAxi4Shared, Axi4WriteOnly}
import spinal.lib.bus.bmb.{Bmb, BmbAccessCapabilities, BmbAccessParameter, BmbArbiter, BmbInterconnectGenerator, BmbSourceRemover, BmbToAxi4ReadOnlyBridge, BmbToAxi4WriteOnlyBridge, BmbWriteRetainer}
import spinal.lib.bus.bsb.{Bsb, BsbDownSizerSparse, BsbParameter, BsbUpSizerDense, BsbUpSizerSparse}
import spinal.lib.bus.misc.DefaultMapping
import spinal.lib.generator.Generator
import spinal.lib.sim.SparseMemory
import spinal.lib.system.dma.sg
import spinal.lib.system.dma.sg.DmaSg.{Channel, Parameter}
import spinal.lib.system.dma.sg.{DmaMemoryLayout, DmaSg, DmaSgTester, DmaSgTesterCtrl, SgDmaTestsParameter}

import scala.collection.mutable
import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}
import scala.util.Random
import scala.util.parsing.json.JSON


//case class EfinixSgDmaParameter(p : DmaSg.Parameter,
//                                )
class EfinixDmaSg(val p : DmaSg.Parameter,
                  ctrlCd : ClockDomain,
                  inputsCd : Seq[ClockDomain],
                  outputsCd : Seq[ClockDomain],
                  inputsFifoDepth : Seq[Int],
                  outputsFifoDepth : Seq[Int],
                  readDataWidth : Int,
                  writeDataWidth : Int,
                  val sharedAxi : Boolean,
                  val withReadQueue : Boolean,
                  val withWriteQueue : Boolean) extends Component{
  val readAxiConfig = Axi4Config(
    addressWidth = p.readAddressWidth,
    dataWidth    = readDataWidth,
    idWidth      = 0,
    useId        = true,
    useRegion    = true,
    useBurst     = true,
    useLock      = true,
    useCache     = true,
    useSize      = true,
    useQos       = true,
    useLen       = true,
    useLast      = true,
    useResp      = true,
    useProt      = true,
    useStrb      = true
  )


  val writeAxiConfig = Axi4Config(
    addressWidth = p.writeAddressWidth,
    dataWidth    = writeDataWidth,
    idWidth      = 0,
    useId        = true,
    useRegion    = true,
    useBurst     = true,
    useLock      = true,
    useCache     = true,
    useSize      = true,
    useQos       = true,
    useLen       = true,
    useLast      = true,
    useResp      = true,
    useProt      = true,
    useStrb      = true
  )

  val io = new Bundle {
    val ctrl = slave(apb.Apb3(14, 32))
    val ctrl_interrupts = out Bits(p.channels.size bits)
    val read = (p.canRead || p.canSgRead) generate master(Axi4ReadOnly(readAxiConfig))
    val write = (p.canWrite || p.canSgWrite) generate master(Axi4WriteOnly(writeAxiConfig))
    val axi = (sharedAxi) generate master(Axi4Shared(if(readAxiConfig != null)readAxiConfig else writeAxiConfig))
    val inputs = Vec(p.inputs.map(e => slave(Bsb(e))))
    val outputs = Vec(p.outputs.map(e => master(Bsb(e))))
  }

  if(sharedAxi){
    var read = io.read
    var write = io.write
    (io.read != null, io.write != null) match {
      case (true, false) => {
        io.read.setAsDirectionLess.allowDirectionLessIo
        write = Axi4WriteOnly(io.read.config)
        write.aw.valid := False
        write.aw.payload.assignDontCare()
        write.w.valid := False
        write.w.payload.assignDontCare()
        write.b.ready := True
      }
      case (false, true) => {
        io.write.setAsDirectionLess.allowDirectionLessIo
        read = Axi4ReadOnly(io.write.config)
        read.ar.valid := False
        read.ar.payload.assignDontCare()
        read.r.ready := True
      }
      case (true, true) => {
        io.read.setAsDirectionLess.allowDirectionLessIo
        io.write.setAsDirectionLess.allowDirectionLessIo
      }
      case _ =>
    }

    val axi4 = Axi4(read.config)
    axi4 << read
    axi4 << write

    io.axi << Axi4ToAxi4Shared(axi4)
    io.axi
  }

  val pAdapted = p.copy(
    outputs = p.outputs.map(output => output.copy(byteCount = Math.max(output.byteCount, p.memory.bankWidth/8))),
    inputs = p.inputs.map(input => input.copy(byteCount = Math.max(input.byteCount, p.memory.bankWidth/8)))
  )

  val core = new DmaSg.Core[Apb3](
    pAdapted,
    ctrlType = HardType(Apb3(14,32)),
    slaveFactory = Apb3SlaveFactory(_)
  )

  for((c, i) <- p.channels.zipWithIndex) if(c.linkedListCapable) {
    val ll = core.channels(i).ll
    val internal = core.rework(out(ll.descriptorUpdated && ll.gotDescriptorStall)).setName(s"ll_${i}_descriptorUpdate")
    out(CombInit(internal)).setName(s"io_${i}_descriptorUpdate")
  }

  val withoutCtrlCc = (ctrlCd == ClockDomain.current) generate new Area{
    core.io.ctrl << io.ctrl
    core.io.interrupts <> io.ctrl_interrupts
  }
  val withCtrlCc = (ctrlCd != ClockDomain.current) generate new Area{
    val apbCc = Apb3CC(core.io.ctrl.config, ctrlCd, ClockDomain.current)
    apbCc.io.input << io.ctrl
    apbCc.io.output >> core.io.ctrl
    io.ctrl_interrupts := ctrlCd(BufferCC(core.io.interrupts))
  }

  import spinal.lib.generator._
  val interconnect = new BmbInterconnectGenerator{
    val read = (p.canRead || p.canSgRead) generate new Area {
      val aggregatedSource = Handle[BmbAccessCapabilities]
      val aggregatedRequirements = Handle[BmbAccessParameter]
      val aggregated = aggregatedRequirements.derivate(Bmb(_))

      addSlave(
        accessSource = aggregatedSource,
        accessCapabilities = aggregatedSource,
        accessRequirements = aggregatedRequirements,
        bus = aggregated,
        mapping = DefaultMapping
      )


      if (p.canRead) {
        val bus = Handle.sync(core.io.read)
        addMaster(accessRequirements = bus.p.access, bus = bus)
        addConnection(bus, aggregated)
      }

      if (p.canSgRead) {
        val bus = Handle.sync(core.io.sgRead)
        addMaster(accessRequirements = bus.p.access, bus = bus)
        addConnection(bus, aggregated)
      }
    }

    val write = (p.canWrite || p.canSgWrite) generate new Area {
      val aggregatedSource = Handle[BmbAccessCapabilities]
      val aggregatedRequirements = Handle[BmbAccessParameter]
      val aggregated = aggregatedRequirements.derivate(Bmb(_))

      addSlave(
        accessSource = aggregatedSource,
        accessCapabilities = aggregatedSource,
        accessRequirements = aggregatedRequirements,
        bus = aggregated,
        mapping = DefaultMapping
      )


      if (p.canWrite) {
        val bus = Handle.sync(core.io.write)
        addMaster(accessRequirements = bus.p.access, bus = bus)
        addConnection(bus, aggregated)
        setPipelining(bus)(cmdValid = true, cmdReady = true)
      }

      if (p.canSgWrite) {
        val bus = Handle.sync(core.io.sgWrite)
        addMaster(accessRequirements = bus.p.access, bus = bus)
        addConnection(bus, aggregated)
      }
    }
  }




  val readLogic = (p.canRead || p.canSgRead) generate new Area{
    val resized = interconnect.read.aggregated.pipelined(cmdHalfRate = true).resize(readDataWidth)

    val sourceRemover = BmbSourceRemover(resized.p)
    sourceRemover.io.input << resized

    val bridge = BmbToAxi4ReadOnlyBridge(sourceRemover.io.output.p)
    bridge.io.input << sourceRemover.io.output

    val adapter = cloneOf(io.read)
    adapter << bridge.io.output

    io.read.ar << adapter.ar.halfPipe()

    val beforeQueue = io.read.r.s2mPipe().m2sPipe()
    (if(withReadQueue) beforeQueue.queue(256).s2mPipe().m2sPipe() else beforeQueue)   >> adapter.r
  }

  val writeLogic = (p.canWrite || p.canSgWrite) generate new Area{
    val resized = interconnect.write.aggregated.pipelined(cmdValid = true).resize(writeDataWidth)

    val sourceRemover = BmbSourceRemover(resized.p)
    sourceRemover.io.input << resized

    val retainer = withWriteQueue generate BmbWriteRetainer(sourceRemover.io.output.p, 256)
    if(withWriteQueue) retainer.io.input << sourceRemover.io.output

    val bridge = BmbToAxi4WriteOnlyBridge(sourceRemover.io.output.p)
    bridge.io.input << (if(withWriteQueue) retainer.io.output else sourceRemover.io.output)

    val adapter = cloneOf(io.write)
    adapter << bridge.io.output

    io.write.aw << adapter.aw.halfPipe()
    io.write.w <<  adapter.w.s2mPipe().m2sPipe()
    io.write.b.halfPipe() >>  adapter.b
  }



  val inputsAdapter = for(inputId <- 0 until p.inputs.size) yield new Area{
    var ptr = io.inputs(inputId)

    val upsizer = (p.memory.bankWidth/8 > p.inputs(inputId).byteCount) generate new ClockingArea(inputsCd(inputId)){
      val logic = new BsbUpSizerDense(ptr.p, outputBytes = p.memory.bankWidth/8)
      logic.io.input << ptr
      ptr = logic.io.output
    }

    val direct = (inputsCd(inputId) == ClockDomain.current) generate new Area {

    }

    val crossclock = (inputsCd(inputId) != ClockDomain.current) generate new Area {
      val fifo = StreamFifoCC(
        dataType = ptr.payloadType,
        depth = inputsFifoDepth(inputId),
        pushClock = inputsCd(inputId),
        popClock = ClockDomain.current
      )

      fifo.io.push << ptr
      ptr = fifo.io.pop
    }



    core.io.inputs(inputId) << ptr.s2mPipe().m2sPipe()
  }

  val outputsAdapter = for(outputId <- 0 until p.outputs.size) yield new Area{
    var ptr = core.io.outputs(outputId).s2mPipe().m2sPipe()

    val direct = (outputsCd(outputId) == ClockDomain.current) generate new Area {

    }

    val crossclock = (outputsCd(outputId) != ClockDomain.current) generate new Area {
      val fifo = StreamFifoCC(
        dataType = ptr.payloadType,
        depth = outputsFifoDepth(outputId),
        pushClock = ClockDomain.current,
        popClock = outputsCd(outputId)
      )

      fifo.io.push << ptr
      ptr = fifo.io.pop
    }

    val sparseDownsizer = (p.memory.bankWidth/8 > p.outputs(outputId).byteCount) generate new ClockingArea(outputsCd(outputId)){
      val logic = new BsbDownSizerSparse(ptr.p, outputBytes = p.outputs(outputId).byteCount)
      logic.io.input << ptr
      ptr = logic.io.output
    }

    io.outputs(outputId) << ptr
  }
}

object EfinixDmaSgGen extends App{
  if(args.size != 1){
    System.err.println("ERROR : Give the json configuration file as first arguement.")
    System.exit(2)
  }

  import org.yaml.snakeyaml.Yaml
  val yaml = new Yaml
  val inputStream = new FileInputStream(args(0))
  val feed = yaml.load(inputStream)

  implicit class Pimper(o : Object) {
    def apply(key : String) = {
      val m = o.asInstanceOf[java.util.LinkedHashMap[String,Object]]
      if(m.containsKey(key)){
        Some(m.get(key))
      } else {
        None
      }
    }
    def cast =  o.asInstanceOf[java.util.LinkedHashMap[String,Object]]
    def iterator =  (cast.keySet().toArray.map(_.asInstanceOf[String]), cast.values().toArray.map(_.asInstanceOf[Object])).zipped
    def get[T](key : String) : T = apply(key) match {
      case Some(v) => v.asInstanceOf[T]
      case None => ???
    }
    def getOrElse[T](key : String, default : => T) : T = apply(key) match {
      case Some(v) => v.asInstanceOf[T]
      case None => default
    }
  }

  case class InputModel(bsb : BsbParameter, id : Int, asynchronous : Boolean, queueSize : Int)
  val inputs = mutable.LinkedHashMap[String, InputModel]()

  feed("inputs") match {
    case Some(inputsDef) => for((name, p) <- inputsDef.iterator){
      inputs(name) = InputModel(
        bsb = new BsbParameter(
          byteCount   = p.get[Int]("data_width")/8,
          sourceWidth = p.get[Int]("tid_width"),
          sinkWidth   = p.get[Int]("tdest_width")
        ),
        id = inputs.size,
        asynchronous = p.getOrElse("asynchronous", false),
        queueSize   = p.getOrElse[Int]("queue_size", 16)
      )
    }
    case _ =>
  }

  case class OutputModel(bsb : BsbParameter, id : Int, asynchronous : Boolean, queueSize : Int)
  val outputs = mutable.LinkedHashMap[String, InputModel]()

  feed("outputs") match {
    case Some(inputsDef) => for((name, p) <- inputsDef.iterator){
      outputs(name) = InputModel(
        bsb = new BsbParameter(
          byteCount   = p.get[Int]("data_width")/8,
          sourceWidth = p.get[Int]("tid_width"),
          sinkWidth   = p.get[Int]("tdest_width")
        ),
        id = outputs.size,
        asynchronous = p.getOrElse("asynchronous", false),
        queueSize   = p.getOrElse[Int]("queue_size", 16)
      )
    }
    case _ =>
  }

  val channels =  mutable.LinkedHashMap[String, DmaSg.Channel]()
  feed("channels") match {
    case Some(inputsDef) => for((name, p) <- inputsDef.iterator){
      channels(name) = DmaSg.Channel(
        memoryToMemory = p.get[Boolean]("memory_to_memory"),
        inputsPorts    = p("inputs") match {
          case Some("all") => inputs.map(_._2.id).toSeq
          case Some(x : util.ArrayList[Object]) => {
            val strs = x.toArray.toSeq.map(_.asInstanceOf[String])
            inputs.filter(i => strs.contains(i._1)).map(_._2.id).toSeq
          }
          case None => Nil
        },
        outputsPorts   = p("outputs") match {
          case Some("all") => outputs.map(_._2.id).toSeq
          case Some(x : util.ArrayList[Object]) => {
            val strs = x.toArray.toSeq.map(_.asInstanceOf[String])
            outputs.filter(i => strs.contains(i._1)).map(_._2.id).toSeq
          }
          case None => Nil
        },
        linkedListCapable = p.getOrElse[Boolean]("linked_list_capable", false),
        directCtrlCapable = p.getOrElse[Boolean]("direct_ctrl_capable", false),
        selfRestartCapable = p.getOrElse[Boolean]("self_restart_capable", false),
        progressProbes =  p.getOrElse[Boolean]("progress_probe", false),
        halfCompletionInterrupt =  p.getOrElse[Boolean]("half_completion_interrupt", false),
        bytePerBurst = p("bytes_per_burst").map(_.asInstanceOf[Int]),
        fifoMapping = if(p("buffer_address").isEmpty) None else Some(p.get[Int]("buffer_address") -> p.get[Int]("buffer_size"))
      )
    }
    case _ =>
  }


  val read = feed.get[Object]("read")
  val write = feed.get[Object]("write")
  val layout = feed.get[Object]("buffer")
  val ctrl = feed.get[Object]("ctrl")
  val p = Parameter(
    readAddressWidth  = read.get[Int]("address_width"),
    readDataWidth     = read.get[Int]("data_width_internal"),
    readLengthWidth   = log2Up(256*read.get[Int]("data_width_internal")/8),
    writeAddressWidth = write.get[Int]("address_width"),
    writeDataWidth    = write.get[Int]("data_width_internal"),
    writeLengthWidth  = log2Up(256*write.get[Int]("data_width_internal")/8),
    sgAddressWidth = read.get[Int]("address_width"),
    sgReadDataWidth = read.get[Int]("data_width_internal"),
    sgWriteDataWidth = read.get[Int]("data_width_internal"),
    memory = DmaMemoryLayout(
      bankCount            = layout.get[Int]("bank_count"),
      bankWidth            = layout.get[Int]("bank_width"),
      bankWords            = layout.get[Int]("bank_words"),
      priorityWidth        = feed.getOrElse[Int]("priorityWidth", 2)
    ),
    outputs = outputs.map(_._2.bsb).toSeq,
    inputs = inputs.map(_._2.bsb).toSeq,
    channels = channels.values.toSeq,
    weightWidth = feed.getOrElse[Int]("weightWidth", 2),
    bytePerTransferWidth = 26
  )


  val topName = feed.get[String]("name")

  SpinalConfig(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
    privateNamespace = true
  ).generateVerilog(new EfinixDmaSg(
    p                 = p,
    ctrlCd            = if(ctrl.getOrElse("asynchronous", false)) ClockDomain.external("ctrl") else ClockDomain.current,
    inputsCd          = inputs.map{case (name, i) => if(i.asynchronous) ClockDomain.external(name) else ClockDomain.current}.toSeq,
    outputsCd         = outputs.map{case (name, i) => if(i.asynchronous) ClockDomain.external(name) else ClockDomain.current}.toSeq,
    inputsFifoDepth   = inputs.map{case (name, i) => i.queueSize}.toSeq,
    outputsFifoDepth  = outputs.map{case (name, o) => o.queueSize}.toSeq,
    readDataWidth = read.get[Int]("data_width_external"),
    writeDataWidth = write.get[Int]("data_width_external") ,
    sharedAxi = feed.getOrElse[Boolean]("efinix_ddr", false) ,
    withWriteQueue = feed.getOrElse[Boolean]("with_ddr_write_queue", true),
    withReadQueue = feed.getOrElse[Boolean]("with_ddr_read_queue", true)
  ){
    setDefinitionName(topName)
    for((i, name) <- (io.inputs, inputs.keys).zipped) i.setName(name)
    for((o, name) <- (io.outputs, outputs.keys).zipped) o.setName(name)
    noIoPrefix()
    if(p.canRead) Axi4SpecRenamer(io.read)
    if(p.canWrite) Axi4SpecRenamer(io.write)
    if(sharedAxi) Axi4SpecRenamer(io.axi)
    io.inputs.foreach(Axi4SpecRenamer(_))
    io.outputs.foreach(Axi4SpecRenamer(_))
  })
}

object EfinixDmaSgTester extends App{
  import spinal.core.sim._

  def test(name : String, p : DmaSg.Parameter) : Long = {
    var st = 0l
    println(s"*** Test $name ***")
//    if(name != "M2mM2sS2m") return 0
//    SimConfig.withCoverage.addSimulatorFlag("--coverage-underscore").compile(new EfinixDmaSg(
    SimConfig.compile(new EfinixDmaSg(
      p                 = p,
      inputsCd          = p.inputs.map(_ => ClockDomain.current),
      outputsCd         = p.outputs.map(_ => ClockDomain.current),
      inputsFifoDepth   =  p.inputs.map(_ => 16),
      outputsFifoDepth  =  p.outputs.map(_ => 16),
      readDataWidth     = p.readDataWidth*List(1,2).randomPick(),
      writeDataWidth    = p.writeDataWidth*List(1,2).randomPick(),
      ctrlCd = ClockDomain.current,
      sharedAxi = false,
      withReadQueue = Random.nextBoolean(),
      withWriteQueue = Random.nextBoolean()
    ){core.io.interrupts.simPublic()}).doSim(seed=42){ dut =>
      dut.clockDomain.forkStimulus(10)
      dut.clockDomain.forkSimSpeedPrinter(2.0)


      var lastTime = System.nanoTime()

      var writeNotificationHandle : (Long, Byte) => Unit = null

      val memory = new SparseMemory()

      if(p.canRead || p.canSgRead) new Axi4ReadOnlySlaveAgent(dut.io.read.ar, dut.io.read.r, dut.clockDomain){
        override def readByte(address: BigInt): Byte = memory.read(address.toLong)
      }
      if(p.canWrite || p.canSgWrite) {
        new Axi4WriteOnlySlaveAgent(dut.io.write.aw, dut.io.write.w, dut.io.write.b, dut.clockDomain)
        new Axi4WriteOnlyMonitor(dut.io.write.aw, dut.io.write.w, dut.io.write.b, dut.clockDomain) {
          override def onWriteByte(address: BigInt, data: Byte): Unit = {
            memory.write(address.toLong, data)
            writeNotificationHandle(address.toLong, data)
          }
        }
      }
      val ctrl = Apb3Driver(dut.io.ctrl, dut.clockDomain)

      val tester = new DmaSgTester(
        p            = p,
        clockDomain  = dut.clockDomain,
        inputsIo     = dut.io.inputs,
        outputsIo    = dut.io.outputs,
        interruptsIo = dut.io.ctrl_interrupts,
        memory       = memory,
        dut.core
      ) {
        override def ctrlWriteHal(data: BigInt, address: BigInt): Unit = ctrl.write(address, data)
        override def ctrlReadHal(address: BigInt): BigInt = ctrl.read(address)
        writeNotificationHandle = writeNotification
      }

      tester.waitCompletion()
      st = simTime()
    }
    st
  }

  Random.setSeed(51)
  val tests = mutable.Queue[(String, DmaSg.Parameter)]()

  for((name, p) <- SgDmaTestsParameter(allowSmallerStreams = true)) tests += name -> p
  for(i <- 0 until 400; name = "random_" + i; p = SgDmaTestsParameter.random()) tests += name -> p

  import scala.concurrent.ExecutionContext.Implicits.global

  val f = for((name, p) <- tests) yield Future{
    try {
      test(name, p)
    } catch {
      case e : Exception => {
        println(e.getStackTrace.mkString("\n"))
        println(s"*************")
        println(name)
        println(s"*************")
        System.exit(42)
        0
      }
    }
  }

  var timeSum = 0l
  val startAt = System.currentTimeMillis()
  for(e <- f) timeSum += Await.result(e, Duration.Inf)
  println(s"Simualted ${timeSum/10} cycles at ${(timeSum/10)/((System.currentTimeMillis() - startAt)*1e-3)/1e3} Khz")
}


object EfxPerfTester extends App{
  SimConfig.withFstWave.compile(new EfinixDmaSg(
    p = DmaSg.Parameter(
      readAddressWidth = 32,
      readDataWidth = 64,
      readLengthWidth = 8,
      writeAddressWidth = 32,
      writeDataWidth = 64,
      writeLengthWidth = 8,
      sgAddressWidth = 32,
      sgReadDataWidth = 64,
      sgWriteDataWidth = 64,
      memory = DmaMemoryLayout(
        bankCount = 2,
        bankWords = 1024,
        bankWidth = 64,
        priorityWidth = 2
      ),
//      memory = DmaMemoryLayout(
//        bankCount = 1,
//        bankWords = 1024,
//        bankWidth = 64,
//        priorityWidth = 2
//      ),
      outputs = List(
        BsbParameter(
          byteCount    = 8,
          sourceWidth = 4,
          sinkWidth   = 4
        ),
        BsbParameter(
          byteCount   = 4,
          sourceWidth = 4,
          sinkWidth   = 4
        )
      ),
      inputs =  List(
        BsbParameter(
          byteCount    = 8,
          sourceWidth = 4,
          sinkWidth   = 4
        ),
        BsbParameter(
          byteCount   = 4,
          sourceWidth = 4,
          sinkWidth   = 4
        )
      ),
      channels = List(
        Channel(
          memoryToMemory = true,
          inputsPorts = List(0,1),
          outputsPorts = List(0,1),
          linkedListCapable = true,
          directCtrlCapable = true,
          selfRestartCapable = true,
          progressProbes = true,
          halfCompletionInterrupt = true,
          bytePerBurst = Some(64),
          fifoMapping = Some(0x000, 0x400)
        ),

        Channel(
          memoryToMemory = true,
          inputsPorts = List(0,1),
          outputsPorts = List(0,1),
          linkedListCapable = true,
          directCtrlCapable = true,
          selfRestartCapable = true,
          progressProbes = true,
          halfCompletionInterrupt = true,
          bytePerBurst = Some(128),
          fifoMapping = Some(0x400, 0x400)
        ),


        Channel(
          memoryToMemory = true,
          inputsPorts = List(0,1),
          outputsPorts = List(0,1),
          linkedListCapable = true,
          directCtrlCapable = true,
          selfRestartCapable = true,
          progressProbes = true,
          halfCompletionInterrupt = true,
          bytePerBurst = Some(64),
          fifoMapping = Some(0x800, 0x400)
        )
      ),
      bytePerTransferWidth = 26,
      weightWidth = 2
    ),
    inputsCd          = List.fill(2)(ClockDomain.current),
    outputsCd         = List.fill(2)(ClockDomain.current),
    inputsFifoDepth   =  List.fill(2)(16),
    outputsFifoDepth  =  List.fill(2)(16),
    readDataWidth     = 256,
    writeDataWidth    = 256,
    ctrlCd = ClockDomain.current,
    sharedAxi = false,
    withReadQueue = true,
    withWriteQueue = true
  )).doSim(seed=42){dut =>
    val p = dut.p
    import spinal.core.sim._
    dut.clockDomain.forkStimulus(10)
    dut.clockDomain.forkSimSpeedPrinter(2.0)


    var lastTime = System.nanoTime()

    var writeNotificationHandle : (Long, Byte) => Unit = null

    val memory = new SparseMemory()

    if(p.canRead || p.canSgRead) new Axi4ReadOnlySlaveAgent(dut.io.read.ar, dut.io.read.r, dut.clockDomain){
      override def readByte(address: BigInt): Byte = memory.read(address.toLong)
      rDriver.transactionDelay = () => 0
      arDriver.factor = 2
    }
    if(p.canWrite || p.canSgWrite) {
      new Axi4WriteOnlySlaveAgent(dut.io.write.aw, dut.io.write.w, dut.io.write.b, dut.clockDomain){
        bDriver.transactionDelay = () => 0
        awDriver.factor = 2
        wDriver.factor = 2
      }
      new Axi4WriteOnlyMonitor(dut.io.write.aw, dut.io.write.w, dut.io.write.b, dut.clockDomain) {
        override def onWriteByte(address: BigInt, data: Byte): Unit = {
          memory.write(address.toLong, data)
        }
      }
    }
    val ctrl = Apb3Driver(dut.io.ctrl, dut.clockDomain)

    val tester = new DmaSgTesterCtrl(
      clockDomain  = dut.clockDomain
    ) {
      override def ctrlWriteHal(data: BigInt, address: BigInt): Unit = ctrl.write(address, data)
      override def ctrlReadHal(address: BigInt): BigInt = ctrl.read(address)


    }


    import tester._


    dut.io.outputs.foreach{s => s.ready #= true}
    dut.io.inputs.foreach{s =>
      s.valid #= true
      s.last #= false
      s.mask #= (1 << s.mask.getWidth) -1
      s.sink #= 1
    }

    val c0 = fork {
      channelPushMemory(0, 0x00000, 16)
      channelPopStream(0, 0, 0, 0, false)
      channelConfig(0, 0, 0x200, 1, 1)
      channelStart(0, bytes = 0x10000, false)
      channelWaitCompletion(0)
    }

    val c1 = fork {
//      channelPopMemory(1, 0x10000, 16)
//      channelPushStream(1, 0, 0, 0, false)
//      channelConfig(1, 0x200, 0x400, 2, 0)
//      channelStart(1, bytes = 0x10000, false)
//
//      dut.clockDomain.waitSampling(100)
//      dut.io.inputs.foreach{s => s.last #= true }
//      dut.clockDomain.waitSampling(1)
//      dut.io.inputs.foreach{s => s.last #= false }
//
//      channelWaitCompletion(1)
    }

    val c2 = fork {
      channelPushMemory(2, 0x20000, 16)
      channelPopStream(2, 1, 0, 0, false)
      channelConfig(2, 0, 0x200, 1, 2)
      channelStart(2, bytes = 0x10000, false)
      channelWaitCompletion(2)
    }

    c0.join()
    c1.join()
    c2.join()
    dut.clockDomain.waitSampling(1000)
  }

}
