#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)
kak -clear
sessions=$(kak -l)
if [[ $sessions ]]; then
    echo "${bold}Choose session:${normal}"
    for s in $sessions; do
        if [ $s == "main" ];then
            kak -c main
        fi
    done
    select s in $sessions
    do
        kak -c $s
        break
    done
else
    kak -s main
fi
