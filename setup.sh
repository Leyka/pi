#!/usr/bin/env bash
set -e

sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -qq && sudo apt upgrade -yqq
packages=(
  bat
  build-essential
  curl
  fail2ban
  htop
  jq
  make
  mosh
  neovim
  stow
  tree
  ufw
  zsh
)
sudo apt install -yqq "${packages[@]}"
sudo apt autoremove -yqq && sudo apt autoclean -yqq

# Firewall
sudo ufw enable
sudo ufw allow from 192.168.1.0/24

# Fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart

# Zsh
sudo chsh -s "$(which zsh)"

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
