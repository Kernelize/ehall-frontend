HEADERPATH="bindings/swift/ehall_networkingFFI.h"
TARGETDIR="target"
OUTDIR="."
RELDIR="release"
NAME="ehall_networking"
STATIC_LIB_NAME="lib${NAME}.a"
DYNAMIC_LIB_NAME="lib${NAME}.dylib"
NEW_HEADER_DIR="bindings/include"

all: build generate_ffi_bindings generate_xcframework

build:
	cargo build --target aarch64-apple-darwin --release
	cargo build --target aarch64-apple-ios --release
	cargo build --target aarch64-apple-ios-sim --release
	# cargo build --target x86_64-apple-ios --release
	# cargo build --target x86_64-apple-darwin --release


generate_ffi_bindings: build
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME} --language swift --out-dir bindings/swift
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${DYNAMIC_LIB_NAME} --language kotlin --out-dir bindings/kotlin
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${DYNAMIC_LIB_NAME} --language python --out-dir bindings/python

generate_xcframework: generate_ffi_bindings
	mkdir -p "${NEW_HEADER_DIR}"
	cp "${HEADERPATH}" "${NEW_HEADER_DIR}/"
	cp "bindings/swift/ehall_networkingFFI.modulemap" "${NEW_HEADER_DIR}/module.modulemap"
	xcodebuild -create-xcframework \
    -library "${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios-sim/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -output "${OUTDIR}/${NAME}_framework.xcframework"

clean:
	cargo clean
	rm -rf bindings
	rm -rf "${OUTDIR}/${NAME}_framework.xcframework"
