#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/mc-setup.sh
source $base/scripts/boards.sh

do_test_group1() {
    csi1n=$1
    csi1p=$2
    csi2n=$3
    csi2p=$4
    csi3n=$5
    csi3p=$6
    csi4n=$7
    csi4p=$8
    mc_set_link "$csi1n" $csi1p "$vinname0" 1
    mc_set_link "$csi2n" $csi2p "$vinname1" 1
    mc_set_link "$csi3n" $csi3p "$vinname2" 1
    mc_set_link "$csi4n" $csi4p "$vinname3" 1

    echo "VIN0"
    mc_test_should_fail "$csi40name" 1 "$vinname0" $(mc_make_skip "$csi40name" 1 "$csi1n" $csi1p)
    mc_test_should_fail "$csi20name" 1 "$vinname0" $(mc_make_skip "$csi20name" 1 "$csi1n" $csi1p)
    mc_test_should_fail "$csi21name" 1 "$vinname0" $(mc_make_skip "$csi21name" 1 "$csi1n" $csi1p)
    mc_test_should_fail "$csi40name" 1 "$vinname0" $(mc_make_skip "$csi40name" 1 "$csi1n" $csi1p)
    mc_test_should_fail "$csi20name" 1 "$vinname0" $(mc_make_skip "$csi20name" 1 "$csi1n" $csi1p)
    mc_test_should_fail "$csi21name" 0 "$vinname0" $(mc_make_skip "$csi21name" 0 "$csi1n" $csi1p)

    echo "VIN1"
    mc_test_should_fail "$csi20name" 1 "$vinname1" $(mc_make_skip "$csi20name" 1 "$csi2n" $csi2p)
    mc_test_should_fail "$csi21name" 1 "$vinname1" $(mc_make_skip "$csi21name" 1 "$csi2n" $csi2p)
    mc_test_should_fail "$csi40name" 1 "$vinname1" $(mc_make_skip "$csi40name" 1 "$csi2n" $csi2p)
    mc_test_should_fail "$csi40name" 2 "$vinname1" $(mc_make_skip "$csi40name" 2 "$csi2n" $csi2p)
    mc_test_should_fail "$csi20name" 2 "$vinname1" $(mc_make_skip "$csi20name" 2 "$csi2n" $csi2p)
    mc_test_should_fail "$csi21name" 2 "$vinname1" $(mc_make_skip "$csi21name" 2 "$csi2n" $csi2p)

    echo "VIN2"
    mc_test_should_fail "$csi21name" 1 "$vinname2" $(mc_make_skip "$csi21name" 1 "$csi3n" $csi3p)
    mc_test_should_fail "$csi40name" 1 "$vinname2" $(mc_make_skip "$csi40name" 1 "$csi3n" $csi3p)
    mc_test_should_fail "$csi20name" 1 "$vinname2" $(mc_make_skip "$csi20name" 1 "$csi3n" $csi3p)
    mc_test_should_fail "$csi40name" 3 "$vinname2" $(mc_make_skip "$csi40name" 3 "$csi3n" $csi3p)
    mc_test_should_fail "$csi20name" 3 "$vinname2" $(mc_make_skip "$csi20name" 3 "$csi3n" $csi3p)
    mc_test_should_fail "$csi21name" 3 "$vinname2" $(mc_make_skip "$csi21name" 3 "$csi3n" $csi3p)

    echo "VIN3"
    mc_test_should_fail "$csi40name" 2 "$vinname3" $(mc_make_skip "$csi40name" 2 "$csi4n" $csi4p)
    mc_test_should_fail "$csi20name" 2 "$vinname3" $(mc_make_skip "$csi20name" 2 "$csi4n" $csi4p)
    mc_test_should_fail "$csi21name" 2 "$vinname3" $(mc_make_skip "$csi21name" 2 "$csi4n" $csi4p)
    mc_test_should_fail "$csi40name" 4 "$vinname3" $(mc_make_skip "$csi40name" 4 "$csi4n" $csi4p)
    mc_test_should_fail "$csi20name" 4 "$vinname3" $(mc_make_skip "$csi20name" 4 "$csi4n" $csi4p)
    mc_test_should_fail "$csi21name" 4 "$vinname3" $(mc_make_skip "$csi21name" 4 "$csi4n" $csi4p)
}

