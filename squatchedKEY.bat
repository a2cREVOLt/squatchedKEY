��
@echo off
title squatch paid
mode 75, 30
chcp 65001 >nul
call powershell exit >nul
color 3




:key
echo enter your paid key
echo if you dont have one join my revolt server https://rvlt.gg/5P1CGyhr to get a key
set /p key="->"


if /i %key% == 102931 goto menu 
if /i %key% == else goto wrong


:wrong 
echo no key found  
















:menu
set ip=""
echo.
echo.
echo       PUBLIC IP
echo       ---------
echo     1) Geolocate
echo     2) Trace DNS
echo     3) Port Scan
echo     4) DDOS
echo.
echo        LOCAL IP
echo       ----------
echo     5) Trace Mac Address
echo     6) Port Scan
echo     7) ARP Spoof (DOS)
echo     8) RPC Dump 
echo.
echo.
echo.
echo.
echo.
echo.
:banner1
echo	███████  ██████  ██    ██  █████  ████████  ██████ ██   ██ 
echo	██      ██    ██ ██    ██ ██   ██    ██    ██      ██   ██ 
echo	███████ ██    ██ ██    ██ ███████    ██    ██      ███████ 
echo	     ██ ██ ▄▄ ██ ██    ██ ██   ██    ██    ██      ██   ██ 
echo	███████  ██████   ██████  ██   ██    ██     ██████ ██   ██ 
echo	            ▀▀                                             
echo ————————————————————————————————————————————————————————————————
set /p input=
if /I "%input%" EQU "1" goto geolocate
if /I "%input%" EQU "2" goto tracedns
if /I "%input%" EQU "3" goto portscan
if /I "%input%" EQU "4" goto ddos
if /I "%input%" EQU "5" goto Macaddr
if /I "%input%" EQU "6" goto portscan
if /I "%input%" EQU "7" goto arpspoof
if /I "%input%" EQU "8" goto rpcdump
if /I "%input%" EQU "9" goto banner
:rpcdump
cls
echo.
set /p ip=Enter IP Address: 
rpcdump %ip%
echo.
pause
cls
goto menu

:Macaddr
cls
echo.
set /p ip=Enter IP Address: 
ping -w 1 %ip% >nul
for /f "tokens=2 delims= " %%a in ('arp -a ^| find "%ip%"') do set macaddr=%%a
for /f "usebackq delims=" %%I in (`powershell "\"%macaddr%\".toUpper()"`) do set "upper=%%~I"
cls
echo.
echo Mac Address: %upper%
echo.
pause
cls
goto menu

:arpspoof
cls
echo.
set errorlevel=0
set /p ip=Enter IP Address: 
start cmd /c "mode 87, 10 && title Spoofing %ip%... && echo. && arpspoof.exe %ip%"
goto menu

:ddos
cls
echo.
echo 1) https://freestresser.so/
echo 2) https://hardstresser.com/
echo 3) https://stresser.net/
echo 4) https://str3ssed.co/
echo 5) https://projectdeltastress.com/
echo 6) Back
echo.
set /p ddosinput=
if /I "%ddosinput%" EQU "1" start https://freestresser.so/
if /I "%ddosinput%" EQU "2" start https://hardstresser.com/
if /I "%ddosinput%" EQU "3" start https://stresser.net/
if /I "%ddosinput%" EQU "4" start https://str3ssed.co/
if /I "%ddosinput%" EQU "5" start https://projectdeltastress.com/
if /I "%ddosinput%" EQU "6" goto menu
goto menu

:portscan
cls
set errorlevel=0
echo.
set /p ip=IP Address: 
set /p ports=Ports (e.g. 21,22,23): 
start cmd /c "mode 40, 15 && title Scanning Ports... && PortScanner.exe hosts=%ip% ports=%ports%>>portscan.txt"
ping localhost -n 5 >nul
taskkill /im PortScanner.exe /f >nul 2>&1
echo.
type portscan.txt
echo.
ping localhost -n 1 >nul
del portscan.txt
pause
goto menu

