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

## Pastas em minúsculas (Desktop, Downloads, Documents e Pictures)

Para renomear as pastas padrão do home é preciso avisar o sistema onde
elas estão, senão os aplicativos continuam usando os nomes antigos:

```bash
mv ~/Desktop ~/desktop
mv ~/Downloads ~/downloads
printf 'XDG_DESKTOP_DIR="$HOME/desktop"\nXDG_DOWNLOAD_DIR="$HOME/downloads"\nXDG_DOCUMENTS_DIR="$HOME/documents"\nXDG_PICTURES_DIR="$HOME/pictures"\n' > ~/.config/user-dirs.dirs
mkdir -p ~/documents ~/pictures
echo 'enabled=False' > ~/.config/user-dirs.conf
```

O `user-dirs.conf` com `enabled=False` impede que o
`xdg-user-dirs-update`, executado no login, recrie as pastas com nomes
em maiúsculas (isso só importa com o pacote `xdg-user-dirs` instalado).
Para conferir:

```bash
xdg-user-dir DESKTOP    # /home/mayer/desktop
xdg-user-dir DOWNLOAD   # /home/mayer/downloads
xdg-user-dir DOCUMENTS  # /home/mayer/documents
xdg-user-dir PICTURES   # /home/mayer/pictures
```

O ícone da área de trabalho e a barra lateral do Thunar passam a usar as
novas pastas depois de sair e entrar de novo na sessão. No Firefox,
`browser.download.lastDir` no `prefs.js` ainda pode apontar para
`~/Downloads`, mas é só a última pasta lembrada pelo seletor de arquivos
(`useDownloadDir` está `false`, então ele pergunta onde salvar); basta
escolher `~/downloads` uma vez.

O Xfce4 Screenshooter salvava as capturas na raiz do home. Para mandá-las
para `~/pictures`, altere `screenshot_dir` em
`~/.config/xfce4/xfce4-screenshooter` (ou escolha a pasta na janela do
programa):

```bash
sed -i 's|^screenshot_dir=.*|screenshot_dir=file:///home/mayer/pictures|' ~/.config/xfce4/xfce4-screenshooter
```

## Compilar pacotes do AUR fora do /tmp (yaourt/makepkg)

Neste Arch o `/tmp` é um `tmpfs` (fica na RAM) com cerca de 923 MB. O
`yaourt` compila em `/tmp/yaourt-tmp-<usuario>`, e pacotes grandes
(como o `quarto-cli-bin`, cujo `.deb` tem 142 MB e descompacta em várias
vezes isso) enchem o `/tmp`. O erro que aparece é enganoso:

```
zstd: error 70 : Write error : cannot write block : Disk quota exceeded
==> ERROR: Failed to create package file.
```

Não é cota de disco: é o `tmpfs` cheio (confira com `df -h /tmp`). Além
disso, compilar na RAM é ruim em uma máquina com 1,8 GiB. A solução é
mandar as compilações para o disco, com arquivos no home:

```bash
mkdir -p ~/.cache/makepkg/{build,pkgs,src} ~/.cache/yaourt
printf 'BUILDDIR=$HOME/.cache/makepkg/build\nPKGDEST=$HOME/.cache/makepkg/pkgs\nSRCDEST=$HOME/.cache/makepkg/src\n' > ~/.makepkg.conf
printf 'YAOURTTMPDIR="$HOME/.cache/yaourt"\n' > ~/.yaourtrc
```

- `~/.makepkg.conf` vale para todo uso do `makepkg`; `~/.yaourtrc`
  muda o diretório temporário do `yaourt`.
- Se o `yaourt` ignorar o `YAOURTTMPDIR`, o `BUILDDIR` do
  `~/.makepkg.conf` ainda vale. Como alternativa, rode
  `TMPDIR=$HOME/.cache/yaourt yaourt -S <pacote>`.
- Os diretórios ficam no disco e podem ser apagados quando quiser sem
  afetar os programas instalados. O `src/` guarda o que foi baixado
  (143 MB após o Quarto) e não é limpo automaticamente:
  `rm -rf ~/.cache/makepkg/src/*`.
- O `yaourt` não tem mais manutenção (`yay` e `paru` são as
  alternativas usuais), mas continuo usando: funciona bem e é leve, o
  que importa nesta máquina.

## Tempo de espera do GRUB

O padrão é 5 segundos (`GRUB_TIMEOUT=5` em `/etc/default/grub`). Para
reduzir para 1 segundo, altere o valor (com backup) e regenere a
configuração:

```bash
sudo cp /etc/default/grub /etc/default/grub.bk && sudo sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
grep '^GRUB_TIMEOUT' /etc/default/grub
```

Vale a partir do próximo boot. Esta máquina inicia em UEFI e o
`grub.cfg` fica em `/boot/grub/grub.cfg`. Com `GRUB_TIMEOUT=0` o menu
nem aparece, o que dificulta a recuperação se algo der errado; com 1
segundo ainda dá tempo de apertar uma tecla para parar a contagem.
Mantenha `GRUB_TIMEOUT_STYLE=menu` para o menu continuar visível.

## Outras notas

- O alias `fixit` que existia no `~/.bashrc` usava `pacman-mirrors`,
  que só existe no Manjaro. No Arch puro a alternativa para atualizar a
  lista de espelhos é o `reflector`. O alias foi removido.
- O `fastfetch` é executado a cada shell interativo (via `~/.bashrc`);
  isso acrescenta um pequeno custo ao abrir cada terminal.
