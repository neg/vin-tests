#!/bin/sh

F=$(basename $1 .bin)
FRAME_SIZE=${2:-1280x720}

raw2rgbpnm -f RGB565 -s $FRAME_SIZE $F.bin $F.pnm
convert $F.pnm $F.png
