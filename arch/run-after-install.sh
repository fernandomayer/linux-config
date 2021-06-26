#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar Emacs? [ 1/0 ]
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
	 texlive-bibtexextra texlive-pstricks texlive-science \
   texlive-humanities texlive-publishers --needed
fi


echo -------------------------------------------------------------------
echo Instalar Java? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm java-environment-common \
         java-runtime-common jre-openjdk jdk-openjdk --needed
fi

echo -------------------------------------------------------------------
echo Instalar Firefox? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm firefox --needed
fi

exit
