##
##
##
package require snit 1.0; # older snits probably won't work
package require base64
package provide AptixiaClient 2.0

set _AC_ ::AptixiaClient; namespace eval ${_AC_} {}

snit::type ${_AC_}::Core::Facility::Util {


    typemethod DodToPortGroup {portGroup fileName} { 
        set bufSize 10240
        set xName [file tail $fileName]; # name for remote side

        set cmd open
        set f [open $fileName "r"]
        set failed [catch {
            set ::errorInfo ""
            fconfigure $f -translation binary
            set xTimeOut 5000
            set cmd DodBeginDownLoad
            set xSessionId [lindex \
                [$portGroup $cmd $xName $xTimeOut] 0]
            set cmd DodUpLoadFileSegment
            while {1} {
                set segment [read $f $bufSize]
                if [eof $f] {
                    break
                }
                $portGroup $cmd $xSessionId $segment
            }
            set cmd DodEndDownLoad
            $portGroup $cmd $xSessionId
        } err]
        set ei $::errorInfo
        close $f;
        if {$failed} {
            return -code error "portGroup $cmd: $err" -errorinfo $ei
        }
        return ""
    }

}

snit::type ${_AC_}::Core::DeprecationHandler {

    variable m_Command "";
    # "::AptixiaClient::Core::DeprecationHandler::IssueWarning"

    method Set {command} {
        set m_Command $command
    }
    #
    # For Internal use by this package.
    #
    method _Invoke {args} {
        if {$m_Command != ""} {
            eval [concat $m_Command $args]
        }
    }
    #
    # Built in handlers
    #
    proc _deprecationMessage {prefix argv} {
        set type [lindex $argv 0]
        set rval "$prefix: obsolete $type"

        if {$type == "property"} {
            array set info $argv 
            array set odata $info(obsoletedata)
            append rval " '$info(property)' ( $info(method) method ): $odata(message)"
        } elseif {$type == "object"} {
            array set info $argv 
            array set odata $info(obsoletedata)
            set o_name [$info(object) cget -name]
            append rval " $o_name ( $info(method) method ): $odata(message)"
        } else {
            append rval " -- " [lrange $argv 1 end]
        }

        return $rval
    }
    proc IssueWarning {argv} {
        puts stderr [_deprecationMessage "Warning" $argv]
    }
    proc IssueError {argv} {
        return -code error [_deprecationMessage "Error" $argv]
    }
}


