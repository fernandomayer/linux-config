sudo dnf groupinstall -y "Development Tools" "Development Libraries"

## Full latex
sudo dnf install texlive-scheme-full texinfo # or -medium

sudo dnf install gcc gcc-c++ gcc-objc gcc-objc++ gcc-gfortran \
  glibc glibc-devel glibc-utils kernel-devel gobject-introspection \
  libgfortran make automake autoconf gawk openmpi openmpi-devel \
  unixODBC unixODBC-devel gdal gdal-devel proj proj-devel \
  curl bwidget libmarkdown libmarkdown-devel \
  zlib-devel bzip2-devel xz-devel \
  readline-devel pcre2-devel libcurl-devel openssl-devel libicu-devel \
  libX11-devel libXt-devel cairo-devel pango-devel \
  libpng-devel libjpeg-turbo-devel libtiff-devel \
  java-latest-openjdk-devel libxml2-devel \
  pandoc


sudo dnf install -y gcc gcc-c++ gcc-objc gcc-objc++ gcc-gfortran \
	glibc glibc-devel glibc-utils kernel-devel gobject-introspection \
 	libgfortran automake autoconf gawk openmpi openmpi-devel \
	pvm unixODBC unixODBC-devel gdal gdal-devel proj proj-devel \
	proj-epsg proj-nad curl bwidget libmarkdown libmarkdown-devel \
	pandoc

