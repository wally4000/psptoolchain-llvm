# PSP-LLVM Installation on APT based linux.

#Install Rust
curl https://sh.rustup.rs -sSf | sh

source $HOME/.cargo/env

rustup set profile complete
rustup toolchain install nightly
rustup default nightly && rustup component add rust-src
rustup update
cargo install cargo-psp


sudo ./installer/prepare2.sh
