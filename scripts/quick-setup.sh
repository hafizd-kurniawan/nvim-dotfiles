#!/bin/bash
# Quick setup script for testing the dotfiles
# This script creates symbolic links for testing without installation

echo "Setting up dotfiles for testing..."

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_test_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup existing configs
configs_to_backup=(
    ".config/bspwm"
    ".config/sxhkd"
    ".config/polybar"
    ".config/rofi"
    ".config/alacritty"
    ".config/picom"
    ".config/dunst"
    ".zshrc"
)

for config in "${configs_to_backup[@]}"; do
    if [ -e "$HOME/$config" ]; then
        echo "Backing up $config..."
        cp -r "$HOME/$config" "$BACKUP_DIR/"
    fi
done

# Create config directories
mkdir -p ~/.config/{bspwm,sxhkd,polybar,rofi,alacritty,picom,dunst}

# Copy configs
cp -r config/* ~/.config/
cp config/zsh/.zshrc ~/.zshrc

# Make scripts executable
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/src/MonitorSetup
chmod +x ~/.config/bspwm/src/Theme.sh
chmod +x ~/.config/bspwm/src/SetSysVars

echo "Test setup complete!"
echo "Backup created at: $BACKUP_DIR"
echo ""
echo "To test BSPWM:"
echo "1. Log out"
echo "2. Select BSPWM session"
echo "3. Log in"
echo ""
echo "Key bindings:"
echo "Super + Return    - Terminal"
echo "Super + Space     - App launcher"
echo "Super + Alt + R   - Reload BSPWM"