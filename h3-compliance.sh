#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/h3.sh

media-ctl -r
mc_set_link $csi40name 1 $vinname0 1
mc_set_link $csi20name 1 $vinname1 1
test_compliance $vin0
# Need to get standard
v4l2-ctl -d /dev/$vin1 --get-detected-standard
test_compliance $vin1

media-ctl -r
mc_set_link $csi40name 1 $vinname2 1
mc_set_link $csi20name 1 $vinname4 1
test_compliance $vin2
# Need to get standard
v4l2-ctl -d /dev/$vin4 --get-detected-standard
test_compliance $vin4
