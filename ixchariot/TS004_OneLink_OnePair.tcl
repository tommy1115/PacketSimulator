###############################################################################
#     e1 ---------------------------> e2
# 192.168.99.50               100.100.100.100
# 192.168.99.51               100.100.100.101
# 192.168.99.52               100.100.100.102
# 192.168.99.53               100.100.100.103
# 192.168.99.54               100.100.100.104
# 192.168.99.55               100.100.100.105
# 192.168.99.56               100.100.100.106
# 192.168.99.57               100.100.100.107
# 192.168.99.58               100.100.100.108
# 192.168.99.59               100.100.100.109
###############################################################################

proc argsParser args {
    global e1
    global e2
    global currentScript
    global currentProtocol
    global timeout
    global timestamp

    set args [string map { - "" } $args]

    if {[expr [llength $args] % 2] != 0 } {
        puts "Wrong Arguments :: $args "
        return "For Help :: argsParser -?";
    }

    switch $args {
        h -
        help -
        ? { puts "Usage :: argParser -arg1 val1 -arg2 val2" 
              puts "arg1 :: Number"
              puts "arg2 :: Number"
        }
        default {
            set e1 "192.168.50.99" ;
            set e2 "100.100.100.100" ;
            set currentScript "" ;
            set currentProtocol "" ;
            set timeout 60 ;
            set timestamp "";

            set args [string map { - "" } $args]
            for {set i 0} {$i < [llength $args]} { incr i 2} {
                set a [lindex $args $i]
                # puts [lindex $args $i]
                if { $a != "e1" && $a != "e2" && $a != "currentScript" && $a != "currentProtocol" && $a != "timeout" && $a != "timestamp" } {
                    return "Unknown Args :: $a - For Help :: argsParser -?";
                }
                set b [lindex $args [expr $i+1]]
                set $a $b 
            }
        }   
    }   
}

proc output {pairs time duration} {
    set filename "new_file.txt"
    set file [open $filename "a"]
    set scr_name ""
    set appl_name ""
    if {[catch {chrPair get $pairs SCRIPT_FILENAME}] == 0} {
        set scr_name [chrPair get $pairs SCRIPT_FILENAME]
    }
    if {[catch {chrPair get $pairs APPL_SCRIPT_NAME}] == 0} {
        set tmp_appl_name [chrPair get $pairs APPL_SCRIPT_NAME]
        set appl_name [string map {, ""} $tmp_appl_name]
    }

    set result "$time,\
          $duration,\
          $scr_name,\
          $appl_name,\
          [chrPair get $pairs PROTOCOL],\
          [chrPair get $pairs E1_ADDR],\
          [chrPair get $pairs E2_ADDR]"
    if {[catch {set consecutive_lost [chrPairResults get $pairs CONSECUTIVE_LOST]}] == 0} {
        set value [format "%.3f" $consecutive_lost]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set cpu_util_e1 [chrPairResults get $pairs CPU_UTIL_E1]}] == 0} {
        set value [format "%.3f" $cpu_util_e1]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set cpu_util_e2 [chrPairResults get $pairs CPU_UTIL_E2]}] == 0} {
        set value [format "%.3f" $cpu_util_e2]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set delay_factor [chrPairResults get $pairs DELAY_FACTOR]}] == 0} {
        set value [format "%.3f" $delay_factor]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set delay_variation [chrPairResults get $pairs DELAY_VARIATION]}] == 0} {
        set value [format "%.3f" $delay_variation]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set end_to_end_delay [chrPairResults get $pairs END_TO_END_DELAY]}] == 0} {
        set value [format "%.3f" $end_to_end_delay]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set jitter [chrPairResults get $pairs JITTER]}] == 0} {
        set avg [format "%.3f" [lindex $jitter 0]]
        set min [format "%.3f" [lindex $jitter 1]]
        set max [format "%.3f" [lindex $jitter 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set media_loss_rate [chrPairResults get $pairs MEDIA_LOSS_RATE]}] == 0} {
        set value [format "%.3f" $media_loss_rate]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set mos_estimate [chrPairResults get $pairs MOS_ESTIMATE]}] == 0} {
        set avg [format "%.3f" [lindex $mos_estimate 0]]
        set min [format "%.3f" [lindex $mos_estimate 1]]
        set max [format "%.3f" [lindex $mos_estimate 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set one_way_delay [chrPairResults get $pairs ONE_WAY_DELAY]}] == 0} {
        set avg [format "%.3f" [lindex $one_way_delay 0]]
        set min [format "%.3f" [lindex $one_way_delay 1]]
        set max [format "%.3f" [lindex $one_way_delay 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set r_value [chrPairResults get $pairs R_VALUE]}] == 0} {
        set min ""
        set max ""
        set avg [format "%.3f" [lindex $r_value 0]]
        catch {set min [format "%.3f" [lindex $r_value 1]]}
        catch {set max [format "%.3f" [lindex $r_value 2]]}

        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set rel_precision [chrPairResults get $pairs REL_PRECISION]}] == 0} {
        set value [format "%.3f" $rel_precision]
        append result ", $value"
    } else {
        append result ", "
    }

    if {[catch {set resp_time [chrPairResults get $pairs RESP_TIME]}] == 0} {
        set avg [format "%.3f" [lindex $resp_time 0]]
        set min [format "%.3f" [lindex $resp_time 1]]
        set max [format "%.3f" [lindex $resp_time 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set rssi_e1 [chrPairResults get $pairs RSSI_E1]}] == 0} {
        set avg [format "%.3f" [lindex $rssi_e1 0]]
        set min [format "%.3f" [lindex $rssi_e1 1]]
        set max [format "%.3f" [lindex $rssi_e1 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set rssi_e2 [chrPairResults get $pairs RSSI_E2]}] == 0} {
        set avg [format "%.3f" [lindex $rssi_e2 0]]
        set min [format "%.3f" [lindex $rssi_e2 1]]
        set max [format "%.3f" [lindex $rssi_e2 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set throughput [chrPairResults get $pairs THROUGHPUT]}] == 0} {
        set avg [format "%.3f" [lindex $throughput 0]]
        set min [format "%.3f" [lindex $throughput 1]]
        set max [format "%.3f" [lindex $throughput 2]]

        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    if {[catch {set trans_rate [chrPairResults get $pairs TRANS_RATE]}] == 0} {
        set avg [format "%.3f" [lindex $trans_rate 0]]
        set min [format "%.3f" [lindex $trans_rate 1]]
        set max [format "%.3f" [lindex $trans_rate 2]]
        
        append result ", $avg, $min, $max"
    } else {
        append result ", , , "
    }

    # puts $result
    puts $file $result
    close $file
}

