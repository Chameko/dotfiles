#!/usr/bin/env bash

herbstclient watch tags.focus.frame_count
herbstclient --idle attribute_changed | while read hook name
do
    if [ $(herbstclient attr tags.focus.frame_count) -lt 2 ]
    then
        herbstclient set frame_transparent_width 0
    else 
        herbstclient set frame_transparent_width 4
    fi
done