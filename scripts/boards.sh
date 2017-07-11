#!/bin/bash

info=$(strings /proc/device-tree/model)

case $info in
    "Renesas Salvator-X board based on r8a7795 ES1.x")
        echo "Board: H3 ES1.x"
        gen="gen3"
        gen3es="1.x"
        vin0=$(basename /sys/devices/platform/soc/e6ef0000.video/video4linux/video*)
        vin1=$(basename /sys/devices/platform/soc/e6ef1000.video/video4linux/video*)
        vin2=$(basename /sys/devices/platform/soc/e6ef2000.video/video4linux/video*)
        vin3=$(basename /sys/devices/platform/soc/e6ef3000.video/video4linux/video*)
        vin4=$(basename /sys/devices/platform/soc/e6ef4000.video/video4linux/video*)
        vin5=$(basename /sys/devices/platform/soc/e6ef5000.video/video4linux/video*)
        vin6=$(basename /sys/devices/platform/soc/e6ef6000.video/video4linux/video*)
        vin7=$(basename /sys/devices/platform/soc/e6ef7000.video/video4linux/video*)

        vinname0="rcar_vin e6ef0000.video"
        vinname1="rcar_vin e6ef1000.video"
        vinname2="rcar_vin e6ef2000.video"
        vinname3="rcar_vin e6ef3000.video"
        vinname4="rcar_vin e6ef4000.video"
        vinname5="rcar_vin e6ef5000.video"
        vinname6="rcar_vin e6ef6000.video"
        vinname7="rcar_vin e6ef7000.video"

        csi20name="rcar_csi2 fea80000.csi2"
        csi21name="rcar_csi2 fea90000.csi2"
        csi40name="rcar_csi2 feaa0000.csi2"
        csi41name="rcar_csi2 feab0000.csi2"

        cvbsname="adv748x 4-0070 afe"
        hdminame="adv748x 4-0070 hdmi"

        txaname="adv748x 4-0070 txa"
        txbname="adv748x 4-0070 txb"
        ;;

    "Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+")
        echo "Board: H3 ES2.0+"
        gen="gen3"
        gen3es="2.0"
        vin0=$(basename /sys/devices/platform/soc/e6ef0000.video/video4linux/video*)
        vin1=$(basename /sys/devices/platform/soc/e6ef1000.video/video4linux/video*)
        vin2=$(basename /sys/devices/platform/soc/e6ef2000.video/video4linux/video*)
        vin3=$(basename /sys/devices/platform/soc/e6ef3000.video/video4linux/video*)
        vin4=$(basename /sys/devices/platform/soc/e6ef4000.video/video4linux/video*)
        vin5=$(basename /sys/devices/platform/soc/e6ef5000.video/video4linux/video*)
        vin6=$(basename /sys/devices/platform/soc/e6ef6000.video/video4linux/video*)
        vin7=$(basename /sys/devices/platform/soc/e6ef7000.video/video4linux/video*)

        vinname0="rcar_vin e6ef0000.video"
        vinname1="rcar_vin e6ef1000.video"
        vinname2="rcar_vin e6ef2000.video"
        vinname3="rcar_vin e6ef3000.video"
        vinname4="rcar_vin e6ef4000.video"
        vinname5="rcar_vin e6ef5000.video"
        vinname6="rcar_vin e6ef6000.video"
        vinname7="rcar_vin e6ef7000.video"

        csi20name="rcar_csi2 fea80000.csi2"
        csi40name="rcar_csi2 feaa0000.csi2"
        csi41name="rcar_csi2 feab0000.csi2"

        cvbsname="adv748x 4-0070 afe"
        hdminame="adv748x 4-0070 hdmi"

        txaname="adv748x 4-0070 txa"
        txbname="adv748x 4-0070 txb"
        ;;

    "Renesas Salvator-X board based on r8a7796")
        echo "Board: M3"
        gen="gen3"
        vin0=$(basename /sys/devices/platform/soc/e6ef0000.video/video4linux/video*)
        vin1=$(basename /sys/devices/platform/soc/e6ef1000.video/video4linux/video*)
        vin2=$(basename /sys/devices/platform/soc/e6ef2000.video/video4linux/video*)
        vin3=$(basename /sys/devices/platform/soc/e6ef3000.video/video4linux/video*)
        vin4=$(basename /sys/devices/platform/soc/e6ef4000.video/video4linux/video*)
        vin5=$(basename /sys/devices/platform/soc/e6ef5000.video/video4linux/video*)
        vin6=$(basename /sys/devices/platform/soc/e6ef6000.video/video4linux/video*)
        vin7=$(basename /sys/devices/platform/soc/e6ef7000.video/video4linux/video*)

        vinname0="rcar_vin e6ef0000.video"
        vinname1="rcar_vin e6ef1000.video"
        vinname2="rcar_vin e6ef2000.video"
        vinname3="rcar_vin e6ef3000.video"
        vinname4="rcar_vin e6ef4000.video"
        vinname5="rcar_vin e6ef5000.video"
        vinname6="rcar_vin e6ef6000.video"
        vinname7="rcar_vin e6ef7000.video"

        csi20name="rcar_csi2 fea80000.csi2"
        csi40name="rcar_csi2 feaa0000.csi2"

        cvbsname="adv748x 4-0070 afe"
        hdminame="adv748x 4-0070 hdmi"

        txaname="adv748x 4-0070 txa"
        txbname="adv748x 4-0070 txb"
        ;;

    "Koelsch")
        echo "Board: M2"
        gen="gen2"
        vin0=$(basename /sys/devices/platform/e6ef0000.video/video4linux/video*)
        vin1=$(basename /sys/devices/platform/e6ef1000.video/video4linux/video*)
        ;;

    *)
        echo "Unknown board identifier '$info'"
        exit 1
        ;;
esac
