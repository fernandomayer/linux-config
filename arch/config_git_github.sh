#!/bin/bash

echo -------------------------------------------------------------------
echo Instalar git e ssh? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    sudo pacman -S --noconfirm git openssh openssh-askpass xclip
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
    echo
    echo Copiando o conteudo de ~/.ssh/id_rsa.pub para o clipboard
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo
    echo ATENCAO
    echo -------
    echo Entre na sua conta do GitLab e do GitHub e cole esse conteudo
    echo
    echo Pronto? [ 1/0 ]
    read pronto
    if [ $pronto -eq 1 ] ; then
        echo Confirmando a adicao da chave com ssh-add
        ssh-add
        echo
	echo Conferindo a conexao com git.leg
        echo ssh -T git@git.leg.ufpr.br
        ssh -T git@git.leg.ufpr.br
	echo
        echo Conferindo a conexao com github.com
        echo ssh -T git@github.com
        ssh -T git@github.com
    fi
    echo
    echo GitLab e GitHub configurados!
    echo
fi

echo -------------------------------------------------------------------
echo Clonar repositorios com arquivos de configuracao? [ 1/0 ]
echo -------------------------------------------------------------------
read opcao
if [ $opcao -eq 1 ] ; then
    echo
    echo Antes, verfica ja existe um diretorio ~/GitLab
    if [ -e ~/GitLab ]; then
        echo ~/GitLab ja foi criado, continuando...
    else
        echo ~/GitLab ausente, vou criar
	mkdir ~/GitLab
    fi
    echo
    echo Clonando R-config-files
    echo
    git clone git@git.leg.ufpr.br:fernandomayer/R-config-files.git ~/GitLab/R-config-files
    echo
    echo Clonando emacs-files
    echo
    git clone git@git.leg.ufpr.br:fernandomayer/emacs.git ~/GitLab/emacs
    echo
    echo Copiando arquivos de configuracao para ~/
    echo
    echo Copiando .Renviron, .Rprofile e .Xresources
    cp ~/GitLab/R-config-files/.Renviron ~/
    cp ~/GitLab/R-config-files/.Rprofile ~/
    cp ~/GitLab/R-config-files/.Xresources ~/
    echo
    echo Colocando knitr-pdflatex.sh em /usr/local/bin
    sudo cp ~/GitLab/R-config-files/knitr-pdflatex.sh /usr/local/bin
    echo
    echo Colocando limpaRAM.sh em /usr/local/bin
    sudo cp limpaRAM.sh /usr/local/bin
    echo
    echo Copiando .bashrc padrao para ~/
    echo
    echo Antes, faz um backup do que ja existe
    cp ~/.bashrc ~/.bashrc_ORIGINAL
    echo
    echo Copia o novo
    cp .bashrc ~/.bashrc
    echo
    echo Rodando xrdb -merge no .Xresources para o emacs reconhecer
    xrdb -merge ~/.Xresources
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
    echo Copiando emacs.el e convertendo em .emacs
    cp ~/GitLab/emacs/emacs.el ~/
    mv ~/emacs.el ~/.emacs
    echo
    echo Verifica se ~/.emacs.d ja existe
    echo
    if [ -e ~/.emacs.d ]; then
        echo ~/.emacs.d ja foi criado
        echo
    else
        echo ~/.emacs.d ausente, vou criar
    	mkdir ~/.emacs.d
    	echo
    fi
    echo Copiando demais arquivos de configuracao do emacs
    echo functions.el, library-install.el e prelude-packages.el
    echo
    cp ~/GitLab/emacs/functions.el ~/.emacs.d
    cp ~/GitLab/emacs/library-install.el ~/.emacs.d
    cp ~/GitLab/emacs/prelude-packages.el ~/.emacs.d
    echo
    echo Roda emacs em batch mode para instalar os pacotes do MELPA
    echo
    emacs --batch -l ~/.emacs.d/library-install.el
    echo
    echo
fi

exit
