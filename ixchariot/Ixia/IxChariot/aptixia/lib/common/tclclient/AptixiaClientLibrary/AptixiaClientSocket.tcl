#
#
#
#
package require snit 1.0; # older snits probably won't work
package require base64
set _AC_ ::AptixiaClient; namespace eval ${_AC_} {}

#
#
#
snit::type ${_AC_}::Core::ClientSocket {
    #-------------------------------------------------------------------------
    # Variables
    #-------------------------------------------------------------------------

    # Buffer incoming data is received and collected into (for frame delimiting)
    #
    variable _RecvBuf ""
    #
    # Buffer individual reads are read into
    #
    variable _ReadBuf

    #-------------------------------------------------------------------------
    # Options
    #-------------------------------------------------------------------------

    #
    # Turns of various tag orineted debug messages
    #
    ##option -tracetags -default "*"
    option -tracetags -default {}
    #
    # If Defined, use this existing channel as the connection for this object
    # -host and -port are ignored in this case
    #
    option -channel -default ""
    #
    # Host to connect to (in conjunction with -port)
    #
    option -host -default "" 
    #
    # Port to connect to (in conjunction with -host)
    #
    option -port -default "" 
    #
    # If true underlying channel is closed on object destroy
    # this is set to true internally if -host & -port are employed
    #
    option -closechannelondestroy -default true
    #
    # This command is called with each frame received
    # if the command is empty (the default). 
    # The frame is tossed after reception
    #
    option -framecommand -default ""

    #-------------------------------------------------------------------------
    # Constructor/Destructor related items
    #-------------------------------------------------------------------------

    constructor {args} {
        $self _TR_ call "constructor"
        $self configurelist $args; # install args into options

        if {[string length [$self cget -channel]] != 0} {
            #
            # channel supplied. clear -host and -port options
            #
            $self _TR_ connect "using existing channel [$self cget -channel]"
            $self configure -host ""
            $self configure -port ""
        }
        # TODO: ...
        if {0} {
           return -code error \
               "A client already exists with the supplied -channel"
        }
    }

    destructor {
        $self _TR_ call "destructor"
        if {[$self cget -closechannelondestroy]} {
            $self _TR_ connect "closing channel"
            if {[string length [$self cget -channel]]} {
                set failed [catch { close [$self cget -channel] } err]
                if {$failed} {
                    $self _TR_ exception "error closing channel: $err"
                }
            } else {
                $self _TR_ connect "note: no channel to close"
            }
        }
    }

    method exception {id args} {
        $self _TR_ exception  "$id: $args"
        return -code error [list $id $args]
    }

    #
    # Internal Tracer method: driven by -tracetags
    #
    method _TR_ {tracetag msg} {
        set _selftags [$self cget -tracetags]
        if {( $_selftags == "*")||([lsearch $_selftags $tracetag] != -1)} {  
            puts stderr "ClientSocket:$tracetag:$msg"; flush stderr
        }
    }

    #--------------------------------------------------------------------------
    # Utility methods
    #--------------------------------------------------------------------------
    method HexDump {buf} {
        set buflen [string length $buf]
        set rval ""

        append rval "## len = $buflen\n"
        for {set x 0} {$x < $buflen} {incr x 16} {
            set s [string range $buf $x [expr $x+15]]

            # Convert the data to hex and to characters.
            binary scan $s H*@0a* hex ascii

            # Replace non-printing characters in the data.
            regsub -all -- {[^[:graph:] ]} $ascii {.} ascii

            # Split the 16 bytes into two 8-byte chunks
            if {[string length $s] < 2} {
                set hex1 $hex
                set hex2 ""
            } else {
                regexp -- {(.{16})(.{0,16})} $hex -> hex1 hex2
            }

            # Convert the hex to pairs of hex digits
            regsub -all -- {..} $hex1 {& } hex1
            regsub -all -- {..} $hex2 {& } hex2

            # Put the hex and Latin-1 data to the channel
            append rval [format {%08x %-24s %-24s %-16s} \
                $x $hex1 $hex2 $ascii]
            append rval "\n"
        }
        append rval "##\n"
        return $rval
    }

    #-------------------------------------------------------------------------
    # Methods
    #-------------------------------------------------------------------------

    method checkConnection {} {
        if {[string length [$self cget -channel]] == 0} {
            $self exception "Aptixia.Client.ClientSocket.NoConnection"
        }
    }
    method Connect {args} {
        set errid "Aptixia.Client.ClientSocket.ConnectionError"
        array set o {
            -host ""
            -port ""
        }; array set o $args
        set host $o(-host)
        set port $o(-port)

        # categorically close any existing channel
        set c [$self cget -channel]
        if {[string length $c]} {
            $self _TR_ connect "closing existing channel $c"
            close $c
            $self configure -channel ""
        }

        if {[string length $host] == 0} {
            set msg "-host is required if -channel not defined" 
            $self exception $errid $msg
        }
        if {[string length $port] == 0} {
            set msg "-port is required if -channel not defined" 
            $self exception $errid $msg
        }
        set failed [catch { 
            $self _TR_ connect "connecting.."
            socket $host $port 
        } res]
        if {$failed} {
            set msg "Connect failed (host=$host port=$port): $res"
            $self exception $errid $msg
        }
        set chan $res

        $self configure -channel $chan
        fconfigure $chan -encoding ""

        $self _TR_ connect "success"
        $self configure -closechannelondestroy true
        $self configure -host $host
        $self configure -host $port
        return ""
    }

    # Map special characters into their XML entity equivalents.  The optional
    # "attribute" pararameter instructs the mapping to also treat quotes as
    # special entities for use in element attributes, which isn't necessary
    # for element body text.
    #
    proc XMLEntities { text {attribute 0} } {
     if {$attribute} {
         return [string map {& &amp; < &lt; > &gt; \' &apos; \" &quot;} $text]
     } else {
         return [string map {& &amp; < &lt; > &gt;} $text]
     }
    }

    #
    # Turn a given body of text into XML comments indented the specified
    # number of spaces.
    #
    proc XMLComment { indent {text ""} } {
     set result ""
     if {$text != ""} {
         append result "\n"
         foreach line [split $text \n] {
             append result [format "%*s<!-- %*s -->\n" \
                 $indent "" -[expr {60 - $indent}] [XMLEntities $line]]
         }
         append result "\n"
     }
     return $result
    }

    #
    # Generate an XML element indented the specified number of spaces.
    # Paramters:
    # name    - the name of the element to be generated.
    # attribs - a list of name value name value ... to be output as
    #           attributes of the element.  They should not be pre-mapped
    #           into XML entities, since this will be handled for you.
    # content - the body of the element (i.e., what is to be inserted
    #           in between the start and end tags, if anything).  Generally
    #           this would be either the result of earlier calls to XMLElement
    #           to generate deeper structures, the result of calling
    #           XMLEntities on a piece of text data.
    #
    proc XMLElement { indent name attribs {content ""} } {
     set result [format "%*s<%s" $indent "" $name]

     foreach {attrib value} $attribs {
         append result " $attrib=\"[XMLEntities $value 1]\""
     }

     if {$content != ""} {
         append result ">"

         set headlen [string length $result]
         set contlen [string length $content]
         set taglen  [string length $name]

         if {([expr {$headlen + $contlen + $taglen + 3}] > 60) || \
                 ([string first "\n" $content] != -1)} {
             append result "\n"
             append result $content
             append result [format "%*s</%s>\n" $indent "" $name]
         } else {
             append result $content
             append result "</$name>\n"
         }
     } else {
         append result "/>\n"
     }
     return $result
    }

    proc list2xml {list} {
      switch -- [llength $list] {
        2 {lindex $list 1}
        3 {
            foreach {tag attributes children} $list break
            set res <$tag
            foreach {name value} $attributes {
                append res " $name=\"$value\""
            }
            if [llength $children] {
                append res >
                foreach child $children {
                    append res [list2xml $child]
                }
                append res </$tag>
            } else {append res />}
        }
        default {error "[llength $list] could not parse $list"}
      }
    }

    #--------------------------------------------------------------------------
    # I/O related methods
    #--------------------------------------------------------------------------

    method ScheduleWrite {data} {
        $self _TR_ call "ScheduleWrite: [string length $data] bytes"
        set chan [$self cget -channel]
        set failed [catch {puts -nonewline [$self cget -channel] $data} err]
        if {$failed} {
            # TODO ???
            # we just let it fail and continue. The read side should take
            # take care of the broken channel
            $self _TR_ write "write failed"
        } else {
            $self _TR_ write "write placed in tcl channel"
            $self _TR_ write "\n================\n$data\n================\n"
        }
    }

    #
    # Variable that all reads are done into. handy sometimes for creating
    # vwaits against
    #
    method readBufferVariable {} {
        return [myvar _ReadBuf]
    }
    #
    # Base level 'fileevent readable' callback used on the underlying socket
    # connections
    #
    method readEventHandler {} { 
      set failed [catch { 
        $self _TR_ call "readEventHandler"

        append _RecvBuf ""
        set chan [$self cget -channel]

        if {[eof $chan]} {
            $self _TR_ readevent "EOF on channel '$chan'" 
            $self disableReadEvents
            close $chan
            return
        }

        append _RecvBuf [set [myvar _ReadBuf] [read $chan]]
        $self _TR_ call "readEventHandler read [string length $_ReadBuf] bytes"

        ##$self _TR_ read "readbuf:\n[$self HexDump $_ReadBuf]"
        ##$self _TR_ read "readbuf:\n$_ReadBuf"

        set _DELIM \x00
        while {[set x [string first $_DELIM $_RecvBuf]]!=-1} {
            # found a frame terminator. peel off the frame 
            set frame [string range $_RecvBuf 0 $x]
            $self _TR_ read "frame:[string length $frame] bytes"
            $self _TR_ readhex "frame:\n[$self HexDump $frame]"
            $self _TR_ readdata "frame:\n$frame"

            # trim off processed frame
            set _RecvBuf [string range $_RecvBuf [incr x 1] end]

            # call frame callback (if any)
            if {[string length $options(-framecommand)]} {
                $self _TR_ readdata "framecommand: >>$options(-framecommand)<<"
                eval $options(-framecommand) frame
            } else {
                $self _TR_ read "frame:tossed frame (no -framecommand defined)" 
            }

            # check for more frames..
        }

      } err]
      if {$failed} {
        $self _TR_ call "readEventHandler error: $err\n$::errorInfo"
      }
    }
    method enableReadEvents {} {
        $self prepareChannelForReadEvents
        # TODO: should it trash the buffer ???
        set _RecvBuf ""; # Note: intentionally trashes any stale recv buf

        $self _TR_ call "enableReadEvents"
        fileevent [$self cget -channel] readable [mymethod readEventHandler]
    }
    method disableReadEvents {} {
        $self _TR_ call "disableReadEvents" 
        fileevent [$self cget -channel] readable {}
    }
    method prepareChannelForReadEvents {} {
        $self _TR_ call "prepareChannelForReadEvents"
        fconfigure [$self cget -channel] \
            -translation binary \
            -encoding "" \
            -blocking 0 -buffering none
    }

    #--------------------------------------------------------------------------
    #
    #--------------------------------------------------------------------------
}

namespace eval ${_AC_}::Core::XPS {
    variable _ns; set _ns [namespace current]

    variable BasicTypes; set BasicTypes {
        int8
        int16
        int64
        int32
        int64
        bool
        double
        string
        octets
    }
    proc IsBasicType {type} {
      variable BasicTypes; expr {[lsearch -exact $BasicTypes $type]==-1?0:1}
    }
    proc IsUserDefinedType {type} {
        expr {[string first "." $type]!=-1}
    }

    #--------------------------------------------------------------------------
    # utils for octet data type processing
    #--------------------------------------------------------------------------

    # Make 'string map' style maps to do octet encode/decode conversion with.
    proc _mk_octet_maps {enc_charMapN dec_charMapN} {
        upvar $enc_charMapN enc_charMap
        upvar $dec_charMapN dec_charMap
        #generate a character map for displaying hex equiv of chars [0..256]
        for {set i 0} {$i < 256} {incr i} {
            append enc_charMap [format " \\%03o {%02x}" $i $i]
            lappend dec_charMap [format "%02x" $i] [subst "\\x[format %x $i]"]
        }
    }
    # install the maps in this namespace
    variable _OCTET_ENC; variable _OCTET_DEC; _mk_octet_maps \
        [namespace current]::_OCTET_ENC [namespace current]::_OCTET_DEC
    # handy (for unit tests if nothing else.)
    proc OctetsEnc {data} {variable _OCTET_ENC; string map $_OCTET_ENC $data}
    proc OctetsDec {data} {variable _OCTET_DEC; string map $_OCTET_DEC $data}
    #--------------------------------------------------------------------------
    proc XEntitiesEnc {text {attr 0}} {
       if {$attr} {
         return [string map {& &amp; < &lt; > &gt; \' &apos; \" &quot;} $text]
       } else {
         return [string map {& &amp; < &lt; > &gt;} $text]
       }
    }
    proc XEntitiesDec {text {attr 0}} {
       if {$attr} {
         return [string map {&amp; & &lt; < &gt; > &apos; \' &quot; \"} $text]
       } else {
         return [string map {&amp; & &lt; < &gt; >} $text]
       }
    }

    # Generate an XML element indented the specified number of spaces.
    # Paramters:
    # name    - the name of the element to be generated.
    # attribs - a list of name value name value ... to be output as
    #           attributes of the element.  They should not be pre-mapped
    #           into XML entities, since this will be handled for you.
    # content - the body of the element (i.e., what is to be inserted
    #           in between the start and end tags, if anything).  Generally
    #           this would be either the result of earlier calls to XMLElement
    #           to generate deeper structures, the result of calling
    #           XMLEntities on a piece of text data.
    #
    proc XElem {indent name attribs {content ""} {resN ""}} {
     if {$resN != ""} {upvar 1 $resN res}
     append res "<$name"
     foreach {a v} $attribs {
         append res " $a=\"[XEntitiesEnc $v 1]\""
     }
     if {$content != ""} {
        append res ">$content</$name>"
     } else {
         append res "/>"
     }
     #if {$resN == ""} {return} else {return $res}
     if {$resN != ""} {return} else {return $res}
    }

    proc _enc_ {i_type i_val} {
        if [IsBasicType $i_type] {
            return [_enc_$i_type $i_val]
        } 
        set otype [string map {"." "::"} $i_type] 
        return [${::_AC_}::${otype} _enc_ $i_val]
    }


    #-------------------------------------------------------------------------
    # _enc_XXX
    #-------------------------------------------------------------------------
    proc _enc_x {i_type i_val} { set i_val }
    # alias all procs that blindly stuff the value into the 
    # text of the element node to the private internal proc '_addarg'
    # which does this generic work for us
    foreach {new_cmd type} {
        _enc_int8 int8 
        _enc_int16 int16
        _enc_int32 int32
        _enc_int64 int64
        _enc_double double
    } {
        interp alias {} ${_ns}::${new_cmd} {} ${_ns}::_enc_x $type
    }
    # normalize the various truth values 
    # (like "true","false", etc..) to zero or 1
    proc _enc_bool {i_val} {
      if {[string is boolean -strict $i_val]} {
          return [expr $i_val ?1 :0]
      } 
      return $i_val
    }
    # encode certain char entities
    proc _enc_string {i_val} {
      string trim [XEntitiesEnc $i_val]
    }
    # for octets we need to data to octet string
    proc _enc_octets {i_val} {
      ::base64::encode -maxlen 0 $i_val
    }

    proc _enc_UdtEnum {specN i_value} { 
        upvar 1 $specN spec
        if {[string is integer -strict] && \
            [lsearch -exact [array get spec]]>-1} {
            return $i_value
        }
        if {[info exists spec($i_value)]} {
            return $spec($i_value)
        } else {
            return -code error [list "Aptixia.Client.IllegalValue" \
            "'$i_value' should be one of the following: '[array names spec]' "]
        }
    }

    proc _dec_UdtEnum {i_context i_type i_lnode i_varN} {
        # note: i_lnode is of form {#text NNN}
        upvar 1 $i_varN v;
        set wireval [string trim [lindex [lindex $i_lnode 0] 1]]
        set otype [string map {"." "::"} $i_type] 
        set v [${::_AC_}::${otype} create %AUTO%]
        $v _decset_ $wireval
    }

    #-------------------------------------------------------------------------
    proc _dec_ {i_context i_type i_lnode i_valN} {
        variable BasicTypes; upvar 1 $i_valN v;  
        if {[lsearch -exact $BasicTypes $i_type]!=-1} {
            foreach {x v} [set n [lindex $i_lnode 0]] {break}
            GetArg_$i_type $n v
        } else {
            # not a basic type use type method to decode 'lnode'
            set otype [string map { "." "::" } $i_type]
            ${::_AC_}::${otype} _dec_ $i_context $i_type $i_lnode v
        }
    }

    # returns true if type i_type could be extracted from i_lnode into i_valN
    proc DecodeLnode {i_type i_lnode i_valN} {
        variable BasicTypes
        if {[lsearch -exact $BasicTypes $i_type]==-1} {return 0}
        upvar 1 $i_valN v;  
        GetArg_$i_type $i_lnode v
        return 1
    }

    #-------------------------------------------------------------------------
    # GetArg_XXX
    #-------------------------------------------------------------------------

    # _t --
    # Args: (e)lement var(n)ame (u)plevel
    # Desctiption: 
    # Private helper proc for GetXXXArg Calls). Get text out of element '$e'
    # and stuff in variable name '$n' up '$u' levels
    proc _t {e n {u 2}} {
        upvar $u $n v; set v [string trim [lindex $e 1]]
    }

    proc _getarg {i_elem i_valN} { _t $i_elem $i_valN }

    #
    # alias the simple class of "get the text from the element and" stuff it
    # into the var
    #
    foreach {new_cmd} {
        GetArg_int8 GetArg_int16 GetArg_int32 GetArg_int64
        GetArg_double
    } {
        interp alias {} ${_ns}::${new_cmd} {} ${_ns}::_getarg
    }
    proc GetArg_bool {i_elem i_valN} { 
        upvar 1 $i_valN v; set v [string trim [string tolower $v]]
    }
    proc GetArg_string {i_elem i_valN} { 
        upvar 1 $i_valN v; set v [XEntitiesDec [lindex $i_elem 1]]
    }
    proc GetArg_octets {i_elem i_valN} { 
        variable _OCTET_DEC; upvar 1 $i_valN v;
        _t $i_elem v 1
        #set v [string map $_OCTET_DEC v] 
        set v [::base64::decode $v]
    }
}

snit::type ${_AC_}::Core::XmlWriter {
    variable _out;
    variable _indent 0;
    variable _elemstack {};

    option -transactioncontext -default ""
    option -objectid -default -1

    constructor {args} {
        $self configurelist $args
        $self Clear
    }

    method Clear {} {
        set _out ""
        set _indent 0
    }
    method GetOutput {} {
        return $_out
    }
    method OutputVariable {} {
        return [myvar _out]
    }

    #----------------------------------------------------------------------
    # Output methods
    #----------------------------------------------------------------------
    typevariable XPS ::AptixiaClient::Core::XPS
    method BeginElemAndAttrs {name attribs} {
        append _out [format "%*s<%s" $_indent "" $name]
        foreach {a v} $attribs {
            append _out " $a=\"[${XPS}::XEntitiesEnc $v 1]\""
        }         
        lappend _elemstack [list name $name]
        append _out ">"
    }
    method EndElement {} {
        array set e [lindex $_elemstack end]
        set _elemstack [lreplace $_elemstack end end]; # pop stack
        append _out "</$e(name)>"
    }
    method Element {name attribs content} {
        ${XPS}::XElem $_indent $name $attribs $content _out
    }
    method RawData {d} {
        append _out $d
    }

}

snit::type ${_AC_}::Core::XProtocolRequest {
    typevariable XPS ::AptixiaClient::Core::XPS
    typevariable ms_requestId 1000;
    component m_XmlWriter -public XmlWriter
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------

    option -transactioncontext -default ""
    option -requestid -default ""

    #
    # signature for the method call associated w/ this request
    #
    option -callsignature -default ""
    option -requestor -default ""

    # command to call back when return block arrives
    option -command -default ""
    option -returntags -default 0
    # whatever the client feels like stashing
    # event use this to install the recurring command after the register
    # reply has come back
    option -clientdata -default ""

    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    constructor {args} {
        $self configure -callsignature [from args -callsignature ""]
        $self configure -requestor [from args -requestor ""]
        $self configure -command [from args -command ""]
        $self configure -clientdata [from args -clientdata ""]
        $self configure -returntags [from args -returntags 0]
        $self configure -requestid [from args -requestid ""]

        if {[$self cget -requestid] == ""} {
            $self configure -requestid [incr ms_requestId]
        }

        set cmd [list ${::_AC_}::Core::XmlWriter %AUTO%]
        set cmd [concat $cmd $args]
        if {[catch $cmd res]} {
            puts stderr ERROR:$res
        }

        set m_XmlWriter $res
    }
    destructor {
        if {[string length $m_XmlWriter]} { $m_XmlWriter destroy }
    }
    method exception {id args} {
        puts stderr "$id: $args"
        return -code error [list $id $args]
    }

    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    typemethod Factory {args} {
      ${::_AC_}::Core::XProtocolRequest create %AUTO%
    }
    method GetMessage {} {
        $self XmlWriter GetOutput
    }
    method BeginRequest {{i_command "object-request"}} {
        set oid [$options(-requestor) cget -objectid]
        $m_XmlWriter Clear
        $m_XmlWriter BeginElemAndAttrs $i_command [list \
            "request-id" $options(-requestid) \
            "address" "ts/$oid" \
        ]
    }
    method EndRequest {} {
        $m_XmlWriter EndElement
    }
    method AddMethod {i_name} {
        $m_XmlWriter Element "method" {} $i_name
    }
    method AddEvent {i_name} {
        $m_XmlWriter Element "event" {} $i_name
    }
    proc _argattrs {t d} {
        lappend l type $t
        if {$d!="in"} {lappend l direction $d}
        return $l
    }
    method AddArg {i_type i_dir i_val} {
        if {$i_dir=="out"} {
            set v ""
        } else {
            set v [${XPS}::_enc_ $i_type $i_val]
        }
        $m_XmlWriter Element "argument" [_argattrs $i_type $i_dir] $v
        return
    }

    foreach {m cmd} {
        BeginEventRegistrationRequest   "event-request"
        BeginEventDeRegistrationRequest "event-cancellation"
    } {
        method $m {} [list BeginRequest $cmd]
    }

    # assign to variables listed in vars the values listed in vals
    # (in the caller's context)
    #proc _lassign {vars vals} {uplevel 1 [list foreach $vars $vals {break}]}
    proc _lassign {vars vals} {
        foreach __n $vars __v $vals {upvar 1 $__n $__n; set $__n $__v}  
    }

    #----------------------------------------------------------------------
    # 
    #----------------------------------------------------------------------
    method InstallExceptionBlock {data} {
        set command $options(-command)
        set returntags $options(-returntags)
        set condition "error"
        set retvalues $data
        set cmd [concat $options(-command) $condition $retvalues]
        eval $cmd
    }
    method InstallFatalError {args} {
        set condition "error"
        # TODO FIXME
        # need to craft proper exception block
        set cmd [concat $options(-command) \
            $condition "Aptixia.Client.InternalError:" $args]
        puts stderr "\n\n================= FATALCMD==================\n$cmd\n\n"
        eval $cmd
    }

    method InstallReturnBlock {data} {
        set command $options(-command)
        set returntags $options(-returntags)

        set nameX 1; set typeX 3; set dirX 5;

        # data is of form { elemname {attrlist} {{childnode} ...} }
        set eid "Aptixia.Client.ProcotolError"

        # calc max index w/ respect to return items
        set rx -1 
        set sig {}
        foreach {x} $options(-callsignature) {
            set dir [lindex $x $dirX]
            if {[lsearch -exact {"out" "inout"} [lindex $x $dirX]]!=-1} {
                incr rx; lappend sig $x
            }
        }

        set x 0; set tvlist {}
        set retvalues {}
        foreach {e} $data {
            _lassign {ename attrs nodes} $e
            ## ignore any non <retval> items
            if {$ename != "retval"} { continue }

            if {$x>$rx} {
                $self exception $eid \
                "$x > max=$rx. Too many items in reply data '$data'"
            }

            set selem [lindex $sig $x]

            ## {attrlist} should only exactly {type "xxx"}
            if {[llength $attrs] != 2} {
                $self exception $eid \
                    "Malformed object-request return attributes '$data'"
            }
            set type [lindex $attrs 1]
            set sname [lindex $selem $nameX]

            ##
            ## cross check type against signature type
            ##
            if {[set stype [lindex $selem $typeX]] != $type} {
                if {![${XPS}::IsBasicType $type] && \
                    ![${XPS}::IsUserDefinedType $type]} {
                    #
                    # TODO just let it go through
                    # need to be more stringent & check base etc...
                    #
                } else {

                    $self exception $eid \
    "Type mismatch. Supplied type $type != required type $stype for item $x '$sname' in reply data '$data'"

                }
            }

            set context $options(-transactioncontext)

            ${XPS}::_dec_ $context $type $nodes v

            if {$returntags} {
                lappend retvalues $sname $v
            } else {
                lappend retvalues $v
            }
            incr x; # on to next <retval>
        }

        set condition "ok"
        set cmd [concat $options(-command) $condition $retvalues]

        eval $cmd
        return
    }
}

snit::type ${_AC_}::Core::TransactionContext {
    #----------------------------------------------------------------------
    # Variables
    #----------------------------------------------------------------------

    #
    # Associative Array containing pending (queued) requests 
    # Key = request id
    # Value = associated Core::XProtocolRequest Object
    #
    variable m_PendingRequests; 

    #----------------------------------------------------------------------
    # Components
    #----------------------------------------------------------------------

    #
    # Underlying (socket) i/o object
    #
    component c_ClientSocket -public ClientSocket -inherit true

    #----------------------------------------------------------------------
    # Options
    #----------------------------------------------------------------------

    #
    # If true all calls are made sychronous
    #
    option -synchronous -default 0 -readonly 1 

    #----------------------------------------------------------------------
    # Constructor/Destructor related items
    #----------------------------------------------------------------------

    constructor {args} {
      set c_ClientSocket \
        [eval [concat [list ${::_AC_}::Core::ClientSocket create %AUTO%] $args]]

      $c_ClientSocket configure -framecommand [mymethod frame_Handler]
      array set m_PendingRequests {}
    }
    destructor {
        $c_ClientSocket destroy
    }

    #----------------------------------------------------------------------
    # Methods
    #----------------------------------------------------------------------

    # Return value:
    #   of the form: {tag attributes {children ..}}
    #
    typemethod xml2list {xml} {
     regsub -all {>\s*<} [string trim $xml " \n\t<>"] "\} \{" xml
     set xml [string map {> "\} \{#text \{" < "\}\} \{"}  $xml]


     set res ""   ;# string to collect the result
     set stack {} ;# track open tags
     set rest {}
     foreach item "{$xml}" {
         switch -regexp -- $item {
            ^# {append res "{[lrange $item 0 end]} " ; #text item}
            ^/ {
                regexp {/(.+)} $item -> tagname ;# end tag
                set expected [lindex $stack end]
                if {$tagname!=$expected} {
                    return -code error "unexpecteditem:$item != $expected"
                }
                set stack [lrange $stack 0 end-1]
                append res "\}\} "
            }
            /$ { # singleton - start and end in one <> group
               regexp {([^ ]+)((.+))?/$} $item -> tagname - rest
               set rest [lrange [string map {= " "} $rest] 0 end]
               append res "{$tagname [list $rest] {}} "
            }
            default {
               set tagname [lindex $item 0] ;# start tag
               set rest [lrange [string map {= " "} $item] 1 end]
               lappend stack $tagname
               append res "\{$tagname [list $rest] \{"
            }
         }
         if {[llength $rest]%2} {
             return -code error "unpairedattributes:$rest"
         }
     }
     if [llength $stack] {return -code error "unresolved:$stack"}
     string map {"\} \}" "\}\}"} [lindex $res 0]
    }

    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    method frame_Handler {dataN} {
        upvar 1 $dataN data
        # note: lindex 2 skips root tag/attrs
        set nlist [lindex [$type xml2list <F>$data</F>] 2]
        foreach {n} $nlist {
            set op [lindex $n 0]
            if {$op=="#text"} {
                # a text node, ignore it
            } else {
                $self ${op}_Handler n
            }
        }
    }

    typemethod reqGetAttrs {dataN attrsN} {
        # data is of form {elemname attrlist {children}}
        upvar 1 $dataN data $attrsN a
        set a(request-id) -1
        array set a [lindex $data 1]
        if {[set rid $a(request-id)] < 0} {
          return -code error "request-id '$rid' is missing in '$data'"
        }
    }

    method reqFind {rid} {
      if {![info exists m_PendingRequests($rid)]} {
        return -code error \
        "request-id $rid does not exist in context: '[array names m_PendingRequests]'"
      }
      set rval $m_PendingRequests($rid)
      return $rval
    }

    method reqDequeue {rid} {
      if {![info exists m_PendingRequests($rid)]} {
        return -code error \
        "request-id $rid does not exist in context: '[array names m_PendingRequests]'"
      }
      set rval $m_PendingRequests($rid)
      unset m_PendingRequests($rid)
      return $rval
    }

    method reqDelete {rid} {
        set rObj [$self reqDequeue $rid]
        $rObj destroy
    }

    method object-failure_Handler {dataN} {
        upvar 1 $dataN data
        $type reqGetAttrs data a
        set rObj [$self reqDequeue $a(request-id)]
        set failed [catch {
            $rObj InstallExceptionBlock [lindex $data 2]
        } err]
        set ei $::errorInfo
        $rObj destroy
        if {$failed} {
            return -code error -errorinfo $ei $err
        }
    }


    method object-response_Handler {dataN} {
        # data is of form {elemname attrlist {children}}
        upvar 1 $dataN data
        $type reqGetAttrs data a
        set rObj [$self reqDequeue $a(request-id)]
        set failed [catch {
            $rObj InstallReturnBlock [lindex $data 2]
        } err]
        set ei $::errorInfo
        if {$failed} {
            catch {$rObj InstallFatalError $err $ei}
        }
        $rObj destroy
        if {$failed} {
            return -code error -errorinfo $ei $err
        }
    }

    method event-failure_Handler {dataN} {
        upvar 1 $dataN data
        $self _TR_ call "event-failure-resp_Handler $data"
        $type reqGetAttrs data a
        set rObj [$self reqDequeue $a(request-id)]

        set result_block [lindex $data 2]

        ::AptixiaClient::Core::Facility XProtocolErrorParse \
            [concat error $result_block] \
            o_code o_errorcode o_errorinfo o_data

        set failed [catch {
            if {[lindex $o_errorcode 0] == "Aptixia.Cancel"} {
                $self _TR_ call "event-failure-resp_Handler response to cancel"
                # this is a "OK" response to a event cancel
                # go figure..
                $rObj InstallReturnBlock {ok}
            } else {
                $rObj InstallExceptionBlock $result_block
            }
        } err]

        set ei $::errorInfo
        $rObj destroy
        if {$failed} {
            return -code error -errorinfo $ei $err
        }
    }

    method event-preliminary-resp_Handler {dataN} {
        set nm "preliminary-resp_Handler"
        # data is of form {elemname attrlist {children}}
        upvar 1 $dataN data
        $self _TR_ call "$nm $data"

        $type reqGetAttrs data a

        set rObj [$self reqFind $a(request-id)]
        set clientdata [$rObj cget -clientdata]
        set tag [lindex $clientdata 0]
        set clientcommand [lindex $clientdata 1]

        if {$tag == "request"} {
            set failed [catch {
                $rObj InstallReturnBlock [lindex $data 2]
                # install the recurring command which is stashed in -clientdata
                $rObj configure -command $clientcommand
            } err]
            set ei $::errorInfo
            if {$failed} {
                $self reqDelete $a(request-id)
                catch {$rObj InstallFatalError $err $ei}
            }
            if {$failed} {
                return -code error -errorinfo $ei $err
            }
        } else {
          puts stderr "$type: $nm: Encountered Unknown response case for '$op'"
        }
    }


    method Init {host port} {
        $self ClientSocket Connect -host $host -port $port
        $self enableReadEvents
    }

    method _DumpRequests {pre} {
        puts stderr "$pre { [array get m_PendingRequests] } "
    }

    method QueueRequest {i_context i_request} {
        $self Flush
        set rid [$i_request cget -requestid]
        $i_request configure -transactioncontext $i_context
        if {[info exists m_PendingRequests($rid)]} {
            return -code error "duplicate request rid '$rid'"
        }
        set m_PendingRequests($rid) $i_request
        $self SendMessage [$i_request GetMessage]
        if {$options(-synchronous)} {
            $self Sync
        }
    }

    method Flush {} {
    }

    method SendMessage {i_msg} {
        set _DELIM \x00
        $c_ClientSocket ScheduleWrite "$i_msg$_DELIM"
    }

    method Sync {} {
        while {1} {
                vwait
        }
    }
}
