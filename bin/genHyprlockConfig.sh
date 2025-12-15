#!/usr/bin/env bash
# genHyprlockConfig.sh
# Generates hyprlock configuration with relative-positioned music widgets

# Base offsets for the music player widget
player_x=-150
player_y=-300

# Compute absolute positions for each music widget
image_x=$((player_x))
image_y=$((player_y - 17))

title_x=$((player_x + 1030))
title_y=$((player_y + 10))

length_x=$((player_x - 580))
length_y=$((player_y - 10))

status_x=$((player_x - 590))
status_y=$((player_y + 10))

source_x=$((player_x - 590))
source_y=$((player_y - 47))

album_x=$((player_x + 1030))
album_y=$((player_y - 30))

artist_x=$((player_x + 1030))
artist_y=$((player_y - 10))

# Path to the generated config
OUT="$HOME/.config/hypr/hyprlock.conf"

# Ensure output directory exists
mkdir -p "$(dirname "$OUT")"

# Generate the configuration file
cat > "$OUT" <<EOF
source = ~/.cache/wal/colors-hyprland.conf

general{
    hide_cursor = true
}

# Background Image
background {
    monitor =
    path = /home/meehir/.cache/screenlock.png # Gets updated by lock.sh

    # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
    blur_passes = 3 # 0 disables blurring
    blur_size = 3
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.7
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
}

# Time label
label {
    monitor =
    text = cmd[update:1000] echo "\$TIME"
    color = \$foreground
    font_size = 70
    font_family = Calibri
    position = 0, 200
    halign = center
    valign = center
}

# password input field
input-field {
    monitor =
    size = 200, 50
    outline_thickness = 1
    dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = false
    dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
    outer_color = \$foreground
    inner_color = \$background
    font_color = \$foreground
    fade_on_empty = true
    fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
    placeholder_text = <i>   ;-)   </i> # Text rendered in the input box when it's empty.
    hide_input = false
    rounding = -1 # -1 means complete rounding (circle/oval)
    check_color = rgb(204, 136, 34)
    fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
    fail_text = <i>\$FAIL <b>(\$ATTEMPTS)</b></i> # can be set to empty
    fail_transition = 300 # transition time in ms between normal outer_color and fail_color
    capslock_color = -1
    numlock_color = -1
    bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
    invert_numlock = false # change color if numlock is off
    swap_font_color = false # see below

    position = 0, -20
    halign = center
    valign = center
}

# batteryInfo
label {
    monitor =
    text = cmd[update:1000] echo -e "\$(~/.config/hypr/bin/batteryInfo.sh)"
    color = \$foreground
    font_size = 35
    font_family = NotoSansM Nerd Font Propo
    position = -30, -550
    halign = right
    valign = center
}

# Music Player Info
image {
    monitor =
    path = 
    size = 77 # lesser side if not 1:1 ratio
    rounding = 5 # negative values mean circle
    border_size = 0
    rotate = 0 # degrees, counter-clockwise
    reload_time = 2
    reload_cmd = ~/.config/hypr/bin/musicPlayerStatus.sh --arturl
    position = $image_x, $image_y
    halign = center
    valign = center
    opacity=0.5
}

# PLAYER TITLE
label {
    monitor =
    #text = cmd[update:1000] echo "\$(playerctl metadata --format "{{ xesam:title }}" 2>/dev/null | cut -c1-25)"
    #text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --title)"
    text = cmd[update:200]  echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --title-scroll)"
    color = rgba(255, 255, 255, 0.8)
    font_size = 12
    font_family = Font Awesome 6 Brands Regular
    position = $title_x, $title_y
    halign = left
    valign = center
}

# PLAYER Length
label {
    monitor =
#    text= cmd[update:1000] echo "\$(( \$(playerctl metadata --format "{{ mpris:length }}" 2>/dev/null) / 60000000 ))m"
    text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --length) "
    color = rgba(255, 255, 255, 1)
    font_size = 11
    font_family = Font Awesome 6 Brands Regular 
    position = $length_x, $length_y
    halign = right
    valign = center
}

# PLAYER STATUS
label {
    monitor =
#    text= cmd[update:1000] echo "\$(( \$(playerctl metadata --format "{{ mpris:length }}" 2>/dev/null) / 60000000 ))m"
    text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --status)"
    color = rgba(255, 255, 255, 1)
    font_size = 14
    font_family = Font Awesome 6 Free Solid 
    position = $status_x, $status_y
    halign = right
    valign = center
}
# PLAYER SOURCE
label {
    monitor =
#    text= cmd[update:1000] echo "\$(playerctl metadata --format "{{ mpris:trackid }}" 2>/dev/null | grep -Eo "chromium|firefox|spotify")"
    text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --source)"
    color = rgba(255, 255, 255, 0.6)
    font_size = 10
    font_family = Font Awesome 6 Brands Regular 
    position = $source_x, $source_y
    halign = right
    valign = center
}

# PLAYER ALBUM
label {
    monitor =
#    text= cmd[update:1000] echo "\$(~/.config/hypr/bin/album.sh)"
    text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --album)"
    color = rgba(255, 255, 255, 1)
    font_size = 10 
    font_family = Font Awesome 6 Brands Regular
    position = $album_x, $album_y
    halign = left
    valign = center
}
# PLAYER Artist
label {
    monitor =
#    text = cmd[update:1000] echo "\$(playerctl metadata --format "{{ xesam:artist }}" 2>/dev/null | cut -c1-30)"
    text = cmd[update:1000] echo "\$(~/.config/hypr/bin/musicPlayerStatus.sh --artist)"
    color = rgba(255, 255, 255, 0.8)
    font_size = 10
    font_family = Font Awesome 6 Brands Regular
    position = $artist_x, $artist_y
    halign = left
    valign = center
}
EOF

echo "Generated hyprlock config at \$OUT"

