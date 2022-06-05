# 🥧 pi 

Dotfiles for Raspberry pi running on Ubuntu Server 64 bit

## Installation

### Prepare SD Card 

* Install Raspberry Pi Manager [ [Windows](https://downloads.raspberrypi.org/imager/imager_latest.exe) | [Mac](https://downloads.raspberrypi.org/imager/imager_latest.dmg) ]
* Choose `Ubuntu Desktop 22.04 LTS 64 bit` and media 
* Grab a ☕ it might take a while
* No extra setting when Ethernet, insert SD card in pi when done

### SSH into Ubuntu server

```sh
ssh ubuntu@<Raspberry Pi’s IP address>
```

Password: `ubuntu`

Change default password

### Github

Generate SSH key

```sh
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
```

Paste SSH key in Github settings

### Run script 

Clone this repo 

```
git clone git@github.com:Leyka/pi.git && cd pi
```

Run setup script

```
./setup.sh
```
