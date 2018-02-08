#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/../scripts/boards.sh

if [ $# -ne 1 ]; then
    echo "usage: $0 <V4L2 device>"
    echo "       $0 /dev/video25"
    exit 1
fi

vdev=$1

case $gen in
    "gen2")
        # ADV7482 do not notify on format changes, preform manual probe
        case $(v4l2-ctl --list-inputs -d $vdev | awk '/Capabilities/{print $2};') in
            "0x00000002")
                v4l2-ctl --set-dv-bt-timings=query -d $vdev
                ;;
            "0x00000004")
                std=$(v4l2-ctl --get-detected-standard -d $vdev | awk '/Video Standard/{print $4}')
                v4l2-ctl --set-standard=$std -d $vdev
                ;;
            *)
                echo "Unkown Capabilities"
                exit 1
                ;;
        esac
        ;;
    "gen3")
        echo ""
        echo "================================================================"
        echo "= Remember to configure the pipeline before running $0!"
        echo "="
        echo "= Any -EPIPE errors is likely caused by the pipeline not beeing configured."
        echo "================================================================"
        echo ""
        ;;
    *)
        echo "Unkown generation '$gen'"
        exit 1
        ;;
esac

connector=$(modetest -c -M rcar-du | awk '/connected/{print $1}')
crtc=$(modetest -e -M rcar-du | awk '/^[0-9]+/{print $2}')

# Figure out resolution, the DU is very pick about this, if it do not match perfectly
# it will fail with a cryptic IOCTL -EINVAL error
res=$(v4l2-ctl --get-fmt-video -d $vdev | awk '/Width/{sub(/\//, ",", $3); print $3};')

$base/../src/dmabuf-sharing/dmabuf-sharing -M rcar-du -i $vdev -S $res -f YUYV -F YUYV -s $res@0,0 -t $res@0,0 -b 2 -o $connector:$crtc
