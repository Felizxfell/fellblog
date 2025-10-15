$filePath = "c:\Users\fell_\AppData\Local\Temp\scp13957\plugins\ShopGUIPlus\shops\blocks.yml"
$content = Get-Content $filePath -Raw -Encoding UTF8
$lines = $content -split "`n"

$inPages1To10 = $false
$resultLines = @()
$currentItemType = ""

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    # Detectar inicio de páginas 1-10
    if ($line -match '#PAGE 1' -and $i -gt 0) {
        $previousLines = $lines[([Math]::Max(0, $i-10))..($i-1)] -join "`n"
        if ($previousLines -match 'items:') {
            $inPages1To10 = $true
        }
    }
    
    # Detectar fin de página 10
    if ($line -match '#PAGE 11') {
        $inPages1To10 = $false
    }
    
    # Detectar tipo de item
    if ($line -match '^\s+type:\s+(\w+)') {
        $currentItemType = $matches[1]
    }
    
    # Reemplazar buyPrice si estamos en páginas 1-10 y no es tipo special
    if ($inPages1To10 -and $line -match '^\s+buyPrice:\s+\d+' -and $currentItemType -ne 'special') {
        $indent = $line -replace '^(\s+)buyPrice:.*', '$1'
        $resultLines += "${indent}buyPrice: 50"
    } else {
        $resultLines += $line
    }
}

$resultContent = $resultLines -join "`n"
Set-Content -Path $filePath -Value $resultContent -Encoding UTF8 -NoNewline
Write-Host "Archivo actualizado correctamente. Se cambiaron todos los buyPrice a 50 en las páginas 1-10"

