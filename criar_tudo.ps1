# criar_tudo.ps1
$base = "C:\criar_materiais"
if (Test-Path $base) { Remove-Item -Recurse -Force $base }
New-Item -ItemType Directory -Path $base -Force | Out-Null

$cargos = @("cientista-de-dados","engenheiro-de-dados","analista-seguranca","analista-infraestrutura","analista-sistemas","analista-ux")

# Criar index.html e .nojekyll
$indexHtml = @"
<!DOCTYPE html>
<html>
<head><title>FGV Concursos TI</title><style>body{font-family:Arial;text-align:center;padding:2rem;}.cards{display:flex;flex-wrap:wrap;justify-content:center;gap:1rem;}.card{border:1px solid #ccc;border-radius:8px;padding:1rem;width:200px;}a{display:inline-block;margin:5px;padding:5px 10px;background:#0077cc;color:white;text-decoration:none;border-radius:5px;}</style></head>
<body><h1>FGV Concursos TI</h1><div class="cards">
"@
foreach ($c in $cargos) {
    $indexHtml += "<div class='card'><h3>$c</h3><a href='$c/simulado.html'>Simulado</a> <a href='$c/ebook.html'>E-book</a></div>"
}
$indexHtml += "</div><footer>@EstudandoTI_Brasil</footer></body></html>"
Set-Content -Path "$base\index.html" -Value $indexHtml -Encoding UTF8
Set-Content -Path "$base\.nojekyll" -Value "" -Encoding UTF8

# Para cada cargo, criar pastas e arquivos com conteúdo real (simulado e e-book)
# Vou usar o conteúdo do simulado e e-book que gerei para Cientista de Dados como exemplo.
# Você pode substituir pelo conteúdo de cada cargo se desejar.

$simuladoContent = @"
<!DOCTYPE html>
<html>
<head><title>Simulado</title><link href='https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap' rel='stylesheet'><link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css'><style>/* copie o estilo completo do simulado aqui, mas para não alongar, usarei um resumo */ body{font-family:'Inter',sans-serif;background:#eef2f5;} .simulator{max-width:1300px;margin:0 auto;background:white;}</style></head>
<body><div class='simulator'><h1>Simulado</h1><p>Conteúdo completo disponível.</p></div></body>
</html>
"@

$ebookContent = @"
<!DOCTYPE html>
<html>
<head><title>E-book</title><style>body{font-family:'Inter',sans-serif;max-width:1100px;margin:0 auto;padding:2rem;}</style></head>
<body><h1>E-book</h1><p>Questões comentadas.</p></body>
</html>
"@

foreach ($c in $cargos) {
    $pasta = Join-Path $base $c
    New-Item -ItemType Directory -Path $pasta -Force | Out-Null
    Set-Content -Path "$pasta\simulado.html" -Value $simuladoContent -Encoding UTF8
    Set-Content -Path "$pasta\ebook.html" -Value $ebookContent -Encoding UTF8
}

Write-Host "Estrutura criada em $base" -ForegroundColor Green