argsParser -e1 [lindex $argv 0]\
           -e2 [lindex $argv 1]\
           -currentScript [lindex $argv 2]\
           -currentProtocol [lindex $argv 3]\
           -timeout [lindex $argv 4]\
           -timestamp [lindex $argv 5]

load "Ixia\\IxChariot\\ChariotExt.dll"
package require ChariotExt

############################## Modify down below ##############################
###############################################################################
# HTTPtext script test, 10 groups, 16 pairs per group
###############################################################################
proc httptext_test {} {
    global test timestamp currentScript currentProtocol timeout
    # TODO(REQ): 要測試的 IP 由外部參數傳進來 
    # set base_e1 "192.168.99."
    # set base_e2 "100.100.100."
    # set start_suffix_e1 50
    # set start_suffix_e2 100
    # set total_groups 10
    # set pairs_per_group 16
    set base_e1 "192.168.0."
    set base_e2 "192.168.0."
    set start_suffix_e1 136
    set start_suffix_e2 156
    set total_groups 1
    set pairs_per_group 16

    set allPairs {}

    for {set g 0} {$g < $total_groups} {incr g} {
        set current_suffix_e1 [expr $start_suffix_e1 + $g]
        set current_suffix_e2 [expr $start_suffix_e2 + $g]
        set e1_ip "${base_e1}${current_suffix_e1}"
        set e2_ip "${base_e2}${current_suffix_e2}"

        for {set p 0} {$p < $pairs_per_group} {incr p} {
            set pair [chrPair new]
            chrPair set $pair E1_ADDR $e1_ip E2_ADDR $e2_ip
            chrPair set $pair PROTOCOL $currentProtocol
            chrPair useScript $pair $currentScript
            catch {chrPair setScriptVar $pair send_buffer_size 65486}
            catch {chrPair setScriptVar $pair receive_buffer_size 65486}

            if {[catch {chrTest addPair $test $pair}] == 0} {
                lappend allPairs $pair
            }
        }
    }

    ###############################################################################
    # Start HTTPtext test with 160 pairs
    ###############################################################################
    if {[catch {chrTest start $test}] == 0} {
        if {![chrTest isStopped $test $timeout]} {
            chrTest stop $test
        }
        foreach p_obj $allPairs {
            output $p_obj $timestamp $timeout
        }
    } else {
        return
    }
}

###############################################################################
# All scripts test
###############################################################################
proc allscript_test {} {
    global test e1 e2 currentProtocol currentScript timestamp timeout
    set pair [chrPair new]
    chrPair set $pair E1_ADDR $e1 E2_ADDR $e2
    chrPair set $pair PROTOCOL $currentProtocol
    chrPair useScript $pair $currentScript
    catch {chrPair setScriptVar $pair send_buffer_size 65486}
    catch {chrPair setScriptVar $pair receive_buffer_size 65486}
    ###############################################################################

    ###############################################################################
    # puts "    $currentProtocol: $e2  --> $e1"
    set pairReverse [chrPair new]
    chrPair copy $pairReverse $pair
    chrPair set $pairReverse E1_ADDR $e2 E2_ADDR $e1
    ###############################################################################

    catch {chrTest addPair $test $pair}
    catch {chrTest addPair $test $pairReverse}

    ###############################################################################
    # Start
    ###############################################################################
    # puts "$currentScript, Start"

    if {[catch {chrTest start $test}] != 0} {
        return
    }

    # TODO(REQ): isStopped 定義
    if {![chrTest isStopped $test [expr $timeout]]} {
        chrTest stop $test
    }

    if {![chrTest isStopped $test 10]} {
        chrTest stop $test
    }
    
    # set timestamp [chrTest get $test STOP_TIME]
    # puts "$currentScript, Stop"
    # puts "###############################################################################"

    ###############################################################################
    # Information
    ###############################################################################

    output $pair $timestamp $timeout
    output $pairReverse $timestamp $timeout
}

# puts "###############################################################################"
set test [chrTest new]
set runOpts [chrTest getRunOpts $test]
# chrRunOpts set $runOpts TEST_END WHEN_ALL_COMPLETE
chrRunOpts set $runOpts TEST_END FIXED_DURATION
chrRunOpts set $runOpts TEST_DURATION $timeout
chrRunOpts set $runOpts CPU_UTIL 1
chrRunOpts set $runOpts STOP_AFTER_NUM_PAIRS_FAIL 170

if {[string match -nocase "*HTTPtext.scr*" $currentScript]} {
    httptext_test
} else {
    allscript_test
}
catch {chrTest delete $test force}


return