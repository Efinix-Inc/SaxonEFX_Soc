ZEPHYR=../zephyr/zephyrSpinalHdl
SHELL=/bin/bash
NETLIST_DEPENDENCIES=$(shell find hardware/scala -type f)
.ONESHELL:
ROOT=$(shell pwd)
SIZELIMIT?=15931539456

formatsdcard:
	./formatsdcard.sh $(SIZELIMIT) $(SDCARD)

linux2sdcard:
	./linux2sdcard.sh $(SIZELIMIT) $(SDCARD)

.PHONY: software/bootloader
software/bootloader:
	source ${ZEPHYR}/zephyr-env.sh
	make -C software/bootloader all
