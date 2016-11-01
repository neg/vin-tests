#!/bin/bash

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

test_compliance() {
    dev=/dev/$1

    if [ ! -c $dev ]; then
        echo "ERROR: $dev is not a video device"
        exit 1
    fi

    # clear dmesg
    dmesg -c > /dev/null

    echo "* v4l2-compliance"
    if ! v4l2-compliance -d $dev -s -f; then
        echo "compliance failed"
        exit 1
    fi

    echo "* dmesg"
    dmesg

    confirm "Are compliance for $dev ok"
}

test_qv4l2() {
    dev=/dev/$1

    echo "* qv4l2"
    qv4l2 -d $dev
    confirm "Are qv4l2 for $dev ok"
}
