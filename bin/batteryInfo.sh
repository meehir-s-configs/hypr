#!/bin/bash

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get the battery status (Charging, Discharging, Full, Not charging, etc.)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Define the battery icons for each 20% segment
battery_icons=("" "" "" "" "")

# Define the charging and plugged-in icons
charging_icon=""
plugged_icon=""

# Calculate the index for the icon array (0–4)
icon_index=$(( battery_percentage / 20 ))

# Pick the base icon
battery_icon=${battery_icons[icon_index]}

# Override if Charging or AC
if [ "$battery_status" = "Charging" ]; then # Charging
    battery_icon="$charging_icon"
elif [ "$battery_status" = "Not charging" ]; then # Plugged in
    battery_icon="$plugged_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"

