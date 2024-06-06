#!/usr/bin/env zsh
set -e

sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -qq && sudo apt upgrade -yqq

packages=(
  curl
  exa
  htop
  iftop
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

# Z
[ ! -f ~/.z ] && curl -O https://raw.githubusercontent.com/rupa/z/master/z.sh ~/.z

# Nvim
rm -rf ~/.config/nvim && stow nvim

[ -f ~/.config/nvim/autoload/plug.vim ] || curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +'PlugInstall --sync' +qa

# Install oh my zsh packages
[ -d ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ] || bgit clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh
[ -f ~/.hushlogin ] || touch ~/.hushlogin

rm -f ~/.zshrc && stow zsh

source ~/.zshrc
