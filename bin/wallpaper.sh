#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/p1"
CACHE_FILE="$HOME/.cache/curwall.png"

IMG_MORNING="$WALLPAPER_DIR/t1.png"
IMG_AFTERNOON="$WALLPAPER_DIR/t2.png"
IMG_EVENING="$WALLPAPER_DIR/t3.png"
IMG_NIGHT="$WALLPAPER_DIR/t4.png"

# Initialize state tracker
CURRENT_IMAGE=""

apply_wallpaper() {
    local new_image="$1"

    # Only run if the image is different to avoid redundant processing
    if [[ "$CURRENT_IMAGE" != "$new_image" ]]; then
        echo "Switching wallpaper to: $new_image"

        #Start hyprpaper if it's not running
        if ! pgrep -x "hyprpaper" > /dev/null; then
            hyprpaper &
            sleep 1
        fi

        #Preload the NEW image into RAM
        hyprctl hyprpaper preload "$new_image"

        #Set the NEW image as wallpaper (The comma sets it for all monitors)
        hyprctl hyprpaper wallpaper ",$new_image"

        if [[ -n "$CURRENT_IMAGE" ]]; then
            hyprctl hyprpaper unload "$CURRENT_IMAGE"
        fi

        cp "$new_image" "$CACHE_FILE"

        matugen image "$new_image" --mode dark --type scheme-fruit-salad

        killall -SIGUSR2 waybar

        #Update the current state
        CURRENT_IMAGE="$new_image"
    fi
}

#Main Logic Loop
while true; do
    hour=$(date +%-H)

    if [[ $hour -le 4 || $hour -ge 19 ]]; then
        apply_wallpaper "$IMG_NIGHT"
    elif [[ $hour -le 10 ]]; then
        apply_wallpaper "$IMG_MORNING"
    elif [[ $hour -le 16 ]]; then
        apply_wallpaper "$IMG_AFTERNOON"
    else
        apply_wallpaper "$IMG_EVENING"
    fi

    sleep 60
done
