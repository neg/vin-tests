#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

function conf() {
    CSI="$1"
    IDX="$2"
    VIN="$3"

    mc_set_link "$CSI" $IDX "$VIN" 1
    media-ctl -d $mdev -V "'$CSI':$IDX [fmt:UYVY8_2X8/1280x800 field:none]"
}

function vin_du() {
    vdev="/dev/$1"

    yavta -f YUYV -s 1280x800 $vdev
    $base/tools/vin_to_du.sh $vdev
}

mc_reset

case $1 in
    1|2|3|4)
        conf  "$csi40name" 1 "$vinname0"
        conf  "$csi40name" 2 "$vinname1"
        conf  "$csi40name" 3 "$vinname2"
        conf  "$csi40name" 4 "$vinname3"
        ;;
    5|6|7|8)
        conf  "$csi41name" 1 "$vinname4"
        conf  "$csi41name" 2 "$vinname5"
        conf  "$csi41name" 3 "$vinname6"
        conf  "$csi41name" 4 "$vinname7"
        ;;
    *)
        echo "Unrecognised camera $cam"
        exit 1
        ;;
esac

case $1 in
    1) vin_du $vin0 ;;
    2) vin_du $vin1 ;;
    3) vin_du $vin2 ;;
    4) vin_du $vin3 ;;
    5) vin_du $vin4 ;;
    6) vin_du $vin5 ;;
    7) vin_du $vin6 ;;
    8) vin_du $vin7 ;;
    *)
        echo "Unrecognised camera $cam"
        exit 1
        ;;
esac
