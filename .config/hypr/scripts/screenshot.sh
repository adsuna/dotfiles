#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

# take a region screenshot, include cursor, save, and send notif
gscreenshot -cs -f "$DIR/$FILENAME" -n
