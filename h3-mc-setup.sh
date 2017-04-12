#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/mc-setup.sh
source $base/scripts/h3.sh

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
    mc_test_should_fail "$csi21name" 1 "$vinname0" ${skip3[2]}
    mc_test_should_fail "$csi40name" 1 "$vinname0" ${skip3[3]}
    mc_test_should_fail "$csi20name" 1 "$vinname0" ${skip3[4]}
    mc_test_should_fail "$csi21name" 0 "$vinname0" ${skip3[5]}

    # VIN1
    mc_test_should_fail "$csi20name" 1 "$vinname1" ${skip6[0]}
    mc_test_should_fail "$csi21name" 1 "$vinname1" ${skip6[1]}
    mc_test_should_fail "$csi40name" 1 "$vinname1" ${skip6[2]}
    mc_test_should_fail "$csi40name" 2 "$vinname1" ${skip6[3]}
    mc_test_should_fail "$csi20name" 2 "$vinname1" ${skip6[4]}
    mc_test_should_fail "$csi21name" 2 "$vinname1" ${skip6[5]}

    # VIN2
    mc_test_should_fail "$csi21name" 1 "$vinname2" ${skip6[0]}
    mc_test_should_fail "$csi40name" 1 "$vinname2" ${skip6[1]}
    mc_test_should_fail "$csi20name" 1 "$vinname2" ${skip6[2]}
    mc_test_should_fail "$csi40name" 3 "$vinname2" ${skip6[3]}
    mc_test_should_fail "$csi20name" 3 "$vinname2" ${skip6[4]}
    mc_test_should_fail "$csi21name" 3 "$vinname2" ${skip6[5]}

    # VIN3
    mc_test_should_fail "$csi40name" 2 "$vinname3" ${skip6[0]}
    mc_test_should_fail "$csi20name" 2 "$vinname3" ${skip6[1]}
    mc_test_should_fail "$csi21name" 2 "$vinname3" ${skip6[2]}
    mc_test_should_fail "$csi40name" 4 "$vinname3" ${skip6[3]}
    mc_test_should_fail "$csi20name" 4 "$vinname3" ${skip6[4]}
    mc_test_should_fail "$csi21name" 4 "$vinname3" ${skip6[5]}
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
    mc_test_should_fail "$csi41name" 1 "$vinname4" ${skip3[0]}
    mc_test_should_fail "$csi20name" 1 "$vinname4" ${skip3[1]}
    mc_test_should_fail "$csi21name" 1 "$vinname4" ${skip3[2]}
    mc_test_should_fail "$csi41name" 1 "$vinname4" ${skip3[3]}
    mc_test_should_fail "$csi20name" 1 "$vinname4" ${skip3[4]}
    mc_test_should_fail "$csi21name" 1 "$vinname4" ${skip3[5]}

    # VIN5
    mc_test_should_fail "$csi20name" 1 "$vinname5" ${skip6[0]}
    mc_test_should_fail "$csi21name" 1 "$vinname5" ${skip6[1]}
    mc_test_should_fail "$csi41name" 1 "$vinname5" ${skip6[2]}
    mc_test_should_fail "$csi41name" 2 "$vinname5" ${skip6[3]}
    mc_test_should_fail "$csi20name" 2 "$vinname5" ${skip6[4]}
    mc_test_should_fail "$csi21name" 2 "$vinname5" ${skip6[5]}

    # VIN6
    mc_test_should_fail "$csi21name" 1 "$vinname6" ${skip6[0]}
    mc_test_should_fail "$csi41name" 1 "$vinname6" ${skip6[1]}
    mc_test_should_fail "$csi20name" 1 "$vinname6" ${skip6[2]}
    mc_test_should_fail "$csi41name" 3 "$vinname6" ${skip6[3]}
    mc_test_should_fail "$csi20name" 3 "$vinname6" ${skip6[4]}
    mc_test_should_fail "$csi21name" 3 "$vinname6" ${skip6[5]}

    # VIN7
    mc_test_should_fail "$csi41name" 2 "$vinname7" ${skip6[0]}
    mc_test_should_fail "$csi20name" 2 "$vinname7" ${skip6[1]}
    mc_test_should_fail "$csi21name" 2 "$vinname7" ${skip6[2]}
    mc_test_should_fail "$csi41name" 4 "$vinname7" ${skip6[3]}
    mc_test_should_fail "$csi20name" 4 "$vinname7" ${skip6[4]}
    mc_test_should_fail "$csi21name" 4 "$vinname7" ${skip6[5]}
}

