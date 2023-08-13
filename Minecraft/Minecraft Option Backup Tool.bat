@echo off
setlocal
:main
title Minecraft Options Backup Tool
cls
echo MINECRAFT OPTIONS BACKUP TOOL
echo ===================================
echo.
echo.
echo Welcome to Minecraft Options Backup Tool!
echo This tool will backup or restore Minecraft settings (options.txt).
echo.
echo Available options:
echo 1. Backup options.txt
echo 2. Restore options.txt
echo 3. Quit
echo.
set /p choice=Choose what you want to do: 

if "%choice%"=="1" (
    goto backup
) else if "%choice%"=="2" (
    goto restore
) else if "%choice%"=="3" (
    cls
    exit /b
) else (
    echo Invalid choice. Please select one from 1 to 3.
    pause > nul
    goto main
)


:backup
cls
title Minecraft Options Backup Tool - Backup
echo MINECRAFT OPTIONS BACKUP TOOL
echo ===================================
echo BACKUP
echo.
echo.
echo This option will backup options.txt.
echo Note: If you already have options.txt, it will be overwritten.
echo.
set /p backuppath=Enter backup location for options.txt: 
copy /y "%userprofile%\AppData\Roaming\.minecraft\options.txt" "%backuppath%\options.txt"
echo Processing completed.
pause > nul
goto ended


:restore
cls
title Minecraft Options Backup Tool - Restore
echo MINECRAFT OPTIONS BACKUP TOOL
echo ===================================
echo RESTORE
echo.
echo.
echo This option will restore options.txt.
echo.
set /p restorepath=Enter backup location for options.txt: 
copy /y "%restorepath%\options.txt" "%userprofile%\AppData\Roaming\.minecraft\options.txt" 
echo Processing completed.
pause > nul
goto ended


:ended
cls
echo MINECRAFT OPTIONS BACKUP TOOL
echo ===================================
echo.
echo This process is complete. what next?
echo.
echo 1. Back to Main Menu
echo 2. Quit
echo.
echo.
set /p end=Select the action you want to perform: 
if "%end%"=="1" (
    goto main
) else if "%choice%"=="2" (
    cls
    exit /b
)

endlocal