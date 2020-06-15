# PSP-LLVM Installation on APT based linux.

#Install Rust - No sudo required
curl https://sh.rustup.rs -sSf | sh

source $HOME/.cargo/env

rustup set profile complete
rustup toolchain install nightly
rustup default nightly && rustup component add rust-src
rustup update
cargo install cargo-psp

echo "Fetching Clang / LLVM from official repo -  https://apt.llvm.org/llvm.sh"
echo "Sudo access is required to continue"
sudo ./installer/prepare2.sh
