#!/bin/bash

fibonacci() {
    termo=$1
    a=0
    b=1
    if [ $termo -eq 0 ]; then
        resultado=0
    elif [ $termo -eq 1 ]; then
        resultado=1
    else
        i=2
	while [ $i -le $termo ]; do
	    resultado=$((a + b))
	    a=$b
	    b=$resultado
	    i=$((i + 1))
        done
    fi
    echo $resultado
}

fibonacci $1