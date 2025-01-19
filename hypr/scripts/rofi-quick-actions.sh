#!/bin/bash

# Quick Actions Rofi Script

declare -a options=(
    "🚀 Performance Mode"
    "⚖️ Balanced Mode"
    "🔋 Power Saver Mode"
)

chosen=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Quick Actions" -theme-str 'window {width: 20%;}')

case $chosen in
    "🚀 Performance Mode")
        powerprofilesctl set performance && notify-send "Power Profile" "Switched to Performance Mode"
        ;;
    "⚖️ Balanced Mode")
        powerprofilesctl set balanced && notify-send "Power Profile" "Switched to Balanced Mode"
        ;;
    "🔋 Power Saver Mode")
        powerprofilesctl set power-saver && notify-send "Power Profile" "Switched to Power Saver Mode"
        ;;
esac
