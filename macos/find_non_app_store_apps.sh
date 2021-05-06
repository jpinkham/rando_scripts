#!/bin/bash
# Finds all installed Apps that used installers rather than App Store
#
# Ref: https://apple.stackexchange.com/a/267892
cd /Applications
for i in *.app; do
    [[ -d "$i/Contents/_MASReceipt" ]] || echo $i
done

# I added this :-)
cd -

