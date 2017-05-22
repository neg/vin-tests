#!/bin/bash

set -e

base=$(readlink -f $(dirname $0))

source $base/scripts/vin-tests.sh
source $base/scripts/h3.sh

mc_reset
mc_set_link "$csi40name" 1 "$vinname0" 1
mc_set_link "$csi20name" 1 "$vinname1" 1

mc_propagate_hdmi "$vinname0"
mc_propagate_cvbs "$vinname1"
