# Paths to profile folders
$edgeProfile   = Join-Path $env:LocalAppData "Microsoft\Edge\User Data\Default"
$chromeProfile = Join-Path $env:LocalAppData "Google\Chrome\User Data\Default"

$edgeFile   = Join-Path $edgeProfile   "Bookmarks"
$chromeFile = Join-Path $chromeProfile "Bookmarks"

# 1. Stop Edge
Write-Host "Stopping Microsoft Edge…" -ForegroundColor Cyan
Get-Process msedge -ErrorAction SilentlyContinue | Stop-Process -Force

# 2. Backup Edge bookmarks
if (Test-Path $edgeFile) {
    $bak = "$edgeFile.bak"
    Write-Host "Backing up existing Edge bookmarks to $bak" -ForegroundColor Cyan
    Copy-Item $edgeFile $bak -Force
}

# 3. Ensure Chrome bookmarks exist
if (-not (Test-Path $chromeFile)) {
    Write-Host "ERROR: Chrome bookmarks not found at $chromeFile" -ForegroundColor Red
    exit 1
}

# 4. Copy Chrome → Edge (preserves JSON order exactly)
Write-Host "Copying Chrome bookmarks into Edge profile…" -ForegroundColor Cyan
Copy-Item $chromeFile $edgeFile -Force

# 5. Verify via file-hash that the two JSONs are identical
$chromeHash = Get-FileHash $chromeFile -Algorithm SHA256
$edgeHash   = Get-FileHash $edgeFile   -Algorithm SHA256

if ($chromeHash.Hash -eq $edgeHash.Hash) {
    Write-Host "✅ Bookmarks content (and order) are identical." -ForegroundColor Green
} else {
    Write-Host "⚠️ ALERT: Bookmarks file differs after copy!" -ForegroundColor Yellow
}

Write-Host "Done. Launch Edge to see your imported Chrome bookmarks." -ForegroundColor Cyan
