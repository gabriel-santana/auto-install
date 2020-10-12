#!/bin/bash

<<SOBRE
Script criado para instalar programas após formatar a máquina,
saiba que ele irá fazer as seguintes alterações no seu Ubuntu:

- Irá destravar o apt, ou seja, irá permitir que o apt seja usado simultaneamente por mais de um processo, permitindo que seja instalado mais de um programa ao mesmo tempo;

- Irá instalar o Curl, Visual Studio Code, Gnome Extensions, Zsh, Insomnia, Spotify, Dbeaver, Flameshot, Vlc, LibreOffice, Git;

SOBRE


echo -e "\nTirando a trava do apt..."

if ! rm -rf /var/lib/apt/lists/lock
then
    echo -e "\nNão foi possivel destravar o apt\n"
    exit 1
fi
if ! apt update
then
    echo -e "\nNão foi possivel destravar o apt\n"
    exit 1
fi
if ! dpkg --configure -a
then
    echo -e "\nNão foi possivel destravar o apt\n"
    exit 1
fi
if ! apt -f install
then
    echo -e "\nNão foi possivel destravar o apt\n"
    exit 1
fi
echo -e "OK!\n"







sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update -y && sudo apt-get install apt-transport-https curl -y


curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list


sudo apt-get update -y && sudo apt-get install vlc libreoffice chrome-gnome-shell git zsh ca-certificates gnupg-agent software-properties-common brave-browser -y




curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get update -y && sudo apt-get install docker-ce docker-ce-cli containerd.io -y












sudo snap install code --classic
sudo snap install insomnia 
sudo snap install dbeaver-ce
sudo snap install spotify
sudo snap install flameshot
sudo snap install discord






echo -e "Finalizando\n"



git config --global user.name "Gabriel Santana"
git config --global user.email gabrielsantana77@hotmail.com

sudo usermod -aG docker $USER

newgrp docker 
