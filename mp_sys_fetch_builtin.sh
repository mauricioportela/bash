#!/bin/env bash


formatar_bytes() {
    local bytes=$1
    local unidade="B"
    if ((bytes >= 1024)); then
        ((bytes /= 1024))
        unidade="KB"
    fi
    if ((bytes >= 1024)); then
        ((bytes /= 1024))
        unidade="MB"
    fi
    if ((bytes >= 1024)); then
        ((bytes /= 1024))
        unidade="GB"
    fi
    printf "$bytes $unidade\n"
}


formatar_tempo() {
    local segundos=$1
    local dias=$((segundos / 86400))
    local horas=$((segundos % 86400 / 3600))
    local minutos=$((segundos % 3600 / 60))
    local segundos_restantes=$((segundos % 60))
    local formato=""
    if ((dias > 0)); then
        formato+="${dias} dia"
        [ $dias -gt 1 ] && formato+="s"
    fi
    if ((horas > 0)); then
        [ -n "$formato" ] && formato+=", "
        formato+=$(printf "%02d" "$horas")" hora"
        [ $horas -gt 1 ] && formato+="s"
    fi
    if ((minutos > 0)); then
        [ -n "$formato" ] && formato+=", "
        formato+=$(printf "%02d" "$minutos")" minuto"
        [ $minutos -gt 1 ] && formato+="s"
    fi
    if ((segundos_restantes > 0)); then
        [ -n "$formato" ] && formato+=", "
        formato+=$(printf "%02d" "$segundos_restantes")" segundo"
        [ $segundos_restantes -gt 1 ] && formato+="s"
    fi
    printf "$formato\n"
}


main() {
    itens=("User" "OS" "Shell" "Kernel" "Host" "CPU" "Uptime" "Memory")
    tam_maior_item=0
    for item in "${itens[@]}"; do
        tam_item=${#item}
        if ((tam_item > tam_maior_item)); then
            tam_maior_item=$tam_item
        fi
    done
    for item in "${itens[@]}"; do
        case "$item" in
            "User")
                : $'\u@\h'
                valor="${_@P}"
            ;;
            "OS")
                . /etc/os-release
                valor="$PRETTY_NAME"
            ;;
            "Shell")
                while read -r; do
                    if [[ "$REPLY" == $USER* ]]; then
                        valor="${REPLY##*:}"
                        break
                    fi
                done < /etc/passwd
            ;;
            "Kernel")
                valor="$(< /proc/sys/kernel/osrelease)"
            ;;
            "Host")
                local host_model=()
                # Houve um erro na apresentacao aqui:
                # (estou utilizando uma distro ubuntu dentro do window 11
                # verificando se existe os arquivo:
                if [ -e "/sys/devices/virtual/dmi/id/board_vendor" ] &&
                   [ -e "/sys/devices/virtual/dmi/id/product_name" ] &&
                   [ -e "/sys/devices/virtual/dmi/id/board_name" ]; then
                    host_model=(
                        Vendedor:$(< /sys/devices/virtual/dmi/id/board_vendor)
                        Produto:$(< /sys/devices/virtual/dmi/id/product_name)
                        Placa:$(< /sys/devices/virtual/dmi/id/board_name)
                    )
                else
                    # caso contrario, mostro traco:
                    host_model=("Vendedor: -" "Produto: -" "Placa: -")
                fi
                valor="${host_model[*]}"
            ;;
            "CPU")
                while read -r; do
                    case "$REPLY" in
                        model\ name*)
                            cpumod="${REPLY#*: }"
                        ;;
                        cpu\ cores*)
                            cpucores="(x${REPLY#*: })"
                            break
                        ;;
                    esac
                done < /proc/cpuinfo
                valor="$cpumod $cpucores"
            ;;
            "Uptime")
                read -r segundos_uptime _ < /proc/uptime
                segundos_uptime=${segundos_uptime%.*}
                valor=$(formatar_tempo "$segundos_uptime")
            ;;
            "Memoria"|"Memory")
                while read -r f v u; do
                    case $f in
                        MemTotal:)
                            mem_total=$v
                        ;;
                        MemAvailable:)
                            mem_livre=$v
                        ;;
                    esac
                done < /proc/meminfo
                mem_usada=$((mem_total-mem_livre))
                mem_percent=$(((100*mem_usada)/mem_total))
                valor="$(formatar_bytes "$mem_usada") / $(formatar_bytes "$mem_total") ($mem_percent%)"
            ;;
            *)
                valor="Informacao nao reconhecida"
            ;;
        esac
        printf "%-${tam_maior_item}s : %s\n" "$item" "$valor"
    done
}


main
