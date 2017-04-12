#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/mc-setup.sh
source $base/scripts/m3.sh

do_fail_group1() {
    chsel=$1

    declare -a skip6=(0 0 0 0 0 0)
    skip6[$chsel]=1

    declare -a skip3=(0 0 0 0 0 0)
    skip3[$(($chsel % 3))]=1
    skip3[$(($chsel % 3 + 3))]=1

    echo "Staring all fail for chsel: $chsel on group 1"

    # VIN0
    mc_test_should_fail "$csi40name" 1 "$vinname0" ${skip3[0]}
    mc_test_should_fail "$csi20name" 1 "$vinname0" ${skip3[1]}
    # chsel2 no op
    mc_test_should_fail "$csi40name" 1 "$vinname0" ${skip3[3]}
    mc_test_should_fail "$csi20name" 1 "$vinname0" ${skip3[4]}

    # VIN1
    mc_test_should_fail "$csi20name" 1 "$vinname1" ${skip6[0]}
    # chsel1 no op
    mc_test_should_fail "$csi40name" 1 "$vinname1" ${skip6[2]}
    mc_test_should_fail "$csi40name" 2 "$vinname1" ${skip6[3]}
    mc_test_should_fail "$csi20name" 2 "$vinname1" ${skip6[4]}

    # VIN2
    # chsel0 no op
    mc_test_should_fail "$csi40name" 1 "$vinname2" ${skip6[1]}
    mc_test_should_fail "$csi20name" 1 "$vinname2" ${skip6[2]}
    mc_test_should_fail "$csi40name" 3 "$vinname2" ${skip6[3]}
    mc_test_should_fail "$csi20name" 3 "$vinname2" ${skip6[4]}

    # VIN3
    mc_test_should_fail "$csi40name" 2 "$vinname3" ${skip6[0]}
    mc_test_should_fail "$csi20name" 2 "$vinname3" ${skip6[1]}
    #chsel2 no op
    mc_test_should_fail "$csi40name" 4 "$vinname3" ${skip6[3]}
    mc_test_should_fail "$csi20name" 4 "$vinname3" ${skip6[4]}
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
    mc_test_should_fail "$csi40name" 1 "$vinname4" ${skip3[0]}
    mc_test_should_fail "$csi20name" 1 "$vinname4" ${skip3[1]}
    # chsel2 no op
    mc_test_should_fail "$csi40name" 1 "$vinname4" ${skip3[3]}
    mc_test_should_fail "$csi20name" 1 "$vinname4" ${skip3[4]}

    # VIN5
    mc_test_should_fail "$csi20name" 1 "$vinname5" ${skip6[0]}
    # chsel1 no op
    mc_test_should_fail "$csi40name" 1 "$vinname5" ${skip6[2]}
    mc_test_should_fail "$csi40name" 2 "$vinname5" ${skip6[3]}
    mc_test_should_fail "$csi20name" 2 "$vinname5" ${skip6[4]}

    # VIN6
    # chsel0 no op
    mc_test_should_fail "$csi40name" 1 "$vinname6" ${skip6[1]}
    mc_test_should_fail "$csi20name" 1 "$vinname6" ${skip6[2]}
    mc_test_should_fail "$csi40name" 3 "$vinname6" ${skip6[3]}
    mc_test_should_fail "$csi20name" 3 "$vinname6" ${skip6[4]}

    # VIN7
    mc_test_should_fail "$csi40name" 2 "$vinname7" ${skip6[0]}
    mc_test_should_fail "$csi20name" 2 "$vinname7" ${skip6[1]}
    # chsel2 no op
    mc_test_should_fail "$csi40name" 4 "$vinname7" ${skip6[3]}
    mc_test_should_fail "$csi20name" 4 "$vinname7" ${skip6[4]}
}

echo "Setup links for chsel 0 group 1"
mc_reset
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi20name" 1 "$vinname1" 1
#vin2 no op
mc_set_link "$csi40name" 2 "$vinname3" 1
do_fail_group1 0
echo "Setup links for chsel 0 group 2"
mc_set_link "$csi40name" 1 "$vinname4" 1
mc_set_link "$csi20name" 1 "$vinname5" 1
#vin6 no op
mc_set_link "$csi40name" 2 "$vinname7" 1
do_fail_group2 0

echo "Setup links for chsel 1 group 1"
mc_reset
mc_set_link "$csi20name" 1 "$vinname0" 1
#vin1 no op
mc_set_link "$csi40name" 1 "$vinname2" 1
mc_set_link "$csi20name" 2 "$vinname3" 1
do_fail_group1 1
echo "Setup links for chsel 1 group 2"
mc_set_link "$csi20name" 1 "$vinname4" 1
#vin5 no op
mc_set_link "$csi40name" 1 "$vinname6" 1
mc_set_link "$csi20name" 2 "$vinname7" 1
do_fail_group2 1

echo "Setup links for chsel 2 group 1"
mc_reset
#vin0 no op
mc_set_link "$csi40name" 1 "$vinname1" 1
mc_set_link "$csi20name" 1 "$vinname2" 1
#vin3 no op
do_fail_group1 2
echo "Setup links for chsel 2 group 2"
#vin4 no op
mc_set_link "$csi40name" 1 "$vinname5" 1
mc_set_link "$csi20name" 1 "$vinname6" 1
#vin7 no op
do_fail_group2 2

echo "Setup links for chsel 3 group 1"
mc_reset
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi40name" 2 "$vinname1" 1
mc_set_link "$csi40name" 3 "$vinname2" 1
mc_set_link "$csi40name" 4 "$vinname3" 1
do_fail_group1 3
echo "Setup links for chsel 3 group 2"
mc_set_link "$csi40name" 1 "$vinname4" 1
mc_set_link "$csi40name" 2 "$vinname5" 1
mc_set_link "$csi40name" 3 "$vinname6" 1
mc_set_link "$csi40name" 4 "$vinname7" 1
do_fail_group2 3

echo "Setup links for chsel 4 group 1"
mc_reset
mc_set_link "$csi20name" 1 "$vinname0" 1
mc_set_link "$csi20name" 2 "$vinname1" 1
mc_set_link "$csi20name" 3 "$vinname2" 1
mc_set_link "$csi20name" 4 "$vinname3" 1
do_fail_group1 4
echo "Setup links for chsel 4 group 2"
mc_set_link "$csi20name" 1 "$vinname4" 1
mc_set_link "$csi20name" 2 "$vinname5" 1
mc_set_link "$csi20name" 3 "$vinname6" 1
mc_set_link "$csi20name" 4 "$vinname7" 1
do_fail_group2 4

echo "Test dual possibilities"

mc_test_chsel_lock \
    "$csi40name" 1 "$vinname0" \
    "$csi20name" 1 "$vinname1" \
    "$csi40name" 3 "$vinname2"

mc_test_chsel_lock \
    "$csi20name" 1 "$vinname0" \
    "$csi40name" 1 "$vinname2" \
    "$csi20name" 2 "$vinname1"

mc_test_chsel_lock \
    "$csi20name" 1 "$vinname4" \
    "$csi20name" 2 "$vinname7" \
    "$csi20name" 2 "$vinname5"

echo "All OK"
