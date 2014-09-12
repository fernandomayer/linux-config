##======================================================================
## Script para instalar os pacotes necessarios inicialmente em uma
## instalacao nova do R
##======================================================================

## Verifica o status
packageStatus()

## Atualiza se necessario
update.packages(ask = FALSE, checkBuilt = TRUE)

## Pacotes a serem instalados
pkgs <- c("ggplot2", "plyr", "lubridate", "knitr",
          "xtable", "gdata", "gridExtra", "latticeExtra",
          "maps", "mapdata", "maptools", "mapproj", "marelac",
          "geoR", "geoRglm", "RandomFields", "gstat", "rgeos",
          "spdep",
          "rpanel", "rgdal", "car", "ESSR", "TeachingDemos",
          "markdown", "pscl",
          "dae", "ExpDes", "multcomp")

## INLA
## http://www.r-inla.org/download
# Pacotes necessarios
pkgs.inla <- c("sp", "numDeriv", "fields", "rgl", "mvtnorm",
               "multicore", "pixmap")

## Instalacao
install.packages(c(pkgs, pkgs.inla), dependencies = TRUE)
# Um adendo: Rgraphviz
source("http://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")
## Para instalar INLA
source("http://www.math.ntnu.no/inla/givemeINLA.R")
## Para atualizar
# inla.update()
