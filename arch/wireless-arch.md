# Configuração de placas wireless no Arch

Para funcionar a placa de rede wireless no Dell Inspiron 1525, é
necessário instalar um firmware proprietário.

Inicialmente, confira o modelo da sua placa com

```sh
lspci -vnn -d 14e4:
```

Meu resultado foi:

```sh
0b:00.0 Network controller [0280]: Broadcom Corporation BCM4312 802.11b/g LP-PHY [14e4:4315] (rev 01)
	Subsystem: Dell Wireless 1395 WLAN Mini-Card [1028:000b]
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at fe7fc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: b43-pci-bridge
	Kernel modules: ssb
```

Para instalar o driver confira a página
[Broadcom wireless](https://wiki.archlinux.org/index.php/Broadcom_wireless).

No meu caso, instalei o pacote `b43-firmware-classic`. Após reiniciar o
computador, a placa de rede fou reconhecida.
