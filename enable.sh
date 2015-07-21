#!/bin/bash
set -e
home=`dirname $(readlink -e $0)`

if [ $# = 0 ]; then
    capes=`find "$home" -mindepth 1 -maxdepth 1 -name '*.dts' -printf '%f '`
    test $? = 0 || { echo "No cape names given and no *.dts files found."; exit 1; }
    capes=${capes%.dts}
else
    capes="$@"
fi
source variables

for cape in $capes; do
    if cat "$SLOTS" | grep $cape &> /dev/null; then
        echo "Cape $cape is already enabled."
    else
        find $FIRMWARE -name "$cape*.dtbo" || { echo "Cannot enable cape, .dtbo object not found in $FIRMWARE."; exit 1; }
        echo "Enabling cape $cape..."
        echo "$cape" > "$SLOTS"
    fi
done
