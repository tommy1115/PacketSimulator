@echo off

REM TODO: close firewall and sleep

REM Usage: ts004_packet_simulator_onelink.bat [E1 Address]   [E2 Address]   [Target] [Version] [Target Name]
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200 GTNet    0.10.0    GTBoosterLauncher
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200 AIFlow   1.1.5.0   GameTurbo
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
set duration=%6
set interval=%7
set round=0
set cpu_min=10
set cpu_max=0
set ram_min=0
set ram_max=0
set file_path=new_file.txt
set "csvfile=%~dp0rep\log\out.csv"

echo "Test","Target","Version","Round","CPU_min","CPU_max","RAM_min(KB)","RAM_max(KB)","Timestamp","Duration","SCRIPT_FILENAME","APPL_SCRIPT_NAME","Protocol","E1_ADDR","E2_ADDR","CONSECUTIVE_LOST","CPU_UTIL_E1","CPU_UTIL_E2","DELAY_FACTOR","DELAY_VARIATION","END_TO_END_DELAY","JITTER_AVG","JITTER_MIN","JITTER_MAX","MEDIA_LOSS_RATE","MOS_ESTIMATE_AVG","MOS_ESTIMATE_MIN","MOS_ESTIMATE_MAX","ONE_WAY_DELAY_AVG","ONE_WAY_DELAY_MIN","ONE_WAY_DELAY_MAX","R_VALUE_AVG","R_VALUE_MIN","R_VALUE_MAX","REL_PRECISION","RESP_TIME_AVG","RESP_TIME_MIN","RESP_TIME_MAX","RSSI_E1_AVG","RSSI_E1_MIN","RSSI_E1_MAX","RSSI_E2_AVG","RSSI_E2_MIN","RSSI_E2_MAX","THROUGHPUT_AVG","THROUGHPUT_MIN","THROUGHPUT_MAX","TRANS_RATE_AVG","TRANS_RATE_MIN","TRANS_RATE_MAX" >> %csvfile%

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
REM TODO(REQ): 紀錄 CPU, RAM 在執行前中後(執行中要定期取值並取得最大值)

    REM ===== 執行前 =====
    echo "正在進行執行前取樣 3 秒...""
    for /L %%i in (1,1,3) do (
        set "cpu_int=0"
        set "ram_mb=0"

        for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
            set "cpu_int=%%d"
        )
        if "!cpu_int!" GTR "!cpu_max_before!" set "cpu_max_before=!cpu_int!"

        for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
            set "ram_mb=%%e"
        )
        if "!ram_mb!" GTR "!ram_max_before!" set "ram_max_before=!ram_mb!"

        REM 注意：echo 內容不要包含括號，避免 Batch 語法解析錯誤
        echo "迴圈 %%i : CPU !cpu_int!%% [Max !cpu_max_before!%%], RAM !ram_mb!MB [Max !ram_max_before!MB]"
        
        timeout /t 1 >nul
    )

for /f %%b in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
    set idx=1
    for /r %%i in (*.scr) do (
        set "scripts[!idx!]=%%i"
        set /a idx+=1
    )
    set script_total=!idx!
    @REM echo !script_total!

    set case[1].script=HTTPtext
    set case[1].protocol=TCP
    set case[1].duration=!duration!
    set case[2].script=all
    set case[2].protocol=TCP,UDP,RTP
    set case[2].duration=60
    set case_total=2

    @REM echo !case[1].script!, !case[1].protocol!, !case[1].duration!, !case[2].script!, !case[2].protocol!, !case[2].duration!
    @REM timeout /t 10000
    @REM @REM for /f "tokens=2 delims=[]" %%i in ('set case[') do (
    @REM @REM     set /a case_total+=1
    @REM @REM )
    @REM echo !case_total!

    for /l %%i in (1,1,!case_total!) do (
        set "SCRIPT_PATH=!case[%%i].script!"
        set "PROTOCOLS=!case[%%i].protocol!"
        set "DURATION=!case[%%i].duration!"
        @REM echo !SCRIPT_PATH!, !PROTOCOLS!, !DURATION!

        for /l %%j in (1,1,!script_total!) do (
            for %%s in (!scripts[%%j]!) do (
                set "RUN=0"
                if /i "!SCRIPT_PATH!"=="all" (
                    set "RUN=1"
                ) else (
                    REM %%s 完整路徑 (C:\builds\work\PacketSimulator\ixchariot\HTTPtext.scr)
                    REM %%~ns 僅檔名 (HTTPtext)
                    REM %%~xs 僅副檔名 (.scr)
                    REM %%~nxs 檔名加副檔名 (HTTPtext.scr)
                    if /i "%%~ns"=="!SCRIPT_PATH!" (
                        set "RUN=1"
                    )
                )

                if "!RUN!"=="1" (
                    for %%p in (!PROTOCOLS!) do (
                        for /f %%t in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
                            REM start /b 啟動應用程式而不開啟新的 命令提示字元 視窗
                            start "" /b tclsh TS004_OneLink_OnePair.tcl %~1 %~2 %%s %%p !DURATION! "%%t" 2>> nul

                            REM ===== Duration=====
                            set /a loops=DURATION/interval
                            echo !loops!

                            for /L %%k in (1,1,!loops!) do (
                                set "cpu_int=0"
                                set "ram_mb=0"

                                REM ---- CPU ----
                                for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
                                    set "cpu_int=%%d"
                                )
                                if "!cpu_int!" GTR "!cpu_max_during!" set "cpu_max_during=!cpu_int!"

                                REM ---- RAM ----
                                for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
                                    set "ram_mb=%%e"
                                )
                                if "!ram_mb!" GTR "!ram_max_during!" set "ram_max_during=!ram_mb!"

                                echo "執行中第 %%k 次 : CPU !cpu_int!%% [Max:!cpu_max_during!%%], RAM !ram_mb!MB [Max:!ram_max_during!MB]"

                                REM ---- every 10 sec ----
                                timeout /t !interval! >nul
                            )

                            REM ===== 執行後 =====
                            echo "正在進行執行後取樣 (3秒)..."
                            for /L %%k in (1,1,3) do (
                                set "cpu_int=0"
                                set "ram_mb=0"

                                REM ---- CPU ----
                                for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
                                    set "cpu_int=%%d"
                                )
                                if "!cpu_int!" GTR "!cpu_max_after!" set "cpu_max_after=!cpu_int!"

                                REM ---- RAM  ----
                                for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
                                    set "ram_mb=%%e"
                                )
                                if "!ram_mb!" GTR "!ram_max_after!" set "ram_max_after=!ram_mb!"

                                echo "執行後第 %%k 次 : CPU !cpu_int!%% [Max:!cpu_max_after!%%], RAM !ram_mb!MB [Max:!ram_max_after!MB]"
                                timeout /t 1 >nul
                            )

                            REM ===== 寫入 CSV =====
                            echo "%0","%target%","%target_version%","!round!", ^
                            "!cpu_max_before!","!cpu_max_during!","!cpu_max_after!", ^
                            "!ram_max_before!","!ram_max_during!","!ram_max_after!" >> %csvfile%

                            echo ## !T_DATETIME!, %%p, %%s --------------------------------------
                            timeout /t 10
                        )
                    )
                )
            )
        )
    )
    timeout /t 10000

)
goto x

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
