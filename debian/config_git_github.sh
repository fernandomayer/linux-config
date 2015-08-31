#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar git e ssh? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo apt-get install -y git git-core git-man git-gui git-doc \
	ssh openssh-server openssh-client
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
    ssh-keygen -t rsa -C "fernandomayer@gmail.com"
    echo
    echo Instalando xclip
    sudo apt-get install -y xclip
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
    echo Clonando R-config-files
    echo
    git clone git@github.com:fernandomayer/R-config-files.git ~/GitHub/R-config-files
    echo
    echo Clonando emacs-files
    echo
    git clone git@github.com:fernandomayer/emacs-files.git ~/GitHub/emacs-files
    echo
    echo Copiando arquivos de configuracao para ~/
    echo
    echo Copiando .Renviron, .Rprofile e .Xresources
    cp ~/GitHub/R-config-files/.Renviron ~/
    cp ~/GitHub/R-config-files/.Rprofile ~/
    cp ~/GitHub/R-config-files/.Xresources ~/
    echo
    echo Colocando knitr-pdflatex.sh em /usr/local/bin
    sudo cp ~/GitHub/R-config-files/knitr-pdflatex.sh /usr/local/bin
    echo
    echo Colocando limpaRAM.sh em /usr/local/bin
    sudo cp limpaRAM.sh /usr/local/bin
    echo
    echo Rodando xrdb -merge no .Xresources para o emacs reconhecer
    xrdb -merge ~/.Xresources
    echo
    echo Pelo .Renviron preciso ter um diretorio ~/R_environment/my_library
    echo Verifica se ~/R_environment ja existe
    echo
    if [ -e ~/R_environment ]; then
        echo ~/R_environment ja foi criado
        echo
        echo Entao verifica se ~/R_environment/my_library ja existe
        echo
        if [ -e ~/R_environment/my_library ]; then
            echo ~/R_environment/my_library ja existe, continuando...
        else
            echo ~/R_environment/my_library ausente, vou criar
            mkdir ~/R_environment/my_library
        fi
    else
        echo ~/R_environment ausente, vou criar
    	mkdir ~/R_environment
    	echo
    	echo Criando tambem ~/R_environment/my_library
    	mkdir ~/R_environment/my_library
    	echo
    fi
    echo Copiando emacs.el e convertendo em .emacs
    cp ~/GitHub/emacs-files/emacs.el ~/
    mv ~/emacs.el ~/.emacs
    echo
    echo Para o .emacs preciso clonar o solarized e o ESS...
    echo
    echo Antes, verfica se o .emacs.d ja esta presente
    if [ -e ~/.emacs.d ]; then
        echo ~/.emacs.d ja foi criado, continuando...
    else
        echo ~/.emacs.d ausente, vou criar
        mkdir ~/.emacs.d
        echo
        echo e agora podemos continuar...
    fi
    echo
    echo Clonando solarized
    echo
    git clone git@github.com:sellout/emacs-color-theme-solarized.git ~/.emacs.d/emacs-color-theme-solarized
    echo
    echo Clonando ESS
    echo
    git clone git@github.com:emacs-ess/ESS.git ~/.emacs.d/ESS
    echo
    echo Clonando polymode
    echo
    git clone git@github.com:vitoshka/polymode.git ~/.emacs.d/polymode
    echo
fi

exit
