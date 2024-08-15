# Compiler
CLANG = clang

# Platform-specific variables
ifeq ($(OS),Windows_NT)
    # Windows settings
    VCPKG_PATH = C:/Users/Owner/vcpkg/packages/raylib_x64-windows
    POSFIX = .exe
    DEL_CMD = del
    PATH_SEP = ;
    RUN_CMD = set PATH=$(VCPKG_PATH)/bin$(PATH_SEP)%PATH% && 
    RUN_SEP = &
    RUN_PREFIX =
else
    # Unix-like settings (Linux, macOS)
    VCPKG_PATH = /usr/local/vcpkg/packages/raylib_x64-linux
    POSFIX = .out
    DEL_CMD = rm -f
    PATH_SEP = :
    RUN_CMD = LD_LIBRARY_PATH=$(VCPKG_PATH)/lib$(PATH_SEP)$$LD_LIBRARY_PATH 
    RUN_SEP = ;
    RUN_PREFIX = ./  # Prefix for running executables
endif

# Paths
RAYLIB_LIB = $(VCPKG_PATH)/lib/raylib.lib
RAYLIB_INCLUDE = $(VCPKG_PATH)/include

# Flags
CFLAGS = -I$(RAYLIB_INCLUDE) -O2
LDFLAGS = -L$(VCPKG_PATH)/lib -lraylib



# Build rules
all: main$(POSFIX) test_compile.ll

%$(POSFIX): %.c
	$(CLANG) $(CFLAGS) -o $@ $< $(RAYLIB_LIB) $(LDFLAGS)

# run: $(TARGETS)
# 	$(RUN_CMD) $(foreach exe,$(TARGETS),$(RUN_PREFIX)$(exe) $(RUN_SEP) )

run: main$(POSFIX)
	$(RUN_CMD) $(RUN_PREFIX)main$(POSFIX)

# Build rule for test_compile
main$(POSFIX): main.ll
	$(CLANG) $(CFLAGS) -o main$(POSFIX) main.ll $(RAYLIB_LIB) $(LDFLAGS)

# Compile and run test_compile.c
test_compile: test_compile$(POSFIX)
	$(RUN_CMD) $(RUN_PREFIX)test_compile$(POSFIX)

# Build rule for test_compile
test_compile$(POSFIX): test_compile.c
	$(CLANG) $(CFLAGS) -o test_compile$(POSFIX) test_compile.c $(RAYLIB_LIB) $(LDFLAGS)

# Build rule for test_compile
test_compile.ll: test_compile.c
	$(CLANG) $(CFLAGS) test_compile.c $(RAYLIB_LIB) -S -emit-llvm

clean:
	$(DEL_CMD) test_compile.ll
	$(DEL_CMD) main$(POSFIX)
	$(DEL_CMD) test_compile$(POSFIX)

.PHONY: all clean run test_compile