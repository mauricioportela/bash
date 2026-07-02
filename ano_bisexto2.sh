#!/bin/bash                                                                                                                                                                                                    

nao_divisivel_por_100() {
    ano=$1
    if [ $((ano % 100)) -ne 0 ]; then
        echo 0
    else
        echo 1
    fi
}

divisivel_por_400() {
    ano=$1
    if [ $((ano % 400)) -eq 0 ]; then
        echo 0
    else
        echo 1
    fi
}

divisivel_por_4() {
    ano=$1
    if [ $((ano % 4)) -eq 0 ]; then
        echo 0
    else
        echo 1
    fi
}

Main() {
    echo -n "Digite um ano: "
    read ano
    if [ $(divisivel_por_4 $ano) -eq 0 ]; then
        if [ $(nao_divisivel_por_100 $ano) -eq 0 ] || [ $(divisivel_por_400 $ano) -eq 0 ]; then
            echo "$ano é um ano bissexto."
        else
            echo "$ano não é um ano bissexto."
        fi
    else
        echo "$ano não é um ano bissexto."
    fi
}

Main