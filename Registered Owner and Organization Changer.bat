@echo off
title Registered Owner and Organization Changer
net session >nul 2>&1 || (
    echo This script must be run with administrator privileges.
    goto :eof
)

setlocal EnableDelayedExpansion
set "_key=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

if "%~1"=="" goto :help

:parse
if "%~1"=="" goto :validate

if /I "%~1"=="-name" (
    shift
    if "%~1"=="" goto :help
    call set "OWNER=%%~1"
) else if /I "%%~1"=="-organization" (
    shift
    if "%~1"=="" goto :help
    call set "ORG=%%~1"
) else if /I "%~1"=="-company" (
    shift
    if "%~1"=="" goto :help
    call set "ORG=%%~1"
) else (
    goto :help
)
shift
goto :parse

:validate
if defined OWNER (
    reg add "%_key%" /v RegisteredOwner /t REG_SZ /d "%OWNER%" /f
    goto :eof
)

if defined ORG (
    reg add "%_key%" /v RegisteredOrganization /t REG_SZ /d "%ORG%" /f
    goto :eof
)

:help
echo Registered Owner and Organization Changer
echo Copyright (C) 2020-2025 Yuuya
echo Version 1.0
echo. 
echo   %~nx0 [-name UserName] [-organization OrgName][-company OrgName]
echo.
echo    name UserName        - Change the username.
echo    organization OrgName
echo    company OrgName      - Change the organization name.
echo.
echo    Both company and organization are the same options.
echo.
echo.
echo  Example:
echo   %~nx0 -name "Your Name"
echo   %~nx0 -organization "Sample Company"
echo   %~nx0 -name "Windows" -organization "Microsoft"
echo.
exit /b 1
