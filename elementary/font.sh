#!/bin/bash
FONT_NAME="SourceCodePro"
URL="https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.tar.gz"
mkdir /tmp/$FONT_NAME
cd /tmp/$FONT_NAME
wget $URL -O "`echo $FONT_NAME`.tar.gz"
tar --extract --gzip --file ${FONT_NAME}.tar.gz
sudo mkdir /usr/share/fonts/truetype/$FONT_NAME
sudo cp -rf /tmp/$FONT_NAME/. /usr/share/fonts/truetype/$FONT_NAME/.
fc-cache -f -v
