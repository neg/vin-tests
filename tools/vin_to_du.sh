#!/bin/bash

base=$(dirname $(readlink -f $0))

if [ $# -ne 3 ]; then
    echo "usage: $0 <V4L2 device> <Connector> <CRTC>"
    echo "       $0 /dev/video25 66 64"
    exit 1
fi

vdev=$1
connector=$2
crtc=$3

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

# Figure out resolution, the DU is very pick about this, if it do not match perfectly
# it will fail with a cryptic IOCTL -EINVAL error
res=$(v4l2-ctl --get-fmt-video -d $vdev | awk '/Width/{sub(/\//, ",", $3); print $3};')

$base/../src/dmabuf-sharing/dmabuf-sharing -M rcar-du -i $vdev -S $res -f YUYV -F YUYV -s $res@0,0 -t $res@0,0 -b 2 -o $connector:$crtc
