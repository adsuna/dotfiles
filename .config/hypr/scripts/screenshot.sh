#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FILE="$DIR/screenshot-$TIMESTAMP.png"

case "$1" in
  area)
    grimblast --freeze copysave area "$FILE"
    satty --filename "$FILE" \
          --output-filename "$FILE" \
          --initial-tool brush \
          --copy-command wl-copy \
          --save-after-copy \
          --early-exit \
          --disable-notifications
    echo "saved area screenshot: $FILE"
    ;;

  screen)
    grimblast --freeze copysave screen "$FILE"
    satty --filename "$FILE" \
          --output-filename "$FILE" \
          --initial-tool brush \
          --copy-command wl-copy \
          --save-after-copy \
          --disable-notifications \
          --early-exit
    echo "saved full screen screenshot: $FILE"
    ;;

  *)
    echo "usage: $0 {area|screen}"
    ;;
esac
