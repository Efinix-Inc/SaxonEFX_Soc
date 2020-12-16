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
    val output = master(Axi4(outputConfig))
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
    io.output << readOnly.io.output
    io.output << writeOnly.io.output
  }
}

object Axi4_2x32_1x256 {
  def main(args: Array[String]): Unit = {
    SpinalVerilog(Axi4_2x32_1x256())
  }
}