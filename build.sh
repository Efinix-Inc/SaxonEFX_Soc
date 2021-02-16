# Locations
BUILD_PATH=$PWD


build_netlist_Ruby(){

cd $BUILD_PATH

sbt "runMain saxon.board.efinix.EfxRubySoc \
--ramHex bootloader/bootloaderRuby.hex \
--systemFrequency 50000000 \
--dCacheSize 4096 \
--iCacheSize 4096 \
--ddrADataWidth 128 \
--ddrASize 0xf7fff000 \
--onChipRamSize 0x1000 \
--axiAAddress 0xfa000000 \
--axiASize 0x100000 \
--apbSlave name=io_apbSlave_0,address=0x800000,size=65536 \
--apbSlave name=io_apbSlave_1,address=0x810000,size=65536 \
--ddrMaster name=io_ddrMasters_0,dataWidth=32 \
--gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12;1->13 \
--uart name=system_uart_0_io,address=0x10000,interruptId=1 \
--uart name=system_uart_1_io,address=0x11000,interruptId=2 \
--spi name=system_spi_0_io,address=0x14000,interruptId=4 \
--spi name=system_spi_1_io,address=0x15000,interruptId=5 \
--spi name=system_spi_2_io,address=0x16000,interruptId=6 \
--i2c name=system_i2c_0_io,address=0x18000,interruptId=8 \
--i2c name=system_i2c_1_io,address=0x19000,interruptId=9 \
--i2c name=system_i2c_2_io,address=0x1A000,interruptId=10 \
--interrupt name=userInterruptA,id=25 \
--softTap false"
}

build_netlist_Opal(){

cd $BUILD_PATH

sbt "runMain saxon.board.efinix.EfxOpalSoc \
--ramHex bootloader/bootloaderOpal.hex \
--systemFrequency 50000000 \
--onChipRamSize 0x1000 \
--apbSlave name=io_apbSlave_0,address=0x800000,size=4096 \
--gpio name=system_gpio_0_io,address=0x000000,width=8,interrupts=0->12;1->13 \
--uart name=system_uart_0_io,address=0x10000,interruptId=1 \
--spi name=system_spi_0_io,address=0x14000,interruptId=4 \
--spi name=system_spi_1_io,address=0x15000,interruptId=5 \
--i2c name=system_i2c_0_io,address=0x18000,interruptId=8 \
--interrupt name=userInterruptA,id=25 \
--softTap false"
}

build_netlist_Opal_t8(){

cd $BUILD_PATH

sbt "runMain saxon.board.efinix.EfxOpalSoc_t8 \
--ramHex bootloader/bootloaderOpalT8.hex \
--systemFrequency 20000000 \
--onChipRamSize 0x1000 \
--apbSlave name=io_apbSlave_0,address=0x800000,size=4096 \
--gpio name=system_gpio_0_io,address=0x000000,width=8,interrupts=0->12;1->13 \
--uart name=system_uart_0_io,address=0x10000,interruptId=1 \
--spi name=system_spi_0_io,address=0x14000,interruptId=4 \
--spi name=system_spi_1_io,address=0x15000,interruptId=5 \
--i2c name=system_i2c_0_io,address=0x18000,interruptId=8 \
--interrupt name=userInterruptA,id=25 \
--softTap false"
}

build_netlist_Jade(){

cd $BUILD_PATH

sbt "runMain saxon.board.efinix.EfxJadeSoc \
--ramHex bootloader/bootloaderJade.hex \
--systemFrequency 50000000 \
--dCacheSize 4096 \
--iCacheSize 4096 \
--onChipRamSize 0x8000 \
--gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12;1->13 \
--apbSlave name=io_apbSlave_0,address=0x800000,size=4096 \
--uart name=system_uart_0_io,address=0x10000,interruptId=1 \
--spi name=system_spi_0_io,address=0x14000,interruptId=4 \
--spi name=system_spi_1_io,address=0x15000,interruptId=5 \
--i2c name=system_i2c_0_io,address=0x18000,interruptId=8 \
--i2c name=system_i2c_1_io,address=0x19000,interruptId=9 \
--interrupt name=userInterruptA,id=25 \
--softTap false
"
}
