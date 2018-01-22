#!/bin/bash

if [[ ${EUID} == 0 ]]; then
	echo "start me with your user."
	exit 1
fi

echo " + Installing packages..."
if [ -f /etc/debian_version ]; then
	echo " + Running on Debian."
	packages="aptitude git sudo curl vim make tmux"
	echo "Give me root password..."
	su -c "apt-get update && apt-get upgrade && apt-get install -y $packages && usermod -a -G sudo $USER && echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers.d/010_$USER-nopasswd && echo 'Done with root...'"
fi

echo "Installing af-etc..."
mkdir -p ~/.config
rm -rf ~/.config/af-etc
git clone https://github.com/0xAF/af-etc.git ~/.config/af-etc
cd ~/.config/af-etc
make user
sudo make system
sudo make user

