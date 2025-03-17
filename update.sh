#!/bin/bash

# Define source and destination directories
CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles/.config"

# Hardcoded list of folders to copy
folders=("fastfetch" "btop" "fish" "hypr" "kitty" "rofi" "hyprpanel" "wlogout" "xdg-desktop-portal" "zed")

# remove any folder in $DOTFILES_DIR that is NOT in the folders array
for existing_folder in "$DOTFILES_DIR"/*; do
    folder_name=$(basename "$existing_folder")
    if [[ ! " ${folders[@]} " =~ " $folder_name " ]]; then
        echo "Removing $folder_name from $DOTFILES_DIR..."
        rm -rf "$existing_folder"
    fi
done

# Loop through the list of folders
for folder in "${folders[@]}"; do
    # Check if the folder exists
    if [ -d "$CONFIG_DIR/$folder" ]; then
        echo "Copying $folder to $DOTFILES_DIR..."
        # Copy the folder recursively to the destination
        rsync -av --delete "$CONFIG_DIR/$folder/" "$DOTFILES_DIR/$folder/"
    else
        echo "Folder $folder does not exist in $CONFIG_DIR."
    fi
done

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || { echo "Failed to navigate to $DOTFILES_DIR"; exit 1; }

# Add changes to git
git add -A

# Commit changes with a default message
git commit -m "updated configs"

# Push changes to the remote repository
git push origin main

echo "Selected folders copied, committed, and pushed successfully."
