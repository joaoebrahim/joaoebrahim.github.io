# =====================================================================
#  Gera a og.png — a imagem de preview que aparece quando o link é
#  compartilhado no WhatsApp, no Instagram e no Telegram.
#
#  Para atualizar quando a turma mudar, edite o bloco AJUSTE AQUI e rode,
#  a partir da raiz do repositório:
#
#      powershell -ExecutionPolicy Bypass -File tools\og.ps1
#
#  Depois é só commitar a og.png junto. As meta tags no index.html não
#  precisam mudar — elas apontam para o nome do arquivo, não para o
#  conteúdo.
#
#  ATENÇÃO: este arquivo precisa estar salvo em UTF-8 COM BOM. Sem o BOM,
#  o PowerShell 5.1 lê como ANSI e todo acento sai corrompido na imagem.
#  O script detecta isso e avisa antes de gerar.
# =====================================================================

# ------------------------------ AJUSTE AQUI ---------------------------
$Titulo   = 'SESAU/CEBRASPE 2026'
$Etiqueta = 'CURSO ONLINE  ·  KIWIFY'
$Chamada  = '20 aulas gravadas, no padrão da banca.'
$Preco    = '197,00'
$Endereco = 'joaoebrahim.github.io'
# ----------------------------------------------------------------------

# Guarda de codificação: se o arquivo perdeu o BOM, 'ç' chega quebrado aqui.
$acento = 'ç'
if ($acento.Length -ne 1 -or [int][char]$acento -ne 0x00E7) {
  Write-Warning 'Este arquivo perdeu a codificação UTF-8 com BOM.'
  Write-Warning 'Os acentos vão sair corrompidos na imagem.'
  Write-Warning "Reabra tools\og.ps1 no editor e salve como 'UTF-8 with BOM'."
  exit 1
}

Add-Type -AssemblyName System.Drawing

$W = 1200; $H = 630
$bmp = New-Object System.Drawing.Bitmap($W, $H)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# --- Paleta: amostrada do logotipo oficial, igual ao :root do index.html ---
$bg       = [System.Drawing.ColorTranslator]::FromHtml('#141114')
$surface  = [System.Drawing.ColorTranslator]::FromHtml('#1D181B')
$wine     = [System.Drawing.ColorTranslator]::FromHtml('#882038')
$wineLift = [System.Drawing.ColorTranslator]::FromHtml('#A8283F')
$cream    = [System.Drawing.ColorTranslator]::FromHtml('#F8F8F0')
$creamDim = [System.Drawing.ColorTranslator]::FromHtml('#D0C8C0')
$ruleCol  = [System.Drawing.ColorTranslator]::FromHtml('#33292E')

$bBg       = New-Object System.Drawing.SolidBrush($bg)
$bSurface  = New-Object System.Drawing.SolidBrush($surface)
$bWine     = New-Object System.Drawing.SolidBrush($wine)
$bWineLift = New-Object System.Drawing.SolidBrush($wineLift)
$bCream    = New-Object System.Drawing.SolidBrush($cream)
$bCreamDim = New-Object System.Drawing.SolidBrush($creamDim)
$bRule     = New-Object System.Drawing.SolidBrush($ruleCol)

$g.FillRectangle($bBg, 0, 0, $W, $H)
$g.FillRectangle($bWine, 0, 0, $W, 8)

# Georgia e Segoe UI são a cadeia de fallback declarada no CSS da página.
# PT Serif e Instrument Sans vêm do Google Fonts e não estão instaladas
# localmente, então usar o fallback mantém a peça coerente com o site.
function New-Fonte([string]$nome, [single]$tam, [string]$estilo = 'Regular') {
  New-Object System.Drawing.Font($nome, $tam, [System.Drawing.FontStyle]::$estilo, [System.Drawing.GraphicsUnit]::Pixel)
}
$fMonogram = New-Fonte 'Georgia'  40 'Bold'
$fMark     = New-Fonte 'Georgia'  36 'Bold'
$fSub      = New-Fonte 'Segoe UI' 16 'Bold'
$fEyebrow  = New-Fonte 'Segoe UI' 18 'Bold'
$fPitch    = New-Fonte 'Segoe UI' 25
$fPrice    = New-Fonte 'Georgia'  48 'Bold'
$fPriceSm  = New-Fonte 'Georgia'  25 'Bold'
$fUrl      = New-Fonte 'Segoe UI' 19

