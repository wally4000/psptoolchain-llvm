# psptoolchain-llvm
An LLVM-supported version of the PSPSDK Toolchain. Currently it relies on rust-psp in order to run and work, even though this can be used for C & C++.

# Install

In order to install LLVM & Dependencies, please run "./installer/prepare.sh" in order to install Rust & LLVM.

In order to install the PSP Toolchain, please run "./installer/install.sh" in order to copy and build to /usr/local/pspdev/include and /usr/local/pspdev/lib.

This will let you use the PSP Core SDK.