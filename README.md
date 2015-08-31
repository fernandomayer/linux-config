# linux-config

Scripts para configuração inicial de um sistema Linux, após uma
instalação nova.

Os scripts foram separados em diretórios, de acordo com a distribuição.

- [arch](/arch): para Arch Linux e derivados, como Antergos e
  Manjaro. Desenvolvido por @fernandomayer.
- [ubuntu](/ubuntu): principalmente para Xubuntu (Ubuntu com
  Xfce). Desenvolvido por @fernandomayer.
- [debian](/debian): para versões recentes do Debian. Desenvolvido por
  @arnaldorusso.
- [fedora](/fedora): para versões recentes do Fedora. Desenvolvido por
  @rodrigosantana.

Os principais pacotes instalados são: LaTeX (texlive), R, git, e outros
softwares que consideramos úteis. 

A ordem de utilização é a seguinte:

1. `run-after-install.sh`: instala Emacs, texlive, java  e outros
pacotes gerais para o funcionamento do sistema. Esse comando é o único
que deve ser rodado como **root** (ou `sudo`). 
2. `config-git-github.sh`: instala o git, ssh, e importa configurações
pessoais dos repositórios do GitLab/GitHub, e coloca nos lugares
apropriados. (Verifique os repositórios do Git antes de instalar, e
altere para qualquer outro que queira ou não execute essas opções).
Deve ser rodado como usuário normal, mas a senha de root será necessária
em algumas etapas.
3. `install-R-deps.sh`: adiciona o repositório do CRAN
(<http://cran-r.c3sl.ufpr.br>) ao `etc/apt/sources.list` (para Ubuntu e
Debian), instala pacotes de programação e demais dependências para o
R. Depois baixa a última versão e *compila* o código-fonte. Deve ser
rodado como usuário normal, mas a senha de root será necessária em
algumas etapas.
4. `script_Rpkgs.R`: coloque os nomes do pacotes que quiser no lugar
apropriado e rode dentro do R com

```r
source("/home/aonde/estiver/linux-config/script_Rpkgs.R")
```

## Proxy

O diretório `proxy` contém os arquivos necessários para setar o proxy
(nesse caso ainda fixo para o proxy da FURG) para todo o sistema. Os
scripts para ligar e desligar o proxy são, respectivamente:
`proxy-ON.sh` e `proxy-OFF.sh`. Eles podem ser colocados em algum lugar
do `PATH` para se tornarem disponíveis para todo o sistema. Por exemplo:

```shell
cp proxy-ON.sh /usr/local/bin
cp proxy-OFF.sh /usr/local/bin
```

e devem ser rodados como `root`

```shell
sudo proxy-ON.sh
sudo proxy-OFF.sh
```

> NOTA: estes scripts ainda estão pouco genéricos, mas com o tempo pretendo deixá-los mais gerais.

## Licença

MIT. Veja [LICENSE](LICENSE.md).
