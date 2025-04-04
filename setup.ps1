# Peter Parser (HolyScraper) Conda Environment Setup Script
Write-Host "`n--- Peter Parser Conda Environment Setup ---`n" -ForegroundColor Cyan

# Check if Conda is installed and accessible
try {
    conda --version | Out-Null
    Write-Host "✅ Conda installation found." -ForegroundColor Green
}
catch {
    Write-Host "⚠️ Conda not found in PATH. Checking default locations..." -ForegroundColor Yellow

    $defaultCondaPath = "$env:USERPROFILE\anaconda3"
    $minicondaPath = "$env:USERPROFILE\miniconda3"

    if (Test-Path $defaultCondaPath) {
        $condaExe = "$defaultCondaPath\Scripts\conda.exe"
    }
    elseif (Test-Path $minicondaPath) {
        $condaExe = "$minicondaPath\Scripts\conda.exe"
    }
    else {
        Write-Host "❌ Anaconda or Miniconda installation not detected." -ForegroundColor Red
        Write-Host "Please install Anaconda or Miniconda first:" -ForegroundColor Yellow
        Write-Host "👉 https://www.anaconda.com/products/distribution`n" -ForegroundColor Cyan
        exit
    }

    Write-Host "✅ Conda found at: $condaExe" -ForegroundColor Green

    # Add Conda to PATH
    $choice = Read-Host "`nWould you like to add Conda to your PATH permanently? (Recommended) [Y/N]"
    if ($choice -match '^[Yy]$') {
        [Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";$(Split-Path $condaExe)", "User")
        Write-Host "`n🔧 Conda path added to user environment variables." -ForegroundColor Green
        Write-Host "Please restart your PowerShell terminal to finalize changes." -ForegroundColor Cyan
        exit
    }
    else {
        Write-Host "`n🛑 Exiting. Conda must be available in PATH to continue." -ForegroundColor Red
        exit
    }
}

# Ask user to confirm environment creation
$envName = "peterparser"
if (!(conda env list | Select-String $envName)) {
    Write-Host "`n🚀 Creating Conda environment: $envName" -ForegroundColor Cyan
    conda env create -f environment.yml
}
else {
    Write-Host "`n✅ Environment '$envName' already exists." -ForegroundColor Green
}

# Activate the Conda environment
Write-Host "`n🌿 Activating Conda environment: $envName" -ForegroundColor Cyan
conda activate $envName

# Confirm success
Write-Host "`n🎉 Setup complete! You can now run Peter Parser scripts.`n" -ForegroundColor Green
