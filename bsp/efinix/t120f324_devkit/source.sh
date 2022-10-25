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


saxon_netlist(){
  if [ -z ${SAXON_CPU_COUNT+x} ]; then echo "SAXON_CPU_COUNT need to be set"; return 1;  fi
  cd $SAXON_SOC
  sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
        --systemFrequency 66666666 \
        --onChipRamSize 0x2000 \
        --gpio name=system_gpio_0_io,address=0x00000,width=16,interrupts=0->12/1->13 \
        --uart name=system_uart_0_io,address=0x10000,interruptId=1 \
        --ramHex software/standalone/bootloader/build/bootloader_spinal_sim.hex \
        --bsp bsp/efinix/EfxRiscvBmbDdrSoc \
        --toplevelName t120f324_SoC  \
        --softJtag \
        --cpuCount=$SAXON_CPU_COUNT
}
