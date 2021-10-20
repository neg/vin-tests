#!/bin/python3

import sys
import os
import subprocess

class VIN:
    def __init__(self, num):
        self.num = num

    def name(self):
        return "'VIN%d output':0" % (self.num)

    def __str__(self):
        return "VIN%d" % (self.num)

class CSI:
    def __init__(self, abrv, name):
        self.abrv = abrv
        self.name = name

    def __str__(self):
        return self.abrv

class CSIVC:
    def __init__(self, csi, vc, failok):
        self.csi = csi
        self.vc = vc
        self.failok = failok

    def csi_name(self):
        return self.csi.name

    def name(self):
        # Increment vc by one as we have 1 source pad
        return "'%s':%d" % (self.csi.name, self.vc + 1)

    def __str__(self):
        return "%s/VC%d" % (self.csi, self.vc)

VIN0 = VIN(0)
VIN1 = VIN(1)
VIN2 = VIN(2)
VIN3 = VIN(3)
VIN4 = VIN(4)
VIN5 = VIN(5)
VIN6 = VIN(6)
VIN7 = VIN(7)

CSI20 = CSI("CSI20", "rcar_csi2 fea80000.csi2")
CSI21 = CSI("CSI21", "rcar_csi2 fea90000.csi2")
CSI40 = CSI("CSI40", "rcar_csi2 feaa0000.csi2")
CSI41 = CSI("CSI41", "rcar_csi2 feab0000.csi2")

CSI20_VC0 = CSIVC(CSI20, 0, False)
CSI20_VC1 = CSIVC(CSI20, 1, False)
CSI20_VC2 = CSIVC(CSI20, 2, False)
CSI20_VC3 = CSIVC(CSI20, 3, False)
CSI21_VC0 = CSIVC(CSI21, 0, True)
CSI21_VC1 = CSIVC(CSI21, 1, True)
CSI21_VC2 = CSIVC(CSI21, 2, True)
CSI21_VC3 = CSIVC(CSI21, 3, True)
CSI40_VC0 = CSIVC(CSI40, 0, False)
CSI40_VC1 = CSIVC(CSI40, 1, False)
CSI40_VC2 = CSIVC(CSI40, 2, False)
CSI40_VC3 = CSIVC(CSI40, 3, False)
CSI41_VC0 = CSIVC(CSI41, 0, True)
CSI41_VC1 = CSIVC(CSI41, 1, True)
CSI41_VC2 = CSIVC(CSI41, 2, True)
CSI41_VC3 = CSIVC(CSI41, 3, True)

h3_m3n = {0: {
                0: {VIN0: CSI40_VC0, VIN1: CSI20_VC0, VIN2: CSI20_VC1, VIN3: CSI40_VC1},
                1: {VIN0: CSI20_VC0, VIN1: CSI40_VC1, VIN2: CSI40_VC0, VIN3: CSI20_VC1},
                2: {VIN0: CSI40_VC1, VIN1: CSI40_VC0, VIN2: CSI20_VC0, VIN3: CSI20_VC1},
                3: {VIN0: CSI40_VC0, VIN1: CSI40_VC1, VIN2: CSI40_VC2, VIN3: CSI40_VC3},
                4: {VIN0: CSI20_VC0, VIN1: CSI20_VC1, VIN2: CSI20_VC2, VIN3: CSI20_VC3},
            },
         1: {
                0: {VIN4: CSI41_VC0, VIN5: CSI20_VC0, VIN6: CSI20_VC1, VIN7: CSI41_VC1},
                1: {VIN4: CSI20_VC0, VIN5: CSI41_VC1, VIN6: CSI41_VC0, VIN7: CSI20_VC1},
                2: {VIN4: CSI41_VC1, VIN5: CSI41_VC0, VIN6: CSI20_VC0, VIN7: CSI20_VC1},
                3: {VIN4: CSI41_VC0, VIN5: CSI41_VC1, VIN6: CSI41_VC2, VIN7: CSI41_VC3},
                4: {VIN4: CSI20_VC0, VIN5: CSI20_VC1, VIN6: CSI20_VC2, VIN7: CSI20_VC3},
            }
        }

