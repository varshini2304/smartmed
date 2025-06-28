# Add Git path to System Environment Variables permanently
$gitPath = "C:\Program Files\Git\cmd"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($currentPath -notlike "*$gitPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$gitPath", "Machine")
    Write-Host "✅ Git path added to system PATH."
} else {
    Write-Host "✅ Git path already exists in system PATH."
}

# Verify Git installation
Write-Host "🔍 Verifying Git..."
git --version

# Restart shell session (only works in new terminal)
Write-Host "`n🌀 Please restart your terminal now and re-run:"
Write-Host "`n    dart pub global activate flutterfire_cli`n"
