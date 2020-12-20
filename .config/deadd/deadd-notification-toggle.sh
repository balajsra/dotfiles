#!/bin/sh

STATUS_FILE=~/.config/deadd/status

if [[ ! -f $STATUS_FILE ]]; then
    echo 1 >$STATUS_FILE
fi

status=$(cat $STATUS_FILE)

if [[ $status == 1 ]]; then
    # Set status to off
    echo 0 >$STATUS_FILE
elif [[ $status == 0 ]]; then
    # Set status to on
    echo 1 >$STATUS_FILE
fi
