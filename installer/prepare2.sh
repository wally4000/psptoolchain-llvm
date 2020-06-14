# Now let's install LLVM/Clang
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# LLVM
apt-get install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
# Clang and co
apt-get install clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 clang-format-10 python-clang-10 clangd-10
# libfuzzer
apt-get install libfuzzer-10-dev
# lldb
apt-get install lldb-10
# lld (linker)
apt-get install lld-10
# libc++
apt-get install libc++-10-dev libc++abi-10-dev
# OpenMP
apt-get install libomp-10-dev

#Cool, dependencies should have been installed.
echo "Dependencies have been installed!"
