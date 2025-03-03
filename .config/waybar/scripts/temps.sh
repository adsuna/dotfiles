#!/bin/bash

# Nerd font icons
CPU_ICON=""
GPU_ICON="󰍹"

# Get CPU temp from k10temp-pci-00c3
CPU_TEMP=$(sensors | awk '/Tctl:/ {gsub("+", ""); print $2}')
CPU_TEMP=${CPU_TEMP%°C}  # Remove the °C suffix if present

# Get GPU temp using nvidia-smi
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | awk '{print $1}')
GPU_TEMP=${GPU_TEMP%°C}  # Remove the °C suffix if present

# Function to get color based on temperature
get_color() {
  local temp=$1
  if (( $(echo "$temp < 60" | bc -l) )); then
    echo "<span color='#00FF00'>$temp°C</span>"  # Green for low temp
  elif (( $(echo "$temp < 80" | bc -l) )); then
    echo "<span color='#FFFF00'>$temp°C</span>"  # Yellow for moderate temp
  else
    echo "<span color='#FF0000'>$temp°C</span>"  # Red for high temp
  fi
}

# Get colored temperature strings
CPU_TEMP_COLORED=$(get_color $CPU_TEMP)
GPU_TEMP_COLORED=$(get_color $GPU_TEMP)

# Output JSON format
echo -n "{\"text\": \"$CPU_ICON $CPU_TEMP_COLORED  $GPU_ICON $GPU_TEMP_COLORED\"}"
