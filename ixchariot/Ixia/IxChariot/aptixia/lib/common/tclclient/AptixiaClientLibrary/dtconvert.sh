#!/bin/sh
# restart using wish    -*- mode: tcl; tab-width: 8; -*- \
exec tclsh $0 ${1+"$@"}

package require doctools 1.1
array set ::_opts {-files {}}
array set ::_doc_opts {-format html}
foreach {t v} $argv {
    switch -glob -- $t {-file} {
        lappend ::_opts(-files) $v
    } {-*} {
        lappend ::_doc_opts($t) $v
    }
}

proc main {} {
    ::doctools::new myDoc
    eval [concat [list myDoc configure] [array get ::_doc_opts]]
    foreach fname $::_opts(-files) {
        set f [open $fname "r"]
        set _DOCDATA [read $f]
        close $f
        puts stdout [myDoc format $_DOCDATA]
    }
}
main
