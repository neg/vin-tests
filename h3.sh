#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/boards.sh

if [[ $gen3es == "1.x" ]]; then
    $base/h3es1-mc-setup.sh || exit 1
elif [[ $gen3es == "2.0" ]]; then
    $base/h3es2-mc-setup.sh || exit 1
else
    echo "Unkown Gen3 ES $gen3es"
    exit 1
fi

$base/compliance.sh || exit 1
$base/qv4l2.sh || exit 1

echo "All Ok"
