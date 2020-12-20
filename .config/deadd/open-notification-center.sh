#!/bin/sh
# Toggle between hidden and shown state of the notification center
kill -s USR1 $(pidof deadd-notification-center)