snit::type ${_AC_}::Core::Facility {
    typecomponent tc_DefaultTransactionContext -public DefaultTransactionContext

    typecomponent tc_DeprecationHandler -public DeprecationHandler
    typemethod GetDefaultTransactionContext {} {
        return $tc_DefaultTransactionContext
    }

    proc _etxt {parentelem etag default} {
        if {[llength $parentelem] != 3} {
            return $default
        }
        foreach e [lindex $parentelem 2] {
            if {[string equal $etag [lindex $e 0]]} {
                set tn [lindex [lindex $e 2] 0]
                if {[lindex $tn 0] != "#text"} {
                    return $default
                }
                return [lindex $tn 1] 
            }
        }
        return $default
    }

    typemethod XProtocolErrorParse {
        i_errorBlock o_codeN o_errorcodeN o_errorinfoN o_dataN
    } {
        upvar 1 $o_codeN o_code
        upvar 1 $o_errorcodeN o_errorcode
        upvar 1 $o_errorinfoN o_errorinfo
        upvar 1 $o_dataN o_data

        #
        # <basic-result-code> {xml-node-tree-encoded-as-a-tcl-list}
        #
        # {xml-node-tree-encoded-as-a-tcl-list} is of form:
        #
        # {element-name {attribute-list} {childelement-list}}
        # 
        # childelement's that are text nodes are of the form {#text "data"} 
        #
        #
        set parseError 0
        set ec [lindex $i_errorBlock 0]
        if {$ec != "error"} {
          set parseError 1
          append i_errorBlock " -- (unknown/undefined basic error code $ec)"
        } else {
            set ixiastatus [lindex $i_errorBlock 1]
            if {[lindex $ixiastatus 0] != "ixia-status"} {
                set parseError 2
                append i_errorBlock " -- (ixia-status not found)"
            } elseif {[set id [_etxt $ixiastatus id "?"]] == "?"} {
                set parseError 3
                append i_errorBlock " -- (ixia-status/id not found)"
            } elseif {[set text [_etxt $ixiastatus text "?"]] == "?"} {
                set parseError 4
                append i_errorBlock "-- (ixia-status/text not found)"
            } 
            
            # missing trace is allowed
            if {!$parseError} {
                if {[set trace [_etxt $ixiastatus trace "?"]] == "?"} {
                    set trace "Server trace info unavailable"
                }
            }
        }
        if {$parseError} {
          set o_code error
          set o_errorcode [list AptixiaClient.UnknownServerError $i_errorBlock]
          set o_errorinfo ""
          set o_data $o_errorcode
        } else {
          set hr "===========================================================\n"
          set o_code error
          set o_errorcode [list $id $text]
          set o_errorinfo "$o_errorcode\n\n"
          append o_errorinfo \
      "AptixiaTestServer Trace:\n${hr}${trace}\n${hr}\nAptixiaClient Trace: "
          set o_data $o_errorcode
        }
        return
    }

    typemethod XProtocolErrorHandler {i_errorBlock} {
        $type XProtocolErrorParse $i_errorBlock \
            o_code o_errorcode o_errorinfo o_data
        return -code $o_code -errorcode $o_errorcode -errorinfo $o_errorinfo \
            $o_data
    }

    #
    # internal housekeeping variables. they are all housed in _package.
    #
    typevariable _Package -array {
        location ""
        initialized 0
    }

    typeconstructor {
        if {$_Package(initialized) != 0} {
            return;
        }
        set _Package(location) [file normalize [info script]]
        set _Package(initialized) 1
        set tc_DefaultTransactionContext \
            [${::_AC_}::Core::TransactionContext %AUTO%]
        set tc_DeprecationHandler \
            [${::_AC_}::Core::DeprecationHandler %AUTO%]
        return ""
    }

    typemethod Attribute {attrname} {
        set attrname [string trimleft $attrname "-"]
        return $_Package($attrname)
    }
    typemethod LogWrite {msg} {
        puts stderr $msg
    }
}

