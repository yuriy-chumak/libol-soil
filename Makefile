.PHONY: all debug release check install uninstall clean

# default toolchain
CC ?= gcc
LD ?= ld

# compiler flags
CFLAGS_DEBUG   := -O0 -g2 -Wall
CFLAGS_RELEASE := -O2 -DNDEBUG
CFLAGS += -fPIC

LDFLAGS += -lGL

# 
all: release

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: libSOIL.so

release: CFLAGS += $(CFLAGS_RELEASE)
release: libSOIL.so

libSOIL.so: src/SOIL.c src/image_DXT.c src/image_helper.c src/stb_image_aug.c src/stb_image_write.c
	$(CC) -shared $(CFLAGS) -Iinclude $^ -o $@ $(LDFLAGS)


# 'make install/uninstall'
DESTDIR?=
PREFIX ?= /usr

clean:
	rm -f libSOIL.so

install: libSOIL.so
	# Install shared library into $(DESTDIR)$(PREFIX)/lib:
	@echo Installing main binary...
	install -d $(DESTDIR)$(PREFIX)/lib
	install -m 644 libSOIL.so $(DESTDIR)$(PREFIX)/lib/libSOIL.so.1
	ln -s $(DESTDIR)$(PREFIX)/lib/libSOIL.so.1 $(DESTDIR)$(PREFIX)/lib/libSOIL.so
	@echo Installing header...
	install -d $(DESTDIR)$(PREFIX)/include/SOIL
	install -m 644 include/SOIL.h $(DESTDIR)$(PREFIX)/include/SOIL/SOIL.h
	@echo -------------------------------------------------------------------
	@echo SOIL library installed. Enjoy!

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/lib/libSOIL.so
	rm -f $(DESTDIR)$(PREFIX)/lib/libSOIL.so.1
	rm -f $(DESTDIR)$(PREFIX)/include/SOIL/SOIL.h
	@echo -------------------------------------------------------------------
	@echo SOIL library uninstalled.

# -----------------------------------------------------------------------------------------------
# win32 build
soil.dll: CC:=x86_64-w64-mingw32-gcc
soil.dll: src/SOIL.c src/image_DXT.c src/image_helper.c src/stb_image_aug.c src/stb_image_write.c
	$(CC) -shared $(CFLAGS) -Iinclude $^ -o $@ -lopengl32
