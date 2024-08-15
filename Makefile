# Compiler
CC = clang

# Platform-specific variables
ifeq ($(OS),Windows_NT)
    # Windows settings
    VCPKG_PATH = C:/Users/Owner/vcpkg/packages/raylib_x64-windows
    EXE_EXT = .exe
    DEL_CMD = del
    PATH_SEP = ;
    RUN_CMD = set PATH=$(VCPKG_PATH)/bin$(PATH_SEP)%PATH% && 
else
    # Unix-like settings (Linux, macOS)
    VCPKG_PATH = /usr/local/vcpkg/packages/raylib_x64-linux
    EXE_EXT =
    DEL_CMD = rm -f
    PATH_SEP = :
    RUN_CMD = LD_LIBRARY_PATH=$(VCPKG_PATH)/lib$(PATH_SEP)$$LD_LIBRARY_PATH 
endif

# Paths
RAYLIB_LIB = $(VCPKG_PATH)/lib/libraylib$(EXE_EXT)
RAYLIB_INCLUDE = $(VCPKG_PATH)/include

# Flags
CFLAGS = -I$(RAYLIB_INCLUDE) -O2
LDFLAGS = -L$(VCPKG_PATH)/lib -lraylib

# Source files
SRC_FILES = $(wildcard *.c)
# Default target is the first target found
TARGETS = $(patsubst %.c,%$(EXE_EXT),$(SRC_FILES))

# Build rules
all: $(TARGETS)

%$(EXE_EXT): %.c
	$(CC) $(CFLAGS) -o $@ $< $(RAYLIB_LIB) $(LDFLAGS)

run: $(TARGETS)
	$(RUN_CMD) $(if $(RUN),$(RUN)$(EXE_EXT),$(TARGETS))

clean:
	$(DEL_CMD) $(TARGETS)