do_test_group2() {
    csi5n=$1
    csi5p=$2
    csi6n=$3
    csi6p=$4
    csi7n=$5
    csi7p=$6
    csi8n=$7
    csi8p=$8

    mc_set_link "$csi5n" $csi5p "$vinname4" 1
    mc_set_link "$csi6n" $csi6p "$vinname5" 1
    mc_set_link "$csi7n" $csi7p "$vinname6" 1
    mc_set_link "$csi8n" $csi8p "$vinname7" 1

    echo "VIN4"
    mc_test_should_fail "$csi41name" 1 "$vinname4" $(mc_make_skip "$csi41name" 1 "$csi5n" $csi5p)
    mc_test_should_fail "$csi20name" 1 "$vinname4" $(mc_make_skip "$csi20name" 1 "$csi5n" $csi5p)
    mc_test_should_fail "$csi21name" 1 "$vinname4" $(mc_make_skip "$csi21name" 1 "$csi5n" $csi5p)
    mc_test_should_fail "$csi41name" 1 "$vinname4" $(mc_make_skip "$csi41name" 1 "$csi5n" $csi5p)
    mc_test_should_fail "$csi20name" 1 "$vinname4" $(mc_make_skip "$csi20name" 1 "$csi5n" $csi5p)
    mc_test_should_fail "$csi21name" 1 "$vinname4" $(mc_make_skip "$csi21name" 1 "$csi5n" $csi5p)

    echo "VIN5"
    mc_test_should_fail "$csi20name" 1 "$vinname5" $(mc_make_skip "$csi20name" 1 "$csi6n" $csi6p)
    mc_test_should_fail "$csi21name" 1 "$vinname5" $(mc_make_skip "$csi21name" 1 "$csi6n" $csi6p)
    mc_test_should_fail "$csi41name" 1 "$vinname5" $(mc_make_skip "$csi41name" 1 "$csi6n" $csi6p)
    mc_test_should_fail "$csi41name" 2 "$vinname5" $(mc_make_skip "$csi41name" 2 "$csi6n" $csi6p)
    mc_test_should_fail "$csi20name" 2 "$vinname5" $(mc_make_skip "$csi20name" 2 "$csi6n" $csi6p)
    mc_test_should_fail "$csi21name" 2 "$vinname5" $(mc_make_skip "$csi21name" 2 "$csi6n" $csi6p)

    echo "VIN6"
    mc_test_should_fail "$csi21name" 1 "$vinname6" $(mc_make_skip "$csi21name" 1 "$csi7n" $csi7p)
    mc_test_should_fail "$csi41name" 1 "$vinname6" $(mc_make_skip "$csi41name" 1 "$csi7n" $csi7p)
    mc_test_should_fail "$csi20name" 1 "$vinname6" $(mc_make_skip "$csi20name" 1 "$csi7n" $csi7p)
    mc_test_should_fail "$csi41name" 3 "$vinname6" $(mc_make_skip "$csi41name" 3 "$csi7n" $csi7p)
    mc_test_should_fail "$csi20name" 3 "$vinname6" $(mc_make_skip "$csi20name" 3 "$csi7n" $csi7p)
    mc_test_should_fail "$csi21name" 3 "$vinname6" $(mc_make_skip "$csi21name" 3 "$csi7n" $csi7p)

    echo "VIN7"
    mc_test_should_fail "$csi41name" 2 "$vinname7" $(mc_make_skip "$csi41name" 2 "$csi8n" $csi8p)
    mc_test_should_fail "$csi20name" 2 "$vinname7" $(mc_make_skip "$csi20name" 2 "$csi8n" $csi8p)
    mc_test_should_fail "$csi21name" 2 "$vinname7" $(mc_make_skip "$csi21name" 2 "$csi8n" $csi8p)
    mc_test_should_fail "$csi41name" 4 "$vinname7" $(mc_make_skip "$csi41name" 4 "$csi8n" $csi8p)
    mc_test_should_fail "$csi20name" 4 "$vinname7" $(mc_make_skip "$csi20name" 4 "$csi8n" $csi8p)
    mc_test_should_fail "$csi21name" 4 "$vinname7" $(mc_make_skip "$csi21name" 4 "$csi8n" $csi8p)
}

