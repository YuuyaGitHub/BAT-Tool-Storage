@echo off
title Windows Update Reset Tool
cls
echo.
echo.
echo.
echo    ==============================================
echo.
echo             WINDOWS UPDATE RESET TOOL
echo.
echo    ==============================================
echo.
echo Welcome to the Windows Update Reset Tool!
echo This tool will repair broken/corrupted/non-functioning Windows Updates.
echo.
echo This process can take several minutes to several hours.
echo Please connect the power supply and never turn off the power until it is completed.
echo. 
set /p YORN="Would you like to start the Windows Update Reset process (Y/N)? "
if not '%YORN%'=='y' (
    echo "Stop processing."
    GOTO END
)

cls
FOR /F "tokens=*" %%A IN ('WMIC OS Get ServicePackMajorVersion^,BuildNumber^,Caption /Value ^| find "="') DO (SET OS.%%A)

cls
rem Stop Service
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc

cls
echo %OS.Caption%|find "Windows 10">NUL
if %ERRORLEVEL% equ 0 (
    net stop usosvc
)

cls
del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr0.dat"
del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr1.dat"

cls
echo.
echo ===================Advanced Mode===========================
echo Skip (N) is recommended for the first time.
echo If there is no effect after skipping, please execute (Y).
echo ===========================================================
echo.
set /p YORN2="Run in Advanced mode (Y/N)? "
cls
if '%YORN2%'=='y' (
    Ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
    Ren %systemroot%\system32\catroot2 catroot2.old
    sc.exe sdset bits "D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"
    sc.exe sdset wuauserv "D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"
)

cls
cd /d %windir%\system32
regsvr32.exe atl.dll /s
regsvr32.exe urlmon.dll /s
regsvr32.exe mshtml.dll /s
regsvr32.exe shdocvw.dll /s
regsvr32.exe browseui.dll /s
regsvr32.exe jscript.dll /s
regsvr32.exe vbscript.dll /s
regsvr32.exe scrrun.dll /s
regsvr32.exe msxml.dll /s
regsvr32.exe msxml3.dll /s
regsvr32.exe msxml6.dll /s
regsvr32.exe actxprxy.dll /s
regsvr32.exe softpub.dll /s
regsvr32.exe wintrust.dll /s
regsvr32.exe dssenh.dll /s
regsvr32.exe rsaenh.dll /s
regsvr32.exe gpkcsp.dll /s
regsvr32.exe sccbase.dll /s
regsvr32.exe slbcsp.dll /s
regsvr32.exe cryptdlg.dll /s
regsvr32.exe oleaut32.dll /s
regsvr32.exe ole32.dll /s
regsvr32.exe shell32.dll /s
regsvr32.exe initpki.dll /s
regsvr32.exe wuapi.dll /s
regsvr32.exe wuaueng.dll /s
regsvr32.exe wuaueng1.dll /s
regsvr32.exe wucltui.dll /s
regsvr32.exe wups.dll /s
regsvr32.exe wups2.dll /s
regsvr32.exe wuweb.dll /s
regsvr32.exe qmgr.dll /s
regsvr32.exe qmgrprxy.dll /s
regsvr32.exe wucltux.dll /s
regsvr32.exe muweb.dll /s
regsvr32.exe wuwebv.dll /s

cls
netsh winsock reset
netsh winhttp reset proxy

cls
net start bits
net start wuauserv
net start appidsvc
net start cryptsvc

cls
echo %OS.Caption%|find "Windows 10">NUL
if %ERRORLEVEL% equ 0 (
    net start usosvc
)

cls
echo %OS.Caption%|find "Windows Vista">NUL
if %ERRORLEVEL% equ 0 (
    bitsadmin.exe /reset /allusers
)

cls
echo.
echo CONGRATULATIONS!!! Processing is complete.
echo A reboot is required for the changes to take effect.
set /p reboot="Reboot Now(Y/N)? "
if /i {%reboot}=={y} (shutdown -r -t 0)

cls
pause
exit /b

:END
cls
exit /b