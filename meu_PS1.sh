#!/usr/bin/env bash

#
# Aqui: 
# "Portela" -> fundo branco, fonte azul
# "INFO" -> fundo azul, fonte branco
#
# ┌──(PortelaINFO)-(mauricio@hspsrv)-[~]
# └─$
#
e
xport PS1='\[\e]0;\u@\\h: \w\a\]\[\e[0;94m\]┌──(\[\e[94;107m\]Portela\[\e[97;104m\]INFO\[\033[0m\])-(\[\e[0;91m\]\u\[\e[0;94m\]@\[\e[0;91m\]\h\[\e[0;94m\])-[\[\e[0;1;92m\]\w\[\e[0;94m\]]\n\[\e[0;94m\]└─\[\e[0;91m\]\$\[\e[0m\] '
