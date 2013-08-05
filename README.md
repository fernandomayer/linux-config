# linux-config

Scripts para configuração inicial de um sistema Linux, após uma instalação nova.

Os principais pacotes instalados são: LaTeX (texlive), R, git, e outros softwares que considero úteis.

A ordem de utilização é a seguinte:

1. `run-after-install.sh`: instala Emacs, texlive, java  e outros    pacotes gerais para o funcionamento do sistema. Esse comando é o único que deve ser rodado como **root** (e.g. `sudo`).
2. `config-git-github.sh`: instala o git, ssh, e importa minhas configurações pessoais dos repositórios do GitHub (e coloca nos lugares apropriados). Deve ser rodado como usuário normal, mas a senha de root será necessária em algumas etapas.
3. `install-R-deps.sh`: adiciona o repositório do CRAN (`cran-r.c3sl.ufpr.br`) ao `etc/apt/sources.list`, instala pacotes de programação e demais dependências para o R. Depois baixa a última versão e *compila* o código-fonte. Deve ser rodado como usuário normal, mas a senha de root será necessária em algumas etapas.
4. `script_Rpkgs.R`: coloque os nomes do pacotes que quiser no lugar apropriado e rode dentro do R com

```r
source("/home/aonde/estiver/linux-config/script_Rpkgs.R")
```

> NOTA: estes scripts ainda estão pouco genéricos, mas com o tempo pretendo deixá-los mais gerais.

## Licença

MIT. Veja [LICENSE](LICENSE.md).