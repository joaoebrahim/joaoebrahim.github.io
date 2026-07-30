# Profa. Luciana Ebrahim — Página de Links

Página de links (estilo Linktree) para a bio do Instagram, em HTML, CSS e JavaScript puros,
em um único arquivo: `index.html`. Sem build, sem dependências.

Estrutura da página, de cima para baixo:

1. **Lockup da marca** — monograma LE + nome + fio bordô + `Português · Redação · Concursos`
2. **Oferta principal** — a turma aberta (hoje: SESAU/CEBRASPE 2026, R$ 197)
3. **Oferta secundária** — e-books, vendidos dentro da área de membros
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
- **Trocar a oferta secundária** — busque por `class="alt-offer"`. Hoje ela aponta para a área
  de membros, porque o e-book é vendido lá dentro e não tem checkout próprio. Se um dia tiver
  link de pagamento direto, troque o `href` por ele e acrescente os `utm_*`.
- **Voltar a turma da COPEVE/AL** — ela saiu da página em 30/07/2026 por ainda estar em
  desenvolvimento. O checkout era `https://pay.kiwify.com.br/Vne3mXY` (R$ 97). Para trazer de
  volta, use o `.alt-offer` como molde.
- **Links de contato** — busque por `class="row"`. Altere o `href`, o `.name` e o `.detail`.
- **Mensagem pronta do WhatsApp** — está no próprio link, no parâmetro `?text=`
  (precisa estar codificado em URL).
- **Preço âncora** ("De R$ 297 por R$ 197") — a classe `.price-was` já existe. Use **somente
  se for verdade**.

### Rastreio de campanha

O link de checkout da turma já sai com `src=linktree` e parâmetros `utm_*`. Troque
`utm_campaign` por campanha, para saber de onde vem cada venda no relatório da Kiwify.

A área de membros aparece em **dois** lugares — em "Também disponível" (comprar e-book) e no
rodapé (quem já é aluno). Mesmo destino, intenções diferentes, então cada um tem seu
`data-track` (`ebook` e `area-de-membros`) para separar no relatório.

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

## Como publicar no GitHub Pages

1. **Settings > Pages**
2. Em **Source**, escolha `Deploy from a branch`
3. Em **Branch**, selecione `main` / `(root)` e salve

A página fica em `https://joaoebrahim.github.io/linktree-Ebrahimisoladas/`.

Se trocar o domínio, atualize junto o `<link rel="canonical">` e as meta tags `og:url` e
`og:image` no `<head>` — elas usam URL absoluta.
