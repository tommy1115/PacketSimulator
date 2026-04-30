@echo off

REM TODO: close firewall and sleep

REM Usage: ts004_packet_simulator_onelink.bat [E1 Address]   [E2 Address]   [Target:Version] [Target Name]         [Duration] [Interval] [Total group] [pairs per group]
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200 "GTNet:0.10.0"   "GTBoosterLauncher"
REM    ex: ts004_packet_simulator_onelink.bat 192.168.99.100 192.168.99.200 "AIFlow:1.1.5.0" "GameTurbo"           3600       10         10            16
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

set ip1=%1
set ip2=%2
set raw_target=%3
set target_name=%4
set duration=%5
set interval=%6
set total_group=%7
set pairs_per_group=%8
set round=0
set cpu_min=10
set cpu_max=0
set ram_min=0
set ram_max=0
set file_path=new_file.txt
set "csvfile=%~dp0rep\log\out.csv"

REM 確保 new_file.txt, out.csv 不存在
if exist "!file_path!" del /f /q "!file_path!" >nul 2>&1
if exist "!csvfile!" del /f /q "!csvfile!" >nul 2>&1

@REM echo "Test","Target","Version","Round","CPU_min","CPU_max","RAM_min(KB)","RAM_max(KB)","Timestamp","Duration","SCRIPT_FILENAME","APPL_SCRIPT_NAME","Protocol","E1_ADDR","E2_ADDR","CONSECUTIVE_LOST","CPU_UTIL_E1","CPU_UTIL_E2","DELAY_FACTOR","DELAY_VARIATION","END_TO_END_DELAY","JITTER_AVG","JITTER_MIN","JITTER_MAX","MEDIA_LOSS_RATE","MOS_ESTIMATE_AVG","MOS_ESTIMATE_MIN","MOS_ESTIMATE_MAX","ONE_WAY_DELAY_AVG","ONE_WAY_DELAY_MIN","ONE_WAY_DELAY_MAX","R_VALUE_AVG","R_VALUE_MIN","R_VALUE_MAX","REL_PRECISION","RESP_TIME_AVG","RESP_TIME_MIN","RESP_TIME_MAX","RSSI_E1_AVG","RSSI_E1_MIN","RSSI_E1_MAX","RSSI_E2_AVG","RSSI_E2_MIN","RSSI_E2_MAX","THROUGHPUT_AVG","THROUGHPUT_MIN","THROUGHPUT_MAX","TRANS_RATE_AVG","TRANS_RATE_MIN","TRANS_RATE_MAX" >> %csvfile%
echo "Test","Target","Version","Round","CPU_before","CPU_during","CPU_after","RAM_before(MB)","RAM_during(MB)","RAM_after(MB)","Timestamp","Duration","SCRIPT_FILENAME","Protocol","E1_ADDR","E2_ADDR" >> %csvfile%

REM Modify down below

REM modify e1, e2 to new_e1, new_e2
for /f "tokens=1-4 delims=." %%a in ("%ip1%") do (
    set e1_prefix=%%a.%%b.%%c
    set /a e1_last=%%d
)
for /f "tokens=1-4 delims=." %%a in ("%ip2%") do (
    set e2_prefix=%%a.%%b.%%c
    set /a e2_last=%%d
)
set "e1=!ip1!"
set "e2=!ip2!"
set new_e1=
set new_e2=
set /a stop_idx=%total_group% - 1
for /l %%i in (0,1,%stop_idx%) do (
    set /a current_e1_last=%e1_last% + %%i
    set /a current_e2_last=%e2_last% + %%i

    if "%%i"=="0" (
        set "new_e1=!e1_prefix!.!current_e1_last!"
        set "new_e2=!e2_prefix!.!current_e2_last!"
    ) else (
        set "new_e1=!new_e1! !e1_prefix!.!current_e1_last!"
        set "new_e2=!new_e2! !e2_prefix!.!current_e2_last!"
    )
)

REM Get Target and Version
for /f "tokens=1* delims=:" %%a in (!raw_target!) do (
    set "target=%%a"
    set "target_version=%%b"
)

REM 紀錄所有 .scr
set idx=1
for /r %%i in (*.scr) do (
    set "scripts[!idx!]=%%i"
    set /a idx+=1
)
set script_total=!idx!

REM TODO(REQ): script and protocol change to array[]
set case[1].script=HTTPtext
set case[1].protocol=TCP
set case[1].duration=!duration!
set case[2].script=all
set case[2].protocol=TCP,UDP,RTP
set case[2].duration=60
set case_total=0

for /f %%i in ('set case[ ^| find /c ".script"') do set case_total=%%i

:x
set /a round=%round%+1
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "T_DATETIME=%%I"
set "StartTime=%T_DATETIME:~0,14%"
echo Packet_Simulator_Start_Time=%StartTime%

