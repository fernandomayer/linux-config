#!/bin/bash

echo -------------------------------------------------------------------
echo Adicionar repositório em /etc/apt/sources.list? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Adicionando repositório cran-r.c3sl.ufpr.br em /etc/apt/sources.list
    echo
    sudo sh -c "echo '\n\n##R\ndeb http://cran-r.c3sl.ufpr.br/bin/linux/ubuntu `lsb_release -sc`/' >> /etc/apt/sources.list"
    echo
    echo Adicionando a chave de segurança
    echo
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    echo
    echo Atualizando pacotes...
    echo
    sudo apt-get update
fi

echo -------------------------------------------------------------------
echo Instalar pacotes de programação? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo apt-get install -y build-essential gobjc gobjc++ \
	gobjc-multilib gobjc++-multilib gfortran-multilib \
	gcc-multilib g++-multilib automake autoconf gawk \
	openmpi-common openmpi-checkpoint libopenmpi1.6 libopenmpi-dev \
	libsprng2 libsprng2-dev pvm pvm-dev unixodbc unixodbc-bin \
	gdal-bin libgdal1-dev libproj-dev curl bwidget markdown pandoc

fi

echo -------------------------------------------------------------------
echo Instalar dependências para RGL? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo apt-get install -y cdbs dh-translations intltool libdrm-dev \
	libgl1-mesa-dev libglu1-mesa-dev libx11-xcb-dev libxcb-glx0-dev \
	libxdamage-dev libxfixes-dev libxxf86vm-dev mesa-common-dev python-scour \
	x11proto-damage-dev x11proto-dri2-dev x11proto-fixes-dev x11proto-gl-dev \
	x11proto-xf86vidmode-dev
fi

echo -------------------------------------------------------------------
echo Instalar demais dependências do R? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo apt-get build-dep -y r-base
fi

echo -------------------------------------------------------------------
echo Baixar e compilar o R? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo Antes, verfica se o diretorio Programas ja existe
    if [ -e ~/Programas ]; then
        echo ~/Programas ja foi criado
    else
        echo ~/Programas ausente, vou criar
        mkdir ~/Programas
        echo
        echo Continuando...
    fi
    echo Agora verifica se Programas/arquivos foi criado
    if [ -e ~/Programas/arquivos ]; then
        echo ~/Programas/arquivos ja foi criado
    else
        echo ~/Programas/arquivo ausente, vou criar
        mkdir ~/Programas/arquivos
        echo
        echo Continuando...
    fi
    echo
    echo Baixando o R de cran-r.c3sl.ufpr.br
    echo
    echo Digite a versao do R, apenas numeros
    read Rver
    wget -O ~/Programas/arquivos/R-$Rver.tar.gz http://cran-r.c3sl.ufpr.br/src/base/R-3/R-$Rver.tar.gz
    echo
    echo Extraindo R-$Rver para ~/Programas
    tar -zxvf ~/Programas/arquivos/R-$Rver.tar.gz -C ~/Programas
    echo
    echo
    echo Compilar o R como uma shared library, com a flag --enable-R-shlib? [ 1/0 ]
    read opt
    if [ $opt -eq 1 ] ; then
	echo Rodando ./configure --enable-R-shlib
	echo
	cd ~/Programas/R-$Rver
	./configure --enable-R-shlib
    else
	echo Rodando ./configure
	echo
	cd ~/Programas/R-$Rver
	./configure
    fi
    echo
    echo
    echo Compilando...
    echo
    make
    echo
    echo
    echo Rodar make check? [ 1/0 ]
    echo WARNING! Isso pode demorar bastante
    read opt
    if [ $opt -eq 1 ] ; then
    echo Rodando make check...
    make check
    else
    echo
    echo Instalando...
    echo
    sudo make install
    echo
    fi
    echo R $Rver compilado e instalado
    echo
    echo
fi

exit
