#!/usr/bin/env bash

set -ex

EXTENSION_DIRECTORY=$HOME/Bitwig\ Studio/Extensions/
EXTENSION_VERSION=5.10
EXTENSION_FILENAME=DrivenByMoss-$EXTENSION_VERSION.zip
EXTENSION_FILEPATH="$EXTENSION_DIRECTORY"$EXTENSION_FILENAME

wget -O "$EXTENSION_FILEPATH" http://www.mossgrabers.de/Software/Bitwig/$EXTENSION_FILENAME

unzip -o "$EXTENSION_FILEPATH" -d "$EXTENSION_DIRECTORY"

rm "$EXTENSION_FILEPATH"