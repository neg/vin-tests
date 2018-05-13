#!/bin/bash

base=$(dirname $(readlink -f $0))

source $base/scripts/boards.sh

confirm() {
    local text=$1

    unset REPLY

    echo "====="

    while [[ ! $REPLY =~ ^[Nn]$ ]]; do
        read -p "$text (Y/n) " -n 1 -r

        case $REPLY in
            [Yy])
                echo
                return 0
                ;;
            "")
                return 0
                ;;
        esac
        echo
    done

    echo -e "Fail"
    exit 1
}

if [[ "$gen" == "gen3" ]]; then
    $base/test-mc-links.py || exit 1
fi

$base/test-compliance.sh || exit 1
$base/test-qv4l2.sh || exit 1

confirm "Are tests ok"
