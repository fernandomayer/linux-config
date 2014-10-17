#!/bin/bash

echo -------------------------------------------------------------------
echo Ligando o proxy da FURG
echo -------------------------------------------------------------------
## Cria .proxy para armazenar os arquivos
echo
echo
echo Criando ~/.proxy ...
echo
echo
if [ -e ~/.proxy ]; then
    echo ~/.proxy ja existe. Criando copia de backup ~/.proxy.bkp.tar.gz ...
    tar -zcPf ~/.proxy.bkp.tar.gz ~/.proxy
else
    echo /etc/bash.bashrc inexistente, vou criar ...
    mkdir ~/.proxy
fi

## Testa se os arquivos ja existem. Se sim, faz uma copia de backup *.bkp
echo
echo
echo Testando a existencia dos arquivos ...
echo
echo
if [ -e /etc/bash.bashrc ]; then
    echo /etc/bash.bashrc ja existe. Criando copia de backup /etc/bash.bashrc.bkp ...
    cp /etc/bash.bashrc /etc/bash.bashrc.bkp
else
    echo /etc/bash.bashrc inexistente, vou criar ...
    touch /etc/bash.bashrc
fi
echo
if [ -e /etc/environment ]; then
    echo /etc/environment ja existe. Criando copia de backup /etc/environment.bkp ...
    cp /etc/environment /etc/environment.bkp
else
    echo /etc/environment inexistente, vou criar ...
    touch /etc/environment
fi
echo
if [ -e /etc/apt/apt.conf ]; then
    echo /etc/apt/apt.conf ja existe. Criando copia de backup /etc/apt/apt.conf.bkp ...
    cp /etc/apt/apt.conf /etc/apt/apt.conf.bkp
else
    echo /etc/apt/apt.conf inexistente, vou criar ...
    touch /etc/apt/apt.conf
fi
echo
if [ -e ~/.wgetrc ]; then
    echo ~/.wgetrc ja existe. Criando copia de backup ~/.wgetrc.bkp ...
    cp ~/.wgetrc ~/.wgetrc.bkp
else
    echo ~/.wgetrc inexistente, vou criar ...
    touch ~/.wgetrc
fi
echo
if [ -e ~/.Renviron ]; then
    echo ~/.Renviron ja existe. Criando copia de backup ~/.Renviron.bkp ...
    cp ~/.Renviron ~/.Renviron.bkp
else
    echo ~/.Renviron inexistente, vou criar ...
    touch ~/.Renviron
fi
echo
echo
echo Configurando /etc/bash.bashrc ...
cp ~/.proxy/bash.bashrc_proxy /etc/bash.bashrc
echo
echo
echo Configurando /etc/environment ...
cp ~/.proxy/environment_proxy /etc/environment
echo
echo
echo Configurando /etc/apt/apt.conf ...
cp ~/.proxy/apt.conf_proxy /etc/apt/apt.conf
echo
echo
echo Configurando ~/.wgetrc ...
cp ~/.proxy/wgetrc_proxy ~/.wgetrc
echo
echo
echo Configurando ~/.Renviron ...
## Se o .Renviron existe entao nao pode ser sobreescrito, a configuracao
## de proxy deve ser anexada no final
if [ -e ~/.Renviron ]; then
    cp ~/.Renviron ~/.proxy/Renviron_no-proxy
    cat ~/.proxy/Renviron_proxy >> ~/.Renviron
else
    cp ~/.proxy/Renviron_proxy ~/.Renviron
fi
echo
echo
echo -------------------------------------------------------------------
echo Proxy configurado com sucesso.
echo -------------------------------------------------------------------
echo
echo
