#  ehall-swift

This repo contains Official ehall app for iOS, iPadOS and macOS.
Minimun requirement is iOS 17.2 && macOS 14.2

This project is currently usable and is still under active developement.

To build your own ehallapp, see [ehall-backend](https://github.com/Kernelize/ehall-backend).

## Build
1. Install rust toolchain and targets for apple platform
```bash
rustup target add aarch64-apple-ios-sim
rustup target add aarch64-apple-ios
rustup target add aarch64-apple-darwin
```

2. Generate the .xcframework
do:
```bash
cd ehall-network
make all
```

3. Open the Ehall.xcodeproj in Xcode and build the app


Step 2 and 3 can be replaced by the following command:
```bash
./build.sh
```

