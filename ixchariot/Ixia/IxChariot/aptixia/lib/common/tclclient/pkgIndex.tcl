#
#
#
if {![package vsatisfies [package provide Tcl] 8.4]} {
    # we need at least tcl version 8.4
    return -code error \
"The AptixiaClientLibrary requires tcl version 8.4. You have version [package provide Tcl]"
}

# -- make subsidiary util packages findable
set _d [file join $dir AptixiaClientLibraryPackages snit1.0]
set ::auto_path [concat [list $_d] $::auto_path]
set _d [file join $dir AptixiaClientLibraryPackages base64]
set ::auto_path [concat [list $_d] $::auto_path]

proc _ac_load_plugins_ {dir} {
    set plugin_dir [file join $dir .. tclclient-plugins]
    foreach {fname} [glob -nocomplain [file join $plugin_dir "*.tcl"]] {
      set failed [catch { uplevel #0 [list source $fname] } err]
      if {$failed} {
        puts stderr ""
        puts stderr "--------------------------------------------------------"
        puts stderr "AptixiaClientLibrary Warning: cannot source file: '$fname'"
        puts stderr "Error: $err"
        puts stderr "ErrorInfo: $::errorInfo"
        puts stderr "--------------------------------------------------------"
        puts stderr ""
      }
    }
}

proc _ac_load_ {dir} {
    uplevel #0 \
    [list source [file join $dir AptixiaClientLibrary AptixiaClientSocket.tcl]]
    uplevel #0 \
    [list source [file join $dir AptixiaClientLibrary AptixiaClient.tcl]]
    uplevel #0 \
    [list source [file join $dir AptixiaClientLibrary AptixiaClientTS.tcl]]
    uplevel #0 \
    [list source [file join $dir AptixiaClientLibrary AptixiaClientFile.tcl]]
    _ac_load_plugins_ $dir
}


package ifneeded AptixiaClient 2.0 [list _ac_load_ $dir]
