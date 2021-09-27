#!/usr/bin/env bash

# get input from argument or STDIN
if [[ -n $1 ]]; then
    ARG1=$1
else
    # try STDIN
#    ARG1=read -t 0
    ARG1=$(cat /dev/stdin)
fi
echo "input >$ARG1<"
FIRSTCHAR=${ARG1:0:1}
if [ -z "${FIRSTCHAR##[0-9]}" ]; then
    dig +short -x $ARG1
else
    dig +short $ARG1
fi
