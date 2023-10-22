@echo off
cls
title Explorer Help Disable Tool

rem Get administrator privileges and run as administrator if not administrator
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (
    goto :welcome
) else (
    powershell Start-Process "%0" -Verb RunAs
)

:check
set "file_path=C:\Windows\HelpPane.exe"
if exist "%file_path%" (
    goto welcome
) else (
    goto alreadydisabled
)

:welcome
rem Displays Welcome Message
echo.
echo Explorer Help Disable Tool
echo ==============================
echo.
echo Welcome to Explorer Help Disable Tool!
echo.
echo This tool allows you to disable help when pressing F1 in Explorer.
echo You can see details at the following URL: https://www.youtube.com/watch?v=K7zRJmPS2_s
echo.
echo Press any key to continue.
pause > nul
goto main

:main
rem Give ownership of HelpPane to current user
takeown /f "C:\Windows\HelpPane.exe" > nul
icacls "C:\Windows\HelpPane.exe" /grant "%USERNAME%:F" > nul

rem Ask if you want to rename or delete
choice /C DR /M "Do you want to delete(D) or rename(R) HelpPane? "

rem Main processing
if errorlevel 2 (
    ren "C:\Windows\HelpPane.exe" "HelpPane_old.exe"
    goto done
) else if errorlevel 1 (
    del "C:\Windows\HelpPane.exe"
    goto done
)

:alreadydisabled
cls
echo HelpPane is already disabled.
echo.
echo Press any key to exit...
pause > nul
exit /b

:done
cls
echo Congratulations! The help that appears when you press F1 in Explorer has been disabled.
pause > nul
exit /b
