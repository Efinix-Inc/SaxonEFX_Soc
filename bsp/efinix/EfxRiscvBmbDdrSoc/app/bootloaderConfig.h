#pragma once

#include "bsp.h"
#include "io.h"
#include "spiFlash.h"
#include "start.h"
#include "vgaInit.h"

#define SPI SYSTEM_SPI_0_IO_CTRL
#define SPI_CS 0

#define USER_SOFTWARE_MEMORY 0x00001000
#define USER_SOFTWARE_FLASH    0x380000
#define USER_SOFTWARE_SIZE	   0x01F000


void bspMain() {

#ifndef SPINAL_SIM
    vgaInit();
	spiFlash_init(SPI, SPI_CS);
	spiFlash_wake(SPI, SPI_CS);
	spiFlash_f2m(SPI, SPI_CS, USER_SOFTWARE_FLASH, USER_SOFTWARE_MEMORY, USER_SOFTWARE_SIZE);
#endif



    bsp_putString("Payload boot\n");
    void (*userMain)(u32, u32, u32) = (void (*)(u32, u32, u32))USER_SOFTWARE_MEMORY;
    #ifdef SMP
    smp_unlock(userMain);
    #endif
    userMain(0,0,0);
}
