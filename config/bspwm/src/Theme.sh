#!/bin/bash
# Theme manager script for Ubuntu dotfiles

THEME_DIR="$HOME/.config/bspwm/themes"
CURRENT_THEME_FILE="$HOME/.config/bspwm/.current_theme"

# Default theme (Tokyo Night)
DEFAULT_THEME="tokyo-night"

# Colors for Tokyo Night theme
declare -A TOKYO_NIGHT_COLORS=(
    [bg]="#1a1b26"
    [bg_alt]="#24283b"
    [fg]="#c0caf5"
    [fg_alt]="#a9b1d6"
    [red]="#f7768e"
    [green]="#9ece6a"
    [yellow]="#e0af68"
    [blue]="#7aa2f7"
    [magenta]="#bb9af7"
    [cyan]="#7dcfff"
    [orange]="#ff9e64"
    [purple]="#9d7cd8"
)

# Function to set wallpaper
set_wallpaper() {
    local wallpaper_path="$1"
    if command -v feh >/dev/null 2>&1; then
        feh --bg-fill "$wallpaper_path"
    elif command -v nitrogen >/dev/null 2>&1; then
        nitrogen --set-zoom-fill "$wallpaper_path"
    else
        echo "No wallpaper manager found (feh or nitrogen required)"
    fi
}

# Apply Tokyo Night theme
apply_tokyo_night() {
    echo "Applying Tokyo Night theme..."
    
    # Set wallpaper
    if [ -f "$HOME/.config/bspwm/wallpapers/tokyo-night.jpg" ]; then
        set_wallpaper "$HOME/.config/bspwm/wallpapers/tokyo-night.jpg"
    elif [ -f "$HOME/.config/bspwm/wallpapers/default.jpg" ]; then
        set_wallpaper "$HOME/.config/bspwm/wallpapers/default.jpg"
    fi
    
    # Update BSPWM colors
    bspc config normal_border_color "#414868"
    bspc config active_border_color "#c0caf5"
    bspc config focused_border_color "#bb9af7"
    bspc config presel_feedback_color "#7aa2f7"
    
    # Restart polybar with new colors
    pkill polybar
    sleep 1
    polybar main -c "$HOME/.config/polybar/config.ini" &
    
    echo "$DEFAULT_THEME" > "$CURRENT_THEME_FILE"
    echo "Tokyo Night theme applied successfully"
}

# Main function
main() {
    case "${1:-apply}" in
        "apply"|"tokyo-night")
            apply_tokyo_night
            ;;
        "current")
            if [ -f "$CURRENT_THEME_FILE" ]; then
                cat "$CURRENT_THEME_FILE"
            else
                echo "$DEFAULT_THEME"
            fi
            ;;
        *)
            echo "Usage: $0 {apply|tokyo-night|current}"
            echo "  apply       - Apply default theme (Tokyo Night)"
            echo "  tokyo-night - Apply Tokyo Night theme"
            echo "  current     - Show current theme"
            exit 1
            ;;
    esac
}

main "$@"