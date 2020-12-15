    .section .init
    .globl _start
    .type _start,@function

_start:

    nop
    nop
    li x1, 0x01020304
    li x2, 0xA0B0C0D0
    .word 0x06000033 | (3 << 7) | (1 << 15) | (2 << 20) //key = M"0000011----------000-----0110011",
    nop
    nop

done:
    j done
memA:
.word 0x10
memB:
.word 0x20
