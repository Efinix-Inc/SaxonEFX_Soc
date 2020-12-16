package saxon.board.efinix

import saxon.{Apb3PlicGenerator, InterruptCtrl}
import spinal.core._
import spinal.lib.{BufferCC, slave}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Shared, Axi4SharedOnChipRam, Axi4SpecRenamer}
import spinal.lib.generator._

case class UserInterrupt(spec: InterruptSpec, ctrl : InterruptCtrl) extends Generator{
  val interrupt = produce(BufferCC(in.Bool().setName(spec.name)))
  ctrl.addInterrupt(interrupt, spec.id)
  setName(spec.name)
}



case class Axi4OnChipRam(dataWidth : Int, byteCount : BigInt, idWidth : Int, arwStage : Boolean = false) extends Component{
  val axiConfig = Axi4SharedOnChipRam.getAxiConfig(dataWidth,byteCount,idWidth)

  val io = new Bundle {
    val axi = slave(Axi4(axiConfig))
  }
  Axi4SpecRenamer(io.axi)

  val axi = io.axi.toShared()
  val wordCount = byteCount / axiConfig.bytePerWord
  val ram = Mem(axiConfig.dataType,wordCount.toInt)
  val wordRange = log2Up(wordCount) + log2Up(axiConfig.bytePerWord)-1 downto log2Up(axiConfig.bytePerWord)

  val arw = if(arwStage) axi.arw.s2mPipe().unburstify.m2sPipe() else axi.arw.unburstify
  val stage0 = arw.haltWhen(arw.write && !axi.writeData.valid)
  axi.readRsp.data := ram.readWriteSync(
    address = stage0.addr(axiConfig.wordRange).resized,
    data = axi.writeData.data,
    enable = stage0.fire,
    write = stage0.write,
    mask = axi.writeData.strb
  )
  axi.writeData.ready :=  arw.valid && arw.write  && stage0.ready

  val stage1 = stage0.stage
  stage1.ready := (axi.readRsp.ready && !stage1.write) || ((axi.writeRsp.ready || ! stage1.last) && stage1.write)

  axi.readRsp.valid  := stage1.valid && !stage1.write
  axi.readRsp.id  := stage1.id
  axi.readRsp.last := stage1.last
  axi.readRsp.setOKAY()
  if(axiConfig.useRUser) axi.readRsp.user  := stage1.user

  axi.writeRsp.valid := stage1.valid &&  stage1.write && stage1.last
  axi.writeRsp.setOKAY()
  axi.writeRsp.id := stage1.id
  if(axiConfig.useBUser) axi.writeRsp.user := stage1.user

  axi.arw.ready.noBackendCombMerge //Verilator perf
}

object Axi4SharedOnChipRamGen extends App{
  SpinalConfig(globalPrefix="top_debug_").generateVerilog(Axi4OnChipRam(dataWidth=32, byteCount=2048, idWidth = 8))
}