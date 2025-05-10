#!/usr/bin/env zsh

set -euo pipefail
sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -q
sudo apt upgrade -yq
packages=(
  bat
  curl
  htop
  jq
  make
  mosh
  redis-server
  ripgrep
  stow
  tig
  tree
  vim
  ufw
)

sudo apt install -yqq "${packages[@]}"
sudo apt autoremove -yqq && sudo apt autoclean -yqq

# Z - jump around
if [ ! -d "$HOME/.z" ]; then
  git clone https://github.com/rupa/z.git ~/.z
fi

# Firewall
sudo ufw --force enable
sudo ufw allow from 192.168.1.0/24

# Vim
rm -f ~/.vimrc
stow vim

# Redis
stow redis
sudo systemctl enable redis-server
sudo systemctl start redis-server

# Zsh
rm -f ~/.zshrc
stow zsh
source ~/.zshrc
