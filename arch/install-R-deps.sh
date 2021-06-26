#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar pacotes de programação? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S base-devel gcc-objc unixodbc gdal proj curl \
	       markdown calibre --needed
fi

echo -------------------------------------------------------------------
echo Instalar dependências para RGL? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S mesa xproto glu --needed
fi

echo -------------------------------------------------------------------
echo Instalar demais dependências do R? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    ## Aqui estao todas as dependencias (mesmo as ja instaladas) obtidas
    ## a partir do site do pacote r para arch
    ## https://www.archlinux.org/packages/extra/i686/r/
    sudo pacman -S curl icu lapack libtiff libxmu pango pcre pcre2 \
         perl unzip which zip gcc-fortran tcl tk gcc-fortran \
         jdk-openjdk texlive-bin texlive-core blas lapack bzip2 \
         desktop-file-utils gcc-libs libjpeg libpng libxt ncurses \
         pango perl readline unzip xz zip zlib --needed
fi

exit
