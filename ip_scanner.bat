::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBxGVReYAE+/Fb4I5/jHwe+Q4ksSWOY6arPJz7qxKfAs+Uble5goxDRfgM5s
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
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

:: Ask if the user wants to restart
set /p Restart=Do you want to restart the IP Scanner? (Y/N): 
if /i "%Restart%"=="Y" goto Start
if /i "%Restart%"=="N" exit

:: If the input is not Y or N, prompt again
echo Invalid input. Please enter Y or N.
goto Start
)
echo Scan complete. Results saved to %SaveFile%.
