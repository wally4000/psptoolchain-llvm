TARGET = Tutorial


PSPSDK=$(shell psp-config --pspsdk-path)

OBJS = main.o modulestart.o

INCDIR = ../include
CFLAGS = -G0 -Wall -O2
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)

LIBDIR = ../../lib
LDFLAGS = 
LIBS= -lpsp


EXTRA_TARGETS = EBOOT.PBP
PSP_EBOOT_TITLE = Tutorial1
PSP_FW_VERSION=500

PSP_LARGE_MEMORY = 0
BUILD_PRX = 1
NO_FIXUP_IMPORTS = 1

include ../../lib/build.mak