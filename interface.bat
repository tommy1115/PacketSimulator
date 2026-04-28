@echo on

REM Usage: interface.bat [Interface Name] [action] [state] [Interface IP]
REM    ex: interface.bat 乙太網路 "disable" "Disabled"
REM    ex: interface.bat 乙太網路 "enable" "Enabled" 192.168.99.100
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

call:interface "%1" "%2" "%3" "%4"

:done
if not %errorlevel% equ 0 (
	REM Change text color to red
	color %RED%
	exit /b %errorlevel%
)

exit /b %errorlevel%

:interface
    SETLOCAL ENABLEDELAYEDEXPANSION
        SET interface_name=%~1
        SET interface_action=%~2
		SET interface_state=%~3
		SET interface_ip=%~4
        
		echo ==========[%interface_name%] %interface_action%, %interface_state%, %interface_ip%==========
		set isUP=0
		for /f "tokens=4*" %%i in ('netsh interface show interface') do (
			if %%i equ %interface_name% (
				set isUP=1
			)
		)
		if %isUP% equ 1 (
			echo netsh interface set interface name=%interface_name% admin=%interface_action%
			@REM netsh interface set interface name=%interface_name% admin=%interface_action%
			powershell -Command "Start-Process cmd.exe -ArgumentList '/c netsh interface set interface name=%interface_name% admin=%interface_action%' -Verb RunAs"
			for /l %%A in (1,1,3) do (
				for /f "tokens=1,3*" %%i in ('netsh interface show interface') do (
					if "%%k" equ "%interface_name%" (
						if "%%i" equ "%interface_state%" (
							REM [%interface_name%] Interface found and %interface_state%, %%i
							if "%interface_state%" equ "Enabled" (
								for /l %%B in (1,1,5) do (
									REM netsh interface ip show addresses "%interface_name%"
									for /f "tokens=3 delims= " %%l in ('netsh interface ip show addresses "%interface_name%" ^| findstr "IP Address"') do (
										if "%%l" equ "%interface_ip%" (
											echo [%interface_name%] %interface_state%, %%l
											echo "Do Enabled Tasks ..."
											
											EXIT /B 0
										)
									)
									timeout /t 1
								)
							) else (
								echo [%interface_name%] %interface_state%
								EXIT /B 0
							)
						)
					)
				)
				timeout /t 3
			)
			color %RED%
			echo [%interface_name%] Failed to NOT %interface_state%
		) else (
			color %RED%
			echo [%interface_name%] Failed to find
		)
    ENDLOCAL
EXIT /B 0