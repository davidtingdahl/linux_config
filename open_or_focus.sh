#!/bin/bash


function open_or_focus
{
    label=$1
    command=$2

    wid=$(xdotool search --onlyvisible "$label"| head -n1)
    echo $wid

    if [ -z $wid ]
    then $command
    else
        xdotool windowactivate --sync $wid
    fi

}

[[ $# != 1 ]] && echo "Give command as argument" && exit 1

set -ex

cmd=$1

[[ $cmd == "emacs" ]]    && open_or_focus "GNU Emacs" emacs
[[ $cmd == "terminal" ]] && open_or_focus "Terminal" xfce4-terminal
[[ $cmd == "slack" ]]    && open_or_focus "slack" slack
[[ $cmd == "teams" ]]    && open_or_focus "teams" teams
[[ $cmd == "firefox" ]]  && open_or_focus "Mozilla" firefox

[[ $cmd == "calendar" ]] && browse https://outlook.office.com/calendar/view/month
[[ $cmd == "mail" ]] && browse https://outlook.office.com/mail/
[[ $cmd == "gerrit" ]] && browse https://gerrit.cicd.autoheim.net/dashboard/self

[[ $cmd == "spotify" ]] && open_or_focus Spotify spotify

