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
# Allow specific services instead of entire subnet
# Allow Redis port if you need to access it from other devices
sudo ufw allow 6379/tcp comment 'Redis'
# Allow SSH
sudo ufw allow 22/tcp comment 'SSH'

# Vim
rm -f ~/.vimrc
stow vim

# Redis - using default configuration
sudo apt-get install -y redis-server
sudo systemctl enable redis-server
sudo systemctl restart redis-server
# Verify Redis is running
sudo systemctl status redis-server --no-pager || echo "Redis failed to start, check logs with: sudo journalctl -xeu redis-server"

# Zsh
rm -f ~/.zshrc ~/.p10k.zsh
stow zsh