REM 紀錄 CPU, RAM 在執行前中後(執行中要定期取值並取得最大值)
for /l %%i in (1,1,!case_total!) do (
    set "SCRIPT_PATH=!case[%%i].script!"
    set "PROTOCOLS=!case[%%i].protocol!"
    set "DURATION=!case[%%i].duration!"
    @REM echo !SCRIPT_PATH!, !PROTOCOLS!, !DURATION!

    for /l %%j in (1,1,!script_total!) do (
        for %%s in ("!scripts[%%j]!") do (
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
                    set "e1=!new_e1!"
                    set "e2=!new_e2!"
                )
            )

            if "!RUN!"=="1" (
                for %%p in (!PROTOCOLS!) do (
                    for /f %%t in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
                        REM initialize cpu and ram max values
                        set cpu_max_before=0
                        set cpu_max_during=0
                        set cpu_max_after=0
                        set ram_max_before=0
                        set ram_max_during=0
                        set ram_max_after=0

                        REM ===== Before execution =====
                        echo "Before execution 60 seconds..."
                        for /L %%k in (1,1,1) do (
                            set "cpu_int=0"
                            set "ram_mb=0"

                            for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
                                set "cpu_int=%%d"
                            )
                            if !cpu_int! GTR !cpu_max_before! set "cpu_max_before=!cpu_int!"

                            for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
                                set "ram_mb=%%e"
                            )
                            if !ram_mb! GTR !ram_max_before! set "ram_max_before=!ram_mb!"

                            REM 注意：echo 內容不要包含括號，避免 Batch 語法解析錯誤
                            echo "Before execution, iteration %%k: CPU !cpu_int!%% [Max !cpu_max_before!%%], RAM !ram_mb!MB [Max !ram_max_before!MB]"
                            
                            timeout /t 1 >nul
                        )

                        REM start /b 啟動應用程式而不開啟新的 命令提示字元 視窗
                        start "" /b tclsh TS004_OneLink_OnePair.tcl "!e1!" "!e2!" "!pairs_per_group!" "%%s" "%%p" "!DURATION!" "%%t" 2>> nul

                        REM ===== Execution =====
                        set /a loops=DURATION/interval
                        echo !loops!

                        for /L %%k in (1,1,!loops!) do (
                            set "cpu_int=0"
                            set "ram_mb=0"

                            REM ---- CPU ----
                            for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
                                set "cpu_int=%%d"
                            )
                            if !cpu_int! GTR !cpu_max_during! set "cpu_max_during=!cpu_int!"

                            REM ---- RAM ----
                            for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
                                set "ram_mb=%%e"
                            )
                            if !ram_mb! GTR !ram_max_during! set "ram_max_during=!ram_mb!"

                            echo "Execution in progress, iteration %%k: CPU !cpu_int!%% [Max:!cpu_max_during!%%], RAM !ram_mb!MB [Max:!ram_max_during!MB]"

                            REM ---- every sec ----
                            timeout /t !interval! >nul
                        )
                        @REM timeout /t 600

                        REM ===== After execution =====
                        echo "After execution 30 seconds..."
                        for /L %%k in (1,1,1) do (
                            set "cpu_int=0"
                            set "ram_mb=0"

                            REM ---- CPU ----
                            for /f %%d in ('powershell -NoProfile -Command "$name='!target_name!'; $cores=[Environment]::ProcessorCount; $p1=Get-Process -Name $name -EA 0; if(-not $p1){0; exit}; $c1=($p1 | Measure-Object CPU -Sum).Sum; Start-Sleep -Milliseconds 1000; $p2=Get-Process -Name $name -EA 0; if(-not $p2){0; exit}; $c2=($p2 | Measure-Object CPU -Sum).Sum; [Math]::Round((($c2-$c1) * 100) / $cores)"') do (
                                set "cpu_int=%%d"
                            )
                            if !cpu_int! GTR !cpu_max_after! set "cpu_max_after=!cpu_int!"

                            REM ---- RAM  ----
                            for /f %%e in ('powershell -NoProfile -Command "$name='!target_name!'; $samples=(Get-Counter '\Process(*)\Working Set - Private').CounterSamples | Where-Object { $_.InstanceName -eq $name.ToLower() -or $_.InstanceName -like ($name.ToLower() + '#*') }; if($samples){ [int](($samples | Measure-Object CookedValue -Sum).Sum / 1MB) } else { 0 }"') do (
                                set "ram_mb=%%e"
                            )
                            if !ram_mb! GTR !ram_max_after! set "ram_max_after=!ram_mb!"

                            echo "After execution, iteration %%k: CPU !cpu_int!%% [Max:!cpu_max_after!%%], RAM !ram_mb!MB [Max:!ram_max_after!MB]"
                            timeout /t 1 >nul
                        )

                        REM ===== Write to CSV =====
                        for /f "delims=" %%c in (!file_path!) do (
                            echo "%0","%target%","%target_version%","!round!",^
                            "!cpu_max_before!","!cpu_max_during!","!cpu_max_after!",^
                            "!ram_max_before!","!ram_max_during!","!ram_max_after!",^
                            "!T_DATETIME!","!DURATION!","%%~nxs","%%p",%%c >> %csvfile%
                        )
                        del !file_path!
                        echo ## !T_DATETIME!, %%p, %%s --------------------------------------
                        timeout /t 10
                    )
                )
            )
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
