#!/usr/bin/env bash

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📦 Updating packages..."
sudo apt update

echo "🐚 Installing zsh..."
sudo apt install zsh

echo "🔧 Setting zsh as default..."
chsh -s $(which zsh)

echo "🔗 Linking .zshrc..."
ZSHRC_TARGET="$HOME/.zshrc"
if [ ! -L "$ZSHRC_TARGET" ]; then
  ln -sf "$REPO_DIR/.zshrc" "$ZSHRC_TARGET"
fi

echo "📄 Ensuring .env file exists..."
if [ ! -f .env ]; then
  touch .env

echo "🚀 Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"

echo "🔤 Installing VictorMono Nerd Font..."
FONT_ZIP="$HOME/Downloads/VictorMono.zip"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
curl -Lo "$FONT_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/VictorMono.zip
unzip -o "$FONT_ZIP" -d "$FONT_DIR"
fc-cache -fv

echo "🎨 Setting GNOME terminal font..."
PROFILE_ID=$(dconf list /org/gnome/terminal/legacy/profiles:/ | head -n 1 | tr -d '/')
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_ID/font "'VictorMono Nerd Font 10'"
dconf write /org/gnome/terminal/legacy/profiles:/$PROFILE_ID/use-system-font false

echo "✅ Done!"
