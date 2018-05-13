#!/bin/bash

error() {
    echo "Error: $*" > /dev/stderr
    exit 1
}

confirm() {
    local text=$1

    unset REPLY

    echo "====="

    while [[ ! $REPLY =~ ^[Nn]$ ]]; do
        read -p "$text (Y/n) " -n 1 -r

        case $REPLY in
            [Yy])
                echo
                return 0
                ;;
            "")
                return 0
                ;;
        esac
        echo
    done

    echo -e "Fail"
    exit 1
}

test_qv4l2() {
    dev=/dev/$1

    echo "* qv4l2"
    qv4l2 -d $dev
    confirm "Are qv4l2 for $dev ok"
}

# Media controller

mediactl="media-ctl"

mc_get_mdev() {
    for mdev in /dev/media* ; do
        if [[ "$($mediactl -d $mdev -p | grep 'rcar_vin')" != "" ]]; then
            echo $mdev
            return 0
        fi
    done

    error "Can't find media device"
}

mc_get_dev() {
    name="$1"
    grep -l "$name" /sys/class/video4linux/*/name | \
	    sed 's#.*video4linux\(.*\)/name#/dev\1#g'
}

mc_reset() {
    mdev=$(mc_get_mdev)

    $mediactl -d $mdev -r
}

mc_set_link()
{
    mdev=$(mc_get_mdev)

    src=$1
    pad=$2
    sink=$3
    mode=$4

    $mediactl -d $mdev -l "'$src':$pad -> '$sink':0 [$mode]"
}

mc_propagate_format() {
    mdev=$(mc_get_mdev)

    cam="'$1':$2"
    atx="'$3':$4"
    csi="'$5':$6"
    vin="$7"

    format=$($mediactl -d $mdev --get-v4l2 "$cam" | sed 's|.*fmt:\([^/]*\).*|\1|')
    size=$($mediactl -d $mdev --get-v4l2 "$cam" | sed 's|.*fmt:[^/]*/\([^ ]*\).*|\1|')
    field=$($mediactl -d $mdev --get-v4l2 "$cam" | sed 's|.*field:\([^] ]*\).*|\1|')
    vdev=$($mediactl -d $mdev -e "$vin" )

    vinsize=$size
    vinfield=$field

    if [[ "$field" == "alternate" ]]; then
        width=$(echo $size | awk -Fx '{print $1}')
        height=$(echo $size | awk -Fx '{print $2}')
        vinsize="${width}x$(($height * 2))"
        vinfield="interlaced"
    fi

    echo "format: $format size: $size/$vinsize field: $field/$vinfield vdev: $vdev"

    $mediactl -d $mdev -V "$cam [fmt:$format/$size field:$field]"
    $mediactl -d $mdev -V "$atx [fmt:$format/$size field:$field]"
    $mediactl -d $mdev -V "$csi [fmt:$format/$size field:$field]"
    yavta -f RGB565 -s $vinsize --field $vinfield $vdev
}

# HDMI can only output to TXA on the ADV748x
mc_propagate_hdmi() {
    vin="$1"

    mc_propagate_format "$hdminame" 1 "$txaname" 0 "$csi40name" 1 "$vin"
}

# CVBS is only currently supported on TXB
mc_propagate_cvbs() {
    vin="$1"

    mc_propagate_format "$cvbsname" 8 "$txbname" 0 "$csi20name" 1 "$vin"
}
