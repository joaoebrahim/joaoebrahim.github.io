# Ebrahim Isoladas — Página de Links

Página estilo Linktree para o Instagram da marca **Ebrahim Isoladas**, com card do curso *Gabaritando COPEVE/AL* e botões de contato (WhatsApp, YouTube e E-mail).

## Como abrir localmente

1. Baixe ou clone este repositório
2. Navegue até a pasta do projeto
3. Dê um clique duplo no arquivo `index.html` ou arraste-o para o navegador

Não é necessário instalar nada — o projeto é HTML, CSS e JavaScript puros.

## Como publicar no GitHub Pages (grátis)

1. Crie um repositório no GitHub com o nome `ebrahim-isoladas-links`
2. Faça o push do código:
   ```bash
   git remote add origin https://github.com/SEU_USUARIO/ebrahim-isoladas-links.git
   git branch -M main
   git push -u origin main
   ```
3. No GitHub, vá em **Settings > Pages**
4. Em **Branch**, selecione `main` e clique em **Save**
5. Em alguns segundos seu site estará disponível em:
   `https://SEU_USUARIO.github.io/ebrahim-isoladas-links`

## Como atualizar os links e o curso

Edite o arquivo `index.html` com qualquer editor de texto:

- **Avatar / nome / descrição**: linhas dentro da `<headline>` e da `.avatar`
- **Card do curso**: busque por `class="card"` — altere título, descrição, preço e link
- **Botões de link**: busque por `class="link-btn"` — altere o `href`, `.label` e `.sublabel`
- **Rodapé**: busque por `class="footer"`
