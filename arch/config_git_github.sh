#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar git e ssh? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm git openssh xclip --needed
fi

echo -------------------------------------------------------------------
echo Configurar Git e GitHub? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Copiando arquivo de configuração do git, .gitconfig
    echo
    cp ../.gitconfig ~/
    echo
    echo Copiando .gitignore global
    echo
    cp ../.gitignore ~/
    echo
    echo Gerando chaves ssh
    ssh-keygen -t rsa -C "fernandomayer@gmail.com"
    echo
    echo
    echo Copiando o conteudo de ~/.ssh/id_rsa.pub para o clipboard
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo
    echo ATENCAO
    echo -------
    echo Entre na sua conta do GitHub e cole esse conteudo
    echo
    echo Pronto? [ 1/0 ]
    read pronto
    if [ $pronto -eq 1 ] ; then
        echo Confirmando a adicao da chave com ssh-add
        ssh-add
        echo
	      echo
        echo Conferindo a conexao com github.com
        echo ssh -T git@github.com
        ssh -T git@github.com
    fi
    echo
    echo GitHub configurado!
    echo
fi

echo -------------------------------------------------------------------
echo Clonar repositorios com arquivos de configuracao? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Antes, verfica ja existe um diretorio ~/Git
    if [ -e ~/Git ]; then
        echo ~/Git ja foi criado, continuando...
    else
        echo ~/Git ausente, vou criar
	mkdir ~/Git
    fi
    echo
    echo Clonando R-config-files
    echo
    git clone git@github.com:fernandomayer/R-config-files.git ~/Git/R-config-files
    echo
    echo Clonando spacemacs conf
    echo
    git clone git@github.com:fernandomayer/spacemacs.git ~/Git/spacemacs
    echo
    echo Copiando arquivos de configuracao para ~/
    echo
    echo Copiando .Renviron e .Rprofile
    cp ~/Git/R-config-files/.Renviron ~/
    cp ~/Git/R-config-files/.Rprofile ~/
    echo
    echo Colocando limpaRAM.sh em /usr/local/bin
    sudo cp ../limpaRAM.sh /usr/local/bin
    echo
    echo Copiando .bashrc padrao para ~/
    echo
    echo Antes, faz um backup do que ja existe
    cp ~/.bashrc ~/.bashrc_ORIGINAL
    echo
    echo Copia o novo
    cp .bashrc ~/.bashrc
    echo
    echo Carrega o .bashrc
    source ~/.bashrc
    echo
    echo Pelo .Renviron preciso ter um diretorio ~/R/library
    echo Verifica se ~/R ja existe
    echo
    if [ -e ~/R ]; then
        echo ~/R ja foi criado
        echo
        echo Entao verifica se ~/R/library ja existe
        echo
        if [ -e ~/R/library ]; then
            echo ~/R/library ja existe, continuando...
        else
            echo ~/R/library ausente, vou criar
            mkdir ~/R/library
        fi
    else
        echo ~/R ausente, vou criar
    	mkdir ~/R
    	echo
    	echo Criando tambem ~/R/library
    	mkdir ~/R/library
    	echo
    fi
fi

exit
