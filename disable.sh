#!/bin/bash
set -e
home=`dirname $(readlink -e $0)`

if [ $# = 0 ]; then
    capes=`find "$home" -mindepth 1 -maxdepth 1 -name '*.dts' -printf '%f '`
    test $? = 0 || { echo "No cape names given and no *.dts files found."; exit 1; }
    capes=${capes/.dts/}
else
    capes="$@"
fi
source variables

for cape in $capes; do
    if cat "$SLOTS" | grep $cape &> /dev/null; then
        number=`cat "$SLOTS" | grep $cape | tail -1 | cut -d ' ' -d ':' -f 1`
        echo "Disabling cape $cape with number $number"
        echo "-$number" > "$SLOTS"
    else
        echo "Cape $cape is not enabled."
    fi
done
