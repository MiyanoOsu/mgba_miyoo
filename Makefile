SYSROOT = /usr/
INCLUDEDIR = $(SYSROOT)include
LIBDIR = $(SYSROOT)lib
BINDIR = /usr/bin/

COM = $(BINDIR)

CC = $(COM)gcc
LD = $(COM)g++

OBJS = src/version.o     \
     src/gba/core.o     \
     src/gba/sio/lockstep.o     \
     src/gba/sio/dolphin.o     \
     src/gba/sio/joybus.o     \
     src/gba/overrides.o     \
     src/gba/gba.o     \
     src/gba/cheats.o     \
     src/gba/matrix.o     \
     src/gba/hle-bios.o     \
     src/gba/cheats/parv3.o     \
     src/gba/cheats/gameshark.o     \
     src/gba/cheats/codebreaker.o     \
     src/gba/savedata.o     \
     src/gba/io.o     \
     src/gba/vfame.o     \
     src/gba/memory.o     \
     src/gba/sharkport.o     \
     src/gba/video.o     \
     src/gba/ereader.o     \
     src/gba/hardware.o     \
     src/gba/input.o     \
     src/gba/dma.o     \
     src/gba/renderers/common.o     \
     src/gba/renderers/software-obj.o     \
     src/gba/renderers/software-mode0.o     \
     src/gba/renderers/cache-set.o     \
     src/gba/renderers/software-bg.o     \
     src/gba/renderers/video-software.o     \
     src/gba/serialize.o     \
     src/gba/extra/battlechip.o     \
     src/gba/extra/proxy.o     \
     src/gba/extra/audio-mixer.o     \
     src/gba/audio.o     \
     src/gba/timer.o     \
     src/gba/bios.o     \
     src/gba/sio.o     \
     src/util/string.o     \
     src/util/patch.o     \
     src/util/patch-fast.o     \
     src/util/text-codec.o     \
     src/util/ring-fifo.o     \
     src/util/hash.o     \
     src/util/table.o     \
     src/util/formatting.o     \
     src/util/patch-ips.o     \
     src/util/vfs.o     \
     src/util/png-io.o     \
     src/util/crc32.o     \
     src/util/vfs/vfs-fifo.o     \
     src/util/vfs/vfs-fd.o     \
     src/util/vfs/vfs-mem.o     \
     src/util/vfs/vfs-dirent.o     \
     src/util/patch-ups.o     \
     src/util/gbk-table.o     \
     src/util/export.o     \
     src/util/circle-buffer.o     \
     src/util/configuration.o     \
     src/util/elf-read.o     \
     src/platform/posix/memory.o     \
     src/third-party/inih/ini.o     \
     src/third-party/blip_buf/blip_buf.o     \
     src/core/core.o     \
     src/core/config.o     \
     src/core/thread.o     \
     src/core/scripting.o     \
     src/core/bitmap-cache.o     \
     src/core/interface.o     \
     src/core/map-cache.o     \
     src/core/lockstep.o     \
     src/core/cheats.o     \
     src/core/directories.o     \
     src/core/sync.o     \
     src/core/log.o     \
     src/core/library.o     \
     src/core/cache-set.o     \
     src/core/input.o     \
     src/core/serialize.o     \
     src/core/timing.o     \
     src/core/rewind.o     \
     src/core/tile-cache.o     \
     src/core/mem-search.o     \
     src/arm/isa-arm.o     \
     src/arm/decoder.o     \
     src/arm/isa-thumb.o     \
     src/arm/arm.o     \
     src/arm/decoder-thumb.o     \
     src/arm/decoder-arm.o     \
     src/feature/video-logger.o     \
     src/feature/thread-proxy.o     \
     src/feature/commandline.o     \
     src/gb/audio.o     \
     src/platform/sdl/menu.o	\
     src/platform/sdl/main.o   \
     src/platform/sdl/sw-sdl1.o   \
     src/platform/sdl/sdl-events.o   \
     src/platform/sdl/sdl-audio.o

CFLAGS = -I$(INCLUDEDIR) -Iinclude -Isrc -O2 -std=c99 -flto -fomit-frame-pointer -DHAVE_STRTOF_L=1 -DHAVE_LOCALE=1	\
	 -I$(INCLUDEDIR)/pixman-1 -DCOLOR_16_BIT -DCOLOR_5_6_5 -DUSE_PNG=1 -DUSE_ZLIB=1 -DUSE_PIXMAN=1 -DM_CORE_GBA=1 	\
	 -DUSE_PTHREADS=1 -DHAVE_STRNDUP -DHAVE_STRDUP -I$(INCLUDEDIR)/SDL -D_GNU_SOURCE=1 -D_REENTRANT

LDFLAGS = -L$(LIBDIR) -flto -lz -static-libgcc -lgcc -lpng16 -lSDL_ttf -lpixman-1 -lpthread -Wl,-rpath,$(LIBDIR) -lSDL -lpthread

TARGET = bin/mgba.dge

#PROFILE = YES
PROFILE = APPLY

ifeq ($(PROFILE), YES)
CFLAGS += -fprofile-generate=./profile
LDFLAGS += -lgcov -fprofile-generate=./profile
TARGET = bin/mgba_pm
else ifeq ($(PROFILE), APPLY)
CFLAGS += -fprofile-use=./ -fbranch-probabilities
endif

all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p bin/
	@echo Linking $@...
	@$(LD) $(LDFLAGS) $(OBJS) -o $@
	@echo Done!!!

%.o: %.c
	@echo Compiling $<...
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)
