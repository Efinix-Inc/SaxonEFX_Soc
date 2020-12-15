package saxon.board.efinix

import saxon.Apb3DecoderGenerator
import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3, Apb3SlaveFactory}
import spinal.lib.generator._


class Apb3Pwm(width : Int) extends Component{
  val io = new Bundle {
    val apb = slave(Apb3(12, 32))
    val pwm = out Bool()
  }

  val counter = Reg(UInt(width bits)) init(0)
  counter := counter + 1

  val factory = Apb3SlaveFactory(io.apb)
  val trigger = factory.createWriteOnly(UInt(width bits), 0x00)

  io.pwm := trigger > counter
}


class Apb3PwmGenerator(address : BigInt) (implicit interconnect : Apb3DecoderGenerator) extends Generator {
  val width = this.createDependency[Int]
  val apb = this.produce(logic.io.apb)
  val pwm = this.produceIo(logic.io.pwm)
  val logic = add task new Apb3Pwm(width)
  interconnect.addSlave(apb, address)
}
