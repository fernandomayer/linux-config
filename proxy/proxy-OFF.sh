#!/bin/bash

echo -------------------------------------------------------------------
echo Desligando o proxy da FURG
echo -------------------------------------------------------------------
## Faz uma copia de backup .bkp antes de mover os arquivos
echo
echo
echo Fazendo uma copia de backup dos arquivos de configuracao ...
echo
echo
cp /etc/bash.bashrc /etc/bash.bashrc.bkp
cp /etc/environment /etc/environment.bkp
cp /etc/apt/apt.conf /etc/apt/apt.conf.bkp
cp ~/.wgetrc ~/.wgetrc.bkp
cp ~/.Renviron ~/.Renviron.bkp
echo
echo
echo Configurando /etc/bash.bashrc ...
cp ~/.proxy/bash.bashrc_no-proxy /etc/bash.bashrc
echo
echo
echo Configurando /etc/environment ...
cp ~/.proxy/environment_no-proxy /etc/environment
echo
echo
echo Configurando /etc/apt/apt.conf ...
cp ~/.proxy/apt.conf_no-proxy /etc/apt/apt.conf
echo
echo
echo Configurando ~/.wgetrc ...
cp ~/.proxy/wgetrc_no-proxy ~/.wgetrc
echo
echo
echo Configurando ~/.Renviron ...
cp ~/.proxy/Renviron_no-proxy ~/.Renviron
echo
echo
echo -------------------------------------------------------------------
echo Proxy desativado com sucesso.
echo -------------------------------------------------------------------
echo
echo
