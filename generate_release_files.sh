#!/bin/bash

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
TAR_FILE="target/distrib/$BIN_NAME-$1.tar.xz"
mkdir -p target/distrib

$TAR_BIN -czf \
    $TAR_FILE \
    README.md \
    LICENSE \
    --transform="s|target/$1/release/$BIN_NAME|$BIN_NAME|" \
    "target/$1/release/$BIN_NAME"

sha256sum $TAR_FILE > "$TAR_FILE.sha256"

