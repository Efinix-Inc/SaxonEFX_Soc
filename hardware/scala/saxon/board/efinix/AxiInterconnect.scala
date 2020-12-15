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

