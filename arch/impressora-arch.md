# Instalação de impressora

## Antergos

### Impressora: HP Deskjet D2360

**Problema**: a impressora não era instalada pelo gerenciador nativo do
  GNOME (mas era reconhecida). Pela interface do CUPS, outros problemas
  apareceram antes mesmo que a impressora pudesse ser reconhecida.

**Etapas**:

1. Entrar pelo gerenciador do CUPS pelo navegador:
   `localhost:631`. Clicar em `Add printer and classes` > `Add
   printer`. Quando solicitar, entre com nome de usuárioo e senha do
   _sistema_ (o mesmo do login). Se a mensagem for "Forbidden" você
   precisa se cadastrar no grupo `printadmin` para ter acesso. Faça:
```shell
sudo groupadd printadmin
```
E adicione seu usuário ao grupo (também ao `lp`):
```shell
sudo gpasswd -a fernando printadmin
sudo gpasswd -a fernando lp
```
Entre no arquivo `/etc/cups/cups-files.conf` e edite a linha abaixo para
conter o grupo criado
```shell
SystemGroup sys root printadmin
```
Reinicie o CUPS com
```shell
sudo systemctl restart org.cups.cupsd.service
```
(Talvez seja necessário fazer login novamente).

2. Adicione a impressora. Se o CUPS não encontrar nenhum driver, remova
   os pacotes `hplip`, `foomatic-db` e `foomatic-db-engine`. Reinstale o
   pacote `hplip` e reinicie o CUPS (como acima), e tente novamente.

Dessa forma a impressora funcionou.

Referências:

* https://wiki.archlinux.org/index.php/CUPS
* https://wiki.archlinux.org/index.php/Systemd#Using_units

### Impressora Lexmark E460dn (em rede no LEG)

Faça o mesmo procedimento anterior para entrar no CUPS como
administrador.

Ao tentar adicionar a impressora já pelo CUPS, nenhuma das opções de
impressora de rede que ele reconheceu automaticamente funcionaram (sem
conexão). Além disso, não existem drivers da Lexmark prontos para serem
utilizados no Arch, eles precisam ser instalados manualmente.

Para instalar o driver:

1. Entre na página da Lexmark e baixe o arquivo
[PPD-Files-LMACI.tar.Z](http://downloads.lexmark.com/downloads/pssd/PPD-Files-LMACI.tar.Z)
2. Extraia os arquivos e veja as instruções de instalação no arquivo
`Readme-Install.txt`

Depois de instalado, abra o CUPS e clique em adicionar nova
impressora. Selecione `Other Network Printer` > `LPD/LPR Host or
Printer`. Coloque o endreço:

```shell
lpd://<ip-impressora>/queue
```

substituino o `ip-impressora` e `queue` fica assim mesmo. Na página
seguinte deve aparecer uma lista com os drivers disponíveis (incluindo
aqueles que você instalou). Selecione o `E460dn.ppd` e teste a
impressão.

> OBS.: os drivers `foomatic-*` devem mesmo estar desinstalados do
> sistema, caso contrário o CUPS não conseguia nem entrar na lista de
> drivers.

Referências:

* https://wiki.archlinux.org/index.php/Lexmark
* http://support.lexmark.com/index?page=driversdownloads
