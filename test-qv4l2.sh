#!/bin/bash

set -e

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

case $gen in
    "gen2")
        $base/set-std
        qv4l2 -d /dev/$vin0
        qv4l2 -d /dev/$vin1
        ;;

    "gen3")
        mc_reset
        $base/set-std
        mc_propagate_hdmi "$vinname0" 1
        qv4l2 -d /dev/$vin0

        if [[ "$csi20name" != "" ]]; then
            mc_reset
            mc_propagate_cvbs "$vinname1" 1
            qv4l2 -d /dev/$vin1
        fi

        if [[ "$parallelname" != "" ]]; then
            mc_reset
            mc_propagate_parallel "$vinname0"
            qv4l2 -d /dev/$vin0
        fi
        ;;
    *)
        echo "Unkown generation '$gen'"
        exit 1
        ;;
esac
