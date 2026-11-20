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
echo "### Atualizando pacotes do sistema (dnf)"
printf '#%.0s' {1..80}; echo
echo
sudo dnf upgrade -y

echo
printf '#%.0s' {1..80}; echo
echo "### Atualizando flatpaks"
printf '#%.0s' {1..80}; echo
echo
sudo flatpak upgrade -y

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
