@echo off

REM TODO: close firewall and sleep

REM Usage: ts001_packet_simulator_duallink.bat [E1 Address]   [E2 Address]   [Target] [Version] [Target Name]
REM    ex: ts001_packet_simulator_duallink.bat 192.168.99.100 192.168.99.200
REM    ex: ts001_packet_simulator_duallink.bat 192.168.99.100 192.168.99.200 GTNet    0.10.0    GTBoosterLauncher
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
set cpu_min=0
set cpu_max=0
set ram_min=0
set ram_max=0
set file_path=new_file.txt
set csvfile=out.csv
echo "Test","Target","Version","Round","CPU_min","CPU_max","RAM_min(KB)","RAM_max(KB)","Timestamp","Duration","SCRIPT_FILENAME","APPL_SCRIPT_NAME","Protocol","E1_ADDR","E2_ADDR","CONSECUTIVE_LOST","CPU_UTIL_E1","CPU_UTIL_E2","DELAY_FACTOR","DELAY_VARIATION","END_TO_END_DELAY","JITTER_AVG","JITTER_MIN","JITTER_MAX","MEDIA_LOSS_RATE","MOS_ESTIMATE_AVG","MOS_ESTIMATE_MIN","MOS_ESTIMATE_MAX","ONE_WAY_DELAY_AVG","ONE_WAY_DELAY_MIN","ONE_WAY_DELAY_MAX","R_VALUE_AVG","R_VALUE_MIN","R_VALUE_MAX","REL_PRECISION","RESP_TIME_AVG","RESP_TIME_MIN","RESP_TIME_MAX","RSSI_E1_AVG","RSSI_E1_MIN","RSSI_E1_MAX","RSSI_E2_AVG","RSSI_E2_MIN","RSSI_E2_MAX","THROUGHPUT_AVG","THROUGHPUT_MIN","THROUGHPUT_MAX","TRANS_RATE_AVG","TRANS_RATE_MIN","TRANS_RATE_MAX" >> %csvfile%

REM Modify down below

:x
set /a round=%round%+1
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do set "T_DATETIME=%%I"
set "StartTime=%T_DATETIME:~0,14%"
echo Packet_Simulator_Start_Time=%StartTime%

for /r %%i in (*.scr) do (

    for %%a in (TCP UDP RTP) do (

        for /f %%b in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMddHHmmss"') do (
            echo #############################################################################
            set "T_DATETIME=%%b"
            SET T_DATETIME=!T_DATETIME:~0,14%!

            tclsh TS003_DualLink_OnePair+VoIPPair.tcl %1 %2 %%i %%a 60 "!T_DATETIME!" 2>> nul

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

@REM starttime
@REM for /f "tokens=2 delims==" %%A in ('wmic os get localdatetime /value') do set "DT=%%A"
@REM Set Year0=%DT:~0,4%
@REM Set Month0=%DT:~4,2%
@REM Set Day0=%DT:~6,2%
@REM Set Hour0=%DT:~8,2%
@REM Set Minute0=%DT:~10,2%
@REM Set Second0=%DT:~12,2%
@REM Set DateTime0=%Year0%%Month0%%Day0%%Hour0%%Minute0%%Second0%
@REM Echo  %DateTime0%

@REM endtime
@REM for /f "tokens=2 delims==" %%A in ('wmic os get localdatetime /value') do set "DT=%%A"
@REM Set Year1=%DT:~0,4%
@REM Set Month1=%DT:~4,2%
@REM Set Day1=%DT:~6,2%
@REM Set Hour1=%DT:~8,2%
@REM Set Minute1=%DT:~10,2%
@REM Set Second1=%DT:~12,2%
@REM Set DateTime1=%Year1%%Month1%%Day1%%Hour1%%Minute1%%Second1%
@REM Echo  %DateTime1%

@REM REM CALCULATE DIFFERENCE BETWEEN START AND FINISH DATETIME STAMPS HERE
@REM set /a "Seconds = (1%Day1% - 1%Day0%) * 86400 + (1%Hour1% - 1%Hour0%) * 3600 + (1%Minute1% - 1%Minute0%) * 60 + (1%Second1% - 1%Second0%)"

@REM echo  Run time was %Seconds%

@REM set /a "second=%Seconds% %% 60"
@REM set /a "minute=%Seconds%/60"
@REM set /a "hour=%minute%/60"
@REM set /a "day=%hour%/24"
@REM echo hour=%hour%, minute=%minute%, second=%second%
endlocal 

cd ..
