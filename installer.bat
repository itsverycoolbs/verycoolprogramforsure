@echo off
set "filepath=%USERPROFILE%\Desktop\ihackedyoulol.txt"

if not exist "%filepath%" (
    type nul > "%filepath%"
    echo File created: %filepath%
) else (
    echo File already exists: %filepath%
)

pause
