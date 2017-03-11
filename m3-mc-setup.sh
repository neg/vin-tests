#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/m3.sh

do_test() {
    src=$1
    pad=$2
    sink=$3
    skip=$4

    if [[ $skip == 1 ]]; then
        mc_log $src $pad $sink "SKIP - This link is active"
        return 0
    fi

    if ! mc_ensure "$src"; then
        mc_log "$src" $pad "$sink" "SKIP - '$src' Not present in system"
        return 0
    fi

    if mc_mc_set_link_raw $src $pad $sink 1; then
        mc_log $src $pad $sink "FAIL - Link OK but should have failed"
        exit 1
    fi

    mc_log $src $pad $sink "OKEY - Link not possible"
}

do_fail_group1() {
    chsel=$1

    declare -a skip6=(0 0 0 0 0 0)
    skip6[$chsel]=1

    declare -a skip3=(0 0 0 0 0 0)
    skip3[$(($chsel % 3))]=1
    skip3[$(($chsel % 3 + 3))]=1

    echo "Staring all fail for chsel: $chsel on group 1"

    # VIN0
    do_test $csi40name 1 $vinname0 ${skip3[0]}
    do_test $csi20name 1 $vinname0 ${skip3[1]}
    # chsel2 no op
    do_test $csi40name 1 $vinname0 ${skip3[3]}
    do_test $csi20name 1 $vinname0 ${skip3[4]}

    # VIN1
    do_test $csi20name 1 $vinname1 ${skip6[0]}
    # chsel1 no op
    do_test $csi40name 1 $vinname1 ${skip6[2]}
    do_test $csi40name 2 $vinname1 ${skip6[3]}
    do_test $csi20name 2 $vinname1 ${skip6[4]}

    # VIN2
    # chsel0 no op
    do_test $csi40name 1 $vinname2 ${skip6[1]}
    do_test $csi20name 1 $vinname2 ${skip6[2]}
    do_test $csi40name 3 $vinname2 ${skip6[3]}
    do_test $csi20name 3 $vinname2 ${skip6[4]}

    # VIN3
    do_test $csi40name 2 $vinname3 ${skip6[0]}
    do_test $csi20name 2 $vinname3 ${skip6[1]}
    #chsel2 no op
    do_test $csi40name 4 $vinname3 ${skip6[3]}
    do_test $csi20name 4 $vinname3 ${skip6[4]}
}

do_fail_group2() {
    chsel=$1

    declare -a skip6=(0 0 0 0 0 0)
    skip6[$chsel]=1

    declare -a skip3=(0 0 0 0 0 0)
    skip3[$(($chsel % 3))]=1
    skip3[$(($chsel % 3 + 3))]=1

    echo "Staring all fail for chsel: $chsel on group 2"

    # VIN4
    do_test $csi40name 1 $vinname4 ${skip3[0]}
    do_test $csi20name 1 $vinname4 ${skip3[1]}
    # chsel2 no op
    do_test $csi40name 1 $vinname4 ${skip3[3]}
    do_test $csi20name 1 $vinname4 ${skip3[4]}

    # VIN5
    do_test $csi20name 1 $vinname5 ${skip6[0]}
    # chsel1 no op
    do_test $csi40name 1 $vinname5 ${skip6[2]}
    do_test $csi40name 2 $vinname5 ${skip6[3]}
    do_test $csi20name 2 $vinname5 ${skip6[4]}

    # VIN6
    # chsel0 no op
    do_test $csi40name 1 $vinname6 ${skip6[1]}
    do_test $csi20name 1 $vinname6 ${skip6[2]}
    do_test $csi40name 3 $vinname6 ${skip6[3]}
    do_test $csi20name 3 $vinname6 ${skip6[4]}

    # VIN7
    do_test $csi40name 2 $vinname7 ${skip6[0]}
    do_test $csi20name 2 $vinname7 ${skip6[1]}
    # chsel2 no op
    do_test $csi40name 4 $vinname7 ${skip6[3]}
    do_test $csi20name 4 $vinname7 ${skip6[4]}
}

