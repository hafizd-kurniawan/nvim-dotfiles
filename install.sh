#!/bin/bash
#  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
#  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
#  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
#  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
#  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
#  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
#
#	Author: hafizd-kurniawan
#	Repo: https://github.com/hafizd-kurniawan/nvim-dotfiles
#	Ubuntu Dotfiles Installer - BSPWM + Neovim setup
#

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Variables
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$HOME/dotfiles_install.log"

# Functions
print_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
    echo "  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
    echo "  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
    echo "  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
    echo "  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
    echo "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
    echo -e "${NC}"
    echo -e "${WHITE}${BOLD}Ubuntu BSPWM + Neovim Dotfiles Installation${NC}"
    echo -e "${YELLOW}Author: hafizd-kurniawan${NC}"
    echo ""
}

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

check_ubuntu() {
    if [ ! -f /etc/lsb-release ] || ! grep -q "Ubuntu" /etc/lsb-release; then
        error "This script is designed for Ubuntu. Other distributions may not work correctly."
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

check_internet() {
    if ! ping -c 1 8.8.8.8 &> /dev/null; then
        error "No internet connection detected. Please check your connection and try again."
        exit 1
    fi
    success "Internet connection verified"
}

update_system() {
    info "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    if [ $? -eq 0 ]; then
        success "System updated successfully"
    else
        error "Failed to update system"
        exit 1
    fi
}

install_dependencies() {
    info "Installing dependencies..."
    
    # Essential packages for BSPWM setup
    packages=(
        # Window manager and compositor
        "bspwm" "sxhkd" "picom"
        
        # Status bar and launcher
        "polybar" "rofi" "dunst"
        
        # Terminal and shell
        "alacritty" "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting"
        
        # Development tools
        "git" "curl" "wget" "build-essential" "nodejs" "npm" "python3" "python3-pip"
        
        # System utilities
        "brightnessctl" "pulseaudio-utils" "pavucontrol" "network-manager" "nm-tray"
        "thunar" "feh" "scrot" "flameshot" "xclip" "xsel" "jq"
        
        # Fonts
        "fonts-jetbrains-mono" "fonts-noto-color-emoji"
        
        # Media
        "mpv" "playerctl"
        
        # Optional but recommended
        "neofetch" "htop" "tree" "unzip" "zip" "ranger"
    )
    
    for package in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package "; then
            info "Installing $package..."
            sudo apt install -y "$package"
            if [ $? -eq 0 ]; then
                success "$package installed"
            else
                warning "Failed to install $package"
            fi
        else
            info "$package already installed"
        fi
    done
}

install_optional_tools() {
    info "Installing optional modern CLI tools..."
    
    # Install eza (modern ls replacement)
    if ! command -v eza &> /dev/null; then
        info "Installing eza..."
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update && sudo apt install -y eza
    fi
    
    # Install bat (modern cat replacement)
    if ! command -v bat &> /dev/null; then
        info "Installing bat..."
        sudo apt install -y bat
        # Create symlink if batcat is installed instead of bat
        if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
            mkdir -p ~/.local/bin
            ln -s /usr/bin/batcat ~/.local/bin/bat
        fi
    fi
    
    # Install starship prompt
    if ! command -v starship &> /dev/null; then
        info "Installing starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
}

backup_configs() {
    info "Creating backup of existing configurations..."
    mkdir -p "$BACKUP_DIR"
    
    configs_to_backup=(
        ".config/bspwm"
        ".config/sxhkd"
        ".config/polybar"
        ".config/rofi"
        ".config/alacritty"
        ".config/picom"
        ".config/dunst"
        ".config/nvim"
        ".zshrc"
    )
    
    for config in "${configs_to_backup[@]}"; do
        if [ -e "$HOME/$config" ]; then
            info "Backing up $config..."
            cp -r "$HOME/$config" "$BACKUP_DIR/"
        fi
    done
    
    if [ "$(ls -A $BACKUP_DIR)" ]; then
        success "Backup created at $BACKUP_DIR"
    else
        info "No existing configurations to backup"
        rmdir "$BACKUP_DIR"
    fi
}

install_dotfiles() {
    info "Installing dotfiles..."
    
    # Copy configuration files
    cp -r config/* "$HOME/.config/"
    
    # Copy zsh configuration
    cp config/zsh/.zshrc "$HOME/.zshrc"
    
    # Make scripts executable
    find "$HOME/.config/bspwm" -name "*.sh" -exec chmod +x {} \;
    chmod +x "$HOME/.config/bspwm/bspwmrc"
    chmod +x "$HOME/.config/bspwm/src/MonitorSetup"
    
    success "Dotfiles installed successfully"
}

setup_nvim() {
    info "Setting up Neovim configuration..."
    
    # The Neovim configuration is already in place from the repository
    # Just ensure lazy.nvim is installed
    if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
        info "Installing lazy.nvim package manager..."
        git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$HOME/.local/share/nvim/lazy/lazy.nvim"
    fi
    
    success "Neovim configuration ready"
}

setup_shell() {
    info "Setting up zsh as default shell..."
    
    if [ "$SHELL" != "/usr/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
        chsh -s $(which zsh)
        success "Default shell changed to zsh"
        info "Please log out and log back in for the shell change to take effect"
    else
        info "Zsh is already the default shell"
    fi
}

create_wallpaper_dir() {
    info "Creating wallpaper directory..."
    mkdir -p "$HOME/.config/bspwm/wallpapers"
    
    # Download a default wallpaper if none exists
    if [ ! -f "$HOME/.config/bspwm/wallpapers/default.jpg" ]; then
        info "Downloading default wallpaper..."
        curl -o "$HOME/.config/bspwm/wallpapers/default.jpg" \
            "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&h=1080&fit=crop" \
            || warning "Failed to download default wallpaper"
    fi
}

post_install_message() {
    success "Installation completed!"
    echo ""
    echo -e "${CYAN}${BOLD}Next Steps:${NC}"
    echo -e "${YELLOW}1.${NC} Log out and log back in"
    echo -e "${YELLOW}2.${NC} Select 'bspwm' as your session in the login manager"
    echo -e "${YELLOW}3.${NC} Open a terminal with ${BOLD}Super + Return${NC}"
    echo -e "${YELLOW}4.${NC} Launch apps with ${BOLD}Super + Space${NC}"
    echo ""
    echo -e "${CYAN}${BOLD}Key Bindings:${NC}"
    echo -e "${YELLOW}Super + Return${NC}        Open terminal"
    echo -e "${YELLOW}Super + Space${NC}         Application launcher"
    echo -e "${YELLOW}Super + Shift + X${NC}     Kill window"
    echo -e "${YELLOW}Super + Alt + R${NC}       Reload BSPWM"
    echo -e "${YELLOW}Super + Escape${NC}        Reload keybindings"
    echo -e "${YELLOW}Super + 1-0${NC}           Switch workspaces"
    echo ""
    echo -e "${GREEN}${BOLD}Enjoy your new setup!${NC}"
    
    if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
        echo ""
        echo -e "${BLUE}Your previous configurations have been backed up to:${NC}"
        echo -e "${BOLD}$BACKUP_DIR${NC}"
    fi
}

# Main installation flow
main() {
    print_banner
    
    # Checks
    check_ubuntu
    check_internet
    
    # Confirm installation
    echo -e "${YELLOW}This will install BSPWM dotfiles on your system.${NC}"
    echo -e "${YELLOW}This includes window manager, terminal, shell, and Neovim configurations.${NC}"
    echo ""
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    
    # Installation steps
    log "Starting dotfiles installation"
    update_system
    install_dependencies
    install_optional_tools
    backup_configs
    install_dotfiles
    setup_nvim
    setup_shell
    create_wallpaper_dir
    
    post_install_message
    log "Installation completed successfully"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi