# Ubuntu BSPWM + Neovim Dotfiles

<div align="center">

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![BSPWM](https://img.shields.io/badge/BSPWM-1E1E2E?style=for-the-badge&logo=linux&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)

A comprehensive dotfiles setup for Ubuntu featuring BSPWM window manager and modern Neovim configuration. Inspired by [gh0stzk/dotfiles](https://github.com/gh0stzk/dotfiles) but optimized for Ubuntu compatibility.

</div>

## 🌟 Features

### Window Manager
- **BSPWM** - Tiling window manager with dynamic workspace management
- **sxhkd** - Simple X hotkey daemon for keyboard shortcuts
- **Picom** - Compositor with transparency and visual effects
- **Polybar** - Highly customizable status bar
- **Rofi** - Application launcher and dmenu replacement
- **Dunst** - Notification daemon

### Terminal & Shell
- **Alacritty** - GPU-accelerated terminal emulator
- **Zsh** - Feature-rich shell with plugins
- **Starship** - Modern, blazing-fast shell prompt

### Development
- **Neovim** - Modern Vim-based editor with NvChad configuration
- **Git** integration and modern CLI tools
- **LSP** support for multiple programming languages

### Theme
- **Tokyo Night** color scheme throughout all applications
- **JetBrains Mono Nerd Font** for consistent typography
- **Consistent** theming across all components

## 📸 Screenshots

*Screenshots will be added after testing the setup*

## 🚀 Quick Installation

### Automatic Installation (Recommended)

```bash
git clone https://github.com/hafizd-kurniawan/nvim-dotfiles.git
cd nvim-dotfiles
./install.sh
```

### Manual Installation

If you prefer to install manually or want to customize the process:

1. **Install dependencies:**
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install bspwm sxhkd picom polybar rofi dunst alacritty zsh git curl wget nodejs npm
```

2. **Clone and setup:**
```bash
git clone https://github.com/hafizd-kurniawan/nvim-dotfiles.git ~/.dotfiles
cd ~/.dotfiles
cp -r config/* ~/.config/
cp config/zsh/.zshrc ~/.zshrc
```

3. **Make scripts executable:**
```bash
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/src/MonitorSetup
```

4. **Change default shell:**
```bash
chsh -s $(which zsh)
```

## ⚙️ Configuration

### Key Bindings

| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open terminal |
| `Super + Space` | Application launcher |
| `Super + Shift + X` | Kill window |
| `Super + Alt + R` | Reload BSPWM |
| `Super + Escape` | Reload sxhkd |
| `Super + 1-0` | Switch to workspace 1-10 |
| `Super + Ctrl + 1-0` | Move window to workspace |
| `Super + Alt + ←↓↑→` | Focus window in direction |
| `Ctrl + Alt + ←↓↑→` | Swap window with direction |
| `Super + B/E/F` | Open browser/editor/file manager |
| `Super + Alt + S` | Take screenshot |
| `Super + Alt + P` | Power menu |

### Applications

- **Terminal:** Alacritty
- **Shell:** Zsh with plugins
- **Editor:** Neovim (NvChad)
- **Browser:** Firefox (configurable)
- **File Manager:** Thunar
- **Launcher:** Rofi
- **Notifications:** Dunst

## 🛠️ Customization

### Changing Colors

The Tokyo Night theme is defined in several files:
- Alacritty: `~/.config/alacritty/alacritty.toml`
- Rofi: `~/.config/rofi/launchers/type-2/style-3.rasi`
- Polybar: `~/.config/polybar/config.ini`
- Dunst: `~/.config/dunst/dunstrc`

### Adding Workspaces

Edit `~/.config/bspwm/src/MonitorSetup` to modify workspace layout.

### Custom Keybindings

Edit `~/.config/sxhkd/sxhkdrc` to add or modify keybindings.

## 📋 System Requirements

### Minimum Requirements
- **OS:** Ubuntu 20.04 LTS or newer
- **RAM:** 2GB minimum, 4GB recommended
- **Storage:** 2GB free space
- **Display:** X11 session (Wayland not supported)

### Tested On
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Linux Mint 21/22
- Pop!_OS 22.04

## 🔧 Dependencies

### Essential Packages
```
bspwm sxhkd picom polybar rofi dunst alacritty zsh git curl wget nodejs npm
python3 python3-pip build-essential brightnessctl pulseaudio-utils pavucontrol
network-manager thunar feh scrot flameshot fonts-jetbrains-mono
```

### Optional Packages
```
eza bat starship neofetch htop tree ranger mpv playerctl
```

## 🐛 Troubleshooting

### BSPWM not starting
- Check if X11 session is selected in login manager
- Verify bspwmrc is executable: `chmod +x ~/.config/bspwm/bspwmrc`
- Check logs: `journalctl --user -u bspwm`

### Polybar not showing
- Install required fonts: `sudo apt install fonts-jetbrains-mono`
- Check polybar config: `polybar --config=~/.config/polybar/config.ini main`

### Keybindings not working
- Restart sxhkd: `pkill sxhkd && sxhkd &`
- Check config syntax: `sxhkd -c ~/.config/sxhkd/sxhkdrc -t 5`

### Neovim issues
- Install Neovim 0.8+: `sudo apt install neovim` or use AppImage
- Run `:checkhealth` in Neovim to diagnose issues

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup
```bash
git clone https://github.com/hafizd-kurniawan/nvim-dotfiles.git
cd nvim-dotfiles
# Make changes
./install.sh  # Test your changes
```

## 📝 Changelog

### v1.0.0 (Initial Release)
- Complete BSPWM setup for Ubuntu
- NvChad-based Neovim configuration
- Tokyo Night theme integration
- Automated installation script
- Comprehensive documentation

## 🙏 Acknowledgments

- [gh0stzk](https://github.com/gh0stzk/dotfiles) - Original inspiration and design
- [NvChad](https://github.com/NvChad/NvChad) - Neovim configuration framework
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - Beautiful color scheme
- Ubuntu and BSPWM communities

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ for the Ubuntu Linux community**

[Report Bug](https://github.com/hafizd-kurniawan/nvim-dotfiles/issues) · [Request Feature](https://github.com/hafizd-kurniawan/nvim-dotfiles/issues) · [Documentation](https://github.com/hafizd-kurniawan/nvim-dotfiles/wiki)

</div>