#!/bin/sh

# Locations
SAXON_SOURCED_SH=$(realpath ${BASH_SOURCE})
SAXON_BSP_PATH=$(dirname $SAXON_SOURCED_SH)
export SAXON_ROOT=$SAXON_BSP_PATH/"../../../.."
SAXON_SOC=$SAXON_ROOT/SaxonEFX_Soc
SAXON_BSP_COMMON_SCRIPTS=$SAXON_SOC/bsp/common/scripts

# Configurations
SAXON_BUILDROOT_DEFCONFIG=saxon_efinix_ti60_devkit_defconfig
LINUX_ADDRESS=0x00400000
SAXON_BUILDROOT_FULL_OOT_GIT="https://github.com/Dolu1990/buildroot-spinal-saxon.git --branch efx"

# Functionalities
source $SAXON_BSP_COMMON_SCRIPTS/base.sh
source $SAXON_BSP_COMMON_SCRIPTS/openocd.sh
source $SAXON_BSP_COMMON_SCRIPTS/buildroot_full.sh


saxon_patch(){
  cd $SAXON_ROOT/u-boot/arch/riscv/dts
  patch -f < $SAXON_BSP_PATH/diff/uboot_dts_Makefile.patch
}

saxon_netlist(){
  if [ -z ${SAXON_CPU_COUNT+x} ]; then echo "SAXON_CPU_COUNT need to be set"; return 1;  fi
  cd $SAXON_SOC
  sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
  --systemFrequency 100000000  \
  --ddrADataWidth 128  \
  --ddrASize 0x1FFF000  \
  --onChipRamSize 0x1000  \
  --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12/1->13  \
  --uart name=system_uart_0_io,address=0x10000,interruptId=1  \
  --spi name=system_spi_0_io,address=0x14000,interruptId=4  \
  --spi name=system_spi_1_io,address=0x15000,interruptId=5  \
  --ramHex software/standalone/bootloader/build/bootloader.hex  \
  --noAxiA \
  --customInstruction \
  --withFpu \
  --cpuCount=$SAXON_CPU_COUNT \
  --bsp=bsp/efinix/ti60_devkit"
}

