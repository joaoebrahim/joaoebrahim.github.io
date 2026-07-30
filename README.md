# Profa. Luciana Ebrahim — Página de Links

Página de links (estilo Linktree) para a bio do Instagram, em HTML, CSS e JavaScript puros,
em um único arquivo: `index.html`. Sem build, sem dependências.

Estrutura da página, de cima para baixo:

1. **Lockup da marca** — monograma LE + nome + fio bordô + `Português · Redação · Concursos`
2. **Oferta principal** — a turma aberta (hoje: SESAU/CEBRASPE 2026, R$ 197)
3. **Oferta secundária** — hoje fora do ar (o molde está comentado no arquivo)
4. **Contato** — WhatsApp, YouTube, E-mail
5. **Área de membros** — para quem já é aluno
6. **Rodapé**

## Como abrir localmente

Dê um clique duplo em `index.html` ou arraste o arquivo para o navegador. Não precisa instalar nada.

## Design

A paleta vem do logotipo oficial. As cores foram amostradas do próprio arquivo e estão no
bloco `:root` do `index.html` — para mudar a identidade visual da página, mexa só ali.

| Token           | Valor     | Uso                                              |
| --------------- | --------- | ------------------------------------------------ |
| `--wine`        | `#882038` | bordô da marca — preenchimentos (CTA, monograma) |
| `--wine-lift`   | `#A8283F` | bordô aceso — hover e fios finos                 |
| `--wine-focus`  | `#C43D59` | anel de foco (precisa de 3:1 na WCAG 1.4.11)     |
| `--cream`       | `#F8F8F0` | texto principal                                  |
| `--cream-dim`   | `#D0C8C0` | texto secundário                                 |
| `--bg`          | `#141114` | fundo                                            |
| `--surface`     | `#1D181B` | cartões                                          |

O bordô **não serve para texto** sobre o fundo escuro (2,06:1, reprova na WCAG). Ele é usado
apenas como preenchimento, com o creme por cima (8,52:1). Se for criar elementos novos, mantenha
essa regra.

O elemento de assinatura é a **bolha de gabarito**: a turma aberta é a resposta já marcada em
bordô, e os outros links são alternativas que se preenchem no hover e no foco.

## Como atualizar

Abra `index.html` em qualquer editor de texto.

- **Trocar a turma em cartaz** — busque por `class="offer"`. Altere o título, o texto, a faixa
  `.specs` (órgão / banca / turma), o preço e o `href` do `.cta`.
- **Ligar a oferta secundária** — busque por `class="alt-offer"`. O bloco está comentado no
  arquivo, com o CSS pronto. Descomente e troque `href`, `data-track`, `.title` e `.meta`.
  - **COPEVE/AL** saiu em 30/07/2026 por ainda estar em desenvolvimento.
    Checkout: `https://pay.kiwify.com.br/Vne3mXY` (R$ 97).
  - **E-books** ficaram de fora até a venda estar definida. Eles não têm checkout próprio —
    a compra acontece dentro da área de membros.
- **Links de contato** — busque por `class="row"`. Altere o `href`, o `.name` e o `.detail`.
- **Mensagem pronta do WhatsApp** — está no próprio link, no parâmetro `?text=`
  (precisa estar codificado em URL).
- **Preço âncora** ("De R$ 297 por R$ 197") — a classe `.price-was` já existe. Use **somente
  se for verdade**.

### Rastreio de campanha

O link de checkout da turma já sai com `src=linktree` e parâmetros `utm_*`. Troque
`utm_campaign` por campanha, para saber de onde vem cada venda no relatório da Kiwify.

Se a oferta secundária voltar apontando para a área de membros, dê a ela um `data-track`
diferente do link do rodapé (`area-de-membros`). Mesmo destino, intenções diferentes —
comprar e entrar no que já comprou — e separar os dois no relatório importa.

O bloco `<script>` no fim do arquivo dispara o clique para o **Meta Pixel** (`fbq`) e o
**GA4** (`gtag`) usando o atributo `data-track` de cada link. Se nenhum dos dois estiver
instalado, ele não faz nada e não quebra. Para instalar, cole o snippet do pixel no `<head>`.

## Pendências

- [ ] **`og.png` (1200×630)** na raiz do repositório. As meta tags Open Graph já apontam para
      ele; enquanto o arquivo não existir, o link compartilhado no WhatsApp e no Instagram
      aparece sem imagem de preview.
- [ ] **Foto da professora** — hoje o cabeçalho usa o lockup da marca. Uma foto aumenta
      conversão em página de bio. Exporte um recorte de ~400×520 como `foto.jpg`.
- [ ] **Logotipo oficial** — o lockup está recriado em HTML/CSS (nítido em qualquer tela e sem
      peso de imagem). Para fidelidade pixel a pixel, exporte o PNG da Kiwify como `logo.png` e
      troque a `div.brand` conforme o comentário no arquivo.
- [ ] **Prova social** — depoimentos ou aprovações reais. Não inclua números inventados.

## Imagem de preview do link

A `og.png` (1200×630) é o que aparece quando o link é compartilhado no WhatsApp, no Instagram
e no Telegram. Ela é **gerada por script**, não editada à mão.

Quando a turma mudar, edite o bloco `AJUSTE AQUI` no topo de `tools/og.ps1` — título,
etiqueta, chamada, preço e endereço — e rode, a partir da raiz do repositório:

```powershell
powershell -ExecutionPolicy Bypass -File tools\og.ps1
```

Commite a `og.png` junto. As meta tags no `index.html` não precisam mudar.

O título encolhe sozinho até caber, então nome de turma longo não estoura o cartão.

> `tools/og.ps1` precisa estar salvo em **UTF-8 com BOM**. Sem o BOM, o PowerShell 5.1 lê o
> arquivo como ANSI e todo acento sai corrompido na imagem. O script detecta isso e aborta
> antes de gerar, com um aviso dizendo o que fazer.

## Publicação

A página está no ar em **https://joaoebrahim.github.io/**, publicada pelo GitHub Pages a
partir da branch `main`, na raiz. Todo push para `main` republica sozinho, em 1 a 2 minutos.

O repositório se chama `joaoebrahim.github.io` de propósito: esse nome faz o GitHub servir o
site na raiz do domínio, sem caminho depois da barra. É o endereço gratuito mais curto
possível — renomear o repositório quebra isso.

Se um dia trocar de endereço, atualize junto o `<link rel="canonical">` e as meta tags
`og:url` e `og:image` no `<head>`. Elas usam URL absoluta e não acompanham a mudança
sozinhas: se ficarem para trás, o preview compartilhado no WhatsApp aponta para o
endereço errado.

### Sobre domínio próprio e tráfego pago

`github.io` está na Public Suffix List — é domínio compartilhado, você não controla a raiz.
O Gerenciador de Negócios da Meta **não consegue verificá-lo**. Sem verificação de domínio
não dá para configurar a Mensuração Agregada de Eventos, o que degrada o rastreamento de
conversão no iOS. Se a página for receber anúncio pago, um domínio próprio deixa de ser
estética e vira requisito.
