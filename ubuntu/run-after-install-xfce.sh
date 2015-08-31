#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar Emacs 24? [ 1/0 ]
echo -------------------------------------------------------------------
# De https://launchpad.net/~cassou/+archive/emacs
# Para versoes antigas apenas
read opcao
if [ $opcao -eq 1 ] ; then
    # add-apt-repository -y ppa:cassou/emacs
    # apt-get update
    apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg \
	emacs-goodies-el
fi

echo -------------------------------------------------------------------
echo Instalar LaTeX? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y texlive-base texlive-bibtex-extra \
	texlive-fonts-extra texlive-fonts-recommended \
	texlive-generic-extra texlive-latex-extra texlive-math-extra \
	texlive-plain-extra texlive-science latex-xcolor latex-beamer \
	texlive-lang-portuguese \
	cm-super cm-super-minimal cm-super-x11 auctex
fi

echo -------------------------------------------------------------------
echo Instalar fontes extras? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y ttf-bitstream-vera ttf-dejavu fonts-inconsolata \
	ttf-liberation fonts-linuxlibertine 
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
echo Instalar Chromium? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y chromium-browser chromium-codecs-ffmpeg-extra
fi

echo -------------------------------------------------------------------
echo Instalar utilidades para desktop? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y shutter python-gpgme # para o dropbox daemon
fi

echo -------------------------------------------------------------------
echo Instalar pacotes de produtividade? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo apt-get install -y dia \
	maxima wxmaxima gnuplot
fi

echo -------------------------------------------------------------------
echo Instalar pacotes multimidia? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    # E o resultado de apt-get install ubuntu-restricted-extras,
    # mas tirei cabextract e ttf-mscorefonts-installer
    apt-get install -y gstreamer0.10-plugins-bad-multiverse \
        libavcodec-extra-54 libav-tools libavutil-extra-52 libfaac0 \
        libmjpegutils-2.1-0 libmpeg2encpp-2.1-0 libmplex2-2.1-0 \
        libopenjpeg2 unrar xfce4-mixer vlc
fi

echo -------------------------------------------------------------------
echo Instalar Medibuntu e libdvdcss2? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo Baixando Medibuntu e colocando em /etc/apt/sources.list.d/
    echo
    wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list 
    apt-get update 
    apt-get --yes --allow-unauthenticated install medibuntu-keyring 
    apt-get update
    echo
    echo
    echo Instalando libdvdcss2
    apt-get install -y libdvdcss2
fi

echo -------------------------------------------------------------------
echo Instalar Java e plugins? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y default-jdk icedtea-plugin
fi

echo -------------------------------------------------------------------
echo Instalar lm-sensors? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    apt-get install -y lm-sensors psensor
    echo 
    echo ATENÇÃO!
    echo --------
    echo Lembre-se de rodar
    echo sudo sensors-detect
    echo e YES em todas
    echo NOTA: o psensor vai ser iniciado automaticamente em cada sessão
    echo
fi

exit
