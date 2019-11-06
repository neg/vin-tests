#!/bin/bash

set -e

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

set_nv12() {
    vdev=/dev/$1

    yavta -f NV12 $vdev
    out=$(yavta $vdev | grep NV12 | wc -l)
    if [[ "$out" == "0" ]]; then
        return 1
    fi

    return 0
}

case $gen in
    "gen2")
        echo "NV12 not supported on Gen2"
        exit 0
        ;;
    "gen3")
        mc_reset
        if ! set_nv12 $vin0; then
            echo "Failed to set NV12 for VIN0"
            exit 1
        fi

        if ! set_nv12 $vin1; then
            echo "Failed to set NV12 for VIN1"
            exit 1
        fi

        if set_nv12 $vin2; then
            echo "Failed to set NV12 for VIN2"
            exit 1
        fi

        if set_nv12 $vin3; then
            echo "Failed to set NV12 for VIN3"
            exit 1
        fi
        ;;
    *)
        echo "Unkown generation '$gen'"
        exit 1
        ;;
esac
