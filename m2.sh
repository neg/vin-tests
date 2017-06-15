#!/bin/bash

base=$(dirname $(readlink -f $0))

$base/compliance.sh || exit 1
$base/qv4l2.sh || exit 1

echo "All Ok"
