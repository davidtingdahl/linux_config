#!/usr/bin/env bash


# If the given program is running, it will receive focus. Otherwise it will open 
if [ $# -ne 1 ]
then
    echo "Give exec to open-or-focus as argument"
    exit 1
fi
cmd=$1
set -ex

wid=$(xdotool search --onlyvisible --class $1 | tail -n1)
echo $wid
xdotool windowactivate --sync $wid || $cmd