h3_es1 = {0: {
                0: {VIN0: CSI40_VC0, VIN1: CSI20_VC0, VIN2: CSI21_VC0, VIN3: CSI40_VC1},
                1: {VIN0: CSI20_VC0, VIN1: CSI21_VC0, VIN2: CSI40_VC0, VIN3: CSI20_VC1},
                2: {VIN0: CSI21_VC0, VIN1: CSI40_VC0, VIN2: CSI20_VC0, VIN3: CSI21_VC1},
                3: {VIN0: CSI40_VC0, VIN1: CSI40_VC1, VIN2: CSI40_VC2, VIN3: CSI40_VC3},
                4: {VIN0: CSI20_VC0, VIN1: CSI20_VC1, VIN2: CSI20_VC2, VIN3: CSI20_VC3},
                5: {VIN0: CSI21_VC0, VIN1: CSI21_VC1, VIN2: CSI21_VC2, VIN3: CSI21_VC3},
             },
          1: {
                0: {VIN4: CSI41_VC0, VIN5: CSI20_VC0, VIN6: CSI21_VC0, VIN7: CSI41_VC1},
                1: {VIN4: CSI20_VC0, VIN5: CSI21_VC0, VIN6: CSI41_VC0, VIN7: CSI20_VC1},
                2: {VIN4: CSI21_VC0, VIN5: CSI41_VC0, VIN6: CSI20_VC0, VIN7: CSI21_VC1},
                3: {VIN4: CSI41_VC0, VIN5: CSI41_VC1, VIN6: CSI41_VC2, VIN7: CSI41_VC3},
                4: {VIN4: CSI20_VC0, VIN5: CSI20_VC1, VIN6: CSI20_VC2, VIN7: CSI20_VC3},
                5: {VIN4: CSI21_VC0, VIN5: CSI21_VC1, VIN6: CSI21_VC2, VIN7: CSI21_VC3},
             }
        }

m3w    = {0: {
                0: {VIN0: CSI40_VC0, VIN1: CSI20_VC0, VIN2: None,      VIN3: CSI40_VC1},
                1: {VIN0: CSI20_VC0, VIN1: None,      VIN2: CSI40_VC0, VIN3: CSI20_VC1},
                2: {VIN0: None,      VIN1: CSI40_VC0, VIN2: CSI20_VC0, VIN3: None     },
                3: {VIN0: CSI40_VC0, VIN1: CSI40_VC1, VIN2: CSI40_VC2, VIN3: CSI40_VC3},
                4: {VIN0: CSI20_VC0, VIN1: CSI20_VC1, VIN2: CSI20_VC2, VIN3: CSI20_VC3},
            },
         1: {
                0: {VIN4: CSI41_VC0, VIN5: CSI20_VC0, VIN6: None,      VIN7: CSI41_VC1},
                1: {VIN4: CSI20_VC0, VIN5: None,      VIN6: CSI41_VC0, VIN7: CSI20_VC1},
                2: {VIN4: None,      VIN5: CSI41_VC0, VIN6: CSI20_VC0, VIN7: None     },
                3: {VIN4: CSI41_VC0, VIN5: CSI41_VC1, VIN6: CSI41_VC2, VIN7: CSI41_VC3},
                4: {VIN4: CSI20_VC0, VIN5: CSI20_VC1, VIN6: CSI20_VC2, VIN7: CSI20_VC3},
            }
        }

v3m    = {0: {
                0: {VIN0: CSI40_VC0, VIN1: None,      VIN2: None,      VIN3: CSI40_VC1},
                1: {VIN0: None,      VIN1: None,      VIN2: CSI40_VC0, VIN3: None     },
                2: {VIN0: None,      VIN1: CSI40_VC0, VIN2: None,      VIN3: None     },
                3: {VIN0: CSI40_VC0, VIN1: CSI40_VC1, VIN2: CSI40_VC2, VIN3: CSI40_VC3},
            },
         1: None
        }


class Lookup:
    mdev = subprocess.check_output("for mdev in /dev/media* ; do if [[ \"$(media-ctl -d $mdev -p | grep 'rcar_vin')\" != \"\" ]]; then echo -n $mdev; fi; done", shell=True).decode("utf-8")
    def model(self):
        return subprocess.check_output("media-ctl -p -d %s | awk '/^model/{printf $2}'" % (self.mdev), shell=True).decode("utf-8")

def csi_available(csi):
    if os.system("media-ctl -d %s -p | grep -q \"%s\"" % (Lookup.mdev, csi.csi_name())) != 0:
        return False
    return True

