#!/bin/bash

echo
printf '#%.0s' {1..80}; echo
echo "### Sincronizando repositórios de configuração"
printf '#%.0s' {1..80}; echo
echo
for repo in ai-instructions spacemacs R-config-files linux-config configs; do
    echo "--- $repo"
    git -C ~/git/$repo pull --ff-only
done

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando pacotes do sistema (pacman)"
printf '#%.0s' {1..80}; echo
echo
sudo pacman -Syu

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando pacotes do AUR (yaourt)"
printf '#%.0s' {1..80}; echo
echo
## O rstudio-desktop-bin precisa de intervenção manual na instalação: avisa se
## há atualização e pula só ele
if yaourt -Qua 2> /dev/null | grep -q rstudio-desktop-bin; then
    echo "*** ATENÇÃO: há atualização do rstudio-desktop-bin. Ele foi pulado."
    echo "*** Atualize à mão com: yaourt -S rstudio-desktop-bin"
    echo
fi
yaourt -Syua --noconfirm --ignore rstudio-desktop-bin

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando o Spacemacs (~/.emacs.d)"
printf '#%.0s' {1..80}; echo
echo
~/.update-emacs.sh

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando os pacotes do Spacemacs"
printf '#%.0s' {1..80}; echo
echo
emacs --batch -l ~/.emacs.d/early-init.el -l ~/.emacs.d/init.el \
    --eval '(progn
              (configuration-layer/update-packages t)
              (with-current-buffer spacemacs-buffer-name
                (goto-char (point-min))
                (search-forward "Updating package archives")
                (princ (buffer-substring-no-properties
                        (line-beginning-position) (point-max)))))'

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando pacotes do R (CRAN)"
printf '#%.0s' {1..80}; echo
echo
Rscript ~/.update.R

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando o INLA"
printf '#%.0s' {1..80}; echo
echo
Rscript ~/.update-inla.R

echo
printf '#%.0s' {1..80}; echo
echo "### Pronto"
printf '#%.0s' {1..80}; echo
echo
