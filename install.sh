#!/usr/bin/env zsh

set -euo pipefail
sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -q
sudo apt upgrade -yq

packages=(
  bat
  curl
  fzf
  htop
  make
  mosh
  neovim
  ripgrep
  stow
  tree
  ufw
  zoxide
)
sudo apt install -yqq "${packages[@]}"
sudo apt autoremove -yqq && sudo apt autoclean -yqq

# Firewall
sudo ufw --force enable
sudo ufw allow from 192.168.1.0/24

# Neovim
rm -rf ~/.config/nvim
stow nvim
if [[ ! -f ~/.config/nvim/autoload/plug.vim ]]; then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
nvim +'PlugInstall --sync' +qa

# Zsh
rm -f ~/.zshrc
stow zsh
source ~/.zshrc
