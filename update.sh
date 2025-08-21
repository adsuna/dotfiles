#!/bin/bash
set -e

# folders to sync
folders=(
  btop
  fastfetch
  fish
  foot
  hypr
  nvim
  fuzzel
  waybar
  wlogout
  xdg-desktop-portal
)

repo_dir="$HOME/dotfiles/.config"
config_dir="$HOME/.config"

echo "[*] syncing configs..."
for f in "${folders[@]}"; do
  rsync -av --delete "$config_dir/$f/" "$repo_dir/$f/"
done

cd "$HOME/dotfiles"

echo "[*] committing changes..."
git add .
git commit -m "update dotfiles $(date '+%Y-%m-%d %H:%M:%S')" || echo "no changes to commit"

echo "[*] pushing..."
git push
