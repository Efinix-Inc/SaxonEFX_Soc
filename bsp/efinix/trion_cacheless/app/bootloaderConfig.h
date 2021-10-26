#pragma once

#include "bsp.h"
#include "io.h"
#include "spiFlash.h"
#include "start.h"
#include "riscv.h"

#define SPI SYSTEM_SPI_0_IO_CTRL
#define SPI_CS 0

#define BOOTLOADER_SIZE 1024
#define RELOCATION_BASE SYSTEM_RAM_A_CTRL+SYSTEM_RAM_A_SIZE-BOOTLOADER_SIZE

#define APP_MEMORY SYSTEM_RAM_A_CTRL
#define APP_FLASH  0xF00000
#define APP_SIZE   SYSTEM_RAM_A_SIZE-BOOTLOADER_SIZE


void bspMain() {
    //Relocate the bootloader at the top of the memory
    if(*((u32*)APP_MEMORY)){
        bsp_putString("Relocation\n");
        u8 *src = (u8 *)SYSTEM_RAM_A_CTRL;
        u8 *dst = (u8 *)RELOCATION_BASE;
        for(s32 idx = 0;idx < BOOTLOADER_SIZE;idx++){
            *dst++ = *src++;
        }
        *((u32*)APP_MEMORY) = 0;

        void (*relocated)() = (void (*)())RELOCATION_BASE;
        relocated();
    }

#ifndef SPINAL_SIM
	spiFlash_init(SPI, SPI_CS);
	spiFlash_wake(SPI, SPI_CS);
    bsp_putString("App copy\n");
    spiFlash_f2m(SPI, SPI_CS, APP_FLASH, APP_MEMORY, APP_SIZE);
#endif

    bsp_putString("Payload boot\n");
    void (*userMain)(u32, u32, u32) = (void (*)(u32, u32, u32))APP_MEMORY;
    userMain(0,0,0);
}
