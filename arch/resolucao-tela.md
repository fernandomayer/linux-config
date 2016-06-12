Para usar a resolução máxima do monitor Samsung SyncMaster 633nw (que é um monitor extra) foi necessário adicionar a resolução máxima pelo `xrandr`. A resolução estava 1024x768 (4:3) e não apareciam mais opções. A resolução máxima dele é 1360x768 (16:9).

Os comandos foram:

```bash
## Verifica o nome dos dispositivos
xrandr -q
## Cria um novo modeline para a resolução e frequência desejada
cvt 1360 768 60
# 1360x768 59.80 Hz (CVT) hsync: 47.72 kHz; pclk: 84.75 MHz
Modeline "1360x768_60.00"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync
xrandr --newmode "1360x768_60.00"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync
## Adiciona ao xrandr
xrandr --addmode VGA-1 1360x768_60.00
## Altera a resolução
xrandr --output VGA-1 --mode 1360x768_60.00
```

Isso altera a resolução para essa seção apenas. Para tornar essa resolução permanente, criei o arquivo `~/.xprofile` com os comandos:

```bash
xrandr --newmode "1360x768_60.00"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync
xrandr --addmode VGA-1 1360x768_60.00
xrandr --output VGA-1 --mode 1360x768_60.00
```

e depois criei o arquivo `~/.xinitrc` para executar esses comandos (apenas o `~/.xprofile` não funciona):

```bash
#
# ~/.xinitrc
#

#
# Run .xprofile
#

if [ -f ~/.xprofile ]; then
	    . ~/.xprofile
fi
```

Links:

- https://wiki.archlinux.org/index.php/multihead
- https://wiki.archlinux.org/index.php/Xrandr
- https://wiki.ubuntu.com/X/Config/Resolution
