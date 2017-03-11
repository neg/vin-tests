#!/bin/bash

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

cvbsname="adv7482 4-0034"
hdminame="adv7482 4-0070"
