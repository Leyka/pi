# 🥧 pi

my Raspberry Pi setup for dev

## Installation

### Prepare SD Card

- Install Raspberry Pi Manager [ [Windows](https://downloads.raspberrypi.org/imager/imager_latest.exe) | [Mac](https://downloads.raspberrypi.org/imager/imager_latest.dmg) ]
- Choose `Ubuntu Server 22.04 LTS 64 bit` and media
- Grab a ☕ it might take a while
- No extra setting when Ethernet, insert SD card in pi when done

### SSH into Ubuntu server

```sh
ssh ubuntu@<Raspberry Pi’s IP address>
```

Password: `ubuntu`

Change default password

### Create new user

Create new user and delete existing `ubuntu` user

```sh
sudo adduser skan
sudo usermod -aG sudo skan
sudo su - skan
sudo pkill -u ubuntu
```

SSH will disconnect, reconnect with new user.

```sh
ssh skan@<Raspberry Pi’s IP address>
sudo deluser -remove-home ubuntu
```

### Launch setup

Clone this repo

```
git clone https://github.com/Leyka/pi.git && cd pi
```

Install `zsh` and `oh-my-zsh` first

```sh
sudo apt update && sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Run setup script

```
./setup.sh
```
