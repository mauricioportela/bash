#
# Sobre notação big O
#
# Teste para analisar a complexidade temporal de algoritmos, especificando como 
# o tempo de execução de um algoritmo aumenta em relação ao tamanho da entrada.
#
#     exemplo: SomaSequencial(nInicio, nFinal)
#
# faz uma série de operações matemáticas, mas não realiza nenhum loop que 
# dependa diretamente do tamanho da entrada. Portanto, a complexidade temporal 
# desta função é constante, ou seja, O(1), porque o tempo de execução não 
# cresce com o tamanho da entrada.
#
# Mesmo que tenha chamadas de Delay() dentro da função, elas não afetam a 
# complexidade assintótica.
#
#     exemplo: SomaSequencialConvencional(nInicio, nFinal)
#
# essa função usa um loop "for" que itera do valor inicio ao valor final. 
# O número de iterações deste loop depende diretamente do tamanho da entrada, 
# ou seja, é proporcional ao valor final - inicio. Portanto, a complexidade 
# temporal desta função é linear, ou seja, O(n), onde "n" é igual a 
# final - inicio.
#
# Portanto, para a função SomaSequencialConvencional, a complexidade temporal 
# é O(n), onde "n" é o tamanho da entrada (ou seja, final - inicio).
#
# a notação Big O descreve o comportamento assintótico do algoritmo, ou seja, 
# como o tempo de execução aumenta em relação ao tamanho da entrada quando a 
# entrada se torna muito grande. Neste caso, a função SomaSequencial é mais 
# eficiente em termos de complexidade temporal do que a função 
# SomaSequencialConvencional.
#

#!/bin/bash

MODO_DEBUG=false

Main() {
    nInicio=1
    aFinal=(10 50 100)
    echo "Teste de Calculos Sequencial"
    echo "calcular o tempo gasto pelas funcoes"
    for final in "${aFinal[@]}"; do
        echo "--------------------------------------------------------------------------------"
        echo "Soma Sequencial: 1-$final"
        start_time=$(date +%s%N)
        resultado=$(SomaSequencial "$nInicio" "$final")
        end_time=$(date +%s%N)
        echo "Resultado da Soma Sequencial: $resultado"
        echo "Tempo Gasto: $(expr $(($end_time - $start_time)) / 1000000) ms"
        echo "................................................................................"
        start_time=$(date +%s%N)
        resultado_convencional=$(SomaSequencialConvencional "$nInicio" "$final")
        end_time=$(date +%s%N)
        echo "Resultado da Soma Sequencial Convencional: $resultado_convencional"
        echo "Tempo Gasto: $(expr $(($end_time - $start_time)) / 1000000) ms"
    done
    echo "--------------------------------------------------------------------------------"
}

Delay() {
    if [ "$MODO_DEBUG" = true ]; then
        read -t 0.2 -n 1
    else
        read -t 0.01 -n 1
    fi
}

SomaSequencial() {
    nInicio=$1
    nFinal=$2
    nReserva=0
    Delay
    nTotTermos=$((nFinal - nInicio + 1))
    Delay
    if [ $((nTotTermos % 2)) -ne 0 ]; then
        nReserva=$nFinal
        Delay
        nFinal=$((nFinal - 1))
        Delay
        nTotTermos=$((nTotTermos - 1))
        Delay
    fi
    nMetade=$((nTotTermos / 2))
    Delay
    nDoisTermos=$((nFinal + nInicio))
    Delay
    nResultado=$((nMetade * nDoisTermos + nReserva))
    Delay
    echo $nResultado
}

SomaSequencialConvencional() {
    nInicio=$1
    nFinal=$2
    nResultado=0
    Delay
    for ((n = nInicio; n <= nFinal; n++)); do
        nResultado=$((nResultado + n))
        Delay
    done
    echo $nResultado
}

Main