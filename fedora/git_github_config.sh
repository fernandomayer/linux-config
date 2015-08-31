#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar git e ssh? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo yum install -y git git-all git-gui libssh openssh-server \
	openssh-client
fi

echo -------------------------------------------------------------------
echo Configurar Git e GitHub? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Copiando arquivo de configuração do git, .gitconfig
    echo
    cp .gitconfig ~/
    echo
    echo Copiando .gitignore global
    echo
    cp .gitignore ~/
    echo
    echo Gerando chaves ssh
    ssh-keygen -t rsa -C "oc.rodrigosantana@gmail.com"
    echo
    echo Instalando xclip
    sudo yum install -y xclip
    echo
    echo Copiando o conteudo de ~/.ssh/id_rsa.pub para o clipboard
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo
    echo ATENCAO
    echo -------
    echo Entre na sua conta do GitHub e cole esse conteudo em
    echo https://github.com/settings/ssh
    echo
    echo Pronto? [ 1/0 ]
    read pronto
    if [ $pronto -eq 1 ] ; then
        echo Confirmando a adicao da chave com ssh-add
        ssh-add
        echo
        echo Conferindo a conexao com github.com
        echo ssh -T git@github.com
        ssh -T git@github.com
    fi
    echo
    echo Git e GitHub configurados!
    echo
fi

echo -------------------------------------------------------------------
echo Clonar repositorios com arquivos de configuracao? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Antes, verfica ja existe um diretorio ~/GitHub
    if [ -e ~/GitHub ]; then
        echo ~/GitHub ja foi criado, continuando...
    else
        echo ~/GitHub ausente, vou criar
	mkdir ~/GitHub
    fi 
    echo
    echo Clonando My-R-Config-Files
    echo
    git clone git@github.com:rodrigosantana/My-R-Config-Files.git \
	~/GitHub/My-R-Config-Files
    echo
    echo Clonando my-emacs-files
    echo
    git clone git@github.com:rodrigosantan/my-emacs-files.git \
	~/GitHub/my-emacs-files
    echo
    echo Copiando arquivos de configuracao para ~/
    echo
    echo Copiando .Renviron, .Rprofile e .Xresources
    cp ~/GitHub/My-R-Config-Files/.Renviron ~/
    cp ~/GitHub/My-R-Config-Files/.Rprofile ~/
    cp ~/GitHub/My-R-Config-Files/.Xresources ~/
    echo
    echo Rodando xrdb -merge no .Xresources para o emacs reconhecer
    xrdb -merge ~/.Xresources
    echo
    echo Pelo .Renviron preciso ter um diretorio ~/R_environment/My_Library
    echo Verifica se ~/R_environment ja existe
    echo
    if [ -e ~/R_environment ]; then
        echo ~/R_environment ja foi criado
        echo
        echo Entao verifica se ~/R_environment/My_Library ja existe
        echo
        if [ -e ~/R_environment/My_Library ]; then
            echo ~/R_environment/My_Library ja existe, continuando...
        else
            echo ~/R_environment/My_Library ausente, vou criar
            mkdir ~/R_environment/My_Library
        fi
    else
        echo ~/R_environment ausente, vou criar
    	mkdir ~/R_environment
    	echo
    	echo Criando tambem ~/R_environment/My_Library
    	mkdir ~/R_environment/My_Library
    	echo
    fi
    echo Copiando emacs.el e convertendo em .emacs
    cp ~/GitHub/my-emacs-files/emacs.el ~/
    mv ~/emacs.el ~/.emacs
    echo
    echo Para o .emacs preciso clonar os meus arquivos do .emacs.d...
    echo
    echo Copiando emacs.d.el e convertendo em .emacs.d
    cp -R ~/GitHub/my-emacs-files/emacs.d.el ~/
    mv ~/emacs.d.el ~/.emacs.d
fi

echo -------------------------------------------------------------------
echo Clonar repositorios ess.el, r-autoyas.el e outros? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    git clone https://github.com/mlf176f2/r-autoyas.el.git \
	~/.emacs.d/r-autoyas
    echo
    echo Clonando r-autoyas
    echo
    git clone git@github.com:vitoshka/polymode.git ~/.emacs.d/polymode
    echo
    echo Clonando polymode
    echo
    git clone --recursive https://github.com/capitaomorte/yasnippet \
	~/.emacs.d/yasnippet
    echo
    echo Clonando yasnippet
    echo
fi

exit
