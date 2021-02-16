#include <stdint.h>
#include "plic.h"
#include "bsp.h"
#include "machineTimer.h"
#include "riscv.h"

void init();
void main();
void trap();
void crash();
void trap_entry();
void UartInterrupt();


#define UART_A_SAMPLE_PER_BAUD 8
#define CORE_HZ SYSTEM_MACHINE_TIMER_HZ

 u32 uart_status_read(void)
 {
	 return read_u32(BSP_UART_TERMINAL+UART_STATUS);
 }

void uart_status_write(char data)
{
	write_u32(data ,BSP_UART_TERMINAL+UART_STATUS);
}

void init(){
    	//UART init
    	Uart_Config uartA;
    	uartA.dataLength = BITS_8; //8 bits
    	uartA.parity = NONE;
    	uartA.stop = ONE;
    	uartA.clockDivider = CORE_HZ/(115200*UART_A_SAMPLE_PER_BAUD)-1;
    	uart_applyConfig(BSP_UART_TERMINAL, &uartA);

	// TX FIFO empty interrupt enable
	//uart_status_write(uart_status_read() | 0x01);	
	
	// RX FIFO not empty interrupt enable
    	uart_status_write(uart_status_read() | 0x02);	

	//configure PLIC
	plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); //cpu 0 accept all interrupts with priority above 0

	//enable SYSTEM_PLIC_USER_INTERRUPT_A_INTERRUPT rising edge interrupt
	plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_SYSTEM_UART_0_IO_INTERRUPT, 1);
	plic_set_priority(BSP_PLIC, SYSTEM_PLIC_SYSTEM_UART_0_IO_INTERRUPT, 1);

	//enable interrupts
	csr_write(mtvec, trap_entry); //Set the machine trap vector (../common/trap.S)
	csr_set(mie, MIE_MEIE); //Enable external interrupts
	csr_write(mstatus, MSTATUS_MPP | MSTATUS_MIE);
}

void main() {
	init();

	uart_writeStr(BSP_UART_TERMINAL, "Hello world\n\r");
	while(1){
        while(uart_readOccupancy(BSP_UART_TERMINAL)){
        	uart_write(BSP_UART_TERMINAL, uart_read(BSP_UART_TERMINAL));
		}
	}
}

//Called by trap_entry on both exceptions and interrupts events
void trap(){
	int32_t mcause = csr_read(mcause);
	int32_t interrupt = mcause < 0;    //Interrupt if set, exception if cleared
	int32_t cause     = mcause & 0xF;

	if(interrupt){
		switch(cause){
		case CAUSE_MACHINE_EXTERNAL: UartInterrupt(); break;
		default: crash(); break;
		}
	} else {
		crash();
	}
}

void UartInterrupt_Sub()
{
	if (uart_status_read() & 0x00000100){

		uart_writeStr(BSP_UART_TERMINAL, "TX FIFO empty interrupt\n\r");

		uart_status_write(uart_status_read() & 0xFFFFFFFE);	// TX FIFO empty interrupt Disable
		uart_status_write(uart_status_read() | 0x01); // TX FIFO empty interrupt enable

		//******Interrupt Function by User******//
	}
	else if (uart_status_read() & 0x00000200){

		uart_writeStr(BSP_UART_TERMINAL, "RX FIFO not empty interrupt\n\r");

		uart_status_write(uart_status_read() & 0xFFFFFFFD); 			// RX FIFO not empty interrupt Disable
		uart_write(BSP_UART_TERMINAL, uart_read(BSP_UART_TERMINAL));	//Dummy Read Clear FIFO
		uart_status_write(uart_status_read() | 0x02); 					// RX FIFO not empty interrupt enable

		//******Interrupt Function by User******//
	}
}

void UartInterrupt(){

uint32_t claim;
	//While there is pending interrupts
	while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
		switch(claim){
		case SYSTEM_PLIC_SYSTEM_UART_0_IO_INTERRUPT: UartInterrupt_Sub(); break;
		default: crash(); break;
		}
		plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); //unmask the claimed interrupt
	}
}


void crash(){
	uart_writeStr(BSP_UART_TERMINAL, "\n*** CRASH ***\n");
	while(1);
}

