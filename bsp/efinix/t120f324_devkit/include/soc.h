#ifndef SOC_H
#define SOC_H
#define SYSTEM_PLIC_SYSTEM_CORES_0_EXTERNAL_INTERRUPT 0
#define SYSTEM_PLIC_SYSTEM_CORES_0_EXTERNAL_SUPERVISOR_INTERRUPT 1
#define SYSTEM_PLIC_SYSTEM_UART_0_IO_INTERRUPT 1
#define SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_0 12
#define SYSTEM_PLIC_SYSTEM_GPIO_0_IO_INTERRUPTS_1 13
#define SYSTEM_CLINT_HZ 66666666
#define SYSTEM_RAM_A_SIZE 8192
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_DATA_WIDTH_MAX 8
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_CLOCK_DIVIDER_WIDTH 20
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_PRE_SAMPLING_SIZE 1
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_SAMPLING_SIZE 5
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_POST_SAMPLING_SIZE 2
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_CTS_GEN 0
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_RTS_GEN 0
#define SYSTEM_UART_0_IO_PARAMETER_UART_CTRL_CONFIG_RX_SAMPLE_PER_BIT 8
#define SYSTEM_UART_0_IO_PARAMETER_INIT_CONFIG_BAUDRATE 115200
#define SYSTEM_UART_0_IO_PARAMETER_INIT_CONFIG_DATA_LENGTH 7
#define SYSTEM_UART_0_IO_PARAMETER_INIT_CONFIG_PARITY NONE
#define SYSTEM_UART_0_IO_PARAMETER_INIT_CONFIG_STOP ONE
#define SYSTEM_UART_0_IO_PARAMETER_BUS_CAN_WRITE_CLOCK_DIVIDER_CONFIG 1
#define SYSTEM_UART_0_IO_PARAMETER_BUS_CAN_WRITE_FRAME_CONFIG 1
#define SYSTEM_UART_0_IO_PARAMETER_TX_FIFO_DEPTH 128
#define SYSTEM_UART_0_IO_PARAMETER_RX_FIFO_DEPTH 128
#define SYSTEM_CORES_0_CFU 0
#define SYSTEM_CORES_0_FPU 0
#define SYSTEM_CORES_0_MMU 1
#define SYSTEM_CORES_0_ICACHE_WAYS 2
#define SYSTEM_CORES_0_ICACHE_SIZE 8192
#define SYSTEM_CORES_0_BYTES_PER_LINE 64
#define SYSTEM_CORES_0_DCACHE_WAYS 2
#define SYSTEM_CORES_0_DCACHE_SIZE 8192
#define SYSTEM_CORES_0_BYTES_PER_LINE 64
#define SYSTEM_CORES_0_SUPERVISOR 1
#define SYSTEM_BRIDGE_BMB 0x0
#define SYSTEM_RAM_A_CTRL 0xf9000000
#define SYSTEM_RAM_A_CTRL_SIZE 0x2000
#define SYSTEM_BMB_PERIPHERAL_BMB 0xf8000000
#define SYSTEM_BMB_PERIPHERAL_BMB_SIZE 0x1000000
#define SYSTEM_PLIC_CTRL 0xf8c00000
#define SYSTEM_PLIC_CTRL_SIZE 0x400000
#define SYSTEM_CLINT_CTRL 0xf8b00000
#define SYSTEM_CLINT_CTRL_SIZE 0x10000
#define SYSTEM_UART_0_IO_CTRL 0xf8010000
#define SYSTEM_UART_0_IO_CTRL_SIZE 0x40
#define SYSTEM_GPIO_0_IO_CTRL 0xf8000000
#define SYSTEM_GPIO_0_IO_CTRL_SIZE 0x100
#define SYSTEM_DDR_BMB 0x1000
#define SYSTEM_DDR_BMB_SIZE 0xf7fff000
#endif