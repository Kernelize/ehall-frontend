HEADERPATH="bindings/swift/ehall_networkingFFI.h"
TARGETDIR="target"
OUTDIR="."
RELDIR="release"
NAME="ehall_networking"
STATIC_LIB_NAME="lib${NAME}.a"
DYNAMIC_LIB_NAME="lib${NAME}.dylib"
NEW_HEADER_DIR="bindings/include"

UNAME := $(shell uname -m)

all: build generate_ffi_bindings generate_xcframework

ifeq ($(UNAME), arm64)
build:
	cargo build --target aarch64-apple-ios --release
	cargo build --target aarch64-apple-ios-sim --release
	cargo build --target aarch64-apple-darwin --release
else ifeq ($(UNAME), x86_64)
build:
	cargo build --target aarch64-apple-ios --release
	cargo build --target x86_64-apple-ios --release
	cargo build --target x86_64-apple-darwin --release
endif


generate_ffi_bindings: build
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME} --language swift --out-dir bindings/swift
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${DYNAMIC_LIB_NAME} --language kotlin --out-dir bindings/kotlin
	cargo run -r --bin uniffi-bindgen generate --library ${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${DYNAMIC_LIB_NAME} --language python --out-dir bindings/python


ifeq ($(UNAME), arm64)
generate_xcframework: generate_ffi_bindings
	mkdir -p "${NEW_HEADER_DIR}"
	cp "${HEADERPATH}" "${NEW_HEADER_DIR}/"
	cp "bindings/swift/ehall_networkingFFI.modulemap" "${NEW_HEADER_DIR}/module.modulemap"
	xcodebuild -create-xcframework \
    -library "${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios-sim/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -output "${OUTDIR}/${NAME}_framework.xcframework"
else ifeq ($(UNAME), x86_64)
generate_xcframework: generate_ffi_bindings
	mkdir -p "${NEW_HEADER_DIR}"
	cp "${HEADERPATH}" "${NEW_HEADER_DIR}/"
	cp "bindings/swift/ehall_networkingFFI.modulemap" "${NEW_HEADER_DIR}/module.modulemap"
	xcodebuild -create-xcframework \
    -library "${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/x86_64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/x86_64-apple-darwin/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -output "${OUTDIR}/${NAME}_framework.xcframework"
endif


clean:
	cargo clean
	rm -rf bindings
	rm -rf "${OUTDIR}/${NAME}_framework.xcframework"
