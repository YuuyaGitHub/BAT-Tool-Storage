@echo off
cls
title Any Size File Generator
echo.
echo.
echo ==========================================
echo.
echo          ANY SIZE FILE GENERATOR
echo.
echo ==========================================
echo.
echo Welcome to Any Size File Generator(ASFG)!
echo This tool will generate a file of the specified size.
echo This is an automated version of the fsutil command.
echo.
echo Note: Depending on where you want to create it, you may need to "run as administrator".
echo.
echo. 
SET INPUTSTR=
SET /P INPUTSTR="Enter location to create file(Example: C:\Example\Test.txt): "
SET INPUTSTR2=
SET /P INPUTSTR2="Enter File Size (Bytes): "
echo.
fsutil file createnew "%INPUTSTR%" %INPUTSTR2% > nul
cls
if %errorlevel% equ 0 goto created
if %errorlevel% neq 0 goto failed

:created
echo File Created: %INPUTSTR% with %INPUTSTR2% bytes
pause > nul
exit /b

:failed
cls
color 4f
echo COMMAND EXECUTION ERROR (ERROR %ERRORLEVEL%)
pause > nul
color
exit /b