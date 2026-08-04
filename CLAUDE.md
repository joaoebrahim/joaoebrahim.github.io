# Contexto do projeto

Página de links (bio do Instagram) da **Profa. Luciana Ebrahim** — português, redação e
concursos, em Maceió/AL. Quem cuida do tráfego é o João (`joaoebrahim`); a professora é a
cliente. O objetivo da página é vender a turma em cartaz.

Arquivo único: `index.html`. HTML, CSS e JS puros, sem build e sem dependências. Publicada em
**https://joaoebrahim.github.io/** pelo GitHub Pages, a partir de `main`, na raiz.

## Esta é a cópia de portfólio

A página existe em **dois lugares**, de propósito:

| Repositório | Endereço | Papel |
| --- | --- | --- |
| `EbrahimIsoladas/ebrahimisoladas.github.io` | ebrahimisoladas.github.io | **oficial** — link da bio |
| `joaoebrahim/joaoebrahim.github.io` | joaoebrahim.github.io | esta aqui, portfólio do João |

Esta cópia é projeto pessoal do João e **fica no ar**. Não apague.

O `canonical` aponta para o repositório oficial, para as duas não competirem na busca. As
tags `og:` continuam apontando para **este** domínio: quem compartilha o link do portfólio
deve ver o portfólio. Essa divergência é intencional — não "conserte".

Ao alterar conteúdo, replique nos dois repositórios.

## Estado atual e para onde vai

Isto é a **versão inicial**, deliberadamente enxuta. O plano combinado é evoluir para uma
**página de vendas completa**, com relatos de alunos, resultados e prova social. Ao propor
melhorias, mire nessa direção.

Oferta em cartaz: **SESAU/CEBRASPE 2026**, R$ 197, checkout `pay.kiwify.com.br/QXO9a83`.

## Identidade visual

A paleta foi **amostrada pixel a pixel do logotipo oficial**, não escolhida por aproximação.
Está no bloco `:root` do `index.html`. Para mudar a identidade, mexa só ali.

| Token | Valor | Uso |
| --- | --- | --- |
| `--wine` | `#882038` | bordô da marca — preenchimentos |
| `--wine-lift` | `#A8283F` | hover e fios |
| `--wine-focus` | `#C43D59` | anel de foco |
| `--cream` | `#F8F8F0` | texto principal |
| `--cream-dim` | `#D0C8C0` | texto secundário |
| `--bg` / `--surface` | `#141114` / `#1D181B` | fundo e cartões |

Tipografia: **PT Serif** (display) + **Instrument Sans** (corpo), via Google Fonts.

**Regra que não pode ser quebrada:** bordô **não serve para texto** sobre o fundo escuro
(2,06:1, reprova na WCAG). Use só como preenchimento, com creme por cima (8,52:1). Se criar
elemento novo, verifique o contraste antes.

O logotipo oficial é creme sobre escuro — some em fundo claro. Por isso a página é escura. O
lockup está recriado em HTML/CSS (nítido em qualquer tela, sem peso de imagem).

## Assinatura do design

A **bolha de gabarito**: a turma aberta é a resposta já marcada em bordô, e os outros links
são alternativas A/B/C que se preenchem no hover e no foco. É o elemento que dá identidade à
página — preserve ao mexer no layout.

## Regras de conteúdo

- **Não invente prova social.** Nada de número de aprovados, depoimento, garantia ou
  parcelamento que não tenha sido confirmado. Já foi removido um superlativo não comprovável
  ("professora mais renomada de Maceió"). Slots existem comentados no HTML para preencher com
  dado real.
- **Preço âncora** ("De R$ X por") só se for verdade.
- A oferta secundária (`.alt-offer`) está comentada no arquivo, servindo de molde. Candidatas:
  e-books (vendidos dentro da área de membros, sem checkout próprio) e a turma da COPEVE/AL
  (`pay.kiwify.com.br/Vne3mXY`, R$ 97), que saiu em 30/07/2026 por estar em desenvolvimento.

## Imagem de preview (og.png)

A `og.png` é **gerada por script**, não editada à mão. Quando a turma mudar, edite o bloco
`AJUSTE AQUI` no topo de `tools/og.ps1` (título, etiqueta, chamada, preço, endereço) e rode:

```
powershell -ExecutionPolicy Bypass -File tools\og.ps1
```

Depois commite a `og.png` junto. As meta tags não mudam — apontam para o nome do arquivo.

O título encolhe sozinho até caber no cartão, então nome de turma longo não estoura.

`tools/og.ps1` precisa estar em **UTF-8 com BOM**. Sem o BOM o PowerShell 5.1 lê como ANSI e
todo acento sai corrompido na imagem. O script detecta e aborta antes de gerar, mas se o
editor salvar sem BOM o problema volta.

## Ao alterar

- **Meta tags de URL absoluta** — `canonical`, `og:url` e `og:image` não acompanham mudança de
  endereço sozinhas. Se o domínio mudar, atualize as três (e o `$Endereco` em `tools/og.ps1`)
  ou o preview no WhatsApp quebra.
- **Rastreio** — cada link tem `data-track`; o script no fim do arquivo dispara para Meta Pixel
  (`fbq`) e GA4 (`gtag`), sem quebrar se não estiverem instalados. Nenhum dos dois está
  instalado ainda.
- **Alvo de toque** mínimo de 44px de altura em qualquer link novo.
- **Faixa `.specs`** é apertada: valores curtos. Nome de banca longo quebra a linha.
- Verifique em **320px e 375px** antes de dar por pronto. Já apareceram três defeitos que só
  existiam no 320px.

## Domínio e tráfego pago

`github.io` está na Public Suffix List. O Gerenciador de Negócios da Meta **não consegue
verificá-lo**, então não dá para configurar a Mensuração Agregada de Eventos — o que degrada o
rastreamento de conversão no iOS. Se a página receber anúncio pago, domínio próprio
(~R$ 40/ano num `.com.br`) deixa de ser estética e vira requisito.

## Pendências

- [ ] Foto da professora no cabeçalho (hoje é o monograma LE). A troca é uma linha, comentada
      no arquivo. Aumenta conversão em página de bio.
- [ ] Meta Pixel / GA4 no `<head>`.
- [ ] Prova social real, quando houver.
