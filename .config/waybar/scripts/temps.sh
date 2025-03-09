#!/bin/bash

# nerd font icons
CPU_ICON=""
GPU_ICON="󰍹"

# get cpu temp from k10temp-pci-00c3
CPU_TEMP=$(sensors | awk '/Tctl:/ {gsub("+", ""); print $2}')
CPU_TEMP=${CPU_TEMP%°C}  # remove the °C suffix if present
CPU_TEMP=${CPU_TEMP%.*}  # convert to integer by removing decimal part if any

# get gpu temp using nvidia-smi
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | awk '{print $1}')
GPU_TEMP=${GPU_TEMP%°C}  # remove the °C suffix if present
GPU_TEMP=${GPU_TEMP%.*}  # convert to integer by removing decimal part if any

# function to get color based on temperature
get_colored_icon_temp() {
  local temp=$1
  local icon=$2
  if (( temp < 60 )); then
    echo "<span color='#A6E3A1'>$icon $temp°C</span>"  # green for low temp
  elif (( temp < 80 )); then
    echo "<span color='#F9E2AF'>$icon $temp°C</span>"  # yellow for moderate temp
  else
    echo "<span color='#F38BA8'>$icon $temp°C</span>"  # red for high temp
  fi
}

# get colored temperature strings with icons
CPU_TEMP_COLORED=$(get_colored_icon_temp $CPU_TEMP "$CPU_ICON")
GPU_TEMP_COLORED=$(get_colored_icon_temp $GPU_TEMP "$GPU_ICON")

# output json format
echo -n "{\"text\": \"$CPU_TEMP_COLORED  $GPU_TEMP_COLORED\"}"