echo "Setup links for chsel 0"
mc_reset
do_test_group1 \
    "$csi40name" 1 \
    "$csi20name" 1 \
    "$csi21name" 1 \
    "$csi40name" 2
do_test_group2 \
    "$csi41name" 1 \
    "$csi20name" 1 \
    "$csi21name" 1 \
    "$csi41name" 2

echo "Setup links for chsel 1"
mc_reset
do_test_group1 \
    "$csi20name" 1 \
    "$csi21name" 1 \
    "$csi40name" 1 \
    "$csi20name" 2
do_test_group2 \
    "$csi20name" 1 \
    "$csi21name" 1 \
    "$csi41name" 1 \
    "$csi20name" 2

echo "Setup links for chsel 2"
mc_reset
do_test_group1 \
    "$csi21name" 1 \
    "$csi40name" 1 \
    "$csi20name" 1 \
    "$csi21name" 2
do_test_group2 \
    "$csi21name" 1 \
    "$csi41name" 1 \
    "$csi20name" 1 \
    "$csi21name" 2

echo "Setup links for chsel 3"
mc_reset
do_test_group1 \
    "$csi40name" 1 \
    "$csi40name" 2 \
    "$csi40name" 3 \
    "$csi40name" 4
if mc_ensure "$csi41name"; then
    do_test_group2 \
        "$csi41name" 1 \
        "$csi41name" 2 \
        "$csi41name" 3 \
        "$csi41name" 4
else
    echo "Skipping chsel3 group 2, "$csi41name" not present"
fi

echo "Setup links for chsel 4"
mc_reset
do_test_group1 \
    "$csi20name" 1 \
    "$csi20name" 2 \
    "$csi20name" 3 \
    "$csi20name" 4
do_test_group2 \
    "$csi20name" 1 \
    "$csi20name" 2 \
    "$csi20name" 3 \
    "$csi20name" 4

if mc_ensure "$csi21name"; then
    echo "Setup links for chsel 5"
    mc_reset
    do_test_group1 \
        "$csi21name" 1 \
        "$csi21name" 2 \
        "$csi21name" 3 \
        "$csi21name" 4
    do_test_group2 \
        "$csi21name" 1 \
        "$csi21name" 2 \
        "$csi21name" 3 \
        "$csi21name" 4
else
    echo "Skipping chsel5 "$csi21name" not present"
fi

echo "Test dual possibilities"

mc_test_chsel_lock \
    "$csi40name" 1 "$vinname0" \
    "$csi20name" 1 "$vinname1" \
    "$csi40name" 3 "$vinname2"

mc_test_chsel_lock \
    "$csi20name" 1 "$vinname0" \
    "$csi40name" 1 "$vinname2" \
    "$csi20name" 2 "$vinname1"

if mc_ensure "$csi21name"; then
    mc_test_chsel_lock \
        "$csi21name" 1 "$vinname0" \
        "$csi40name" 1 "$vinname1" \
        "$csi21name" 3 "$vinname2"
fi

if mc_ensure "$csi41name"; then
    mc_test_chsel_lock \
        "$csi41name" 1 "$vinname4" \
        "$csi20name" 1 "$vinname5" \
        "$csi41name" 3 "$vinname6"
fi

mc_test_chsel_lock \
    "$csi20name" 1 "$vinname4" \
    "$csi20name" 2 "$vinname7" \
    "$csi20name" 2 "$vinname5"

if mc_ensure "$csi21name"; then
    mc_test_chsel_lock \
        "$csi21name" 1 "$vinname4" \
        "$csi20name" 1 "$vinname6" \
        "$csi21name" 2 "$vinname5"
fi

echo "All OK"
