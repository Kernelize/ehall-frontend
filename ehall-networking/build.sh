HEADERPATH="bindings/swift/ehall_networkingFFI.h"
TARGETDIR="target"
OUTDIR="."
RELDIR="release"
NAME="ehall_networking"
STATIC_LIB_NAME="lib${NAME}.a"
DYNAMIC_LIB_NAME="lib${NAME}.dylib"
NEW_HEADER_DIR="bindings/include"

cargo build --target aarch64-apple-darwin --release
cargo build --target aarch64-apple-ios --release
cargo build --target aarch64-apple-ios-sim --release

rm -rf bindings

cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME} --language swift --out-dir bindings/swift
cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${DYNAMIC_LIB_NAME} --language kotlin --out-dir bindings/kotlin
cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${DYNAMIC_LIB_NAME} --language python --out-dir bindings/python

mkdir -p "${NEW_HEADER_DIR}"
cp "${HEADERPATH}" "${NEW_HEADER_DIR}/"
cp "bindings/swift/ehall_networkingFFI.modulemap" "${NEW_HEADER_DIR}/module.modulemap"

rm -rf "${OUTDIR}/${NAME}_framework.xcframework"

xcodebuild -create-xcframework \
    -library "${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios-sim/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -output "${OUTDIR}/${NAME}_framework.xcframework"
