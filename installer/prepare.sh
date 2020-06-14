# PSP-LLVM Installation on APT based linux.

#Install Rust
curl https://sh.rustup.rs -sSf | sh

rustup set profile complete
rustup toolchain install nightly
rustup default nightly && rustup component add rust-src
rustup update
cargo install cargo-psp

# Now let's install LLVM/Clang
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421 

# LLVM
sudo apt-get install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
# Clang and co
sudo apt-get install clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python-clang-10 clangd-10
# libfuzzer
sudo apt-get install libfuzzer-10-dev
# lldb
sudo apt-get install lldb-10
# lld (linker)
sudo apt-get install lld-10
# libc++
sudo apt-get install libc++-10-dev libc++abi-10-dev
# OpenMP
sudo apt-get install libomp-10-dev

#Cool, dependencies should have been installed.
