# psptoolchain-llvm

A modern approach to the PSPSDK Toolchain using LLVM / Clang which will enable easy access to C / C++ standards and updated tools.

# Why Clang / LLVM?
- Clang / LLVM are unmodified, no manual patching required.
- Super quick to compile / install (Dependant on internet connection but should be miles quicker than existing install)



# Installing

Installing is easy, just run "./installer/prepare.sh" 

Note: For installation of Clang / LLVM you will need to have sudo access. You will be prompted to insert password

# File Locations:

PSP Toolchain will be installed in $HOME/.pspdev

# Compiling:

## cmake
  `set (CMAKE_TOOLCHAIN_FILE $HOME/pspdev/psp/share/cmake/PSP.cmake)`
  Add the above to your cmakelists.txt file and it should do it's thing.

## Makefiles 

TBD.