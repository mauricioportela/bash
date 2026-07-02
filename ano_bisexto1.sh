#!/bin/bash
echo -n "Digite um ano: "
read ano

if [ $((ano % 4)) -eq 0 ]; then
    if [ $((ano % 100)) -ne 0 ] || [ $((ano % 400)) -eq 0 ]; then
        echo "$ano é um ano bissexto."
    else
        echo "$ano não é um ano bissexto."
    fi
else
    echo "$ano não é um ano bissexto."
fi