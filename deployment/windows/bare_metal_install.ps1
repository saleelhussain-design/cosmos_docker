# Windows Bare Metal Installation Script
Write-Host "Starting Bare Metal Installation for CosmOS on Windows..." -ForegroundColor Cyan

# This is a simplified version. Bare metal Frappe on Windows usually requires WSL.
# We will attempt to install prerequisites via Chocolatey if available.

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

$deps = @("python", "nodejs", "mariadb", "redis")
foreach ($dep in $deps) {
    Write-Host "Installing $dep..."
    choco install $dep -y
}

Write-Host "Installing Frappe Bench..."
pip install frappe-bench

Write-Host "Bare metal dependencies installed. Please follow the manual setup for site initialization."
pause
