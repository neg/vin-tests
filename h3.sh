#!/bin/bash

base=$(dirname $(readlink -f $0))

$base/h3-mc-setup.sh || exit 1
$base/compliance.sh || exit 1
$base/h3-qv4l2.sh || exit 1

echo "All Ok"
