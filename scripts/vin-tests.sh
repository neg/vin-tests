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

test_compliance_begin() {
    # clear dmesg
    dmesg -c > /dev/null
}

test_compliance() {
    dev=/dev/$1

    if [ ! -c $dev ]; then
        echo "ERROR: $dev is not a video device"
        exit 1
    fi

    echo "* v4l2-compliance"
    echo "v4l2-compliance for $dev" > /dev/kmsg
    if ! v4l2-compliance -d $dev -s -f; then
        echo "compliance failed for $dev"
        exit 1
    fi
}

test_compliance_end() {
    echo "* dmesg"
    dmesg

    confirm "Are compliance dmesg output ok"
}

test_qv4l2() {
    dev=/dev/$1

    echo "* qv4l2"
    qv4l2 -d $dev
    confirm "Are qv4l2 for $dev ok"
}

test_qv4l2_dual() {
    deva=/dev/$1
    devb=/dev/$2

    echo "* dual qv4l2"
    qv4l2 -d $deva &
    qv4l2 -d $devb &
    wait
    confirm "Are dual qv4l2 for $deva and $devb ok"
}

# Media controller

mediactl="media-ctl"

mc_get_mdev() {
    for mdev in /dev/media* ; do
        if [[ "$($mediactl -d $mdev -p | grep 'Renesas VIN')" != "" ]]; then
            echo $mdev
            return 0
        fi
    done

    error "Can't find media device"
}

mc_log() {
    src=$1
    pad=$2
    sink=$3
    msg=$4
    echo "'$src':$pad -> '$sink':0 : $msg"
}

mc_ensure() {
    mdev=$(mc_get_mdev)

    src=$1
    pad=$2
    sink=$3

    if [[ "$($mediactl -d $mdev -p | grep $src)" == "" ]]; then
        mc_log $src $pad $sink "SKIP - Not all devices for this run are present"
        return 1
    fi

    return 0
}

mc_mc_set_link_raw()
{
    mdev=$(mc_get_mdev)

    src=$1
    pad=$2
    sink=$3
    mode=$4

    $mediactl -d $mdev -l "'$src':$pad -> '$sink':0 [$mode]" &> /dev/null
    return $?
}

mc_set_link() {
    src=$1
    pad=$2
    sink=$3
    mode=$4

    mc_ensure $src $pad $sink || return 0

    if ! mc_mc_set_link_raw $src $pad $sink $mode; then
        mc_log $src $pad $sink "FAIL - Link set $mode failed but should be OK"
        exit 1
    fi

    mc_log $src $pad $sink "OKEY - Link set $mode"
}
