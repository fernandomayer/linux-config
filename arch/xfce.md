# Arch Linux + Xfce em máquina antiga

Configurações feitas em um ASUS X200MA (Intel Celeron N2830, 2 núcleos,
gráficos Intel Atom Z36xx/Z37xx, **1,8 GiB de RAM**) com Arch Linux,
Xfce 4.20 e LightDM. Como a memória é o principal limitador, quase tudo
aqui gira em torno de usar menos RAM.

## zram (swap comprimido em RAM)

O zram cria um dispositivo em RAM que funciona como swap e comprime as
páginas (com zstd, tipicamente 2-3x). É muito mais rápido do que fazer
swap em um disco antigo.

Situação inicial: apenas uma partição de swap de 4 GB (`/dev/sda3`),
com `vm.swappiness = 60` e cerca de 2 GB já em uso.

Instalação:

```bash
sudo pacman -S --needed zram-generator
```

Configuração do dispositivo (metade da RAM, prioridade maior que a do
swap em disco, que fica como reserva):

```bash
printf '[zram0]\nzram-size = ram / 2\ncompression-algorithm = zstd\nswap-priority = 100\n' | sudo tee /etc/systemd/zram-generator.conf
```

Ajustes do kernel. Com zram, um `swappiness` alto é melhor, e
`page-cluster = 0` desliga a leitura de swap em blocos (útil só em
disco rotativo):

```bash
printf 'vm.swappiness = 100\nvm.page-cluster = 0\n' | sudo tee /etc/sysctl.d/99-swappiness.conf
```

Aplicar e iniciar:

```bash
sudo sysctl --system >/dev/null
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service
swapon --show
```

A saída deve listar `/dev/zram0` (922M, prioridade 100) além de
`/dev/sda3` (prioridade -1). Tudo persiste após reiniciar.

> Se `systemctl start` falhar com "control process exited with error
> code", confira se `/etc/systemd/zram-generator.conf` existe. Sem a
> seção `[zram0]` o serviço não sobe.
>
> Os comandos com `sudo` precisam ser rodados em um terminal de verdade
> (o Claude Code, por exemplo, não consegue digitar a senha).

## Firefox

O Firefox era o maior consumidor de memória (processo principal mais
cinco processos de conteúdo, cerca de 1 GB). Para reduzir, em
`about:config` altere `dom.ipc.processCount` para 2 ou 3.

## Layout de teclado (pt-BR ABNT2)

O teclado da máquina é ABNT2, mas as configurações estavam com uma lista
de layouts `br(nativo)`, `br(thinkpad)` e `us`, e nenhuma das variantes
`br` era a correta. Para testar sem alterar nada:

```bash
setxkbmap -layout br -variant abnt2
```

Isso vale só para a sessão atual. Para diagnóstico de teclas use
`xev -event keyboard` e observe `keycode` e `keysym`. O campo `state` do
evento indica o grupo de layout ativo: `0x0` é o primeiro, `0x2000` o
segundo e `0x4000` o terceiro. Se o teste for feito com o `us` ativo, as
teclas de pontuação não mostram o comportamento do layout brasileiro.

Configuração definitiva no Xfce (guarde antes o estado atual para poder
voltar):

```bash
xfconf-query -c keyboard-layout -lv > ~/.keyboard-layout.bk
xfconf-query -c keyboard-layout -p /Default/XkbLayout -s br
xfconf-query -c keyboard-layout -p /Default/XkbVariant -s abnt2
xfconf-query -c keyboard-layout -p /Default/XkbDisable -s false
```

Vale a partir do próximo login. O layout do sistema (também usado na
tela de login do LightDM) é configurado à parte:

```bash
sudo localectl set-x11-keymap br pc105 abnt2
```

Isso grava `/etc/X11/xorg.conf.d/00-keyboard.conf`. O teclado do console
já estava como `br-abnt2`. Para conferir depois do login:

```bash
setxkbmap -query
```

Deve mostrar `layout: br` e `variant: abnt2`.

## Outras notas

- O alias `fixit` que existia no `~/.bashrc` usava `pacman-mirrors`,
  que só existe no Manjaro. No Arch puro a alternativa para atualizar a
  lista de espelhos é o `reflector`. O alias foi removido.
- O `fastfetch` é executado a cada shell interativo (via `~/.bashrc`);
  isso acrescenta um pequeno custo ao abrir cada terminal.
