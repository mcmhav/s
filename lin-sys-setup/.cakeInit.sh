#!/bin/sh

echo "$1"
ps=$(acpi -a)
echo $ps

run_once(){
    echo $1
    app="$1"
    # if [ "$1" = "google-chrome-stable" ]; then
    #     app="google-chrome"
    # fi
    echo $app
    if [ -z "`ps -Af | grep -o -w ".*$app" | grep -v grep | grep -v run-once`" ]; then
        echo "Starting " $1
        if [ "$1" = "xterm" ]; then
            "$@" &
            "$@" &
            "$@" & cd ~/repos/snake || exit;
            "$@" & cd ~/repos/snake || exit;
            "$@" & cd ~/repos/snake || exit;
            "$@" & cd ~/repos/snake || exit;
            "$@" -e top &
            "$@" -e "mongo" &
        fi
        if [ "$1" = "nemo" ]; then
            "$@" &
        fi
        "$@" &
    fi
}

if [ "$1" = "u" ]; then
    sudo pacman -Syyu --noconfirm &&
    exit
fi

if [ "$1" = "i" ]; then
    sudo pacman -S $2 --noconfirm &&
    exit
fi


if [ "$1" = "s" ]; then
    net=$(iwconfig wlp3s0 | awk -F ':' '/ESSID:*/ { print $2}' | cut -d '"' -f 2)
    if [ "$net" = "Cake" ]; then
        sleep 15 &&
        xrandr --output HDMI1 --auto --left-of LVDS1 &&
        sleep 2 &&
        run_once synergy &
    fi
    
    ON="Adapter 0: on-line"
    OFF="Adapter 0: off-line"
    
    if [ "$ps" = "$ON" ]; then
        echo "power";
    elif [ "$ps" = "$OFF" ]; then
        echo "battery";
    fi
    
    
    run_once xcompmgr &
    run_once xterm &
    run_once subl3 &
    run_once google-musicmanager &
    run_once nemo &
    run_once google-chrome-stable &
    #rund_once "conky -c ~/repos/s/conky/.conkyrc2" &
    # run_once "idea.sh" &
    # run_once syncdrive &
    
    echo "end";
    exit;
fi

exit;