# GenericTypographic remove o preenchimento extra do MeasureString padrão
$sf = [System.Drawing.StringFormat]::GenericTypographic.Clone()
$sf.FormatFlags = $sf.FormatFlags -bor [System.Drawing.StringFormatFlags]::MeasureTrailingSpaces

function Get-TextW([string]$t, $font) { return $g.MeasureString($t, $font, [int]::MaxValue, $sf).Width }

# System.Drawing não tem letter-spacing; desenha caractere a caractere
function Draw-Tracked([string]$text, $font, $brush, [single]$x, [single]$y, [single]$track) {
  $cx = $x
  foreach ($ch in $text.ToCharArray()) {
    $s = [string]$ch
    $g.DrawString($s, $font, $brush, $cx, $y, $sf)
    $cx += (Get-TextW $s $font) + $track
  }
}
function Get-TrackedW([string]$text, $font, [single]$track) {
  $w = 0
  foreach ($ch in $text.ToCharArray()) { $w += (Get-TextW ([string]$ch) $font) + $track }
  return $w
}

# ---------- Lockup da marca ----------
$cxM = 78; $cyM = 62; $dM = 92
$g.FillEllipse($bWine, $cxM, $cyM, $dM, $dM)
$mw = Get-TextW 'LE' $fMonogram
$g.DrawString('LE', $fMonogram, $bCream, ($cxM + ($dM - $mw) / 2), ($cyM + 23), $sf)

$xText = $cxM + $dM + 30
Draw-Tracked 'PROFA. LUCIANA EBRAHIM' $fMark $bCream $xText 64 3.0
$g.FillRectangle($bWineLift, $xText, 112, 246, 3)
Draw-Tracked 'PORTUGUÊS  ·  REDAÇÃO  ·  CONCURSOS' $fSub $bCreamDim $xText 126 2.4

# ---------- Cartão da oferta ----------
$cardY = 198; $cardH = 300
$g.FillRectangle($bSurface, 70, $cardY, ($W - 140), $cardH)
$g.FillRectangle($bWine, 70, $cardY, ($W - 140), 4)

# Bolha de gabarito preenchida: a assinatura do design, a resposta já marcada
$g.FillEllipse($bWine, 112, ($cardY + 48), 28, 28)
Draw-Tracked $Etiqueta $fEyebrow $bCreamDim 156 ($cardY + 52) 2.2

# O título encolhe sozinho até caber: nome de turma mais longo não estoura o cartão
$larguraMax = $W - 140 - 76
$tamTitulo = 74
do {
  $fTitle = New-Fonte 'Georgia' $tamTitulo 'Bold'
  $larguraTitulo = Get-TextW $Titulo $fTitle
  if ($larguraTitulo -le $larguraMax) { break }
  $tamTitulo -= 2
} while ($tamTitulo -gt 34)
if ($tamTitulo -lt 74) { "titulo reduzido para ${tamTitulo}px para caber" }

$g.DrawString($Titulo, $fTitle, $bCream, 108, ($cardY + 104 + (74 - $tamTitulo) / 2), $sf)
$g.DrawString($Chamada, $fPitch, $bCreamDim, 112, ($cardY + 208), $sf)

# ---------- Preço e endereço ----------
$g.FillRectangle($bRule, 70, 526, ($W - 140), 1)
$g.DrawString('R$', $fPriceSm, $bCreamDim, 112, 562, $sf)
$g.DrawString($Preco, $fPrice, $bCream, 152, 546, $sf)

$uw = Get-TrackedW $Endereco $fUrl 1.0
Draw-Tracked $Endereco $fUrl $bCreamDim ($W - 112 - $uw) 562 1.0

# Salva na raiz do repositório, independente de onde o script foi chamado
$raiz = Split-Path $PSScriptRoot -Parent
$out = Join-Path $raiz 'og.png'
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()

$fi = Get-Item $out
"gerado: $out"
"tamanho: $([math]::Round($fi.Length/1KB,1)) KB"
$chk = [System.Drawing.Image]::FromFile($out)
"dimensões: $($chk.Width)x$($chk.Height)"
$chk.Dispose()
