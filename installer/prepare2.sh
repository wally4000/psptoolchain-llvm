# Now let's install LLVM/Clang
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# LLVM
apt-get -y install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
# Clang and co
apt-get -y install clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python-clang-10 clangd-10
# libfuzzer, lldb, lld (linker), libc++, OpenMP
apt-get -y install libfuzzer-10-dev lldb-10 lld-10 libc++-10-dev libc++abi-10-dev libomp-10-dev

echo "Dependencies have been installed!"

