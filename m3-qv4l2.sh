#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/m3.sh

media-ctl -r
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi20name" 1 "$vinname1" 1
mc_set_link "$csi20name" 1 "$vinname6" 1

# Need to get standard
v4l2-ctl -d /dev/$vin1 --get-detected-standard
v4l2-ctl -d /dev/$vin6 --get-detected-standard

# Test HDMI
test_qv4l2 $vin0

# Test CVBS
test_qv4l2 $vin1

# Test dual CVBS
test_qv4l2_dual $vin1 $vin6

# Test dual CVBS+HDMI
test_qv4l2_dual $vin1 $vin0