:tracedns
cls
echo.
set /p ip=IP Address: 
cls
for /f "tokens=2 delims= " %%a in ('nslookup %ip% ^| find "Name"') do set dns=%%a
echo.
echo Domain Name: %dns%
echo.
pause
goto menu

:geolocate
cls
echo.
set /p ip=IP Address: 
cls
setlocal ENABLEDELAYEDEXPANSION
set webclient=webclient
if exist "%temp%\%webclient%.vbs" del "%temp%\%webclient%.vbs" /f /q /s >nul
if exist "%temp%\response.txt" del "%temp%\response.txt" /f /q /s >nul
:iplookup
echo sUrl = "http://ipinfo.io/%ip%/json" > %temp%\%webclient%.vbs
:localip
cls
echo set oHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0") >> %temp%\%webclient%.vbs
echo oHTTP.open "GET", sUrl,false >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Length", Len(sRequest) >> %temp%\%webclient%.vbs
echo oHTTP.send sRequest >> %temp%\%webclient%.vbs
echo HTTPGET = oHTTP.responseText >> %temp%\%webclient%.vbs
echo strDirectory = "%temp%\response.txt" >> %temp%\%webclient%.vbs
echo set objFSO = CreateObject("Scripting.FileSystemObject") >> %temp%\%webclient%.vbs
echo set objFile = objFSO.CreateTextFile(strDirectory) >> %temp%\%webclient%.vbs
echo objFile.Write(HTTPGET) >> %temp%\%webclient%.vbs
echo objFile.Close >> %temp%\%webclient%.vbs
echo Wscript.Quit >> %temp%\%webclient%.vbs
start %temp%\%webclient%.vbs
set /a requests=0
:checkresponseexists
set /a requests=%requests% + 1
if %requests% gtr 7 goto failed
IF EXIST "%temp%\response.txt" (
goto response_exist
) ELSE (
ping 127.0.0.1 -n 2 -w 1000 >nul
goto checkresponseexists
)
:failed
taskkill /f /im wscript.exe >nul
del "%temp%\%webclient%.vbs" /f /q /s >nul
echo.
echo Did not receive a response from the API.
echo.
pause
goto menu
:response_exist
cls
echo.
for /f "delims=     " %%i in ('findstr /i "," %temp%\response.txt') do (
    set data=%%i
    set data=!data:,=!
    set data=!data:""=Not Listed!
    set data=!data:"=!
    set data=!data:ip:=IP:      !
    set data=!data:hostname:=Hostname:  !
    set data=!data:org:=ISP:        !
    set data=!data:city:=City:      !
    set data=!data:region:=State:   !
    set data=!data:country:=Country:    !
    set data=!data:postal:=Postal:  !
    set data=!data:loc:=Location:   !
    set data=!data:timezone:=Timezone:  !
    echo !data!
)
echo.
del "%temp%\%webclient%.vbs" /f /q /s >nul
del "%temp%\response.txt" /f /q /s >nul
if '%ip%'=='' goto menu
pause
goto menu







:banner
cls
echo	             ~PP~        
echo	           .P##00P.      
echo	        .0PG0#GP#P.      
echo	       .G000###00:       
echo	      7B0000###00G:      
echo	     000#000##000@B07.   
echo	    00#00@0##000@0000BJ0:
echo	:::J00#@@0#####0J:^JY#0G0
echo	BPB0BJ^&0#######J:   ::7J
echo	:700: .0B#000#000#Y.     
echo	        ~0@@@@000005.    
echo	       ~##00@0000000:    
echo	      0##00G7  700#0.    
echo	   .0000000.   .00#00~.  
echo	  .P00#00GP.   :000000GP:
echo	  .~~1PPPGP.   .PGPPPPGP:
pause 
goto Geolocate