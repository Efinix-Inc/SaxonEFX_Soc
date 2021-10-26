## Generating the netlist

For the hardware/synthesis/efx/T120F576_BB_cacheless : 

```sh
sbt "runMain saxon.board.efinix.EfxRiscvBmbDdrSoc \
  --systemFrequency 66666666  \
  --onChipRamSize 0x2000  \
  --gpio name=system_gpio_0_io,address=0x000000,width=16,interrupts=0->12/1->13  \
  --uart name=system_uart_0_io,address=0x10000,interruptId=1  \
  --spi name=system_spi_0_io,address=0x14000,interruptId=4 \
  --customInstruction \
  --ramHex software/standalone/bootloader/build/bootloader.hex \
  --bsp bsp/efinix/trion_cacheless \
  --toplevelName trion_cacheless \
  --noAxiA --noDdrA --noLinux --noAtomic --noL1D --noL1I"
"
```

If you add more ram, don't forget to recompile the bootloader (to adjust its relocation), and update the bsp linker/default.ld memory.

## Boot sequence

The boot sequence is done in 4 steps :

* bitstream + reset :
  * Initialise the on chip ram with the bootloader (at its base address).
  * Set the CPU PC to the base address of the on chip ram.

* bootloader : 
  * Copy itself to the last 1KB of the ram.
  * Reboot itself on that new location.
  * Copy the flash @ 0xF00000 to the base of the ram up to its end minus 1 KB.
  * Jump to to the base of the ram to boot the user app.
  
* User app


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
```


## Flash a user application

```
Terminal 1 => run openocd
source SaxonEFX_Soc/bsp/efinix/EfxRiscvBmbDdrSoc/source.sh
saxon_openocd_connect

Terminal 2 => run telenet and flash
telnet localhost 4444
targets saxon.cpu0   
halt
flash write_image erase unlock SaxonSoc/software/standalone/blinkAndEcho/build/blinkAndEcho.bin  0xF00000
```
