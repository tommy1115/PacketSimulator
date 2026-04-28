@echo off

REM TODO: close firewall and sleep

REM Usage: ts004_packet_simulator_onelink.bat [E1 Address]   [E2 Address]   [Target] [Version] [Target Name]
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.50 100.100.100.100
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.50 100.100.100.100 GTNet    0.10.0    GTBoosterLauncher
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.50 100.100.100.100 AIFlow   1.1.5.0   GameTurbo
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

cd ixchariot

setlocal enabledelayedexpansion

set target=%3
set target_version=%4
set target_name=%5
set round=0
set file_path=new_file.txt
set csvfile=out.csv
echo "Target","Version","Round","CPU_before","CPU_during","CPU_after","RAM_before","RAM_during","RAM_after" >> %csvfile%
@REM echo "Test","Target","Version","Round","CPU_min","CPU_max","RAM_min(B)","RAM_max(B)","Timestamp","Duration","SCRIPT_FILENAME","APPL_SCRIPT_NAME","Protocol","E1_ADDR","E2_ADDR","CONSECUTIVE_LOST","CPU_UTIL_E1","CPU_UTIL_E2","DELAY_FACTOR","DELAY_VARIATION","END_TO_END_DELAY","JITTER_AVG","JITTER_MIN","JITTER_MAX","MEDIA_LOSS_RATE","MOS_ESTIMATE_AVG","MOS_ESTIMATE_MIN","MOS_ESTIMATE_MAX","ONE_WAY_DELAY_AVG","ONE_WAY_DELAY_MIN","ONE_WAY_DELAY_MAX","R_VALUE_AVG","R_VALUE_MIN","R_VALUE_MAX","REL_PRECISION","RESP_TIME_AVG","RESP_TIME_MIN","RESP_TIME_MAX","RSSI_E1_AVG","RSSI_E1_MIN","RSSI_E1_MAX","RSSI_E2_AVG","RSSI_E2_MIN","RSSI_E2_MAX","THROUGHPUT_AVG","THROUGHPUT_MIN","THROUGHPUT_MAX","TRANS_RATE_AVG","TRANS_RATE_MIN","TRANS_RATE_MAX" >> %csvfile%

REM Modify down below

:x
set cpu_max_before=0
set cpu_max_during=0
set cpu_max_after=0

set ram_max_before=0
set ram_max_during=0
set ram_max_after=0

set /a round=%round%+1
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "T_DATETIME=%%I"
set "StartTime=%T_DATETIME:~0,14%"
echo Packet_Simulator_Start_Time=%StartTime%

REM TODO(REQ): script and protocol change to array[]
REM TODO(REQ): 紀錄 CPU, RAM 在執行前中後(執行中要定期取值並取得最大值) (還沒測試)

    REM ===== 執行前（取樣 5 秒）=====
    for /L %%i in (1,1,5) do (

        for /f "skip=2 tokens=2 delims=," %%d in ('typeperf "\Process(!target_name!)\%% Processor Time" -sc 1') do (
            set "cpu=%%d"
            set "cpu=!cpu:~1,8!"
            for /f "tokens=1 delims=." %%x in ("!cpu!") do set cpu_int=%%x
        )
        if !cpu_int! gtr !cpu_max_before! set cpu_max_before=!cpu_int!

        for /f "skip=2 tokens=2 delims=," %%e in ('typeperf "\Process(!target_name!)\Working Set - Private" -sc 1') do (
            set "ram_raw=%%e"
            set "ram_raw=!ram_raw:~1!"
        )
        set /a ram_mb=!ram_raw!/1024/1024

        if !ram_mb! gtr !ram_max_before! set ram_max_before=!ram_mb!

        timeout /t 1 >nul
    )

