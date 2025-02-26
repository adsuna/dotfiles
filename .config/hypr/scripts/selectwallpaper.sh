#!/usr/bin/env sh
wallpaper=$(kdialog --getopenfilename ~/Pictures/Wallpapers "*.jpg *.png *.gif" --title "Pick a Wallpaper")

if [ -f "$wallpaper" ]; then
    swww img "$wallpaper" --transition-step 100 --transition-fps 165 --transition-type grow --transition-angle 30 --transition-duration 1 && cp "$wallpaper" ~/.config/background
fi
