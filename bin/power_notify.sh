#!/usr/bin/env bash

dbus-monitor --system "sender='com.redhat.tuned'" | while read -r line; do
    if [[ "$line" == *"member=profile_changed"* ]]; then
        read -r next_line
        profile=$(echo "$next_line" | awk -F'"' '{print $2}')
        notify-send -t 3000 "Power Profile" "Switched to: $profile"
    fi
done
