#!/bin/bash

set -e

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

marker=$(dmesg | tail -n 1 | sed 's/^\[\([^]]*\)\].*/\1/g')

case $gen in
    "gen2")
        v4l2-ctl --set-dv-bt-timings=query -d /dev/$vin0
        $base/set-edid
        v4l2-compliance -d /dev/$vin0 -s -f

        std=$(v4l2-ctl --get-detected-standard -d /dev/$vin1 | awk '/Video Standard/{print $4}')
        v4l2-ctl --set-standard=$std -d /dev/$vin1
        v4l2-compliance -d /dev/$vin1 -s -f

        # Make sure we can dequeue all buffers
        yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin0
        yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin1
        ;;

    "gen3")
        mc_reset
        mc_set_link "$csi40name" 1 "$vinname0" 1
        mc_set_link "$csi20name" 1 "$vinname1" 1
        mc_propagate_hdmi "$vinname0"
        mc_propagate_cvbs "$vinname1"
        v4l2-compliance -d /dev/$vin0 -s
        v4l2-compliance -d /dev/$vin1 -s

        mc_reset
        mc_set_link "$csi40name" 1 "$vinname2" 1
        mc_set_link "$csi20name" 1 "$vinname4" 1
        mc_propagate_hdmi "$vinname2"
        mc_propagate_cvbs "$vinname4"
        v4l2-compliance -d /dev/$vin2 -s
        v4l2-compliance -d /dev/$vin4 -s

        # Make sure we can dequeue all buffers
        yavta -n 4 --capture=10 /dev/$vin2
        yavta -n 4 --capture=10 /dev/$vin4
        ;;
    *)
        echo "Unkown generation '$gen'"
        exit 1
        ;;
esac

# Print any log which happens when running test
dmesg | sed "1,/$marker/d"

confirm "Are compliance dmesg output ok"
