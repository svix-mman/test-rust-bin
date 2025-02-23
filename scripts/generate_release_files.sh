#!/usr/bin/env bash
BIN_NAME="test-rust-bin"
if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

set -eox pipefail

if [ "$(uname)" == "Darwin" ]; then
  TAR_BIN="gtar"
else
  TAR_BIN="tar"
fi



BIN_NAME="test-rust-bin"
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  BIN_FILE="$BIN_NAME.exe"
  else
  BIN_FILE="$BIN_NAME"
fi

TAR_FILE="target/distrib/$BIN_NAME-$1.tar.xz"
mkdir -p target/distrib

$TAR_BIN -czf \
    $TAR_FILE \
    README.md \
    LICENSE \
    --transform="s|target/$1/release/$BIN_FILE|$BIN_FILE|" \
    "target/$1/release/$BIN_FILE"

sha256sum $TAR_FILE > "$TAR_FILE.sha256"

