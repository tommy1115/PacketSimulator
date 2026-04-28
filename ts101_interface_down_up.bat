@echo off

REM Usage: ts_network_down_up.bat [Interface Name] [Interface IP]
REM    ex: ts_network_down_up.bat 乙太網路 192.168.99.100
REM git Should be included in the PATH
REM Define Error Output Color
set "RED=4"
REM Define Dirty Output Color
set "Green=2"
REM Reset color to default (optional)
set "errorlevel=0"
color %GREEN%
color

REM %1 : Interface Name or identify
chcp 65001 > nul

@ECHO OFF

:MAIN
set e1_ipaddress=%2

:x
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "T_DATETIME=%%I"
set "T_DATETIME=%T_DATETIME:~0,14%"
echo T_DATETIME=%T_DATETIME%

call interface.bat %1 disable Disabled
timeout /t 3
call interface.bat %1 enable Enabled %e1_ipaddress%
timeout /t 3

:done
if not %errorlevel% equ 0 (
	REM Change text color to red
	color %RED%
	REM　exit /b %errorlevel%
)

REM　exit /b %errorlevel%
goto x
