#!/usr/bin/env sh
wallpaper=$(kdialog --getopenfilename ~/Pictures/Wallpapers "*.jpg *.png *.gif" --title "Pick a Wallpaper")
cp "$wallpaper" ~/Pictures/background
setwal=~/Pictures/background
if [ -f "$setwal" ]; then
    swww img "$setwal" --transition-step 100 --transition-fps 165 --transition-type grow --transition-angle 30 --transition-duration 1
fi
