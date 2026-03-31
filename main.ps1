# Disable Task Manager restriction (set to 0 = enabled)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "DisableTaskMgr" -Value 0 -Type DWord

# Disable power options
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" `
    -Name "NoClose" -Value 1 -Type DWord

# Restart Explorer
Stop-Process -Name explorer -Force
Start-Process explorer
