#!/bin/sh

# Locations
SAXON_SOURCED_SH=$(realpath ${BASH_SOURCE})
SAXON_BSP_PATH=$(dirname $SAXON_SOURCED_SH)
SAXON_ROOT=$SAXON_BSP_PATH/"../../../.."
SAXON_SOC=$SAXON_ROOT/SaxonEFX_Soc
SAXON_BSP_COMMON_SCRIPTS=$SAXON_SOC/bsp/common/scripts

# Functionalities
source $SAXON_BSP_COMMON_SCRIPTS/base.sh
source $SAXON_BSP_COMMON_SCRIPTS/openocd.sh


saxon_patch(){
  cd $SAXON_ROOT/u-boot/arch/riscv/dts
  patch -f < $SAXON_BSP_PATH/diff/uboot_dts_Makefile.patch
}

saxon_netlist(){
  if [ -z ${SAXON_CPU_COUNT+x} ]; then echo "SAXON_CPU_COUNT need to be set"; return 1;  fi
  cd $SAXON_SOC
  sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
  --systemFrequency 66666666  \
  --onChipRamSize 0x2000  \
  --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12/1->13  \
  --uart name=system_uart_0_io,address=0x10000,interruptId=1  \
  --spi name=system_spi_0_io,address=0x14000,interruptId=4 \
  --customInstruction \
  --ramHex software/standalone/bootloader/build/bootloader.hex \
  --bsp bsp/efinix/trion_cacheless \
  --toplevelName trion_cacheless \
  --noAxiA --noDdrA --noLinux --noAtomic --noL1D --noL1I"
}
