## Generating the netlist

For the hardware/synthesis/efx/ti60_devkit : 

```sh
  sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
  --systemFrequency 100000000  \
  --ddrADataWidth 128  \
  --ddrASize 0x1FFF000  \
  --onChipRamSize 0x1000  \
  --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12/1->13  \
  --uart name=system_uart_0_io,address=0x10000,interruptId=1  \
  --spi name=system_spi_0_io,address=0x14000,interruptId=4  \
  --spi name=system_spi_1_io,address=0x15000,interruptId=5  \
  --ramHex software/standalone/bootloader/build/bootloader.hex  \
  --noAxiA \
  --customInstruction \
  --withFpu \
  --cpuCount=1"
```

## Boot sequence

The boot sequence is done in 4 steps :

* bootloader : In the OnChipRam initialized by the FPGA bitstream
  * Initialise the HyperRAM
  * Copy the openSBI and the u-boot binary from the FPGA SPI flash to the HyperRAM
  * Jump to the openSBI binary in machine mode

* openSBI : In the HyperRAM
  * Initialise the machine mode CSR to support further supervisor SBI call and to emulate some missing CSR
  * Jump to the u-boot binary in supervisor mode

* u-boot : In the HyperRAM
  * Wait two seconds for user inputs
  * Read the linux uImage and dtb from the sdcard first partition
  * Boot linux

* Linux : in the HyperRAM
  * Kernel boot
  * Run Buildroot from the sdcard second partition

## Binary locations

OnChipRam:
- 0xF9000000 : bootloader (4 KB)

HyperRAM:
- 0x00400000 : Linux kernel
- 0x00001000 : opensbi
- 0x00100000 : u-boot

FPGA SPI flash:
- 0x000000   : FPGA bitstream
- 0xF00000   : opensbi
- 0xF40000   : u-boot

Sdcard :
- p1:uImage  : Linux kernel
- p1:dtb     : Linux device tree binary
- p2:*       : Buildroot

## Dependencies

```
# Java JDK 8 (higher is ok)
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk -y
sudo update-alternatives --config java
sudo update-alternatives --config javac

# SBT (Scala build tool)
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

# RISC-V toolchain
VERSION=8.3.0-1.2
mkdir -p ~/opt
cd ~/opt
wget https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/download/v$VERSION/xpack-riscv-none-embed-gcc-$VERSION-linux-x64.tar.gz
tar -xvf xpack-riscv-none-embed-gcc-$VERSION-linux-x64.tar.gz
rm xpack-riscv-none-embed-gcc-$VERSION-linux-x64.tar.gz
mv xpack-riscv-none-embed-gcc-$VERSION xpack-riscv-none-embed-gcc
echo 'export PATH=~/opt/xpack-riscv-none-embed-gcc/bin:$PATH' >> ~/.bashrc
export PATH=~/opt/xpack-riscv-none-embed-gcc/bin:$PATH

# Vivado in the path for synthesis
```

## Building everything

It will take quite a while to build, good luck and have fun <3

```
# Getting this repository
mkdir ti60_devkit_linux
cd ti60_devkit_linux
git clone https://github.com/Dolu1990/SaxonEFX_Soc.git -b dev-0.3 --recursive SaxonEFX_Soc

# Sourcing the build script
export SAXON_CPU_COUNT=1
source SaxonEFX_Soc/bsp/efinix/ti60_devkit/source.sh

# Clone opensbi, u-boot, linux, buildroot, openocd
saxon_clone

# Build the FPGA bitstream
saxon_standalone_compile bootloader
saxon_netlist
cp -f hardware/netlist/EfxRiscvBmbDdrSoc.v hardware/synthesis/efx/ti60_devkit/source
cp -f hardware/netlist/EfxRiscvBmbDdrSoc.v*.bin hardware/synthesis/efx/ti60_devkit
! run the hardware/synthesis/efx/ti60_devkit project and programe the board !

# Build the firmware
saxon_buildroot

# Build the programming tools
saxon_standalone_compile sdramInit
saxon_openocd
```

## Loading buildroot via jtag

```
export SAXON_CPU_COUNT=4
source SaxonEFX_Soc/bsp/efinix/EfxRiscvBmbDdrSoc/source.sh
saxon_buildroot_load
```


## Loading the FPGA and booting linux with ramfs using openocd

```
source SaxonEFX_Soc/bsp/efinix/EfxRiscvBmbDdrSoc/source.sh

# Boot linux using a ram file system (no sdcard), look at the saxon_buildroot_load end message
saxon_buildroot_load

# Connecting the USB serial port (assuming you don't have nother ttyUSB pluged)
picocom -b 115200 /dev/ttyUSB2 --imap lfcrlf
```

## Booting with a ramfs with a preloaded sdcard in uboot

```
load mmc 0:1 0x00400000 uImage;load mmc 0:1 0x00FF0000 dtb; load mmc 0:1 0x00FFFFC0 rootfs.cpio.uboot;bootm 0x00400000 0x00FFFFC0 0x00FF0000
```

## Test AES acceleration

```
nice --20 openssl speed -elapsed -evp aes-128-cbc aes-256-cbc
```

## Flash opensbi and uboot in the SPI flash

```
Terminal 1 => run openocd
source SaxonEFX_Soc/bsp/efinix/EfxRiscvBmbDdrSoc/source.sh
saxon_openocd_connect

Terminal 2 => run telenet and flash
source SaxonEFX_Soc/bsp/efinix/EfxRiscvBmbDdrSoc/source.sh
telnet localhost 4444
targets saxon.cpu0   
halt
flash write_image erase unlock $env(SAXON_ROOT)/buildroot-build/images/fw_jump.bin  0xC0F00000
flash write_image erase unlock $env(SAXON_ROOT)/buildroot-build/images/u-boot.bin   0xC0F40000
```

## Flash the sdcard

```
sudo dd if=$SAXON_ROOT/buildroot-build/images/sdcard.img of=/dev/sd???
```

## Boot from sdcard

```
load mmc 0:1 0x00400000 uImage;load mmc 0:1 0x00FF0000 linux.dtb;bootm 0x00400000 - 0x00FF0000
```

