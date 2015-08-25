#!/bin/bash

echo "starting `pwd`/build.sh"
echo "ztarting $0"

ARCH_PRIV_DIR="architecture-private"

echo "../$ARCH_PRIV_DIR"

if [ ! -d "../$ARCH_PRIV_DIR" ]; then

  echo "the $ARCH_PRIV_DIR repo must be adjacent to this repo in the filesystem"

  exit;

fi

../$ARCH_PRIV_DIR/setup-users-pri.sh

./setup-users-pub.sh





