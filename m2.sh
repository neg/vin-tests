#!/bin/bash

base=$(readlink -f $(dirname $0))

$base/m2-compliance.sh || exit 1
$base/m2-qv4l2.sh || exit 1

echo "All Ok"
