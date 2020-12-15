package saxon.board.efinix

import saxon.SpinalRtlConfig
import spinal.core._
import spinal.lib._
import spinal.lib.bus.bmb.{Bmb, BmbParameter, BmbSlaveFactory}
import spinal.lib.bus.bsb.{Bsb, BsbParameter}
import spinal.lib.graphic.{Rgb, RgbConfig}
import spinal.lib.graphic.vga.{BmbVgaCtrl, BmbVgaCtrlParameter, Vga, VgaCtrl}


case class EfxVideoCtrl(inputParameter : BsbParameter) extends Component{
  val rgbConfig = RgbConfig(8,8,8)
  val timingsWidth = 12

  val io = new Bundle{
    val input = slave(Bsb(inputParameter))
    val vga = master(Vga(rgbConfig))
  }

  val run = RegNext(True) init(False)

  val input = io.input.toStreamFragment(omitMask = true)
  val adapted = Stream(Fragment(Rgb(rgbConfig)))
  adapted.arbitrationFrom(input)
  adapted.last := input.last
  adapted.b := U(input.fragment( 16, 8 bits))
  adapted.g := U(input.fragment( 8, 8 bits))
  adapted.r := U(input.fragment( 0, 8 bits))

  val ctrl = VgaCtrl(rgbConfig, timingsWidth)
  ctrl.feedWith(adapted, resync = run.rise)
  io.input.ready setWhen(!run) //Flush
  ctrl.io.softReset := !run

  ctrl.io.vga <> io.vga
  ctrl.io.timings.setAs_h1920_v1080_r60
}

object EfxVideoCtrlGen extends App{
  SpinalRtlConfig.copy(
    defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
    inlineRom = false,
    globalPrefix = "video_ctrl_"
  ).generateVerilog(new EfxVideoCtrl(BsbParameter(4, 0, 0)).setDefinitionName("video_ctrl_top"))
}