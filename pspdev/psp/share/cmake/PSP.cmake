#
# CMake toolchain file for PSP.
#
# Copyright 2019 - Wally
# Copyright 2020 - Daniel 'dbeef' Zalega

if (DEFINED PSPDEV)
    # Custom PSPDEV passed as cmake call argument.
else()
    # Determine PSP toolchain installation directory;
    # psp-config binary is guaranteed to be in path after successful installation:
    execute_process(COMMAND bash -c "psp-config --pspdev-path" OUTPUT_VARIABLE PSPDEV OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

# Assert that PSP SDK path is now defined:
if (NOT DEFINED PSPDEV)
    message(FATAL_ERROR "PSPDEV not defined. Make sure psp-config in your path or pass custom \
                        toolchain location via PSPDEV variable in cmake call.")
endif ()

# Set helper variables:
set(PSPSDK ${PSPDEV}/psp/sdk)
set(PSPBIN ${PSPDEV}/bin)
set(PSPCMAKE ${PSPDEV}/psp/share/cmake)

# Basic CMake Declarations
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_FIND_ROOT_PATH "${PSPSDK};${PSPDEV}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set paths to PSP-specific utilities:
set(MKSFO ${PSPBIN}/mksfo)
set(MKSFOEX ${PSPBIN}/mksfoex)
set(PACK_PBP ${PSPBIN}/pack-pbp)
set(FIXUP ${PSPBIN}/psp-fixup-imports)
set(ENC ${PSPBIN}/PrxEncrypter)
set(STRIP llvm-strip)
set(PRXGEN ${PSPBIN}/psp-prxgen)
# Include directories:
include_directories(${include_directories} ${PSPDEV}/include ${PSPSDK}/include)

# Discard debug information:
add_definitions("-G0")

# Set flags for building prx files for non-release builds
	set(CLANG_FLAGS "-target mips -mcpu=mips2 -msingle-float -mlittle-endian -std=c99 -std=c++11 -nostdinc++ -fno-exceptions -fno-rtti -fstrict-aliasing -funwind-tables")
	set(_DEBUG_FLAGS "-ggdb -specs=${PSPSDK}/lib/prxspecs -Wl,-q,-T${PSPSDK}/lib/linkfile.prx")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_DEBUG} ${_DEBUG_FLAGS}")
	set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS_DEBUG} ${_DEBUG_FLAGS}")

# Definitions that may be needed to use some libraries:
add_definitions("-D__PSP__")
add_definitions("-DHAVE_OPENGL")

# Aggregated list of all PSP-specific libraries for convenience.
set(PSP_LIBRARIES
        "-lg -lc -lpspdebug -lpspctrl -lpspsdk \
        -lpspnet -lpspnet_inet -lpspnet_apctl -lpspnet_resolver -lpspaudiolib \
        -lpsputility -lGL \
        -lpspvfpu -lpspdisplay -lpsphprm -lpspirkeyb \
        -lpsprtc -lpspaudio -lpspvram  -lpspgu -lpspge -lpspuser \
        -L${PSPSDK}/lib -L${PSPDEV}/lib"
)

# File defining macro outputting PSP-specific EBOOT.PBP out of passed executable target:
include("${PSPCMAKE}/CreatePBP.cmake")

# Helper variable for multi-platform projects to identify current platform:
set(PLATFORM_PSP TRUE BOOL)
