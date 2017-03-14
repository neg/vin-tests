#!/bin/bash

set -e

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/m3.sh

test_compliance_begin

media-ctl -r
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi20name" 1 "$vinname1" 1
mc_propagate_format "$hdminame" 10 "$csi40name" 1 "$vinname0"
mc_propagate_format "$cvbsname" 11 "$csi20name" 1 "$vinname1"
test_compliance_mc $vin0
test_compliance_mc $vin1

media-ctl -r
mc_set_link "$csi40name" 1 "$vinname2" 1
mc_set_link "$csi20name" 1 "$vinname4" 1
mc_propagate_format "$hdminame" 10 "$csi40name" 1 "$vinname2"
mc_propagate_format "$cvbsname" 11 "$csi20name" 1 "$vinname4"
test_compliance_mc $vin2
test_compliance_mc $vin4

# Make sure we can dequeue all buffers
yavta -n 4 --capture=10 /dev/$vin2
yavta -n 4 --capture=10 /dev/$vin4

test_compliance_end
