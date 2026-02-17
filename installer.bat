@echo off
title Fun Batch Animation
color 0b

echo Welcome to the Fun Batch File!
echo.

:: Simple spinning animation
set "spin=\|/-"
:loop
for /l %%i in (0,1,3) do (
    <nul set /p= %spin:~%%i,1%
    ping -n 2 127.0.0.1 >nul
    <nul set /p= "\b"
)
goto loop
