#!/bin/bash

# Lock file location
LOCK_FILE="/tmp/mic_mute_last_run"

# Get current time in milliseconds
current_time=$(date +%s%3N)

# Check if lock file exists
if [ -f "$LOCK_FILE" ]; then
    last_run=$(cat "$LOCK_FILE")
    diff=$((current_time - last_run))

    # If less than 200ms has passed since last run, exit (ignore duplicate)
    if [ "$diff" -lt 200 ]; then
        exit 0
    fi
fi

# Update the lock file with current time
echo "$current_time" > "$LOCK_FILE"

# --- YOUR MUTE COMMAND GOES BELOW ---
# Detect if using WirePlumber (Pipewire) or PulseAudio
if command -v wpctl &> /dev/null; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
elif command -v pamixer &> /dev/null; then
    pamixer --default-source -t
else
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi
