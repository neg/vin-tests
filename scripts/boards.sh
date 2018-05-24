#!/bin/bash

info=$(strings /proc/device-tree/model)

case $info in
    "Renesas Salvator-X board based on r8a7795 ES1.x")
        gen="gen3"
        vins="0 1 2 3 4 5 6 7"
        csis="20 21 40 41"
        ;;
    "Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+")
        gen="gen3"
        vins="0 1 2 3 4 5 6 7"
        csis="20 40 41"
        ;;
    "Renesas Salvator-X board based on r8a7796" | \
        "Renesas Salvator-X 2nd version board based on r8a77965")
        gen="gen3"
        vins="0 1 2 3 4 5 6 7"
        csis="20 40"
        ;;
    "Renesas Eagle board based on r8a77970")
        gen="gen3"
        vins="0 1 2 3"
        csis="40"

        parallelname="adv7612 0-004c"
        # FIXME: This is a hack and not the correct mbus format
        # for V3M, but results in an image.
        parallelformat="YUYV8_1X16"
        ;;
    "Koelsch")
        gen="gen2"

        if [ -d /sys/devices/platform/soc ]; then
            vin0=$(basename /sys/devices/platform/soc/e6ef0000.video/video4linux/video*)
            vin1=$(basename /sys/devices/platform/soc/e6ef1000.video/video4linux/video*)
        else
            vin0=$(basename /sys/devices/platform/e6ef0000.video/video4linux/video*)
            vin1=$(basename /sys/devices/platform/e6ef1000.video/video4linux/video*)
        fi

        hdminame="adv7612"
        ;;

    *)
        echo "Unknown board identifier '$info'"
        exit 1
        ;;
esac

if [[ "$gen" == "gen3" ]]; then
    for vin in $vins; do
        eval "vin$vin=$(basename /sys/devices/platform/soc/e6ef${vin}000.video/video4linux/video*)"
        eval "vinname$vin='VIN$vin output'"
    done

    for csi in $csis; do
        case $csi in
            20) csi20name="rcar_csi2 fea80000.csi2" ;;
            21) csi21name="rcar_csi2 fea90000.csi2" ;;
            40) csi40name="rcar_csi2 feaa0000.csi2" ;;
            41) csi41name="rcar_csi2 feab0000.csi2" ;;
        esac
    done

    if [[ "$info" == "Renesas Eagle board based on r8a77970" ]]; then
        cvbsname="adv748x 0-0070 afe"
        hdminame="adv748x 0-0070 hdmi"

        txaname="adv748x 0-0070 txa"
        txbname="adv748x 0-0070 txb"
    else
        cvbsname="adv748x 4-0070 afe"
        hdminame="adv748x 4-0070 hdmi"

        txaname="adv748x 4-0070 txa"
        txbname="adv748x 4-0070 txb"
    fi
fi
