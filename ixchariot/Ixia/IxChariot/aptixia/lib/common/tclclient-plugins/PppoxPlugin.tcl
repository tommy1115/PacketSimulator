#----------------------------------------------------------------------
# File: PppoxPlugin.tcl
# compiled from Ppp.xml, Pppoe.xml, PppoxPlugin.xml
# Author: metacompiler.py
# Date: 09/23/08
# $Id: $
# (c) 2008 , Ixia.  All Rights Reserved.
#
#----------------------------------------------------------------------
package require Tcl 8.4
package require snit 1.0
#----------------------------------------------------------------------
# ..\metaschemas\Ppp.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Ppp {
    typevariable CoreFacility ::AptixiaClient::Core::Facility
    typevariable ClientNS ::AptixiaClient
    #
    # common options
    #
    option -transactioncontext -default "" -readonly 1
    option -objectid -default -1 -readonly 1
    option -obsolete -default "" -readonly 1
    option -name -default "" -readonly 1
    #
    # component implementing the type's base type
    #
    component c_Base -public XProtocolObject -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::XProtocolObject %AUTO%}
        set cmd [concat $cmd $args]
        if {[catch $cmd c_Base]} {
            puts stderr "$type: Constructor Error: $c_Base"; return -code error $type:$c_Base
        }
        $self _constructor_Properties
        $self _constructor_Udt
    }
    method _constructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _ctor_$pname $args
        }
    }
    destructor {
        $self _destructor_Properties
        $self _destructor_Udt
        $c_Base destroy
    }
    method _destructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _dtor_$pname $args
        }
    }
    method _LookupPropType {i_name} {
        if {[info exists _propertyTypes($i_name)]} {
            return $_propertyTypes($i_name)
        }
        set fail [ catch { $c_Base _LookupPropType $i_name } rval ]
        if {$fail} {
            error "No such property $i_name"
        } else {
            return $rval
        }
    }
    method _Bind {i_name i_srcobj} {
        ::AptixiaClient::Core::ClientObjectBase _Bind \
            $self $_propertyTypes($i_name) $i_name $i_srcobj
    }
    method _Instantiate {i_name i_type} {
        ::AptixiaClient::Core::ClientObjectBase _Instantiate \
            $self [$self _LookupPropType $i_name ] $i_name $i_type
    }
    method _Characterize {i_name} {
        ::AptixiaClient::Core::ClientObjectBase _Characterize \
            $self $_propertyTypes($i_name) $i_name
    }
    #----------------------------------------------------------------------
    # User Defined Types are:
    #----------------------------------------------------------------------
    method _constructor_Udt {args} {}
    method _destructor_Udt {args} {}
    #----------------------------------------------------------------------
    # Decoders
    #----------------------------------------------------------------------
    typemethod _dec_ {i_context i_type i_elem i_varN} {
        upvar 1 $i_varN v
        set objectid [lindex [lindex $i_elem 0] 1]
        set v [$type create %AUTO% \
            -objectid $objectid -transactioncontext $i_context]
        return 1
    }
    typemethod _Get_SIG {i_methodName} {
        return [set _SIG_$i_methodName]
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        lcpTimeout PropertyInt
        lcpRetries PropertyInt
        mtu PropertyInt
        ncpType PropertyString
        clientBaseIp PropertyString
        clientIpIncr PropertyString
        serverBaseIp PropertyString
        serverIpIncr PropertyString
        clientBaseIID PropertyString
        clientIIDIncr PropertyInt
        serverBaseIID PropertyString
        serverIIDIncr PropertyInt
        ipv6PoolPrefix PropertyString
        ipv6PoolPrefixLen PropertyInt
        ipv6AddrPrefixLen PropertyInt
        authType PropertyString
        papUser PropertyString
        papPassword PropertyString
        chapName PropertyString
        chapSecret PropertyString
        lcpTermTimeout PropertyInt
        lcpTermRetries PropertyInt
        useMagic PropertyBoolean
        enableEchoRsp PropertyBoolean
        enableEchoReq PropertyBoolean
        echoReqInterval PropertyInt
        ncpTimeout PropertyInt
        ncpRetries PropertyInt
        authTimeout PropertyInt
        authRetries PropertyInt
    }
    #----------------------------------------------------------------------
    # lcpTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method lcpTimeout {args} {$self _mProp $self lcpTimeout $_propertyTypes(lcpTimeout) $args}
    method _ctor_lcpTimeout {args} {}
    method _dtor_lcpTimeout {args} {}
    #----------------------------------------------------------------------
    # lcpRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method lcpRetries {args} {$self _mProp $self lcpRetries $_propertyTypes(lcpRetries) $args}
    method _ctor_lcpRetries {args} {}
    method _dtor_lcpRetries {args} {}
    #----------------------------------------------------------------------
    # mtu (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method mtu {args} {$self _mProp $self mtu $_propertyTypes(mtu) $args}
    method _ctor_mtu {args} {}
    method _dtor_mtu {args} {}
    #----------------------------------------------------------------------
    # ncpType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ncpType {args} {$self _mProp $self ncpType $_propertyTypes(ncpType) $args}
    method _ctor_ncpType {args} {}
    method _dtor_ncpType {args} {}
    #----------------------------------------------------------------------
    # clientBaseIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method clientBaseIp {args} {$self _mProp $self clientBaseIp $_propertyTypes(clientBaseIp) $args}
    method _ctor_clientBaseIp {args} {}
    method _dtor_clientBaseIp {args} {}
    #----------------------------------------------------------------------
    # clientIpIncr (PropertyString)
    # 
    #----------------------------------------------------------------------
    method clientIpIncr {args} {$self _mProp $self clientIpIncr $_propertyTypes(clientIpIncr) $args}
    method _ctor_clientIpIncr {args} {}
    method _dtor_clientIpIncr {args} {}
    #----------------------------------------------------------------------
    # serverBaseIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method serverBaseIp {args} {$self _mProp $self serverBaseIp $_propertyTypes(serverBaseIp) $args}
    method _ctor_serverBaseIp {args} {}
    method _dtor_serverBaseIp {args} {}
    #----------------------------------------------------------------------
    # serverIpIncr (PropertyString)
    # 
    #----------------------------------------------------------------------
    method serverIpIncr {args} {$self _mProp $self serverIpIncr $_propertyTypes(serverIpIncr) $args}
    method _ctor_serverIpIncr {args} {}
    method _dtor_serverIpIncr {args} {}
    #----------------------------------------------------------------------
    # clientBaseIID (PropertyString)
    # 
    #----------------------------------------------------------------------
    method clientBaseIID {args} {$self _mProp $self clientBaseIID $_propertyTypes(clientBaseIID) $args}
    method _ctor_clientBaseIID {args} {}
    method _dtor_clientBaseIID {args} {}
    #----------------------------------------------------------------------
    # clientIIDIncr (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method clientIIDIncr {args} {$self _mProp $self clientIIDIncr $_propertyTypes(clientIIDIncr) $args}
    method _ctor_clientIIDIncr {args} {}
    method _dtor_clientIIDIncr {args} {}
    #----------------------------------------------------------------------
    # serverBaseIID (PropertyString)
    # 
    #----------------------------------------------------------------------
    method serverBaseIID {args} {$self _mProp $self serverBaseIID $_propertyTypes(serverBaseIID) $args}
    method _ctor_serverBaseIID {args} {}
    method _dtor_serverBaseIID {args} {}
    #----------------------------------------------------------------------
    # serverIIDIncr (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method serverIIDIncr {args} {$self _mProp $self serverIIDIncr $_propertyTypes(serverIIDIncr) $args}
    method _ctor_serverIIDIncr {args} {}
    method _dtor_serverIIDIncr {args} {}
    #----------------------------------------------------------------------
    # ipv6PoolPrefix (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ipv6PoolPrefix {args} {$self _mProp $self ipv6PoolPrefix $_propertyTypes(ipv6PoolPrefix) $args}
    method _ctor_ipv6PoolPrefix {args} {}
    method _dtor_ipv6PoolPrefix {args} {}
    #----------------------------------------------------------------------
    # ipv6PoolPrefixLen (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method ipv6PoolPrefixLen {args} {$self _mProp $self ipv6PoolPrefixLen $_propertyTypes(ipv6PoolPrefixLen) $args}
    method _ctor_ipv6PoolPrefixLen {args} {}
    method _dtor_ipv6PoolPrefixLen {args} {}
    #----------------------------------------------------------------------
    # ipv6AddrPrefixLen (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method ipv6AddrPrefixLen {args} {$self _mProp $self ipv6AddrPrefixLen $_propertyTypes(ipv6AddrPrefixLen) $args}
    method _ctor_ipv6AddrPrefixLen {args} {}
    method _dtor_ipv6AddrPrefixLen {args} {}
    #----------------------------------------------------------------------
    # authType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method authType {args} {$self _mProp $self authType $_propertyTypes(authType) $args}
    method _ctor_authType {args} {}
    method _dtor_authType {args} {}
    #----------------------------------------------------------------------
    # papUser (PropertyString)
    # 
    #----------------------------------------------------------------------
    method papUser {args} {$self _mProp $self papUser $_propertyTypes(papUser) $args}
    method _ctor_papUser {args} {}
    method _dtor_papUser {args} {}
    #----------------------------------------------------------------------
    # papPassword (PropertyString)
    # 
    #----------------------------------------------------------------------
    method papPassword {args} {$self _mProp $self papPassword $_propertyTypes(papPassword) $args}
    method _ctor_papPassword {args} {}
    method _dtor_papPassword {args} {}
    #----------------------------------------------------------------------
    # chapName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method chapName {args} {$self _mProp $self chapName $_propertyTypes(chapName) $args}
    method _ctor_chapName {args} {}
    method _dtor_chapName {args} {}
    #----------------------------------------------------------------------
    # chapSecret (PropertyString)
    # 
    #----------------------------------------------------------------------
    method chapSecret {args} {$self _mProp $self chapSecret $_propertyTypes(chapSecret) $args}
    method _ctor_chapSecret {args} {}
    method _dtor_chapSecret {args} {}
    #----------------------------------------------------------------------
    # lcpTermTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method lcpTermTimeout {args} {$self _mProp $self lcpTermTimeout $_propertyTypes(lcpTermTimeout) $args}
    method _ctor_lcpTermTimeout {args} {}
    method _dtor_lcpTermTimeout {args} {}
    #----------------------------------------------------------------------
    # lcpTermRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method lcpTermRetries {args} {$self _mProp $self lcpTermRetries $_propertyTypes(lcpTermRetries) $args}
    method _ctor_lcpTermRetries {args} {}
    method _dtor_lcpTermRetries {args} {}
    #----------------------------------------------------------------------
    # useMagic (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method useMagic {args} {$self _mProp $self useMagic $_propertyTypes(useMagic) $args}
    method _ctor_useMagic {args} {}
    method _dtor_useMagic {args} {}
    #----------------------------------------------------------------------
    # enableEchoRsp (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableEchoRsp {args} {$self _mProp $self enableEchoRsp $_propertyTypes(enableEchoRsp) $args}
    method _ctor_enableEchoRsp {args} {}
    method _dtor_enableEchoRsp {args} {}
    #----------------------------------------------------------------------
    # enableEchoReq (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableEchoReq {args} {$self _mProp $self enableEchoReq $_propertyTypes(enableEchoReq) $args}
    method _ctor_enableEchoReq {args} {}
    method _dtor_enableEchoReq {args} {}
    #----------------------------------------------------------------------
    # echoReqInterval (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method echoReqInterval {args} {$self _mProp $self echoReqInterval $_propertyTypes(echoReqInterval) $args}
    method _ctor_echoReqInterval {args} {}
    method _dtor_echoReqInterval {args} {}
    #----------------------------------------------------------------------
    # ncpTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method ncpTimeout {args} {$self _mProp $self ncpTimeout $_propertyTypes(ncpTimeout) $args}
    method _ctor_ncpTimeout {args} {}
    method _dtor_ncpTimeout {args} {}
    #----------------------------------------------------------------------
    # ncpRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method ncpRetries {args} {$self _mProp $self ncpRetries $_propertyTypes(ncpRetries) $args}
    method _ctor_ncpRetries {args} {}
    method _dtor_ncpRetries {args} {}
    #----------------------------------------------------------------------
    # authTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method authTimeout {args} {$self _mProp $self authTimeout $_propertyTypes(authTimeout) $args}
    method _ctor_authTimeout {args} {}
    method _dtor_authTimeout {args} {}
    #----------------------------------------------------------------------
    # authRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method authRetries {args} {$self _mProp $self authRetries $_propertyTypes(authRetries) $args}
    method _ctor_authRetries {args} {}
    method _dtor_authRetries {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\metaschemas\Pppoe.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Pppoe {
    typevariable CoreFacility ::AptixiaClient::Core::Facility
    typevariable ClientNS ::AptixiaClient
    #
    # common options
    #
    option -transactioncontext -default "" -readonly 1
    option -objectid -default -1 -readonly 1
    option -obsolete -default "" -readonly 1
    option -name -default "" -readonly 1
    #
    # component implementing the type's base type
    #
    component c_Base -public XProtocolObject -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::XProtocolObject %AUTO%}
        set cmd [concat $cmd $args]
        if {[catch $cmd c_Base]} {
            puts stderr "$type: Constructor Error: $c_Base"; return -code error $type:$c_Base
        }
        $self _constructor_Properties
        $self _constructor_Udt
    }
    method _constructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _ctor_$pname $args
        }
    }
    destructor {
        $self _destructor_Properties
        $self _destructor_Udt
        $c_Base destroy
    }
    method _destructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _dtor_$pname $args
        }
    }
    method _LookupPropType {i_name} {
        if {[info exists _propertyTypes($i_name)]} {
            return $_propertyTypes($i_name)
        }
        set fail [ catch { $c_Base _LookupPropType $i_name } rval ]
        if {$fail} {
            error "No such property $i_name"
        } else {
            return $rval
        }
    }
    method _Bind {i_name i_srcobj} {
        ::AptixiaClient::Core::ClientObjectBase _Bind \
            $self $_propertyTypes($i_name) $i_name $i_srcobj
    }
    method _Instantiate {i_name i_type} {
        ::AptixiaClient::Core::ClientObjectBase _Instantiate \
            $self [$self _LookupPropType $i_name ] $i_name $i_type
    }
    method _Characterize {i_name} {
        ::AptixiaClient::Core::ClientObjectBase _Characterize \
            $self $_propertyTypes($i_name) $i_name
    }
    #----------------------------------------------------------------------
    # User Defined Types are:
    #----------------------------------------------------------------------
    method _constructor_Udt {args} {}
    method _destructor_Udt {args} {}
    #----------------------------------------------------------------------
    # Decoders
    #----------------------------------------------------------------------
    typemethod _dec_ {i_context i_type i_elem i_varN} {
        upvar 1 $i_varN v
        set objectid [lindex [lindex $i_elem 0] 1]
        set v [$type create %AUTO% \
            -objectid $objectid -transactioncontext $i_context]
        return 1
    }
    typemethod _Get_SIG {i_methodName} {
        return [set _SIG_$i_methodName]
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        padiTimeout PropertyInt
        padiRetries PropertyInt
        padrTimeout PropertyInt
        padrRetries PropertyInt
        serviceName PropertyString
        acName PropertyString
        enableRedial PropertyBoolean
        redialTimeout PropertyInt
        redialMax PropertyInt
    }
    #----------------------------------------------------------------------
    # padiTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method padiTimeout {args} {$self _mProp $self padiTimeout $_propertyTypes(padiTimeout) $args}
    method _ctor_padiTimeout {args} {}
    method _dtor_padiTimeout {args} {}
    #----------------------------------------------------------------------
    # padiRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method padiRetries {args} {$self _mProp $self padiRetries $_propertyTypes(padiRetries) $args}
    method _ctor_padiRetries {args} {}
    method _dtor_padiRetries {args} {}
    #----------------------------------------------------------------------
    # padrTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method padrTimeout {args} {$self _mProp $self padrTimeout $_propertyTypes(padrTimeout) $args}
    method _ctor_padrTimeout {args} {}
    method _dtor_padrTimeout {args} {}
    #----------------------------------------------------------------------
    # padrRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method padrRetries {args} {$self _mProp $self padrRetries $_propertyTypes(padrRetries) $args}
    method _ctor_padrRetries {args} {}
    method _dtor_padrRetries {args} {}
    #----------------------------------------------------------------------
    # serviceName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method serviceName {args} {$self _mProp $self serviceName $_propertyTypes(serviceName) $args}
    method _ctor_serviceName {args} {}
    method _dtor_serviceName {args} {}
    #----------------------------------------------------------------------
    # acName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method acName {args} {$self _mProp $self acName $_propertyTypes(acName) $args}
    method _ctor_acName {args} {}
    method _dtor_acName {args} {}
    #----------------------------------------------------------------------
    # enableRedial (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableRedial {args} {$self _mProp $self enableRedial $_propertyTypes(enableRedial) $args}
    method _ctor_enableRedial {args} {}
    method _dtor_enableRedial {args} {}
    #----------------------------------------------------------------------
    # redialTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method redialTimeout {args} {$self _mProp $self redialTimeout $_propertyTypes(redialTimeout) $args}
    method _ctor_redialTimeout {args} {}
    method _dtor_redialTimeout {args} {}
    #----------------------------------------------------------------------
    # redialMax (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method redialMax {args} {$self _mProp $self redialMax $_propertyTypes(redialMax) $args}
    method _ctor_redialMax {args} {}
    method _dtor_redialMax {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\metaschemas\PppoxPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PppoxPlugin {
    typevariable CoreFacility ::AptixiaClient::Core::Facility
    typevariable ClientNS ::AptixiaClient
    #
    # common options
    #
    option -transactioncontext -default "" -readonly 1
    option -objectid -default -1 -readonly 1
    option -obsolete -default "" -readonly 1
    option -name -default "" -readonly 1
    #
    # component implementing the type's base type
    #
    component c_Base -public StackElementPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::StackElementPlugin %AUTO%}
        set cmd [concat $cmd $args]
        if {[catch $cmd c_Base]} {
            puts stderr "$type: Constructor Error: $c_Base"; return -code error $type:$c_Base
        }
        $self _constructor_Properties
        $self _constructor_Udt
    }
    method _constructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _ctor_$pname $args
        }
    }
    destructor {
        $self _destructor_Properties
        $self _destructor_Udt
        $c_Base destroy
    }
    method _destructor_Properties {args} {
        foreach {pname ptype} [array get _propertyTypes] {
            $self _dtor_$pname $args
        }
    }
    method _LookupPropType {i_name} {
        if {[info exists _propertyTypes($i_name)]} {
            return $_propertyTypes($i_name)
        }
        set fail [ catch { $c_Base _LookupPropType $i_name } rval ]
        if {$fail} {
            error "No such property $i_name"
        } else {
            return $rval
        }
    }
    method _Bind {i_name i_srcobj} {
        ::AptixiaClient::Core::ClientObjectBase _Bind \
            $self $_propertyTypes($i_name) $i_name $i_srcobj
    }
    method _Instantiate {i_name i_type} {
        ::AptixiaClient::Core::ClientObjectBase _Instantiate \
            $self [$self _LookupPropType $i_name ] $i_name $i_type
    }
    method _Characterize {i_name} {
        ::AptixiaClient::Core::ClientObjectBase _Characterize \
            $self $_propertyTypes($i_name) $i_name
    }
    #----------------------------------------------------------------------
    # User Defined Types are:
    #----------------------------------------------------------------------
    method _constructor_Udt {args} {}
    method _destructor_Udt {args} {}
    #----------------------------------------------------------------------
    # Decoders
    #----------------------------------------------------------------------
    typemethod _dec_ {i_context i_type i_elem i_varN} {
        upvar 1 $i_varN v
        set objectid [lindex [lindex $i_elem 0] 1]
        set v [$type create %AUTO% \
            -objectid $objectid -transactioncontext $i_context]
        return 1
    }
    typemethod _Get_SIG {i_methodName} {
        return [set _SIG_$i_methodName]
    }
    typevariable _SIG_GetTestMode {
        {name testMode type string direction out}
    }
    method GetTestMode {
        args
    } {
        $self _mCall $self $_SIG_GetTestMode GetTestMode args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        enabled PropertyBoolean
        role PropertyString
        numSessions PropertyInt
        setupRate PropertyInt
        enableThrottling PropertyBoolean
        maxOutstandingSessions PropertyInt
        teardownRate PropertyInt
        atmRange PropertyNode
        macRange PropertyNode
        vlanRange PropertyNode
        pvcRange PropertyNode
        pppoe PropertyNode
        ppp PropertyNode
    }
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # role (PropertyString)
    # 
    #----------------------------------------------------------------------
    method role {args} {$self _mProp $self role $_propertyTypes(role) $args}
    method _ctor_role {args} {}
    method _dtor_role {args} {}
    #----------------------------------------------------------------------
    # numSessions (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method numSessions {args} {$self _mProp $self numSessions $_propertyTypes(numSessions) $args}
    method _ctor_numSessions {args} {}
    method _dtor_numSessions {args} {}
    #----------------------------------------------------------------------
    # setupRate (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method setupRate {args} {$self _mProp $self setupRate $_propertyTypes(setupRate) $args}
    method _ctor_setupRate {args} {}
    method _dtor_setupRate {args} {}
    #----------------------------------------------------------------------
    # enableThrottling (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableThrottling {args} {$self _mProp $self enableThrottling $_propertyTypes(enableThrottling) $args}
    method _ctor_enableThrottling {args} {}
    method _dtor_enableThrottling {args} {}
    #----------------------------------------------------------------------
    # maxOutstandingSessions (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method maxOutstandingSessions {args} {$self _mProp $self maxOutstandingSessions $_propertyTypes(maxOutstandingSessions) $args}
    method _ctor_maxOutstandingSessions {args} {}
    method _dtor_maxOutstandingSessions {args} {}
    #----------------------------------------------------------------------
    # teardownRate (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method teardownRate {args} {$self _mProp $self teardownRate $_propertyTypes(teardownRate) $args}
    method _ctor_teardownRate {args} {}
    method _dtor_teardownRate {args} {}
    #----------------------------------------------------------------------
    # atmRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component atmRange -public atmRange
    method _ctor_atmRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype AtmRange]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType atmRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set atmRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name atmRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_atmRange {args} {catch {$atmRange destroy}}
    #----------------------------------------------------------------------
    # macRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component macRange -public macRange
    method _ctor_macRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype MacRange]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType macRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set macRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name macRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_macRange {args} {catch {$macRange destroy}}
    #----------------------------------------------------------------------
    # vlanRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component vlanRange -public vlanRange
    method _ctor_vlanRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype VlanIdRange]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType vlanRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set vlanRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name vlanRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_vlanRange {args} {catch {$vlanRange destroy}}
    #----------------------------------------------------------------------
    # pvcRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component pvcRange -public pvcRange
    method _ctor_pvcRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype PvcRange]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType pvcRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set pvcRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name pvcRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_pvcRange {args} {catch {$pvcRange destroy}}
    #----------------------------------------------------------------------
    # pppoe (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component pppoe -public pppoe
    method _ctor_pppoe {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Pppoe]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType pppoe]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set pppoe [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name pppoe \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_pppoe {args} {catch {$pppoe destroy}}
    #----------------------------------------------------------------------
    # ppp (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component ppp -public ppp
    method _ctor_ppp {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Ppp]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType ppp]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set ppp [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name ppp \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_ppp {args} {catch {$ppp destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


