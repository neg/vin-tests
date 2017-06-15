#!/bin/bash

set -e

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/boards.sh

case $gen in
    "gen2")
        test_qv4l2 $vin0
        test_qv4l2 $vin1
        ;;

    "gen3")
        mc_reset
        mc_set_link "$csi40name" 1 "$vinname0" 1
        mc_set_link "$csi20name" 1 "$vinname1" 1
        mc_set_link "$csi20name" 1 "$vinname6" 1

        mc_propagate_hdmi "$vinname0"
        mc_propagate_cvbs "$vinname1"
        mc_propagate_cvbs "$vinname6"

        test_qv4l2 $vin0
        test_qv4l2 $vin1
        ;;
    *)
        echo "Unkown generation '$gen'"
        exit 1
        ;;
esac
