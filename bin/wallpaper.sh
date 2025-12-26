#!/bin/bash

t=0  # Set the redundancy variable
main() {
  # Get current hour
  current_hour=$(date +%H | sed 's/^0//')

  # Set wallpaper based on time interval using hyprpaper arguments
  if [[ $current_hour -ge 5 && $current_hour -le 10  && $t -ne 1 ]]; then
    killall hyprpaper
    hyprpaper --config ~/.config/hypr/hyprpaper/morning.conf &
    cp ~/Pictures/wallpapers/p1/t1.png ~/.cache/curwall.png
    wal -c
    wal -qtsi .cache/curwall.png
    killall waybar
    waybar &
    t=1
  elif [[ $current_hour -ge 11 && $current_hour -le 16 && $t -ne 2 ]]; then
    killall hyprpaper
    hyprpaper --config ~/.config/hypr/hyprpaper/afternoon.conf &
    cp ~/Pictures/wallpapers/p1/t2.png ~/.cache/curwall.png
    wal -c
    wal -qtsi .cache/curwall.png
    killall waybar
    waybar &
    t=2
  elif [[ $current_hour -ge 17 && $current_hour -le 18 && $t -ne 3 ]]; then
    killall hyprpaper
    hyprpaper --config ~/.config/hypr/hyprpaper/evening.conf &
    cp ~/Pictures/wallpapers/p1/t3.png ~/.cache/curwall.png
    wal -c
    wal -qtsi .cache/curwall.png
    killall waybar
    waybar &
    t=3
  elif [[ ( $current_hour -ge 19 || $current_hour -le 4 ) &&  $t -ne 4 ]]; then
    killall hyprpaper
    hyprpaper --config ~/.config/hypr/hyprpaper/night.conf &
    cp ~/Pictures/wallpapers/p1/t4.png ~/.cache/curwall.png
    wal -c
    wal -qtsi .cache/curwall.png
    killall waybar
    waybar &
    t=4
  fi
}

# Set wallpaper initially
main

# Run the script periodically
while true; do
  sleep 60  # Change the interval here (in seconds)
  main
done
