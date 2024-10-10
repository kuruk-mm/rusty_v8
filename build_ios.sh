#!/bin/bash
# Build all
CARGO_TOML="Cargo.toml"
VERSION=v$(grep -m1 "^version" "$CARGO_TOML" | cut -d'=' -f2 | tr -d ' "')

build() # usage build true aarch64-apple-ios
{
    USE_RELEASE=$1
    TARGET=$2
    TARGET_TYPE=$( [ "$USE_RELEASE" = true ] && echo "release" || echo "debug" )
    RELEASE_PARAM=$( [ "$USE_RELEASE" = true ] && echo "--release" )

    V8_FROM_SOURCE=true cargo build -vv ${RELEASE_PARAM} --target ${TARGET}
    gzip -9c target/${TARGET}/${TARGET_TYPE}/gn_out/obj/librusty_v8.a > ${OUTDIR}/librusty_v8_${TARGET_TYPE}_${TARGET}.a.gz
    cp target/${TARGET}/${TARGET_TYPE}/gn_out/src_binding.rs ${OUTDIR}/src_binding_${TARGET_TYPE}_${TARGET}.rs
}

export MACOSX_DEPLOYMENT_TARGET=14.0
export CODE_SIGN_IDENTITY="5CDE1493D592FE0C354FA514485904CF76C8221A"

OUTDIR=out/${VERSION}/
mkdir -p ${OUTDIR}

build true aarch64-apple-ios
#build true aarch64-apple-darwin

#V8_FROM_SOURCE=true cargo build -vv --target aarch64-apple-ios
#gzip -9c target/aarch64-apple-ios/debug/gn_out/obj/librusty_v8.a > ${OUTDIR}/librusty_v8_debug_aarch64-apple-ios.a.gz
#cp target/aarch64-apple-ios/debug/gn_out/src_binding.rs ${OUTDIR}/src_binding_debug_aarch64-apple-ios.rs

say Building finished. Building finished. Building finished. Building finished.