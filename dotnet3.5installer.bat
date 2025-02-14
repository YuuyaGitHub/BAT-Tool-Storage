@echo off
cls
title .NET Framework 3.5 Installer
echo Welcome to .NET Fremework 3.5 Installer!
echo.
echo This tool is intended for cases where .NET Framework 3.5 cannot be enabled from "Turn Windows features on or off" (an error occurs, there is no network connection, etc).
echo.
echo This tool requires Windows installation media (USB/DVD).
echo If you have not created one, create one using the Media Creation Tool and then run the tool again.
echo.
pause
cls
goto selectlocation

:selectlocation
cls
echo Select installation media location
echo First of all, you need to specify the location of the installation media.
echo.
echo Example: D:\ = D
echo.
SET DRIVE_LETTER=
SET /P DRIVE_LETTER="Please enter the drive for your installation media: "

:driveconfirm
cls
echo The selected drive is %DRIVE_LETTER%.
set /p anser="Are you sure about this (Y/N)? "

if /i %anser%==y (
	
	goto installation
) else if /i %anser%==n (
	goto selectlocation
) else (
	echo Choice is invalid. Must be ^(Y/N^).
	pause > nul
	goto driveconfirm
)

:installation
cls
echo Everything is ready. Now let's start the installation.
echo.
pause
echo.
echo =====
dism /online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:%DRIVE_LETTER%:\sources\sxs
echo =====
echo Operation completed.
echo.
pause
goto finish

:finish
cls
echo All done!
echo Applications that depend on .NET Framework 3.5 will now start.
echo.
pause
exit /b

rem This tool installs .NET Framework 3.5.
rem This tool is intended for offline use.
rem This tool requires Windows installation media to install .NET Framework 3.5