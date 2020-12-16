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


saxon_serial(){
  picocom -b 115200 /dev/ttyUSB2 --imap lfcrlf
}