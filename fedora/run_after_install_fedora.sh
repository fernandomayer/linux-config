#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar Emacs 24? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y emacs emacs-el emacs-goodies-el \ 
        emacs-color-theme-el emacs-ess-el
fi

echo -------------------------------------------------------------------
echo Instalar LaTeX? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y texlive-base texlive-bibtex texlive-scheme-full \
	texlive-collection-bibtexextra texlive-collection-fontsextra \
	texlive-collection-fontsrecommended texlive-collection-fontutils \
	texlive-collection-formatsextra texlive-collection-genericextra \
	texlive-collection-genericrecommended texlive-collection-langportuguese \
	texlive-collection-latexextra texlive-collection-latexrecommended \
	texlive-collection-latex texlive-collection-mathextra \
	texlive-collection-plainextra texlive-collection-publishers \
	texlive-collection-science texlive-plain texlive-beamer \
	texlive-collection-luatex texlive-xcolor cm-super emacs-auctex \
	emacs-ess
fi

echo -------------------------------------------------------------------
echo Instalar fontes extras? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y bitstream-vera-fonts-common bitstream-vera-sans-fonts \
	bitstream-vera-sans-mono-fonts bitstream-vera-serif-fonts \
	dejavu-fonts-common dejavu-sans-fonts dejavu-sans-mono-fonts \
	dejavu-serif-fonts levien-inconsolata-fonts liberation-fonts-common \
	liberation-mono-fonts liberation-narrow-fonts liberation-sans-fonts \
	liberation-serif-fonts linux-libertine-biolinum-fonts \
	linux-libertine-fonts linux-libertine-fonts-common
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
    texlua install-getnonfreefonts
    echo
    echo Baixando e instalando todas as fontes nonfree
    getnonfreefonts-sys -a
    updmap-sys
    texhash
    echo
    echo Removendo instalador...
    rm install-getnonfreefonts
fi

echo -------------------------------------------------------------------
echo Instalar Chrome? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y google-chrome-stable
fi

echo -------------------------------------------------------------------
echo Instalar Adobe-flash-player? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    wget http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
    yum install -y flash-plugin
    rm adobe-release-x86_64-1.0-1.noarch.rpm
fi

echo -------------------------------------------------------------------
echo Instalar utilidades para desktop? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y shutter
fi

echo -------------------------------------------------------------------
echo Instalar pacotes de produtividade? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y dia maxima wxMaxima maxima-gui gnuplot
fi

echo -------------------------------------------------------------------
echo Instalar pacotes multimidia? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y ffmpeg-devel ffmpeg-libs ffmpeg gstreamer-ffmpeg \
	gstreamer1-plugins-ugly gstreamer1-plugins-bad-free \
	xmms xmms-mp3 xmms-mplayer mplayer smplayer libdvdcss \
	xine-lib xine-lib-extras unrar vlc-core vlc-extras vlc
fi

echo -------------------------------------------------------------------
echo Instalar YUM utilities? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    yum install -y yum-utils
fi

exit