echo "Setup links for chsel 0"
mc_reset
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi20name" 1 "$vinname1" 1
mc_set_link "$csi21name" 1 "$vinname2" 1
mc_set_link "$csi40name" 2 "$vinname3" 1
do_fail_group1 0
mc_set_link "$csi41name" 1 "$vinname4" 1
mc_set_link "$csi20name" 1 "$vinname5" 1
mc_set_link "$csi21name" 1 "$vinname6" 1
mc_set_link "$csi41name" 2 "$vinname7" 1
do_fail_group2 0

echo "Setup links for chsel 1"
mc_reset
mc_set_link "$csi20name" 1 "$vinname0" 1
mc_set_link "$csi21name" 1 "$vinname1" 1
mc_set_link "$csi40name" 1 "$vinname2" 1
mc_set_link "$csi20name" 2 "$vinname3" 1
do_fail_group1 1
mc_set_link "$csi20name" 1 "$vinname4" 1
mc_set_link "$csi21name" 1 "$vinname5" 1
mc_set_link "$csi41name" 1 "$vinname6" 1
mc_set_link "$csi20name" 2 "$vinname7" 1
do_fail_group2 1

echo "Setup links for chsel 2"
mc_reset
mc_set_link "$csi21name" 1 "$vinname0" 1
mc_set_link "$csi40name" 1 "$vinname1" 1
mc_set_link "$csi20name" 1 "$vinname2" 1
mc_set_link "$csi21name" 2 "$vinname3" 1
do_fail_group1 2
mc_set_link "$csi21name" 1 "$vinname4" 1
mc_set_link "$csi41name" 1 "$vinname5" 1
mc_set_link "$csi20name" 1 "$vinname6" 1
mc_set_link "$csi21name" 2 "$vinname7" 1
do_fail_group2 2

echo "Setup links for chsel 3"
mc_reset
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi40name" 2 "$vinname1" 1
mc_set_link "$csi40name" 3 "$vinname2" 1
mc_set_link "$csi40name" 4 "$vinname3" 1
do_fail_group1 3
if mc_ensure "$csi41name"; then
    mc_set_link "$csi41name" 1 "$vinname4" 1
    mc_set_link "$csi41name" 2 "$vinname5" 1
    mc_set_link "$csi41name" 3 "$vinname6" 1
    mc_set_link "$csi41name" 4 "$vinname7" 1
    do_fail_group2 3
else
    echo "Skipping chsel3 group 2, "$csi41name" not present"
fi

echo "Setup links for chsel 4"
mc_reset
mc_set_link "$csi20name" 1 "$vinname0" 1
mc_set_link "$csi20name" 2 "$vinname1" 1
mc_set_link "$csi20name" 3 "$vinname2" 1
mc_set_link "$csi20name" 4 "$vinname3" 1
do_fail_group1 4
mc_set_link "$csi20name" 1 "$vinname4" 1
mc_set_link "$csi20name" 2 "$vinname5" 1
mc_set_link "$csi20name" 3 "$vinname6" 1
mc_set_link "$csi20name" 4 "$vinname7" 1
do_fail_group2 4

if mc_ensure "$csi21name"; then
    echo "Setup links for chsel 5"
    mc_reset
    mc_set_link "$csi21name" 1 "$vinname0" 1
    mc_set_link "$csi21name" 2 "$vinname1" 1
    mc_set_link "$csi21name" 3 "$vinname2" 1
    mc_set_link "$csi21name" 4 "$vinname3" 1
    do_fail_group1 5
    mc_set_link "$csi21name" 1 "$vinname4" 1
    mc_set_link "$csi21name" 2 "$vinname5" 1
    mc_set_link "$csi21name" 3 "$vinname6" 1
    mc_set_link "$csi21name" 4 "$vinname7" 1
    do_fail_group2 5
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
