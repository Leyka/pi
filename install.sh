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

# Firewall
sudo ufw --force enable
sudo ufw allow from 192.168.1.0/24

# Vim
rm -f ~/.vimrc
stow vim

# Redis
sudo rm -rf /etc/redis/redis.conf
sudo ln -s $HOME/.dotfiles/redis/redis.conf /etc/redis/redis.conf
sudo systemctl enable redis-server
sudo systemctl start redis-server

# Zsh
rm -f ~/.zshrc ~/.p10k.zsh
stow zsh
