#!/usr/bin/env zsh
set -e

sudo -v

sudo timedatectl set-timezone America/Toronto

sudo apt update -qq && sudo apt upgrade -yqq
packages=(
  bat
  curl
  exa
  fail2ban
  htop
  jq
  make
  mosh
  postgresql
  postgresql-contrib
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

# Fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart

# Z
[ ! -f ~/.z ] && curl -O https://raw.githubusercontent.com/rupa/z/master/z.sh ~/.z

# Vim
rm -f ~/.vimrc && stow vim

# Postgres
sudo systemctl start postgresql.service
sudo systemctl enable postgresql.service

# Oh-my-zsh & plugins
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
[ ! -f ~/.hushlogin ] && touch ~/.hushlogin

# Zsh
sudo chsh -s "$(which zsh)"
rm -f ~/.zshrc && stow zsh
source ~/.zshrc
