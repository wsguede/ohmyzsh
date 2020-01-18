#!/bin/bash
# @author Bill Guedel <wsguede@gmail.com>
#
# This is what should be run on a fresh install. This should be run as sudo


# Install zsh first
apt update
apt install -y zsh git curl
apt autoremove -y
apt clean


# Change the skel for a new user
rm -f /etc/skel/.profile /etc/skel/.bash*
curl -fsSLo /etc/skel/.zshrc "https://raw.githubusercontent.com/wsguede/ohmyzsh/master/.zshrc"
mkdir -p /etc/skel/.oh-my-zsh/plugins /etc/skel/.oh-my-zsh/themes
chmod -R 755 /etc/skel
chown root:root /etc/skel
# change root to have zsh file
rm -f /root/.profile /root/.bash*
yes | cp -R /etc/skel/ /root/


# Change adduser to use zsh by default. Also change root user to use zsh
useradd -D --shell /bin/zsh
useradd -s /bin/zsh root

export ZSH=/etc/oh-my-zsh
# install oh-my-zsh globally
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# add syntax highlighting to the global config. This might be a bad idea. Will probably never get updated, might get overwritten on upgrade
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/plugins/zsh-syntax-highlighting
