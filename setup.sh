#!/usr/bin/env bash

set -e

sudo apt update
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set zshell as default
sudo apt install zsh
chsh -s $(which zsh)
echo $SHELL
# Symlink zshell to this repo
ln -s "$REPO_DIR/.zshrc" "$HOME/.zshrc"

# Create .env if there isn't one
if [ ! -f .env ]; then
  touch .env

# Install starship
curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"

# Install font
FONT_ZIP="$HOME/Downloads/VictorMono.zip"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
curl -Lo "$FONT_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/VictorMono.zip
unzip -o "$FONT_ZIP" -d "$FONT_DIR"
fc-cache -fv

# Set GNOME terminal font
PROFILE_ID=$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n 1 | tr -d '/')
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_ID/font "'VictorMono Nerd Font 10'"
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_ID/use-system-font false


