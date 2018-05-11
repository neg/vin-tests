#!/bin/sh

F=$(dirname $1)/$(basename $1 .bin)
FRAME_SIZE=${2:-1280x720}
FORMAT=${3:-RGB565}

raw2rgbpnm -f $FORMAT -s $FRAME_SIZE $F.bin $F.pnm
convert $F.pnm $F.png
