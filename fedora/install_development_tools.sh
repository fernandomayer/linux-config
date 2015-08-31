#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar Pacotes de Desenvolvimento? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
# No Fedora o equivalente aos pacotes build-essential do Ubuntu e a 
# instalacao do Development Tools e Development Libraries... estes 
# estes pacotes serao instalados pelo comando yum groupinstall...
if [ $opcao -eq 1 ] ; then
    sudo yum groupinstall -y "Development Tools" "Development Libraries"
fi

echo -------------------------------------------------------------------
echo Instalar Pacotes de Desenvolvimento 2? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo yum install -y gcc gcc-c++ gcc-objc gcc-objc++ gcc-gfortran \
	glibc glibc-devel glibc-utils kernel-devel gobject-introspection \
 	libgfortran automake autoconf gawk openmpi openmpi-devel \
	pvm unixODBC unixODBC-devel gdal gdal-devel proj proj-devel \
	proj-epgs proj-nad curl bwidget libmarkdown libmarkdown-devel \
	pandoc
fi

echo -------------------------------------------------------------------
echo Instalar dependências para RGL? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo yum install -y cdbs intltool libdrm-dev mesa-libGLU \
	mesa-libGLU-devel mesa-libGL mesa-libGL-devel xorg-x11-proto-devel \
	libglpng libglpng-devel opengl-games-utils
fi

echo -------------------------------------------------------------------
echo Instalar demais dependências do R? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo mv /etc/yum.repos.d/livna.repo /etc/yum.repos.d/livna-repo
    sudo yum update
    sudo yum-builddep -y R
    sudo mv /etc/yum.repos.d/livna-repo /etc/yum.repos.d/livna.repo
    sudo yum update
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
