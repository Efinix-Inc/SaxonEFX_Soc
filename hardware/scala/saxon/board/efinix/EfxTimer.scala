package saxon.board.efinix

import spinal.core._
import spinal.core.fiber.{Handle, Unset}
import spinal.lib.bus.bmb._
import spinal.lib.bus.misc.SizeMapping
import spinal.lib.generator.InterruptCtrlGeneratorI
import spinal.lib.io.{BmbGpio2, Gpio}
import spinal.lib.misc.{InterruptCtrl, Prescaler, Timer}
import spinal.lib.{BufferCC, slave}

case class EfxTimerParameter(width : Int)
case class EfxTimerCtrlParameter(timers : Seq[EfxTimerParameter],
                                 prescalerWidth : Int)
case class EfxTimerCtrl(p : EfxTimerCtrlParameter, bmbParameter : BmbParameter) extends Component {
  val io = new Bundle{
    val ctrl = slave(Bmb(bmbParameter))
    val interrupts = out Bits(p.timers.size bits)
  }

  val busCtrl = BmbSlaveFactory(io.ctrl)

  val prescaler = Prescaler(p.prescalerWidth)
  val prescalerBridge = prescaler.driveFrom(busCtrl,0x00)

  val timers = for((tp, idx) <- p.timers.zipWithIndex){
    val logic = new Timer(tp.width)
    val mapping = logic.driveFrom(busCtrl,0x40 + 0x10*idx)(
      ticks  = List(True, prescaler.io.overflow),
      clears = List(logic.io.full)
    )

    io.interrupts(idx) := logic.io.full
  }
}


case class  EfxTimerGenerator(ctrlOffset : Handle[BigInt] = Unset)
                            (implicit interconnect: BmbInterconnectGenerator, decoder : BmbImplicitPeripheralDecoder = null) extends Area{
  val parameter = Handle[EfxTimerCtrlParameter]
  val ctrl = Handle(logic.io.ctrl)

  val accessSource = Handle[BmbAccessCapabilities]
  val accessRequirements = Handle[BmbAccessParameter]
  val interrupts : Handle[List[Handle[Bool]]] = Handle(List.tabulate(parameter.timers.size)(i => logic.io.interrupts(i).setCompositeName(interrupts, i.toString)))
  val logic = Handle(EfxTimerCtrl(parameter, accessRequirements.toBmbParameter()))

  @dontName var interruptCtrl : InterruptCtrlGeneratorI = null
  var interruptOffsetId = 0
  def connectInterrupts(ctrl : InterruptCtrlGeneratorI, offsetId : Int): Unit = interrupts.produce{
    for(pinId <- 0 until parameter.timers.size) ctrl.addInterrupt(interrupts.get(pinId), offsetId + pinId)
    interruptCtrl = ctrl
    interruptOffsetId = offsetId
  }
  def connectInterrupt(ctrl : InterruptCtrlGeneratorI, pinId : Int, interruptId : Int): Unit = interrupts.produce{
    ctrl.addInterrupt(interrupts.get(pinId), interruptId)
  }

  interconnect.addSlave(
    accessSource = accessSource,
    accessCapabilities = accessSource.derivate(BmbGpio2.getBmbCapabilities),
    accessRequirements = accessRequirements,
    bus = ctrl,
    mapping = ctrlOffset.derivate(SizeMapping(_, 1 << 12))
  )
  if(decoder != null) interconnect.addConnection(decoder.bus, ctrl)
}


