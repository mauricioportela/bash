#!/bin/bash

linha() {
    chr=$1
    replicar=$2
    linha=$(printf "%${replicar}s" | tr ' ' $chr)
    echo $linha
}

semaforo() {
    usuarios=$1
    if [ $usuarios -gt 1 ]; then
        cor="\e[31m"
    else
        cor="\e[32m"
    fi
    reset="\e[0m"
    sinaleira="<${cor}*${reset}> Pressione CTRL+C para finalizar o script."
    echo -e $sinaleira
}


lin=2
col=10

while true; do
    lin=6
    col=10
    clear
    tput cup 0  0 ; echo 'Empresa Modelo Ltda'
    tput cup 1  0 ; echo 'Quem esta logado?'
    tput cup 2  0 ; linha "-" 80
    tput cup 4 10 ; echo 'USUARIOS'

    usuarios=$(who -u | awk '{ print $1 }')
    qtdusr=$(echo "$usuarios" | wc -l)

    for usuario in $usuarios; do
        tput cup $lin $col ; echo $usuario
	lin=$((lin + 1))
    done
    tput cup 22 0 ; linha "-" 80
    tput cup 23 0 ; semaforo $qtdusr
    sleep 3
done