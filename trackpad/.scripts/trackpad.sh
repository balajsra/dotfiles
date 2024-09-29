#!/usr/bin/env bash
trackpad_id=13

if xinput list-props $trackpad_id | grep "Device Enabled (.*):.*1" >/dev/null
then
    xinput disable $trackpad_id
    notify-send -u low -i mouse "Trackpad disabled" &
else
    xinput enable $trackpad_id
    notify-send -u low -i mouse "Trackpad enabled" &
fi
