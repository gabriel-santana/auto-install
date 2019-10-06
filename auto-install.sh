#!/bin/bash

<<SOBRE
Script criado para instalar programas após formatar a máquina, 
caso seja preguiçoso como eu e decida usar este auto-install, 
saiba que ele irá fazer as seguintes alterações no seu Ubuntu:

- Irá destravar o apt, ou seja, irá permitir que o apt seja usado simultaneamente por mais de um processo, permitindo que seja instalado mais de um programa ao mesmo tempo;

- Irá instalar o curl;

- Irá instalar o Visual Studio Code;

- Irá instalar o Skype;

- Irá instalar o Google Chrome;

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








echo -e "\nInstalando curl..."
if ! apt install curl -y
then
    echo -e "\nNão foi possivel instalar curl\n"
    exit 1
fi
echo -e "OK!\n"









echo -e "\nCriando Source List...[Visual Studio Code]"
if ! sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
then
    echo -e "\nNão foi possivel criar o arquivo\n"
    exit 1
fi
echo -e "OK!\n"


echo -e "\nBaixando gpg...[Visual Studio Code]"
if ! curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
then
    echo -e "\nNão foi possivel baixar o arquivo\n"
    exit 1
fi
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo -e "OK!\n"


echo -e "\nInstalando Visual Studio Code..."
if ! sudo apt update 
then
    echo -e "\nNão foi possivel rodar apt update\n"
    exit 1
fi
if !  sudo apt install code
then
    echo -e "\nNão foi possivel instalar o Visual Studio Code\n"
    exit 1
fi
echo -e "OK!\n"

echo -e "\nInstalando Skype..."
if ! wget https://go.skype.com/skypeforlinux-64.deb
then
    echo -e "\nNão foi possivel instalar o Visual Studio Code\n"
    exit 1
fi
sudo apt install ./skypeforlinux-64.deb
echo -e "OK!\n"






echo -e "\nInstalando Google Chrome...\nBaixando a key e adicionando a source list..."

if ! wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
then
    echo -e "\nNão foi possivel fazer o Download e adiocionar a key\n"
    exit 1
fi
if !  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
then
    echo -e "\nNão foi possivel adicionar o chrome a source list\n"
    exit 1
fi
echo -e "\nAtualizando repositórios e instalando o Chrome..."
if ! sudo apt-get update ; sudo apt-get install google-chrome-stable -y
then
    echo -e "\nNão foi possivel instalar o Google Chrome!\n"
    exit 1
fi
echo -e "OK!\n"






echo -e "Foram instalados:\n\n- Curl;\n- Visual Studio Code;\n- Skype;\n- Google Chrome\n"