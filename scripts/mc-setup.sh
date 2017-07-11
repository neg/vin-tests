#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh

mc_make_skip() {
    csi1n=$1
    csi1p=$2
    csi2n=$3
    csi2p=$4

    if [[ $csi1n == $csi2n && $csi1p == $csi2p ]]; then
        echo 1
    else
        echo 0
    fi
}

mc_test_should_fail() {
    src=$1
    pad=$2
    sink=$3
    skip=$4

    if [[ $skip == 1 ]]; then
        mc_log "$src" $pad "$sink" "SKIP - This link is active"
        return 0
    fi

    if ! mc_ensure "$src"; then
        mc_log "$src" $pad "$sink" "SKIP - '$src' Not present in system"
        return 0
    fi

    if mc_mc_set_link_raw "$src" $pad "$sink" 1; then
        mc_log "$src" $pad "$sink" "FAIL - Link OK but should have failed"
        exit 1
    fi

    mc_log "$src" $pad "$sink" "OKEY - Link not possible"
}

mc_test_chsel_lock() {
    deva=$1
    pada=$2
    vina=$3
    devb=$4
    padb=$5
    vinb=$6
    devc=$7
    padc=$8
    vinc=$9

    echo "Testing dual settings based on $deva:$pada -> $vina"
    mc_reset
    # Set the dual link
    mc_set_link "$deva" $pada "$vina" 1

    # Test link possibility 1
    mc_set_link "$devb" $padb "$vinb" 1
    mc_test_should_fail "$devc" $padc "$vinc"
    mc_set_link "$devb" $padb "$vinb" 0

    # Test link possibility 2
    mc_set_link "$devc" $padc "$vinc" 1
    mc_test_should_fail "$devb" $padb "$vinb"
    mc_set_link "$devc" $padc "$vinc" 0
}