echo "Setup links for chsel 0 group 1"
media-ctl -r
mc_set_link $csi40name 1 $vinname0 1
mc_set_link $csi20name 1 $vinname1 1
#vin2 no op
mc_set_link $csi40name 2 $vinname3 1
do_fail_group1 0
echo "Setup links for chsel 0 group 2"
mc_set_link $csi40name 1 $vinname4 1
mc_set_link $csi20name 1 $vinname5 1
#vin6 no op
mc_set_link $csi40name 2 $vinname7 1
do_fail_group2 0

echo "Setup links for chsel 1 group 1"
media-ctl -r
mc_set_link $csi20name 1 $vinname0 1
#vin1 no op
mc_set_link $csi40name 1 $vinname2 1
mc_set_link $csi20name 2 $vinname3 1
do_fail_group1 1
echo "Setup links for chsel 1 group 2"
mc_set_link $csi20name 1 $vinname4 1
#vin5 no op
mc_set_link $csi40name 1 $vinname6 1
mc_set_link $csi20name 2 $vinname7 1
do_fail_group2 1

echo "Setup links for chsel 2 group 1"
media-ctl -r
#vin0 no op
mc_set_link $csi40name 1 $vinname1 1
mc_set_link $csi20name 1 $vinname2 1
#vin3 no op
do_fail_group1 2
echo "Setup links for chsel 2 group 2"
#vin4 no op
mc_set_link $csi40name 1 $vinname5 1
mc_set_link $csi20name 1 $vinname6 1
#vin7 no op
do_fail_group2 2

echo "Setup links for chsel 3 group 1"
media-ctl -r
mc_set_link $csi40name 1 $vinname0 1
mc_set_link $csi40name 2 $vinname1 1
mc_set_link $csi40name 3 $vinname2 1
mc_set_link $csi40name 4 $vinname3 1
do_fail_group1 3
echo "Setup links for chsel 3 group 2"
mc_set_link $csi40name 1 $vinname4 1
mc_set_link $csi40name 2 $vinname5 1
mc_set_link $csi40name 3 $vinname6 1
mc_set_link $csi40name 4 $vinname7 1
do_fail_group2 3

echo "Setup links for chsel 4 group 1"
media-ctl -r
mc_set_link $csi20name 1 $vinname0 1
mc_set_link $csi20name 2 $vinname1 1
mc_set_link $csi20name 3 $vinname2 1
mc_set_link $csi20name 4 $vinname3 1
do_fail_group1 4
echo "Setup links for chsel 4 group 2"
mc_set_link $csi20name 1 $vinname4 1
mc_set_link $csi20name 2 $vinname5 1
mc_set_link $csi20name 3 $vinname6 1
mc_set_link $csi20name 4 $vinname7 1
do_fail_group2 4

do_test_dual() {
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
    media-ctl -r
    # Set the dual link
    mc_set_link $deva $pada $vina 1

    # Test link possibility 1
    mc_set_link $devb $padb $vinb 1
    do_test $devc $padc $vinc
    mc_set_link $devb $padb $vinb 0

    # Test link possibility 2
    mc_set_link $devc $padc $vinc 1
    do_test $devb $padb $vinb
    mc_set_link $devc $padc $vinc 0
}

echo "Test dual possibilities"

do_test_dual \
    $csi40name 1 $vinname0 \
    $csi20name 1 $vinname1 \
    $csi40name 3 $vinname2

do_test_dual \
    $csi20name 1 $vinname0 \
    $csi40name 1 $vinname2 \
    $csi20name 2 $vinname1

do_test_dual \
    $csi20name 1 $vinname4 \
    $csi20name 2 $vinname7 \
    $csi20name 2 $vinname5

echo "All OK"
