#!/bin/bash

fatorial() {
    numero=$1
    resultado=1
    if [ $numero -eq 0 ] || [ $numero -eq 1 ]; then
        resultado=1
    else
        i=2
	while [ $i -le $numero ]; do
            resultado=$((resultado * i))
	    i=$((i+1))
        done
    fi
    echo $resultado
}

fatorial $1