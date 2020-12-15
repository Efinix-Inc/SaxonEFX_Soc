## Generating the netlist

The strict minimum is :

```sh
sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc"
```

But for the hardware/synthesis/efx/EFX_Riscv_BMB_DDR_revB : 

```sh
sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
--dCacheSize 4096 \
--ddrADataWidth 128 \
--ddrASize 0xdffff000 \
--onChipRamSize 0x1000 \
--axiAAddress 0xe0000000 \
--axiASize 0x10000000 \
--apbSlave name=io_ddrMasters_0,address=0x800000,size=4096 \
--apbSlave name=io_ddrMasters_1,address=0x801000,size=4096 \
--uart name=system_uart_0_io,address=0x10000,interruptId=1 \
--spi name=system_spi_0_io,address=0x14000,interruptId=4 \
--i2c name=system_i2c_0_io,address=0x18000,interruptId=8 \
--i2c name=system_i2c_1_io,address=0x19000,interruptId=9 \
--gpio name=system_gpio_0_io,address=0x000000,width=8,interrupts=0->12;1->13 \
--ddrMaster name=io_ddrMasters_0,dataWidth=32 \
--ddrMaster name=io_ddrMasters_1,dataWidth=32 \
--interrupt name=userInterruptA,id=25  \
--linux \
"
```

## GDB server (OpenOCD)

You can use https://github.com/SpinalHDL/openocd_riscv to create a GDB server.

After compiling it accordingly to the openocd_riscv readme, you can use it the following ways :

```
cd openocd_riscv

# Connect to the simulation virtual jtag
src/openocd -f tcl/interface/jtag_tcp.cfg -c 'set MURAX_CPU0_YAML THIS_REPOSITORY_FOLDER/cpu0.yaml' -f tcl/target/murax.cfg

# Connect to the physical target using the FPGA jtag
sudo openocd -f bsp/efinix/EfxRiscvBmbDdrSoc/openocd/ftdi.cfg  -c 'set CPU0_YAML cpu0.yaml' -f bsp/efinix/EfxRiscvBmbDdrSoc/openocd/debug.cfg 
```

The expected result is :

```
Open On-Chip Debugger 0.10.0+dev-01202-gced8dcd (2019-04-06-20:46)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : only one transport option; autoselect 'jtag'
../../efinity/Soc1/cpu0.yaml
adapter speed: 800 kHz
adapter_nsrst_delay: 260
jtag_ntrst_delay: 250
Info : set servers polling period to 50ms
Info : clock speed 800 kHz
Info : JTAG tap: fpga_spinal.bridge tap/device found: 0x10001fff (mfg: 0x7ff (<invalid>), part: 0x0001, ver: 0x1)
Info : Listening on port 3333 for gdb connections
requesting target halt and executing a soft reset
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
```

Then you can use eclipse to load and debug the target's software.

## Eclipse debugging

See the related instructions in ext/VexRiscv/README.md to download, install and setup eclipse.

## Software demo

There is multiple software demo in software/standalone. To build them you can use make and the RISC-V GCC. See the ext/VexRiscv/README.md for informations about the RISC-V GCC instalation.

Once GCC RISC-V installed, you can build each software demo using :

```
make BSP_PATH=PATH_TO_THE_BOARD_SUPPORT_PACKAGE
```


Alternatively you can do

```
make BSP=PATH_RELATIVE_TO_THE_SOFTWARE_BSP_FOLDER

For example :
make BSP=efinix/EfxRiscvBmbDdrSoc
```

## Flashing software via openocd

```
Terminal 1 => run openocd
cd OPENOCD_PATH
src/openocd -f tcl/interface/YOUR_JTAG_INTERFACE.cfg -c 'set MURAX_CPU0_YAML THIS_REPO/cpu0.yaml' -f  THIS_REPO/bsp/efinix/EfxRiscvBmbDdrSoc/openocd/flash.cfg

Terminal 2 => run telenet and flash
cd PATH_TO_THIS_REPO
telnet localhost 4444
flash write_image erase unlock software/standalone/gpioDemo/build/gpioDemo.bin 0x380000
```

## Serial terminal

```
picocom -b 115200 /dev/ttyUSBx --imap lfcrlf
```