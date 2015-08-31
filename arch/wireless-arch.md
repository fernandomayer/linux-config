# Configuração de placas wireless no Arch

Para funcionar a placa de rede wireless no Dell Inspiron 1525, é
necessário instalar um firmware proprietário.

Inicialmente, confira o modelo da sua placa com

```sh
lspci -vnn -d 14e4:
```

Meu resultado foi:


Para instalar o driver confira a página
[Broadcom wireless](https://wiki.archlinux.org/index.php/Broadcom_wireless).

No meu caso, instalei o pacote `b43-firmware-classic`. Após reiniciar o
computador, a placa de rede fou reconhecida.
