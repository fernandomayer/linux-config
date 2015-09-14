# Pandoc no RStudio

O pandoc que vem integrado ao RStudio apresentou um conflito no Arch
Linux a partir de Agosto de 2015, como pode ser visto nesse
[issue](https://github.com/rstudio/rmarkdown/issues/498).

Para contornar esse problema, instale o pacote `pandoc-static` do AUR. O
`pandoc` já funciona normalmenet para o sistema, mas o pandoc do RStudio
não funciona pois ele usa o próprio pandoc. Crie links simbólicos do
pandoc do sistema para o pandoc do RStudio, dessa forma ele volta a
funcionar.

```{sh}
## Diretorio do pandoc do RStudio
cd /usr/lib/rstudio/bin/
## Faca um backup do pandoc do RStudio
sudo mv pandoc pandoc_rstudio
sudo mv pandoc-citeproc pandoc-citeproc_rstudio
## Crie o link simbolico
sudo ln -s /usr/bin/pandoc pandoc
sudo ln -s /usr/bin/pandoc-citeproc pandoc-citeproc
```
