@echo off
title Utils for ya
color 05
chcp 65001 >nul

:: Function to check if running as admin
:CheckAdmin
fsutil dirty query %systemdrive% >nul 2>&1
if '%errorlevel%' == '0' goto Admin
echo RUN AS ADMINASTRATOR
pause
exit

:Admin
:: We are running as admin

:banner
echo ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗    
echo ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝    
echo ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝     
echo ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝      
echo ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║       
echo  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝       
echo ------------------------------------------------------------------------
echo 1) - CLEAR TEMP
echo 2) - INSTALL REDISTS
echo 3) - FIX REDISTS
echo 4) - EXIT
echo ------------------------------------------------------------------------

set /p choice="Select an option (1-3): "

if "%choice%"=="1" goto FIX1
if "%choice%"=="2" goto FIX2
if "%choice%"=="3" goto FIX4
if "%choice%"=="4" exit
:FIX1
echo CLEARING UP TEMP FILES...
echo.

:: Delete all files in the temp folder
del /s /q "%temp%\*.*"

:: Remove subdirectories in the temp folder
for /d %%p in ("%temp%\*.*") do rmdir "%%p" /s /q

echo TEMPORARY FILES HAVE BEEN DELETED
pause
goto MENU

:FIX2
:: Modify paths to your downloaded files

:: Install VC Redist X64
echo DOWNLOADING AND AUTO-INSTALLING VC REDIST X64...
powershell -Command "Invoke-WebRequest -Uri 'https://download.visualstudio.microsoft.com/download/pr/368cc6bf-087b-49f9-93e6-ab05b70a58e0/814E9DA5EC5E5D6A8FA701999D1FC3BADDF7F3ADC528E202590E9B1CB73E4A11/VC_redist.x64.exe' -OutFile 'VC_redist.x64.exe'; Start-Process 'VC_redist.x64.exe' -ArgumentList '/install', '/quiet', '/norestart' -Wait"
del "VC_redist.x64.exe"

:: Install VC Redist X86
echo DOWNLOADING AND AUTO-INSTALLING VC REDIST X86...
powershell -Command "Invoke-WebRequest -Uri 'https://download.visualstudio.microsoft.com/download/pr/5cc0a375-ebc5-4a27-8a76-aa43097a8949/ED1967C2AC27D806806D121601B526F84E497AE1B99ED139C0C4C6B50147DF4A/VC_redist.x86.exe' -OutFile 'VC_redist.x86.exe'; Start-Process 'VC_redist.x86.exe' -ArgumentList '/install', '/quiet', '/norestart' -Wait"
del "VC_redist.x86.exe"

:: Install DirectX
echo DOWNLOADING AND AUTO-INSTALLING DIRECTX...
powershell -Command "Invoke-WebRequest -Uri 'https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe' -OutFile 'dxwebsetup.exe'; Start-Process 'dxwebsetup.exe' -ArgumentList '/silent' -Wait"
del "dxwebsetup.exe"

:: Completion
echo Redists has been installed and setup files has been deleted silently 

pause
goto MENU