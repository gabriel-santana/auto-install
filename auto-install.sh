#!/bin/bash

<<SOBRE
Script criado para instalar programas após formatar a máquina, 
caso seja preguiçoso como eu e decida usar este auto-install, 
saiba que ele irá fazer as seguintes alterações no seu Ubuntu:

- Irá destravar o apt, ou seja, irá permitir que o apt seja usado simultaneamente por mais de um processo, permitindo que seja instalado mais de um programa ao mesmo tempo.

- 

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


echo -e "\nCriando Source List..."
if ! sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
then
    echo -e "\nNão foi possivel criar o arquivo\n"
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
