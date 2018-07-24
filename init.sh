#!/bin/bash

if [[ ${EUID} == 0 ]]; then
	is_root=1
else
	is_root=0
fi

echo " + Installing packages..."
if [ -f /etc/debian_version ]; then
	echo " + Running on Debian."
	if [[ $is_root == 1 ]]; then
		echo "do not run with root."
		exit 1
	fi
	sudo=sudo
	packages="aptitude git sudo curl vim make tmux"
	echo "Give me root password..."
	su -c "echo 'Europe/Sofia' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && sed -i -e 's/# bg_BG.UTF-8 UTF-8/bg_BG.UTF-8 UTF-8/' /etc/locale.gen && echo 'LANG=\"en_US.UTF-8\"' >/etc/default/locale && dpkg-reconfigure --frontend=noninteractive locales && update-locale LANG=en_US.UTF-8 && apt-get update && apt-get upgrade && apt-get install -y $packages && usermod -a -G sudo $USER && echo \"$USER ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers.d/010_$USER-nopasswd && echo 'Done with root...'"
fi

if [ -f /etc/alpine-release ]; then
	echo " + Running on Alpine."
	if [[ $is_root == 0 ]]; then
		echo "run me with root."
		exit 1
	fi
	packages="bash vim git make findutils wget coreutils grep"
	apk add -t af-etc $packages
fi

echo "Installing af-etc..."
mkdir -p ~/.config
rm -rf ~/.config/af-etc
git clone https://github.com/0xAF/af-etc.git ~/.config/af-etc
cd ~/.config/af-etc

if [[ $is_root == 0 ]]; then
	make user
fi

$sudo make system
$sudo make user

