#!/bin/bash

# nerd font icons
CPU_ICON=""
GPU_ICON="󰇅"

# get cpu temp from k10temp-pci-00c3
CPU_TEMP=$(sensors | awk '/Tctl:/ {gsub("+", ""); printf "%.0f\n", $2}')

# get gpu temp using nvidia-smi
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | awk '{printf "%.0f\n", $1}')

# function to get color based on temperature
get_color() {
    local temp=$1
    if [ "$temp" -ge 80 ]; then
        echo "#F38BA8"  # Red
    elif [ "$temp" -ge 60 ]; then
        echo "#F9E2AF"  # Orange
    else
        echo "#74C7EC"  # Blue
    fi
}

# get colors based on temperatures
CPU_COLOR=$(get_color $CPU_TEMP)
GPU_COLOR=$(get_color $GPU_TEMP)

# output json format with pango markup for colors
echo -n "{\"text\": \"<span color='$CPU_COLOR'>$CPU_ICON $CPU_TEMP°C</span>  <span color='$GPU_COLOR'>$GPU_ICON $GPU_TEMP°C</span>\"}"
