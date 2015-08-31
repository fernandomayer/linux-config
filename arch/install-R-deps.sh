#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar pacotes de programação? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    ## calibre serve para converter os manuais em ebooks
    sudo pacman -S base-devel gcc-objc unixodbc gdal proj curl \
	 bwidget markdown calibre ipython2
    yaourt -S pandoc-static
fi

echo -------------------------------------------------------------------
echo Instalar dependências para RGL? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S mesa xproto
fi

echo -------------------------------------------------------------------
echo Instalar demais dependências do R? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    ## Aqui estao todas as dependencias (mesmo as ja instaladas) obtidas
    ## a partir do site do pacote r para arch
    ## https://www.archlinux.org/packages/extra/i686/r/
    sudo pacman -S blas bzip2 desktop-file-utils gcc-libs lapack \
	 libjpeg libpng libtiff libxmu libxt ncurses pango pcre \
	 perl readline unzip xz zip zlib tk gcc-fortran jdk7-openjdk \
	 tk
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
    echo Converter os manuais para ebook, MOBI e EPUB? [ 1/0 ]
    read opt
    if [ $opt -eq 1 ] ; then
	echo Convertendo os manuais em ebooks...
	echo
	cd ~/Programas/R-$Rver/doc/manual
	make ebooks
	echo
	echo Os manuais estao em ~/Programas/R-$Rver/doc/manual
    fi
    echo
    echo
fi

exit
