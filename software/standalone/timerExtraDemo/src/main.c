#include <stdint.h>

#include "bsp.h"
#include "prescaler.h"
#include "timer.h"
#include "timerFromPlicDemo.h"
#include "riscv.h"
#include "plic.h"

#define TIMER_PRESCALER_CTRL (TIMER_CTRL + 0x00)
#define TIMER_0_CTRL (TIMER_CTRL + 0x40)
#define TIMER_1_CTRL (TIMER_CTRL + 0x50)
#define TIMER_CONFIG_WITH_PRESCALER 0x2
#define TIMER_CONFIG_WITHOUT_PRESCALER 0x1
#define TIMER_CONFIG_SELF_RESTART 0x10000

void init();
void main();
void trap();
void crash();
void trap_entry();
void timerInterrupt();
void externalInterrupt();
void initTimer();

#ifdef SPINAL_SIM
    #define TIMER_TICK_DELAY (BSP_CLINT_HZ/200) //Faster timer tick in simulation to avoid having to wait too long
#else
    #define TIMER_TICK_DELAY (BSP_CLINT_HZ)
#endif

void main() {
    init();

    bsp_putString("Hello world\n");
    while(1); //Idle
}


void init(){
    //configure timer
    initTimer();

    //configure PLIC
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); //cpu 0 accept all interrupts with priority above 0

    //enable Timer 0 interrupts
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_TIMER_INTERRUPTS_0, 1);
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_TIMER_INTERRUPTS_0, 1);

    //enable Timer 1 interrupts
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_TIMER_INTERRUPTS_1, 1);
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_TIMER_INTERRUPTS_1, 1);

    //enable interrupts
    csr_write(mtvec, trap_entry); //Set the machine trap vector (../common/trap.S)
    csr_set(mie, MIE_MTIE | MIE_MEIE); //Enable machine timer and external interrupts
    csr_write(mstatus, MSTATUS_MPP | MSTATUS_MIE);
}

uint64_t timerCmp; //Store the next interrupt time


void initTimer(){
    prescaler_setValue(TIMER_PRESCALER_CTRL, 99); //Divide clock rate by 99+1

    timer_setConfig(TIMER_0_CTRL, TIMER_CONFIG_WITH_PRESCALER | TIMER_CONFIG_SELF_RESTART);
    timer_setLimit(TIMER_0_CTRL, 999); // Will tick each (999+1)*(99+1) cycles (as it use the prescaler)

    timer_setConfig(TIMER_1_CTRL, TIMER_CONFIG_WITHOUT_PRESCALER);
    timer_setLimit(TIMER_1_CTRL, 299999); // Will tick each (299999+1)* cycles (as it directly use the clock to count)
}


//Called by trap_entry on both exceptions and interrupts events
void trap(){
    int32_t mcause = csr_read(mcause);
    int32_t interrupt = mcause < 0;    //Interrupt if true, exception if false
    int32_t cause     = mcause & 0xF;
    if(interrupt){
        switch(cause){
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
        default: crash(); break;
        }
    } else {
        crash();
    }
}


void externalInterrupt(){
    uint32_t claim;
    //While there is pending interrupts
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
        switch(claim){
        case SYSTEM_PLIC_TIMER_INTERRUPTS_0: bsp_putString("T0 !\n"); break;
        case SYSTEM_PLIC_TIMER_INTERRUPTS_1: {
            bsp_putString("T1 !\n");
            timer_clearValue(TIMER_1_CTRL); //That timer wasn't configured with self restart, so we do it in software. This will drift a bit as this introduce delays
        } break;
        default: crash(); break;
        }
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); //unmask the claimed interrupt
    }
}

//Used on unexpected trap/interrupt codes
void crash(){
    bsp_putString("\n*** CRASH ***\n");
    while(1);
}

