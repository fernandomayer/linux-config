#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar Emacs 24? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm emacs
fi

echo -------------------------------------------------------------------
echo Instalar LaTeX? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm texlive-core texlive-bin \
	 texlive-fontsextra texlive-formatsextra texlive-latexextra \
	 texlive-pstricks texlive-science
    yaourt -S --noconfirm latex-beamer latex-enumitem \
	   texlive-fonts-emerald urw-classico urw-garamond minionpro 
fi

echo -------------------------------------------------------------------
echo Instalar fontes extras? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm ttf-anonymous-pro ttf-bitstream-vera \
	 ttf-dejavu ttf-inconsolata ttf-linux-libertine
    # gera algum conflito com ttf-google-fonts, que parece que ja
    # providencia todos estes
    yaourt -S --noconfirm ttf-adobe-fonts ttf-bitstream-charter \
	   ttf-bitstream-cyberbit ttf-cm-unicode ttf-computer-modern-fonts \
	   otf-bakoma otf-cm-unicode otf-latin-modern otf-latinmodern-math \
	   otf-inconsolata
fi

echo -------------------------------------------------------------------
echo Instalar fontes nonfree do LaTeX? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Baixando o instalador de tug.org
    wget http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
    echo
    echo Instalando o programa
    sudo texlua install-getnonfreefonts
    echo
    echo Baixando e instalando todas as fontes nonfree
    sudo getnonfreefonts-sys -a
    sudo updmap-sys
    sudo texhash
    echo
    echo Removendo instalador...
    rm install-getnonfreefonts
fi

echo -------------------------------------------------------------------
echo Instalar Java e plugins? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm java-runtime-common \
	 java-environment-common jdk7-openjdk jre7-openjdk \
	 jre7-openjdk-headless icedtea-web chromium-pepper-flash
fi

echo -------------------------------------------------------------------
echo Instalar Google Chrome? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm google-chrome
fi

echo -------------------------------------------------------------------
echo Instalar Firefox? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm firefox
fi


exit