def links_reset():
    if os.system("media-ctl -d %s -r" % (Lookup.mdev)) != 0:
        raise Exception("Failed to reset media graph")

def link_set(vin, csi, mode):
    if csi == None:
        return True

    if not csi_available(csi):
        if csi.failok:
            print("SKIP - Set link for %s to %s as CSI-2 not available" % (vin, csi))
            return True

        print("FAIL - %s required but not found in system" % (csi))
        return False

    #print("Try set link for %s -> %s [%d]" % (csi, vin, mode))
    if os.system("media-ctl -d %s -l \"%s -> %s [%d]\" > /dev/null" % (Lookup.mdev, csi.name(), vin.name(), mode)) != 0:
        return False
    return True

def link_set_row(row, skip, mode):
    for vin in row:
        if vin == skip:
            continue

        if not link_set(vin, row[vin], mode):
            print("FAIL - Link from %s -> %s [%d] is not possible" % (vin.name(), row[vin].name(), mode))

    return True

# Test 1 - Try single links
#
# Looper over SoC data and try to enable and disable
# all valid links and make sure it's possible.

def test_single(data):
    for chsel in data:
        row = data[chsel]
        for vin in row:
            if not link_set(vin, row[vin], 1):
                print("FAIL - Link from %s to %s is not possible to enable" % (vin, row[vin]))

            if not link_set(vin, row[vin], 0):
                print("FAIL - Link from %s to %s is not possible to disable" % (vin, row[vin]))

    return True

# Test 2 - Full CHSEL row
#
# Sel all VIN -> CSI-2 links for a row and try to enable additional
# valid links that are not possible due to other links.

def test_full_chsel_already_enabled(row, avin, acsi):

    for vin in row:
        if vin == avin and row[vin] == acsi:
            return True
    return False


def test_full_chsel_fail_row(data, chsel_used):
    for chsel in data:
        if chsel == chsel_used:
            continue

        row = data[chsel]

        for vin in row:
            csi = row[vin]

            if csi == None:
                continue

            if test_full_chsel_already_enabled(data[chsel_used], vin, csi):
                print("SKIP - Link from %s to %s already enabled" % (vin, csi))
                continue

            if not csi_available(csi) and csi.failok:
                print("SKIP - Row Link from %s as it's not available in system" % (csi))
                continue

            if link_set(vin, csi, 1):
                print("FAIL - Link from %s to %s is possible when it should NOT be" % (vin, csi))
                continue

    return True

def test_full_chsel(data):
    for chsel in data:

        runok = False
        row = data[chsel]
        for vin in data[chsel]:
            if data[chsel][vin] == None:
                continue
            if csi_available(data[chsel][vin]):
                runok = True
                break

        if not runok:
            print("SKIP - No links avaiable for chsel %d" % (chsel))
            continue

        if not link_set_row(data[chsel], None, 1):
            return False

        if not test_full_chsel_fail_row(data, chsel):
            return False

        if not link_set_row(data[chsel], None, 0):
            return False


    return True

# Test setup

def run_test(data, vins):
    print("Test 1 - Single links")
    if not test_single(data):
        return False

    print("Test 2 - Full rows")
    if not test_full_chsel(data):
        return False

    return True

def test(data):

    links_reset()

    print("=== First half ===")
    if not run_test(data[0], [VIN0, VIN1, VIN2, VIN3]):
        return False

    if not data[1]:
        return True

    print("=== Second half ===")
    if not run_test(data[1], [VIN4, VIN5, VIN6, VIN7]):
        return False

    return True

def main(argv):

    if Lookup.mdev == "":
        print("No media device found")
        sys.exit(1)

    model = Lookup().model()

    if model == "renesas,vin-r8a7795":
        # ES1.x is special...
        if os.system("grep -q ES1.x /proc/device-tree/model") == 0:
            status = test(h3_es1)
        else:
            status = test(h3_m3n)
    elif model == "renesas,vin-r8a7796":
        status = test(m3w)
    elif model == "renesas,vin-r8a77965":
        status = test(h3_m3n)
    elif model == "renesas,vin-r8a77970":
        status = test(v3m)
    else:
        print("Unkown model %s" % (model))
        sys.exit(1)

    links_reset()

    if not status:
        print("Fail")
        sys.exit(1)

    print("All OK")
    sys.exit(0)

if __name__ == "__main__":
    main(sys.argv)
