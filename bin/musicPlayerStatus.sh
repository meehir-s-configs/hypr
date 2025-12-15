#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 --title | --arturl | --artist | --length | --album | --source"
	exit 1
fi

# Function to get metadata using playerctl
get_metadata() {
	key=$1
	playerctl metadata --format "{{ $key }}" 2>/dev/null
}

# Check for arguments

# Function to determine the source and return an icon and text
get_source_info() {
	trackid=$(get_metadata "mpris:trackid")
	if [[ "$trackid" == *"brave"* ]]; then
		echo -e "Brave "
	elif [[ "$trackid" == *"chromium"* ]]; then
		echo -e "Chrome "
	else
		echo ""
	fi
}

scroll_title() {
    local full="${1}"
    local width=27
    local len=${#full}

    # if not overflowing, just echo
    if (( len <= width )); then
        echo "$full"
        return
    fi

    # compute an offset that advances every tick
    # here tick = every second; you can divide by 2 or 3 for slower scroll
    local tick=$(( $(date +%s) % len ))

    # slice out width characters, wrapping around
    if (( tick + width <= len )); then
        echo "${full:tick:width}"
    else
        # end is past end of string → wrap
        local part1=${full:tick}
        local part2=${full:0:((width - ${#part1}))}
        echo "${part1}${part2}"
    fi
}

# Parse the argument
case "$1" in
--title)
	title=$(get_metadata "xesam:title")
	if [ -z "$title" ]; then
		echo ""
	else
		echo "${title:0:28}" # Limit the output to 50 characters
	fi
	;;
--title-scroll)
    title=$(get_metadata "xesam:title")
    scroll_title "$title"
    ;;
--arturl)
	url=$(get_metadata "mpris:artUrl")
	if [ -z "$url" ]; then
		echo ""
	else
		if [[ "$url" == file://* ]]; then
			url=${url#file://}
		fi
		echo "$url"
	fi
	;;
--artist)
	artist=$(get_metadata "xesam:artist")
	if [ -z "$artist" ]; then
		echo ""
	else
		echo "${artist:0:30}" # Limit the output to 50 characters
	fi
	;;
#--length)
#	length=$(get_metadata "mpris:length")
#	if [ -z "$length" ]; then
#		echo ""
#	else
#		# Convert length from microseconds to a more readable format (seconds)
#		echo "$(echo "scale=2; $length / 1000000 / 60" | bc) m"
#	fi
#	;;
--length)
	len=$(get_metadata "mpris:length")
	if [ -n "$len" ]; then
		sec=$((len / 1000000))
		printf "%d:%02d m" $((sec / 60)) $((sec % 60))
	fi
	;;
--status)
	status=$(playerctl status 2>/dev/null)
	if [[ $status == "Playing" ]]; then
		echo ""
	elif [[ $status == "Paused" ]]; then
		echo ""
	else
		echo ""
	fi
	;;
--album)
	album=$(playerctl metadata --format "{{ xesam:album }}" 2>/dev/null)
	if [[ -n $album ]]; then
		echo "$album"
	else
		status=$(playerctl status 2>/dev/null)
		if [[ "$status" = "Stopped" || "$status" = "" ]]; then
			echo ""
		else
			echo "No album"
		fi
	fi
	;;
--source)
	get_source_info
	;;
*)
	echo "Invalid option: $1"
	echo "Usage: $0 --title | --url | --artist | --length | --album | --source"
	exit 1
	;;
esac
