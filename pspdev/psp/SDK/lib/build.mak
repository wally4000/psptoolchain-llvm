# PSP Software Development Kit - https://github.com/pspdev
# -----------------------------------------------------------------------
# Licensed under the BSD license, see LICENSE in PSPSDK root for details.
#
# build.mak - Base makefile for projects using PSPSDK.
#
# Copyright (c) 2005 Marcus R. Brown <mrbrown@ocgnet.org>
# Copyright (c) 2005 James Forshaw <tyranid@gmail.com>
# Copyright (c) 2005 John Kelley <ps2dev@kelley.ca>
#

CC       = clang
CXX      = clang++
AS       = llvm-as
LD       = ld.lld-10
AR       = llvm-ar
RANLIB   = llvm-ranlib
STRIP    = llvm-strip --strip-debug
MKSFO    = mksfo
PACK_PBP = pack-pbp
PRXGEN   = psp-prxgen # Soon to be replaced with prxgen from cargo-psp
ENC		 = PrxEncrypter

# Add in PSPSDK includes and libraries.
LIBDIR   := $(LIBDIR) . $(PSPSDK_CLANG)/psp/SDK/lib $(PSPSDK_CLANG)/psp/lib 
INCDIR   := $(INCDIR) . $(PSPSDK_CLANG)/psp/SDK/include $(PSPSDK_CLANG)/psp/include

CFLAGS   := $(addprefix -I,$(INCDIR)) $(CFLAGS) -target mips -mcpu=mips2 -msingle-float -mlittle-endian -std=c11 -fstrict-aliasing -funwind-tables -g3 -ffreestanding
CXXFLAGS := $(CFLAGS) $(CXXFLAGS) -std=c++17 -nostdinc++
ASFLAGS  := $(CFLAGS) $(ASFLAGS)


ifeq ($(PSP_LARGE_MEMORY),1)
MKSFO = mksfoex -d MEMSIZE=1
endif

ifeq ($(PSP_FW_VERSION),)
PSP_FW_VERSION=371
endif

CFLAGS += -D_PSP_FW_VERSION=$(PSP_FW_VERSION)
CXXFLAGS += -D_PSP_FW_VERSION=$(PSP_FW_VERSION)

LDFLAGS  := $(addprefix -L,$(LIBDIR)) $(LDFLAGS)
LDFLAGS += -emit-relocs --eh-frame-hdr
LDFLAGS += --no-gc-sections

LIBS += -lpsp


# Define the overridable parameters for EBOOT.PBP
ifndef PSP_EBOOT_TITLE
PSP_EBOOT_TITLE = $(TARGET)
endif

ifndef PSP_EBOOT_SFO
PSP_EBOOT_SFO = PARAM.SFO
endif

ifndef PSP_EBOOT_ICON
PSP_EBOOT_ICON = NULL
endif

ifndef PSP_EBOOT_ICON1
PSP_EBOOT_ICON1 = NULL
endif

ifndef PSP_EBOOT_UNKPNG
PSP_EBOOT_UNKPNG = NULL
endif

ifndef PSP_EBOOT_PIC1
PSP_EBOOT_PIC1 = NULL
endif

ifndef PSP_EBOOT_SND0
PSP_EBOOT_SND0 = NULL
endif

ifndef PSP_EBOOT_PSAR
PSP_EBOOT_PSAR = NULL
endif

ifndef PSP_EBOOT
PSP_EBOOT = EBOOT.PBP
endif

ifeq ($(BUILD_PRX),1)
ifneq ($(TARGET_LIB),)
$(error TARGET_LIB should not be defined when building a prx)
else
FINAL_TARGET = $(TARGET).prx
endif
else
ifneq ($(TARGET_LIB),)
FINAL_TARGET = $(TARGET_LIB)
else
FINAL_TARGET = $(TARGET).elf
endif
endif

all: $(EXTRA_TARGETS) $(FINAL_TARGET)

kxploit: $(TARGET).elf $(PSP_EBOOT_SFO)
	mkdir -p "$(TARGET)"
	$(STRIP) $(TARGET).elf -o $(TARGET)/$(PSP_EBOOT)
	mkdir -p "$(TARGET)%"
	$(PACK_PBP) "$(TARGET)%/$(PSP_EBOOT)" $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0) NULL $(PSP_EBOOT_PSAR)

SCEkxploit: $(TARGET).elf $(PSP_EBOOT_SFO)
	mkdir -p "__SCE__$(TARGET)"
	$(STRIP) $(TARGET).elf -o __SCE__$(TARGET)/$(PSP_EBOOT)
	mkdir -p "%__SCE__$(TARGET)"
	$(PACK_PBP) "%__SCE__$(TARGET)/$(PSP_EBOOT)" $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0) NULL $(PSP_EBOOT_PSAR)

$(TARGET).elf: $(OBJS) $(EXPORT_OBJ)
	$(LD) $(LDFLAGS) -T $(PSPSDK_CLANG)/psp/SDK/lib/linkfile.ld -lm -lg -lc $(LIBS) -o $@ $^ $(PSPSDK_CLANG)/psp/SDK/lib/prxexports.o --allow-multiple-definition

$(TARGET_LIB): $(OBJS)
	$(AR) cru $@ $(OBJS)
	$(RANLIB) $@

$(PSP_EBOOT_SFO): 
	$(MKSFO) '$(PSP_EBOOT_TITLE)' $@

$(PSP_EBOOT): $(TARGET).prx $(PSP_EBOOT_SFO)
ifeq ($(ENCRYPT), 1)
	- $(ENC) $(TARGET).prx $(TARGET).prx
endif
	$(PACK_PBP) $(PSP_EBOOT) $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0)  $(TARGET).prx $(PSP_EBOOT_PSAR)

%.prx: %.elf
	cp $(TARGET).elf $(TARGET)_unstripped.elf
	$(STRIP) $(TARGET).elf
	psp-prxgen $< $@

%.c: %.exp
	psp-build-exports -b $< > $@

clean: 
	-rm -f $(FINAL_TARGET) $(EXTRA_CLEAN) $(OBJS) $(PSP_EBOOT_SFO) $(PSP_EBOOT) $(EXTRA_TARGETS)

rebuild: clean all
