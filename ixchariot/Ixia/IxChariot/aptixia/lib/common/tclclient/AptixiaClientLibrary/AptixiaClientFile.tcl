##
##
##
package require snit 1.0; # older snits probably won't work
set _AC_ ::AptixiaClient; namespace eval ${_AC_} {}

snit::type ${_AC_}::file {

    component c_XferObj -public XferObj

    option -file -default "" -readonly 1
    option -channel -default "" -readonly 1
    variable m_SourceTag ""
    variable m_SourceVal ""

    option -transactioncontext -default "" -readonly 1

    # >=0 means bound to (readable) file transfer context
    # -1 means not bound to (readable) file transfer context
    # -2 means bound to (readable file transfer context that has already
    #    been consumed
    option -outputxid -default "-1" -readonly 1

    constructor {args} {
        $self configurelist $args
        set cmd [list ::AptixiaClient::TestServer %AUTO% \
            -objectid 1 -transactioncontext [$self cget -transactioncontext] \
        ]
        if {[catch $cmd c_XferObj]} {
            puts stderr "$type: Constructor Error: $c_XferObj"; 
            return -code error "Constructor Error $type: $c_XferObj"
        }
        foreach tag { -file -channel } {
            if {[string length [$self cget $tag]]} {
                set m_SourceTag $tag
                set m_SourceVal [$self cget $tag]
            }
        }
    }
    destructor {
        catch {$c_XferObj destroy}
    }

    method _SourceDescription {} {
        return [list $m_SourceTag $m_SourceVal]
    }


    typemethod _enc_ {i_val} {
        set src_desc ""
        set src_chan ""
        set close_chan 0

        set failed [catch {$i_val info type} i_type]
        if {$failed || ($i_type != $type)} {
            return -code error \
              "parameter '[$i_val info type]' is not of type '$type'"
        }

        set tmp [$i_val _SourceDescription]
        set sourceTag [lindex $tmp 0]
        set sourceVal [lindex $tmp 1]
        set bufsize 100000

        if {$sourceTag == "-file"} {
            set src_desc $sourceVal
            set close_chan 1
            set failed [catch {open $sourceVal "r"} rval]
            if {$failed} {
                set msg "error opening '$src_desc':$rval" 
                return -code error -errorinfo $::errorInfo $msg
            }
            set src_chan $rval
            fconfigure $src_chan -buffersize $bufsize \
                -encoding binary -translation binary
        } elseif {$sourceTag == "-channel"} {
            set src_desc $sourceVal
            set close_chan 0
            set src_chan $sourceVal

        } else {
            set msg \
{A Data Source must be defined for this 'file' input parameter
via the 'UseDataSource' method
}
            return -code error "$i_val: $msg"
        }

        set xid ""
        set failed [catch {
            set res [$i_val XferObj _CreateFileTransferContext]
            set xid [lindex $res 0]
            while {1} {
                set buf [read $src_chan $bufsize]
                if {[string bytelength $buf] == 0} {
                    break
                }
                $i_val XferObj _WriteFileBlock $xid $buf
            }
        } err]

        if {$src_chan != ""} {
            if {$close_chan} {
                close $src_chan
            }
        }
        if {$failed} {
            catch {$i_val XferObj _CloseFileTransferContext $xid}
            return -code error $err
        }
        return $xid
    }

    typemethod _dec_ {i_context i_type i_elems i_varN} {
        # Note: we place the result in the 'reference' i_varN
        upvar 1 $i_varN v

        # i_elems should be one node that contains the file tranfer 
        # context (numeric id) that we should to 'XferObj _ReadBlock' 
        # calls against

        set xid -1
        ${::_AC_}::Core::XPS::GetArg_int64 [lindex $i_elems 0] xid 

        set v [${::_AC_}::file create %AUTO% \
            -transactioncontext $i_context -outputxid $xid]
    }

    method UseDataSource {args} {
        set usage \
{Wrong # of arguments: method call should be one of the following:
    $fileobject UseDataSource -file _filename_
    $fileobject UseDataSource -channel _channel_
}

        if {[llength $args]%2 != 0} {
            return -code error $usage
        }
        array set o $args
        set xid [$self cget -outputxid]
        if {$xid != -1} {
            return -code error \
              "UseDataSource can only be used on 'file' input parameter objects"
        }
        if {[info exists o(-file)]} {
            set m_SourceTag -file
            set m_SourceVal $o(-file)
        } elseif {[info exists o(-channel)]} {
            set m_SourceTag -channel
            set m_SourceVal $o(-channel)
        } else {
            return -code error $usage
        }
    }

    method CopyDataTo {args} {
        set usage \
{Wrong # of arguments: method call should be one of the following:
    $fileobject CopyDataTo -file _filename_
    $fileobject CopyDataTo -channel _channel_
}

        if {[llength $args]%2 != 0} {
            return -code error $usage
        }
        array set o $args
        set xid [$self cget -outputxid]

        if {$xid == -2} {
            return -code error "$self: Data has already been copied"
        }
        if {$xid < 0} {
            return -code error \
              "CopyTo can only be used with 'file' output parameter objects"
        }

        set bufsize 100000
        set close_chan 0
        set chan ""
        if {[info exists o(-file)]} {
            set close_chan 1
            set chan [open $o(-file) "w+"]
            fconfigure $chan -buffersize $bufsize \
                -encoding binary -translation binary
        } elseif {[info exists o(-channel)]} {
            set close_chan 0
            set chan $o(-channel)
        }

        set failed [catch {
            while {1} {
                set buf [lindex \
                    [$self XferObj _ReadFileBlock $xid $bufsize] 0]
                if {[string bytelength $buf] == 0} {
                    break
                }
                puts -nonewline $chan $buf
            }
        } err]
        set options(-outputxid) -2; # source has been consumed
        if {$close_chan} {
            close $chan
        }
        if {$failed} {
            catch {$self XferObj _CloseFileTransferContext $xid}
            return -code error $err
        }
    }
}
