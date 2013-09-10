##======================================================================
## Script para instalar os pacotes necessarios inicialmente em uma
## instalacao nova do R
##======================================================================

## Verifica o status
packageStatus()

## Atualiza se necessario
update.packages(ask = FALSE)

## Pacotes a serem instalados
pkgs <- c("ggplot2", "plyr", "lubridate", "knitr",
          "xtable", "gdata", "gridExtra", "latticeExtra",
          "maps", "mapdata", "maptools", "mapproj", "sp", "marelac",
          "geoR", "geoRglm", "fields", "RandomFields", "gstat", "rgeos",
          "rpanel", "rgl", "rgdal",
          "mvtnorm", "markdown",
          "dae", "ExpDes", "multcomp")

## Instalacao
install.packages(pkgs, dependencies = TRUE)
