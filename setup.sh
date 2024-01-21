#!/usr/bin/env zsh
set -e

sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -qq && sudo apt upgrade -yqq

packages=(
  bat
  curl
  exa
  htop
  make
  mosh
  stow
  tree
  ufw
  vim
  zsh
)

sudo apt install -yqq "${packages[@]}"
sudo apt autoremove -yqq && sudo apt autoclean -yqq

# Firewall
sudo ufw enable
sudo ufw allow from 192.168.1.0/24

# Configure bat => cat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Z
[ ! -f ~/.z ] && curl -O https://raw.githubusercontent.com/rupa/z/master/z.sh ~/.z

# Vim
rm -f ~/.vimrc && stow vim

# Install oh my zsh + packages
[ -d ~/.oh-my-zsh ] ||
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ] ||
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ] ||
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
[ -f ~/.hushlogin ] || touch ~/.hushlogin

# Zsh
sudo chsh -s "$(which zsh)"
rm -f ~/.zshrc && stow zsh
source ~/.zshrc
