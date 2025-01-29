#!/usr/bin/env sh
wallpaper=$(yad --file --title="Pick a Wallpaper" --filter="*.jpg *.png *.gif" --width=500 --height=400)

if [ -f "$wallpaper" ]; then
    swww img "$wallpaper" --transition-step 100 --transition-fps 165 --transition-type grow --transition-angle 30 --transition-duration 1 && cp "$wallpaper" ~/.config/background
fi
