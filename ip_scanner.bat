
@echo off
SET SaveFile="ip_scan_results.txt"
del %SaveFile% 2>nul
echo.
    python ascii_art.py
echo.
set /p IPRange=Enter the first three octets of the network (e.g., 192.168.1): 
set /p Start=Enter the starting last octet (1-254): 
set /p End=Enter the ending last octet (1-254): 
REM 
(
    echo Scan Date: %date% %time%
    echo Scanning IPs from %IPRange%.%Start% to %IPRange%.%End%...
    echo ============================
) > %SaveFile%
FOR /L %%i IN (%Start%,1,%End%) DO (
    echo Pinging %IPRange%.%%i... >> %SaveFile%
    ping -n 1 %IPRange%.%%i >> %SaveFile%
    REM 
    for /f "tokens=1" %%j in ('ping -a %IPRange%.%%i ^| find "Pinging"') do (
        echo Hostname: %%j >> %SaveFile%
    )
    REM 
    for /f "tokens=2" %%j in ('arp -a %IPRange%.%%i ^| find /i "%IPRange%.%%i"') do (
        echo MAC Address: %%j >> %SaveFile%
    )
    REM 
    echo Open Ports: >> %SaveFile%
    netstat -an | findstr /i "LISTENING" >> %SaveFile%
    REM 
    echo Network Interface Information: >> %SaveFile%
    ipconfig >> %SaveFile%
    REM 
    echo Traceroute to %IPRange%.%%i: >> %SaveFile%
    tracert %IPRange%.%%i >> %SaveFile%
    echo. >> %SaveFile%
    echo Results saved to %SaveFile%.
)
echo Scan complete. Results saved to %SaveFile%.
