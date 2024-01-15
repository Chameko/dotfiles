#!/bin/bash

if [ true == $(pamixer --get-mute) ]; then
    echo -1
    exit
else
    pamixer --get-volume
fi
