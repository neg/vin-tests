#!/bin/bash

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/m2.sh

test_compliance_begin

test_compliance $vin0
test_compliance $vin1

# Make sure we can dequeue all buffers
yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin0
yavta -f RGB565 -s 640x480 -n 4 --capture=10 /dev/$vin1

test_compliance_end
