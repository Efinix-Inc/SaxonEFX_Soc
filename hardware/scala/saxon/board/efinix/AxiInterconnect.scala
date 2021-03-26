package saxon.board.efinix

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._

case class Axi4_2x32_1x256() extends Component{
  val inputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = 32,
    idWidth = 4
  )

  val outputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = 256,
    idWidth = 5
  )
  val io = new Bundle {
    val inputs = Vec(slave(Axi4(inputConfig)), 2)
    val output = master(Axi4Shared(outputConfig))
    val output_arw_id = out(UInt(outputConfig.idWidth bits))
  }
  
  val up = for(i <- io.inputs) yield new Area{
    val logic = Axi4Upsizer(
      inputConfig = inputConfig,
      outputConfig = inputConfig.copy(dataWidth = outputConfig.dataWidth),
      readPendingQueueSize = 64
    )
    logic.io.input << i
  }

  val arbiter = new Area{
    val readOnly = Axi4ReadOnlyArbiter(outputConfig, inputsCount = 2)
    val writeOnly = Axi4WriteOnlyArbiter(outputConfig, inputsCount = 2, routeBufferSize = 4)

    for(i <- 0 to 1){
      readOnly.io.inputs(i) << up(i).logic.io.output.toReadOnly()
      writeOnly.io.inputs(i) << up(i).logic.io.output.toWriteOnly()
    }
    val axi4 = Axi4(outputConfig)

    axi4.ar << readOnly.io.output.ar.halfPipe()
    axi4.r.m2sPipe().s2mPipe() >> readOnly.io.output.r

    axi4.aw << writeOnly.io.output.aw.halfPipe()
    axi4.w << writeOnly.io.output.w.m2sPipe().s2mPipe()
    axi4.b.halfPipe() >> writeOnly.io.output.b
  }

  val shared = Axi4ToAxi4Shared(arbiter.axi4)

  val toAxi3 = new Axi4SharedToAxi3Shared(shared.config)
  toAxi3.io.input << shared
  toAxi3.io.output >> io.output
  toAxi3.io.output_aw_id <> io.output_arw_id
}

object Axi4_2x32_1x256 {
  def main(args: Array[String]): Unit = {
    SpinalVerilog(Axi4_2x32_1x256())
  }
}

case class Axi4_2x256_1x256() extends Component{
  val inputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = 256,
    idWidth = 4
  )

  val outputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = 256,
    idWidth = 5
  )
  val io = new Bundle {
    val inputs = Vec(slave(Axi4(inputConfig)), 2)
    val output = master(Axi4(outputConfig))
  }


  val arbiter = new Area{
    val readOnly = Axi4ReadOnlyArbiter(outputConfig, inputsCount = 2)
    val writeOnly = Axi4WriteOnlyArbiter(outputConfig, inputsCount = 2, routeBufferSize = 4)

    for(i <- 0 to 1){
      val read = io.inputs(i).toReadOnly()
      val write = io.inputs(i).toWriteOnly()
      readOnly.io.inputs(i).ar <-/< read.ar
      readOnly.io.inputs(i).r >/-> read.r
      writeOnly.io.inputs(i).aw <-/< write.aw
      writeOnly.io.inputs(i).w <-/< write.w
      writeOnly.io.inputs(i).b >/-> write.b
    }

    io.output.ar <-/< readOnly.io.output.ar
    io.output.r >/-> readOnly.io.output.r
    io.output.aw <-/< writeOnly.io.output.aw
    io.output.w <-/< writeOnly.io.output.w
    io.output.b >/-> writeOnly.io.output.b
  }
}

object Axi4_2x256_1x256 {
  def main(args: Array[String]): Unit = {
    SpinalVerilog(Axi4_2x256_1x256())
  }
}

case class Axi4_2x_1x_shared(width : Int) extends Component{
  setDefinitionName(s"Axi4_2x${width}_1x${width}_shared")
  val inputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = width,
    idWidth = 4
  )

  val outputConfig = Axi4Config(
    addressWidth = 32,
    dataWidth = width,
    idWidth = 5
  )

  val io = new Bundle {
    val inputs = Vec(slave(Axi4(inputConfig)), 2)
    val output = master(Axi4Shared(outputConfig))
    val output_w_payload_id = out(UInt(outputConfig.idWidth bits))
  }


  val arbiter = new Area{
    val cfg = inputConfig.copy(idWidth = 5)
    val readOnly = Axi4ReadOnlyArbiter(cfg, inputsCount = 2)
    val writeOnly = Axi4WriteOnlyArbiter(cfg, inputsCount = 2, routeBufferSize = 4)

    for(i <- 0 to 1){
      val read = io.inputs(i).toReadOnly()
      val write = io.inputs(i).toWriteOnly()
      readOnly.io.inputs(i).ar <-/< read.ar
      readOnly.io.inputs(i).r >/-> read.r
      writeOnly.io.inputs(i).aw <-/< write.aw
      writeOnly.io.inputs(i).w <-/< write.w
      writeOnly.io.inputs(i).b >/-> write.b
    }
  }


  val axiNotShared = Axi4(arbiter.cfg)
  axiNotShared.ar <-/< arbiter.readOnly.io.output.ar
  axiNotShared.r >/-> arbiter.readOnly.io.output.r
  axiNotShared.aw <-/< arbiter.writeOnly.io.output.aw
  axiNotShared.w <-/< arbiter.writeOnly.io.output.w
  axiNotShared.b >/-> arbiter.writeOnly.io.output.b

  val axiShared = axiNotShared.toShared()
  val toAxi3Shared = new Area{
    val (arwFork, wFork) = StreamFork2(axiShared.arw)
    val wQueue = wFork.translateWith(wFork.id).takeWhen(wFork.write).queueLowLatency(4).pipelined(m2s = true, s2m = true)

    io.output.arw << arwFork
    io.output.w << axiShared.w.haltWhen(!wQueue.valid)
    io.output_w_payload_id := wQueue.payload

    wQueue.ready := axiShared.w.fire && axiShared.w.last

    axiShared.r << io.output.r
    axiShared.b << io.output.b
  }
//  val toAxi3Shared = new Area{
//    val (arwFork, rFork, bFork) = StreamFork3(axiShared.arw)
//    val rQueue = rFork.translateWith(rFork.id).takeWhen(!rFork.write).pipelined(m2s = true, s2m = true).queue(32).pipelined(m2s = true, s2m = true)
//    val bQueue = bFork.translateWith(bFork.id).takeWhen( bFork.write).pipelined(m2s = true, s2m = true).queue(32).pipelined(m2s = true, s2m = true)
//
//    io.output.arw << arwFork
//    io.output.w << axiShared.w
//    io.output.arw.id.removeAssignments() := 0
//
//    rQueue.ready := axiShared.r.fire && axiShared.r.last
//    bQueue.ready := axiShared.b.fire
//
//    axiShared.r << io.output.r.haltWhen(!rQueue.valid)
//    axiShared.b << io.output.b.haltWhen(!bQueue.valid)
//
//    axiShared.r.id.removeAssignments() := rQueue.payload
//    axiShared.b.id.removeAssignments() := bQueue.payload
//  }
}

object Axi4_2x_1x_shared {
  def main(args: Array[String]): Unit = {
    SpinalVerilog(Axi4_2x_1x_shared(256))
    SpinalVerilog(Axi4_2x_1x_shared(128))
  }
}
