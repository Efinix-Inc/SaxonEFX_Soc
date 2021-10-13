#pragma once

#include "vgaInit.h"


void bspMain() {
    vgaInit();
    asm("ebreak");
}