snit::type ${_AC_}::Core::UdtList {
    typevariable XPS ::AptixiaClient::Core::XPS
    typevariable AC ::AptixiaClient
    option -itemtype -default "" -readonly 1
    option -parent -default "" -readonly 1
    variable m_Data {}

    # TODO: to value checking here...
    proc _ckval {i_value} { return $i_value }

    method Set {i_index i_value} {
        lset m_Data $i_index [_ckval $i_value]
    }
    method Append {i_value} {
        lappend m_Data [_ckval $i_value]
    }
    method Get {idx} {
        return [lindex $m_Data $idx]
    }
    method Data {} {
        return $m_Data
    }
    typemethod _enc_ {i_val} {
        # i_val is struct instance
        set t [$i_val cget -itemtype]
        set v ""
        foreach {d} [$i_val Data] {
            set ee [${XPS}::_enc_ $t $d]
            append v [${XPS}::XElem 0 "item" [list "type" $t] $ee v] "\n"
        }
        return $v
    }

    typemethod _dec_ {i_context i_type i_elems i_varN} {
        upvar 1 $i_varN v
        set otype [string map {"." "::"} $i_type]
        set v [${AC}::${otype} create %AUTO% \
            -transactioncontext $i_context]
        foreach e $i_elems {
            foreach {name attrs childnodes} $e {break}; #lassign
            if {$name != "item"} { continue }
            array set m $attrs; # load member attrs to m(type)
            set vv ""; ${XPS}::_dec_ $i_context $m(type) $childnodes vv; 
            $v Append $vv
        }
        # stuff is in v...
    }
}
snit::type ${_AC_}::Core::UdtStruct {
    option -spec -default "" -readonly 1
    option -version -default 0 -readonly 1
    option -parent -default "" -readonly 1
    variable m_Data -array {}
    variable m_Types {}
    variable m_Names {}
    typevariable XPS ::AptixiaClient::Core::XPS
    typevariable AC ::AptixiaClient

    constructor {args} {
        set spec [from args -spec {}]
        $self configurelist $args
        # cvt spec into m_Names,m_Types,m_Data
        foreach {n stype default} $spec {
            lappend m_Types $stype
            lappend m_Names $n
            if {[${XPS}::IsBasicType $stype]} {
                set m_Data($n) $default
            } else {
                set t [string map {"." "::"} $stype]
                set m_Data($n) [${::_AC_}::${t} create %AUTO%]
            }
        }
    }
    destructor {
        foreach {n} $m_Names {t} $m_Types {
            if {[${XPS}::IsBasicType $t]} {
                # simple type, do nothing
            } else {
                if {[string length $m_Data($n)]} { $m_Data($n) destroy }
            }
        }
    }

    typemethod exception {id args} {
        if {[string length $id] == 0} { set id "Aptixia.Client.Error" }
        return -code error [list $id $args"]
    }

    typemethod _enc_ {i_val} {
        # i_val is struct instance
        set v ""
        foreach {n d} [$i_val _data] {t} [$i_val Types] {
            # TODO ?? OPTIONDASH ??
            ####set attrs [list "type" $t "name" [string range $n 1 end]]
            set attrs [list "type" $t "name" $n]
            set data [${XPS}::_enc_ $t $d]
            ${XPS}::XElem 0 "member" $attrs $data v
            append v "\n"
        }
        return $v
    }

    typemethod _dec_ {i_context i_type i_elems i_varN} {
        upvar 1 $i_varN v
        set otype [string map {"." "::"} $i_type]
        set v [${AC}::${otype} create %AUTO% \
            -transactioncontext $i_context]

        foreach e $i_elems {
            foreach {name attrs childnodes} $e {break}; #lassign
            if {$name != "member"} { continue }
            array set m $attrs; # load member attrs to get m(name) & m(type)
            set vv ""; ${XPS}::_dec_ $i_context $m(type) $childnodes vv; 
            # TODO ??? OPTION DASH ??
            ####$v Set -$m(name) $vv
            $v Set $m(name) $vv
        }
    }

    method _dcall {n args} {
        eval [linsert $args 0 $m_Data($n)]
    }

    method _data {} {
        set r {}
        foreach {n} $m_Names { 
            lappend r $n $m_Data($n) 
        }
        return $r
    }
    method Types {} { return $m_Types }
    method Names {} { return $m_Names }
    method Data {} { array get m_Data }

    method Set {args} {
        foreach {n v} $args {
            if {[lsearch $m_Names $n]==-1} {
              $type exception "Aptixia.Client.ElementDoesNotExist" \
                $n "should be one of '[array names m_Types]'"
            }
            set m_Data($n) $v
        }
    }
    method Get {n} {
        if {![lsearch $m_Names $n]==-1} {
          $type exception "Aptixia.Client.ElementDoesNotExist" \
            $n "should be one of '$m_Names]'"
        }
        return $m_Data($n)
    }
    method GetV {args} {
        set rval {}
        foreach n $args {
            if {![lsearch $m_Names $n]==-1} {
              $type exception "Aptixia.Client.ElementDoesNotExist" \
                $n "should be one of '$m_Names]'"
            }
            lappend rval $m_Data($n)
        }
        return $rval
    }
}


snit::type ${_AC_}::Core::ClientObjectBase {
    option -version 0.0
    option -tracelevel 2000
    option -traceincludeargs 1
    option -name ""

    option -transactioncontext -default "" -readonly 1
    option -objectid -default "-1" -readonly 1
    option -parent -default "" -readonly 1
    option -obsolete -default "" -readonly 1

    component m_transactionContext
    constructor {args} {
        $self configurelist $args
        if {[string length [$self cget -transactioncontext]] == 0} {
            $self configure -transactioncontext \
                [${::_AC_}::Core::Facility GetDefaultTransactionContext]
        }
        if {0} {
            if {$options(-parent) == ""} {
                    $type exception "Aptixia.Client.Error" \
                    "$type: -parent required for construction"
            }
        }
        set m_transactionContext [$self cget -transactioncontext]
    }


    destructor {
        #-#$self MTrace 1000 ""
        # Note: we don't own the transaction context. so don't destroy it.
    }

    typemethod _Characterize {i_target i_classification i_name} {
        if {$i_classification != "PropertyNode"} {
            $i_target exception "Aptixia.Client.InCorrectType" \
            "'$i_type' ($i_classification) is not Castable"
        }
        # kill off existing component
        $i_target _dtor_${i_name}

        # re-make it with new type
        set r [$i_target _PropertyNodeCharacterizationData $i_name]
        set o_type [lindex $r 0]
        set o_oid [lindex $r 1]
        $i_target _ctor_${i_name} -objectid $o_oid -itemtype $o_type
    }

    typemethod _Bind {i_target i_classification i_name i_srcobj} {
        if {$i_classification != "PropertyNode"} {
            $i_target exception "Aptixia.Client.InCorrectType" \
            "'$i_type' ($i_classification) is not Bindable"
        }

        # kill off existing component
        $i_target _dtor_${i_name}

        # get objectid from source object
        set oid [$i_srcobj cget -objectid]
        #set otype [$i_srcobj cget -itemtype]
        set otype [lindex [$i_target _PropertyNodeBind $i_name $oid] 0]

        $i_target _ctor_${i_name} -objectid $oid -itemtype $otype
        return
    }

    typemethod _Instantiate {i_target i_classification i_name i_type} {
        if {$i_classification != "PropertyNode"} {
            $i_target exception "Aptixia.Client.InCorrectType" \
            "'$i_type' ($i_classification) is not Instantiateable"
        }
        # kill off existing component
        $i_target _dtor_${i_name}

        ##puts stderr ">>>>>>>>>>type=$i_type name=$i_name"
        ##${::_AC_}::$i_type create %AUTO% -objectid $oid -transactioncontext 
        ##$i_target _ctor_${i_name} -objectid $oid -itemtype $i_type

        # make the new one
        set oid [lindex [$i_target _PropertyNodeInstantiate $i_name $i_type] 0]
        # reconstitute client side object
        $i_target _ctor_${i_name} -objectid $oid -itemtype $i_type
        return
    }

    method _GetObjectId {} {
        $self cget -objectid
    }

    method MTrace {level msg} {
        if {$level >= [$self cget -tracelevel]} {
            if {[$self cget -traceincludeargs]} {
                set m ">>[uplevel 1 {info level 0}]>> $msg"
            } else {
                set m ">>[lindex [uplevel 1 {info level 0}] 0]>> $msg"
            }
            ${::_AC_}::Core::Facility LogWrite $m
        }
    }

    typemethod exception {id args} {
        if {[string length $id] == 0} { set id "Aptixia.Client.Error" }
        return -code error [list $id $args"]
    }

    variable _mResultBlock [list UNDEFINED -1 {}]
    method _setResultBlockCommand {varname args} {
        set $varname $args
        return
    }

    variable _myIdRes [list UNDEFINED -1 {}]
    method _myId {i_propertyName} {
        set _myIdRes [list UNDEFINED -1 {}]
        set command [concat [mymethod _setResultBlockCommand] [myvar _myIdRes]]
        set sig {
            {name name type string direction in}
            {name id type int64 direction out}
        }
        set av [list -command $command $i_propertyName]
        $self _mCall $self $sig _GetPropertyObjectId av
        set oid $_myIdRes 
        set _myIdRes [list UNDEFINED -1 {}]
        return $oid
    }


    # hack to get at _SIG_XXX vars in XProtocolObject
    proc _mProp_GetSig {mN} {
        ${::_AC_}::XProtocolObject _Get_SIG $mN
    }

    # example usage: _mProp $self stringVar $_propertyTypes(stringVar) $args

    method _mProp {target pname ptype av {obsoleteData {}}} {
        set op [lindex $av 0]
        if {[llength $obsoleteData]} { 
            ::AptixiaClient::Core::Facility DeprecationHandler _Invoke \
            [list property $pname object $target method $op obsoletedata $obsoleteData]
            set obsoleteCheck 0
        } else {
            set obsoleteCheck 1
        }

        switch -exact -- $op Get {
            if {[llength $av] != 1} {
              $target exception "Aptixia.Client.Error" "wrong number of args"
            }
            set mN _${ptype}Get
            set sig [_mProp_GetSig $mN]
            set av [list $pname] 
            return [lindex \
                [$target _mCall $target $sig $mN av $obsoleteCheck] 0]

        } Set {
            set av [lrange $av 1 end]
            if {[llength $av] != 1} {
              $target exception "Aptixia.Client.Error" "wrong number of args"
            }
            set mN _${ptype}Set
            set sig [_mProp_GetSig $mN]
            set av [list $pname [lindex $av 0]]
            $target _mCall $target $sig $mN av $obsoleteCheck
            return
                
        } default {
            $target exception \
              "Aptixia.Client.Error" \
              "$pname: unknown subcommand '$op' must be 'Get' or 'Set'"
        }
    }

    method Configure {args} {
        if {[llength $args]%2 != 0} {
            $type exception "Aptixia.Client.WrongNumberOfArgs"  \
                "Configure" \
                "Arguments should be of form: name val name val..."
        }
        foreach {t v} $args {
            $options(-parent) $t Set $v
        }
    }

    typemethod _RecurringEventHandler {signature command args} {
        #
        # 'args' has the format:
        #       {"error|ok" eventarg0 eventarg1 .... eventargN}
        #
        set userargs [lrange $args 1 end]
        set cmd [concat $command $userargs]
        set err ""
        set failed [catch $cmd err]
        set ei $::errorInfo
        foreach {s} $signature {v} $userargs {
            set st [lindex $s 3]; # get type from signature
            if {[::AptixiaClient::Core::XPS::IsUserDefinedType $st]} {
                $v destroy
            }
        }
        if {$failed} {
            puts stderr "\nAptixiaClient: User Event Handler Error: $err\n\n$ei"
        }
    }
            
    typemethod _CancelResponseHandler {signature command args} {
        # Do nothing
    }

    method _eEvent {op target sig avN} {
        upvar 1 $avN av
        set command [from av -command {}] 
        set returntags [from av -returntags 0] 
        set tc $options(-transactioncontext)
        set event [from av -event ""] 
        set requestid [from av -requestid ""] 

        if {($op != "request") && ($op != "cancellation")} {
            error "Illegal operation '$op'"
        }

        if {"$op"=="request"} {
            if {[llength $command] == 0} {
              error "$target: Event $op requires '-command {_command_}' as parameters"
            }
            if {$event == ""} {
              error "$target: Event $op requires '-event _eventtype_' as parameters"
            }
        } elseif {"$op"=="cancellation"} {
            if {$event == ""} {
              error "$target: Event $op requires '-event _eventtype_' as parameters"
            }
            if {$requestid == ""} {
              error "$target: Event $op requires '-requestid _id_' as parameters"
            }
        }

        # wrap the supplied command. this allows us to release/destroy
        # complex event arguments after the call has been made
        if {$op == "request"} {
            set wrappedcommand [list $type _RecurringEventHandler $sig $command]

        } elseif {$op == "cancellation"} {
            #
            # Delete the existing (recurring) request object
            #
            set failed [catch { $tc reqDelete $requestid } err]
            if {$failed} {
                error "Cannot find Event Request id '$requestid'"
            }

            set wrappedcommand [list $type _CancelResponseHandler $sig $command]
        } else {
            error "Illegal operation '$op'"
        }


        set waitVarName [myvar _eventRegisterResult]
        set initialcommand \
            [concat [mymethod _setResultBlockCommand] $waitVarName]

        set oid [$target cget -objectid]
        if {$oid < 0} {
            append  _msg \
                "method call '$mN' " \
                "attempted on an unresolved/un-Instantiated object"
            $type exception "Aptixia.Client.UnresolvedObject" $_msg
        }

        set failed [catch {
            set rObj [${::_AC_}::Core::XProtocolRequest create %AUTO% \
                -requestid $requestid \
                -requestor $target \
                -command $initialcommand \
                -returntags $returntags \
                -clientdata [list $op $wrappedcommand] \
                -callsignature $sig \
                -transactioncontext $tc \
                -objectid $oid \
            ]
            # if requesting, extract auto-genereated request id
            # if cancelling, set the requestid to one supplied by the caller
            set requestid [$rObj cget -requestid]

            $rObj BeginRequest "event-$op"
            $rObj AddEvent $event
            $rObj EndRequest
            $tc QueueRequest $tc $rObj
        } err]


        if {$failed} {
            # clean up rObj object rethrow the error
            set ei $::errorInfo
            catch {$rObj destroy}
            return -code error -errorinfo $ei $err
        }

        set synchronousCall 1
        if {$synchronousCall} {
            set $waitVarName [list UNDEFINED -1 {}]
            vwait $waitVarName
            set block [set $waitVarName]
            set $waitVarName [list UNDEFINED -1 {}]

            # just return the return value portion of the result block
            set condition [lindex $block 0]
            if {$condition == "ok"} {
                # return the requestid which is used for Cancelling
                ###return [lrange $block 1 end]
                return $requestid
            } else {
                # TODO: the raw exception block is probably not the form 
                # we want for the exception data recvd by the user
                ${::_AC_}::Core::Facility XProtocolErrorHandler $block
            }
        }
    }

    method _mCall {target sig mN avN {obsoleteCheck 1}} {

        if {$obsoleteCheck && ([$target cget -obsolete] != "")} {
            ::AptixiaClient::Core::Facility DeprecationHandler _Invoke \
                [list object $target method $mN obsoletedata [$target cget -obsolete]]
        }

        upvar 1 $avN av
        set command [from av -command {}] 
        set returntags [from av -returntags 0] 

        set nameX 1; set typeX 3; set dirX 5

        if {[llength $command]} {
            set synchronousCall 0
        } else {
            set synchronousCall 1
            set command [concat \
            [mymethod _setResultBlockCommand] [myvar _mResultBlock]]
        }

        if {1000 >= [$self cget -tracelevel]} {
            set m ">>$mN"
            if {[$self cget -traceincludeargs]} {append m " $av"}
            ${::_AC_}::Core::Facility LogWrite $m
        }
        set tc $options(-transactioncontext)

        set oid [$target cget -objectid]
        if {$oid < 0} {
            append  _msg \
                "method call '$mN' " \
                "attempted on an unresolved/un-Instantiated object"
            $type exception "Aptixia.Client.UnresolvedObject" $_msg
        }

        set failed [catch {
            set rObj [${::_AC_}::Core::XProtocolRequest create %AUTO% \
                -requestor $target -command $command -returntags $returntags \
                -callsignature $sig \
                -transactioncontext $tc \
                -objectid $oid \
            ]
            $rObj BeginRequest
            $rObj AddMethod $mN

            set ax 0;
            foreach {selem} $sig {
                set dir [lindex $selem $dirX]
                if {$dir == "out"} {
                    set a "--"; # placeholder argument, ignored by AddArg
                } else {
                    set a [lindex $av $ax]
                    incr ax
                }
                #
                # TODO: 
                # do client side validation duties here
                # range checking etc..
                #
                $rObj AddArg [lindex $selem $typeX] $dir $a
            }

            if {$ax != [llength $av]} {
                $type exception "Aptixia.Client.WrongNumberOfArgs"  \
    "[llength $av] args supplied. should be $ax\nsignature='$sig'\nargs='$av'" 
            }

            $rObj EndRequest
            $tc QueueRequest $tc $rObj
        } err]

        if {$failed} {
            # clean up rObj object rethrow the error
            set ei $::errorInfo
            catch {$rObj destroy}
            return -code error -errorinfo $ei $err
        }

        if {$synchronousCall} {
            set _mResultBlock [list UNDEFINED -1 {}]
            vwait [myvar _mResultBlock]
            set block $_mResultBlock
            set _mResultBlock [list UNDEFINED -1 {}]

            # just return the return value portion of the result block
            set condition [lindex $block 0]
            if {$condition == "ok"} {
                return [lrange $block 1 end]
            } else {
                # TODO: the raw exception block is probably not the form 
                # we want for the exception data recvd by the user
                ${::_AC_}::Core::Facility XProtocolErrorHandler $block
            }
        }

        return
    }
}

#
# Base worker component for PropertyListXXX managed data types
# lists that have simple data types as items
#
snit::type ${_AC_}::Core::PropertyListBase {
    component c_Base -inherit true
    option -itemtype -default "" -readonly 1
    option -parent -default "_UNDEFINED_" -readonly 1
    option -name -default "_UNDEFINED_" -readonly 1
    option -obsolete -default "" -readonly 1

    variable m_ptype "_UNDEFINED_"
    proc _sig {mN} { ${::_AC_}::XProtocolObject _Get_SIG $mN }

    constructor {args} {
        set c_Base ""
        set options(-itemtype) [from args -itemtype {}] 
        set options(-parent) [from args -parent "_UNDEFINED_"] 
        set options(-name) [from args -name "_UNDEFINED_"] 
        set options(-obsolete) [from args -obsolete ""]

        set m_ptype "Property$options(-itemtype)List"

        set cmd [list ${::_AC_}::Core::ClientObjectBase %AUTO%]
        set cmd [concat $cmd $args]
        set c_Base [eval $cmd] 
        $self MTrace 1000 "";
    }
    destructor {
        $self MTrace 1000 "";
        if {[string length $c_Base]} {
            $c_Base destroy
        }
    }

    method _call {userMethod internalMethod avN} {
        upvar 1 $avN av
        set obsdata [$self cget -obsolete]
        if {$obsdata != ""} {
            ::AptixiaClient::Core::Facility DeprecationHandler _Invoke [list \
                property $options(-name) \
                object $options(-parent) \
                method $userMethod \
                obsoletedata $obsdata \
            ]
        }
        $options(-parent) \
            _mCall $options(-parent) [_sig $internalMethod] $internalMethod av
    }

    method Empty {} {
        set av $options(-name); set m _${m_ptype}Empty
        $self _call Empty $m av
        return
    }
    method Size {} {
        set av $options(-name); set m _${m_ptype}Size
        lindex [$self _call Size $m av] 0
    }
    method Get {i_index} {
        lappend av $options(-name) $i_index; set m _${m_ptype}Get
        lindex [$self _call Get $m av] 0
    }
    method Delete {i_index} {
        lappend av $options(-name) $i_index; set m _${m_ptype}Delete
        $self _call Delete $m av
        return
    }
    method AddHead {i_value} {
        lappend av $options(-name) $i_value; set m _${m_ptype}AddHead
        $self _call AddHead $m av
        return
    }
    method AddTail {i_value} {
        lappend av $options(-name) $i_value; set m _${m_ptype}AddTail
        $self _call AddTail $m av
        return
    }
    method PopHead {} {
        set av $options(-name); set m _${m_ptype}PopHead
        $self _call PopHead $m av
        return
    }
    method PopTail {} {
        set av $options(-name); set m _${m_ptype}PopTail
        $self _call PopTail $m av
        return
    }
}

#
# Worker componenet for PropertyNodeList managed data items
#
snit::type ${_AC_}::Core::PropertyNodeList {
    component c_Base -inherit true
    option -itemtype -default "" -readonly 1
    option -parent -default "_UNDEFINED_" -readonly 1
    option -name -default "_UNDEFINED_" -readonly 1
    option -obsolete -default "" -readonly 1
    constructor {args} {
        set c_Base ""
        set options(-itemtype) [from args -itemtype {}] 
        set options(-parent) [from args -parent "_UNDEFINED_"] 
        set options(-name) [from args -name "_UNDEFINED_"] 
        set options(-obsolete) [from args -obsolete ""]

        set cmd [list ${::_AC_}::Core::ClientObjectBase create %AUTO%]
        set cmd [concat $cmd $args]
        set c_Base [eval $cmd] 
        $self MTrace 1000 "";
    }

    typemethod exception {id args} {
        if {[string length $id] == 0} { set id "Aptixia.Client.Error" }
        return -code error [list $id $args"]
    }

    destructor {
        $self MTrace 1000 "";
        if {[string length $c_Base]} {
            $c_Base destroy
        }
    }
    method _call {n userMethod internalMethod args} {
        set obsdata [$self cget -obsolete]
        if {$obsdata != ""} {
            ::AptixiaClient::Core::Facility DeprecationHandler _Invoke [list \
                property $options(-name) \
                object $options(-parent) \
                method $userMethod \
                obsoletedata $obsdata \
            ]
        }
        $n _mCall $n [${::_AC_}::XProtocolObject _Get_SIG $internalMethod] \
            $internalMethod args
    }
    method Empty {} {
      $self _call $options(-parent) Empty \
          _PropertyNodeListEmpty $options(-name)
      return
    }
    method Delete {i_index} {
      $self _call $options(-parent) Delete \
          _PropertyNodeListDelete $options(-name) $i_index
      return
    }
    method Size {} {
      lindex [$self _call $options(-parent) Size \
          _PropertyNodeListSize $options(-name)] 0
    }

    method AddTail {args} {
      set itemtype [from args -itemtype $options(-itemtype)]
      if {[llength $args] != 0} {
        $type exception "Aptixia.Client.WrongNumberOfArgs"  \
            "AddTail" \
            "Arguments should be of form: '-itemtype _node_type_'"
      }
      $self _call $options(-parent) AddTail \
          _PropertyNodeListAddTail $options(-name) $itemtype
      return
    }
    method AddHead {args} {
      set itemtype [from args -itemtype $options(-itemtype)]
      if {[llength $args] != 0} {
        $type exception "Aptixia.Client.WrongNumberOfArgs"  \
            "AddHead" \
            "Arguments should be of form: '-itemtype _node_type_'"
      }
      $self _call $options(-parent) AddHead \
          _PropertyNodeListAddHead $options(-name) $itemtype
      return
    }
    method Get {i_index} {
      set r [$self _call $options(-parent) Get \
          _PropertyNodeListGet $options(-name) $i_index]
      foreach {otype oid} $r {break}; #split&assign
      return [${::_AC_}::${otype} create %AUTO% -objectid $oid \
          -transactioncontext [$options(-parent) cget -transactioncontext] \
      ]
    }
}
