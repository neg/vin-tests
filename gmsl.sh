#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

mdev=$(mc_get_mdev)

out=$base/output
rm -fr $out
mkdir $out

function conf() {
    CSI="$1"
    IDX="$2"
    media-ctl -d $mdev -V "'$CSI':$IDX [fmt:UYVY8_2X8/1280x800 field:none]"
}

function capture() {
    CSI="$1"
    IDX="$2"
    VIN="$3"
    VID="$4"

    mc_set_link "$CSI" $IDX "$VIN" 1
    yavta -f YUYV -s 1280x800 -c10 --skip 7 --file="$out/$VID-#.bin" /dev/${!VID}
}

mc_reset

# Need to configure all formats going through each MAX9286
for cam in "$@"; do
	case $cam in
        1|2|3|4)
            conf  "$csi40name" 1
            conf  "$csi40name" 2
            conf  "$csi40name" 3
            conf  "$csi40name" 4
            ;;
        5|6|7|8)
            conf  "$csi41name" 1
            conf  "$csi41name" 2
            conf  "$csi41name" 3
            conf  "$csi41name" 4
            ;;
	    *)
		echo "Unrecognised camera $cam"
		;;
	esac
done

for cam in "$@"
do
	echo "Capturing camera $cam"
	case $cam in
	    1)	capture "$csi40name" 1 "$vinname0" vin0 ;;
	    2)	capture "$csi40name" 2 "$vinname1" vin1 ;;
	    3)	capture "$csi40name" 3 "$vinname2" vin2 ;;
	    4)	capture "$csi40name" 4 "$vinname3" vin3 ;;

	    5)	capture "$csi41name" 1 "$vinname4" vin4 ;;
	    6)	capture "$csi41name" 2 "$vinname5" vin5 ;;
	    7)	capture "$csi41name" 3 "$vinname6" vin6 ;;
	    8)	capture "$csi41name" 4 "$vinname7" vin7 ;;

	    *)
		echo "Unrecognised camera $cam"
		;;
	esac
done;

for f in $out/*bin; do
    name=$(basename $f .bin)
    raw2rgbpnm -f YUYV -s 1280x800 $out/$name.bin $out/$name.pnm
done
