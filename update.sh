#!/bin/bash

# Define source and destination directories
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

# Hardcoded list of folders to copy
folders=("fastfetch" "fish" "hypr" "kitty" "rofi" "waybar" "wlogout" "xdg-desktop-portal" "zed")

# Loop through the list of folders
for folder in "${folders[@]}"; do
    # Check if the folder exists
    if [ -d "$CONFIG_DIR/$folder" ]; then
        echo "Copying $folder to $DOTFILES_DIR..."
        # Copy the folder recursively to the destination
        cp -r "$CONFIG_DIR/$folder" "$DOTFILES_DIR/"
    else
        echo "Folder $folder does not exist in $CONFIG_DIR."
    fi
done

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || { echo "Failed to navigate to $DOTFILES_DIR"; exit 1; }

# Add changes to git
git add .

# Commit changes with a default message
git commit -m "updated configs"

# Push changes to the remote repository
git push

echo "Selected folders copied, committed, and pushed successfully."

