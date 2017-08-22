#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

mdev=$(mc_get_mdev)

if [ $# -ne 1 ]; then
    echo "Usage: $0 <config>"
    echo "config:"
    echo "  1 - MAX9286 1 (CSI40)"
    echo "  2 - MAX9286 2 (CSI41)"
    echo "  3 - MAX9286 1 (CSI40) + MAX9286 2 (CSI41)"
    exit 0
fi

max9286_1=0
max9286_2=0

case $1 in
    1)
        max9286_1=1
        ;;
    2)
        max9286_2=1
        ;;
    3)
        max9286_1=1
        max9286_2=1
        ;;
    *)
        echo "Unkown config '$1'"
        exit 1
        ;;
esac

out=$base/output
rm -fr $out
mkdir $out

mc_reset

if [ $max9286_1 -eq 1 ]; then
    mc_set_link "$csi40name" 1 "$vinname0" 1
    mc_set_link "$csi40name" 2 "$vinname1" 1
    mc_set_link "$csi40name" 3 "$vinname2" 1
    mc_set_link "$csi40name" 4 "$vinname3" 1

    media-ctl -d $mdev -V "'$csi40name':1 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi40name':2 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi40name':3 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi40name':4 [fmt:UYVY8_2X8/1280x800 field:none]"

    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin0-#.bin" /dev/$vin0
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin1-#.bin" /dev/$vin1
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin2-#.bin" /dev/$vin2
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin3-#.bin" /dev/$vin3
fi

if [ $max9286_2 -eq 1 ]; then
    mc_set_link "$csi41name" 1 "$vinname4" 1
    mc_set_link "$csi41name" 2 "$vinname5" 1
    mc_set_link "$csi41name" 3 "$vinname6" 1
    mc_set_link "$csi41name" 4 "$vinname7" 1

    media-ctl -d $mdev -V "'$csi41name':1 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi41name':2 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi41name':3 [fmt:UYVY8_2X8/1280x800 field:none]"
    media-ctl -d $mdev -V "'$csi41name':4 [fmt:UYVY8_2X8/1280x800 field:none]"

    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin4-#.bin" /dev/$vin4
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin5-#.bin" /dev/$vin5
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin6-#.bin" /dev/$vin6
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/vin7-#.bin" /dev/$vin7
fi

for f in $out/*bin; do
    name=$(basename $f .bin)
    raw2rgbpnm -f YUYV -s 1280x800 $out/$name.bin $out/$name.pnm
done
