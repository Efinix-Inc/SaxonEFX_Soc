#!/bin/sh

# Locations
SAXON_SOURCED_SH=$(realpath ${BASH_SOURCE})
SAXON_BSP_PATH=$(dirname $SAXON_SOURCED_SH)
SAXON_ROOT=$SAXON_BSP_PATH/"../../../.."
SAXON_SOC=$SAXON_ROOT/SaxonEFX_Soc
SAXON_BSP_COMMON_SCRIPTS=$SAXON_SOC/bsp/common/scripts

# Configurations
SAXON_BUILDROOT_DEFCONFIG=saxon_efinix_ddr_soc_defconfig
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
  --systemFrequency 66666666  \
  --ddrADataWidth 128  \
  --ddrASize 0xf7fff000  \
  --onChipRamSize 0x1000  \
  --axiAAddress 0xfa000000  \
  --axiASize 0x1000  \
  --apbSlave name=io_apbSlave_0,address=0x800000,size=4096  \
  --apbSlave name=io_dma_ctrl,address=0x804000,size=16384  \
  --ddrMaster name=io_ddrMasters_0,dataWidth=32  \
  --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12/1->13  \
  --uart name=system_uart_0_io,address=0x10000,interruptId=1  \
  --uart name=system_uart_1_io,address=0x11000,interruptId=2  \
  --spi name=system_spi_0_io,address=0x14000,interruptId=4  \
  --spi name=system_spi_1_io,address=0x15000,interruptId=5  \
  --spi name=system_spi_2_io,address=0x16000,interruptId=6  \
  --i2c name=system_i2c_0_io,address=0x18000,interruptId=8  \
  --i2c name=system_i2c_1_io,address=0x19000,interruptId=9  \
  --i2c name=system_i2c_2_io,address=0x1A000,interruptId=10  \
  --interrupt name=userInterruptA,id=25  \
  --ramHex software/standalone/bootloader/build/bootloader.hex  \
  --cpuCount=$SAXON_CPU_COUNT  \
  --customInstruction"
}
