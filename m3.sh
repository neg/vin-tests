#!/bin/bash

base=$(dirname $(readlink -f $0))

$base/m3-mc-setup.sh || exit 1
$base/compliance.sh || exit 1
$base/m3-qv4l2.sh || exit 1

echo "All Ok"
