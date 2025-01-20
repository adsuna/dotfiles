#!/bin/bash

# Set the dotfiles directory (where the dotfiles repo is)
DOTFILES_DIR="$HOME/dotfiles"

# Function to copy files
copy_files() {
    local src="$1"
    local dest="$2"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dest"
    
    # Copy the contents (including hidden files) from the source to the destination
    cp -r "$src/." "$dest/"
    echo "Copied files from $src to $dest"
}

# Copy config files to ~/.config
echo "Copying dotfiles..."
copy_files "$DOTFILES_DIR/.config" "$HOME/.config"


# Install required packages or dependencies
install_dependencies() {
    echo "Installing dependencies..."

    # Install necessary packages using yay
    yay
    yay -S --noconfirm fastfetch fish hyprland kitty zoxide pyenv waybar wlogout xdg-desktop-portal-hyprland zed swww input-remapper-git vesktop wl-clipboard cliphist hypridle hyprlock mako rofi-wayland thunar ttf-jetbrains-mono-nerd power-profiles-daemon brightnessctl playerctl hyprshot yad rofi-emoji nwg-look


    echo "Dependencies installed!"
}

# Call the install_dependencies
install_dependencies


echo "Dotfiles installation complete!"

