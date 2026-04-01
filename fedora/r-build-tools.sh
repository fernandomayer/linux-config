
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
  tcl-devel tk-devel libdeflate-devel libXmu-devel libtirpc-devel \
  pandoc libuv-devel


## Intel MKL

sudo tee /etc/yum.repos.d/intel-oneapi.repo << 'EOF'
[oneAPI]
name=Intel® oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF

sudo dnf install intel-oneapi-mkl intel-oneapi-mkl-devel
