# 1. Check for Administrative privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Requesting Administrative privileges..."
    
    # ADDED: "-NoExit" to the ArgumentList to keep the new window open
    Start-Process powershell.exe -ArgumentList "-NoExit -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Everything below this line runs as Administrator ---

Write-Host "Preparing for download..."

# 2. Define the target URL
$url = "https://raw.githubusercontent.com/itsverycoolbs/verycoolprogramforsure/main/setup.ps1"

# 3. Download and execute (irm | iex)
try {
    Write-Host "Downloading..."
    Write-Host "Executing..."
    Invoke-RestMethod -Uri $url | Invoke-Expression
}
catch {
    Write-Error "Failed to execute the remote script. Ensure the URL is valid and you have an internet connection."
}

# --- Keep the window open at the very end ---
Write-Host ""
Read-Host "Please keep open, waiting for Install..."
