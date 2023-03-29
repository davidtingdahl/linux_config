#!/usr/bin/env bash


# If the given program is running, it will receive focus. Otherwise it will open 
if [ $# -ne 1 ]
then
    echo "Give exec to open-or-focus as argument"
    exit 1
fi
cmd=$1
set -ex
xdotool search --onlyvisible --class $1 windowactivate --sync || $cmd