REM HTTPtext script
for /f %%b in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
    echo #############################################################################
    set "T_DATETIME=%%b"
    SET T_DATETIME=!T_DATETIME:~0,14%!
    set "HTTP_SCR_PATH=%CD%\Ixia\IxChariot\Scripts\Internet\HTTPtext.scr"

    set duration=3600
    set interval=10
    set /a loops=duration/interval
    

    start "" /b tclsh TS004_OneLink_OnePair.tcl %1 %2 "!HTTP_SCR_PATH!" TCP !duration! "!T_DATETIME!" 2>> nul
    
    REM 1. processor time 2. private working set

    REM ===== 執行中（每十秒抓一次）=====
    for /L %%i in (1,1,!loops!) do (

        REM ---- CPU ----
        for /f "skip=2 tokens=2 delims=," %%d in ('typeperf "\Process(!target_name!)\%% Processor Time" -sc 1') do (
            set "cpu=%%d"
            set "cpu=!cpu:~1,8!"
            for /f "tokens=1 delims=." %%x in ("!cpu!") do set cpu_int=%%x
        )
        if !cpu_int! gtr !cpu_max_during! set cpu_max_during=!cpu_int!

        REM ---- RAM ----
        for /f "skip=2 tokens=2 delims=," %%e in ('typeperf "\Process(!target_name!)\Working Set - Private" -sc 1') do (
            set "ram_raw=%%e"
            set "ram_raw=!ram_raw:~1!"
        )
        set /a ram_mb=!ram_raw!/1024/1024

        if !ram_mb! gtr !ram_max_during! set ram_max_during=!ram_mb!

        REM ---- 每10秒抓一次 ----
        timeout /t !interval! >nul
    )

    REM ===== 執行後 =====
    for /L %%i in (1,1,5) do (

        for /f "skip=2 tokens=2 delims=," %%d in ('typeperf "\Process(!target_name!)\%% Processor Time" -sc 1') do (
            set "cpu=%%d"
            set "cpu=!cpu:~1,8!"
            for /f "tokens=1 delims=." %%x in ("!cpu!") do set cpu_int=%%x
        )
        if !cpu_int! gtr !cpu_max_after! set cpu_max_after=!cpu_int!

        for /f "skip=2 tokens=2 delims=," %%e in ('typeperf "\Process(!target_name!)\Working Set - Private" -sc 1') do (
            set "ram_raw=%%e"
            set "ram_raw=!ram_raw:~1!"
        )
        set /a ram_mb=!ram_raw!/1024/1024

        if !ram_mb! gtr !ram_max_after! set ram_max_after=!ram_mb!

        timeout /t 1 >nul
    )

    REM ===== 寫入 CSV =====
    echo "%0","%target%","%target_version%","!round!", ^
    "!cpu_max_before!","!cpu_max_during!","!cpu_max_after!", ^
    "!ram_max_before!","!ram_max_during!","!ram_max_after!" >> %csvfile%
    
    echo ## !T_DATETIME!, TCP, "!HTTP_SCR_PATH!" --------------------------------------
    timeout /t 10
)
goto x

REM All scripts
for /r %%i in (*.scr) do (

    for %%a in (TCP UDP RTP) do (

        for /f %%b in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
            echo #############################################################################
            set "T_DATETIME=%%b"
            SET T_DATETIME=!T_DATETIME:~0,14%!

            tclsh TS004_OneLink_OnePair.tcl %1 %2 %%i %%a 60 "!T_DATETIME!" 2>> nul

            REM 1. processor time 2. private working set

            set cnt=0
            for /f "skip=2 tokens=2 delims=," %%d in ('typeperf "\Process(!target_name!)\%% Processor Time" -sc 0') do (
                set /a cnt+=1
                if !cnt! equ 1 (
                    set "cpu_min=%%d"
                    set "cpu_min=!cpu_min:~1,8%!"
                    echo !cpu_min!
                )
            )

            set cnt=0
            for /f "skip=2 tokens=2 delims=," %%e in ('typeperf "\Process(!target_name!)\Working Set - Private" -sc 0') do (
                set /a cnt+=1
                if !cnt! equ 1 (
                    set "ram_min=%%e"
                    set "ram_min=!ram_min:~1,8%!"
                    echo !ram_min!
                )
            )
            
            for /f "delims=" %%c in (!file_path!) do (
                echo "%0","%target%","%target_version%","!round!","!cpu_min!","!cpu_max!","!ram_min!","!ram_max!",%%c >> %csvfile%
            )
            
            del !file_path!
            echo ## !T_DATETIME!, %%a, %%i --------------------------------------
            timeout /t 1
        )

    )

)

SET T_DATETIME=

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "T_DATETIME=%%I"
set "EndTime=%T_DATETIME:~0,14%"
echo Packet_Simulator_Start_Time=%StartTime%, Packet_Simulator_End_Time=%EndTime%

goto x

endlocal 

cd ..
