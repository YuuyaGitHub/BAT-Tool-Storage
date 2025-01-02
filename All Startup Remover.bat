@echo off
cls
title Startup Remover

rem By running this, all startups will be removed.
rem For virtual machines, do not run this after installing VMware Tools and/or VirtualBox Guest Additions; they will no longer work.

rem Check if it is Running as Administrator
NET SESSION >nul 2>&1
if %errorLevel% == 0 (
    goto main
) else (
    goto adminrequired
)

:main
rem Delete Startup Folder
rd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" /s /q
rd "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup" /s /q

rem Remove Registry Startups
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /f

rem Regenerate Registry Startups
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /f

rem End of processing
cls
echo Congratulations! All startups have been removed.
echo Press any key to close...
pause > nul
exit /b

:adminrequired
rem Prompts you to run as administrator if you are not already doing so
cls
echo You must have administrator privileges to run this program.
echo Please make sure you are running as administrator and try again.
echo.
pause > nul
exit /b
