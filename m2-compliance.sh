#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/vin-tests.sh
source $base/scripts/m2.sh

test_compliance_begin

v4l2-ctl --set-dv-bt-timings=query -d /dev/$vin0
test_compliance $vin0

std=$(v4l2-ctl --get-detected-standard -d /dev/$vin1 | awk '/Video Standard/{print $4}')
v4l2-ctl --set-standard=$std -d /dev/$vin1
test_compliance $vin1

# Make sure we can dequeue all buffers
yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin0
yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin1

test_compliance_end
