#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

set -eox pipefail
mkdir -p target/distrib

TAR_FILE="target/distrib/test-rust-bin-$1.tar.xz"

tar -czf \
    $TAR_FILE \
    README.md \
    LICENSE \
    --transform="s|target/$1/release/test-rust-bin|test-rust-bin|" \
    "target/$1/release/test-rust-bin"

sha256sum $TAR_FILE > "$TAR_FILE.sha256"

