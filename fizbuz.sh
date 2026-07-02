#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "necessario dois parametros: inicio e final"
    exit 1
fi

inicio=$1
final=$2

for ((i = inicio; i <= final; i++)); do
    if ((i % 3 == 0)) && ((i % 5 == 0)); then
        echo "fizbuz"
    elif ((i % 3 == 0)); then
        echo "fiz"
    elif ((i % 5 == 0)); then
        echo "buz"
    else
        echo $i
    fi
done