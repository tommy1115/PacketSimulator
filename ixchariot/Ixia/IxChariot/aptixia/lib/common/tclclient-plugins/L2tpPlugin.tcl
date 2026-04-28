#----------------------------------------------------------------------
# File: L2tpPlugin.tcl
# compiled from PppL2tp.xml, L2tpTunDestIpRange.xml, L2tp.xml, L2tpPlugin.xml
# Author: metacompiler.py
# Date: 09/23/08
# $Id: $
# (c) 2008 , Ixia.  All Rights Reserved.
#
#----------------------------------------------------------------------
package require Tcl 8.4
package require snit 1.0
#----------------------------------------------------------------------
# ..\metaschemas\PppL2tp.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PppL2tp {
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
# ..\metaschemas\L2tpTunDestIpRange.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::L2tpTunDestIpRange {
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
        enabled PropertyBoolean
        sourceIpRange PropertyNode
        baseTunDestIp PropertyString
        incrementBy PropertyString
    }
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # sourceIpRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component sourceIpRange -public sourceIpRange
    method _ctor_sourceIpRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype IpV4V6Range]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType sourceIpRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set sourceIpRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name sourceIpRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_sourceIpRange {args} {catch {$sourceIpRange destroy}}
    #----------------------------------------------------------------------
    # baseTunDestIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method baseTunDestIp {args} {$self _mProp $self baseTunDestIp $_propertyTypes(baseTunDestIp) $args}
    method _ctor_baseTunDestIp {args} {}
    method _dtor_baseTunDestIp {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\metaschemas\L2tp.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::L2tp {
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
        sessionsPerTunnel PropertyInt
        sessionAllocMethod PropertyString
        rws PropertyInt
        sourceUdpPort PropertyInt
        destinationUdpPort PropertyInt
        enableDataChecksum PropertyBoolean
        enableControlChecksum PropertyBoolean
        enableAvpHiding PropertyBoolean
        tunnelAuthMode PropertyString
        localHostName PropertyString
        secret PropertyString
        peerHostName PropertyString
        tunnelStartId PropertyInt
        noCallTimeout PropertyInt
        framingCapability PropertyString
        bearerCapability PropertyString
        sessionStartId PropertyInt
        bearerType PropertyString
        txConnectSpeed PropertyInt
        rxConnectSpeed PropertyInt
        enableOffsetBit PropertyBoolean
        offsetLen PropertyInt
        offsetByte PropertyInt
        enableLengthBit PropertyBoolean
        enableProxy PropertyBoolean
        enableSequenceBit PropertyBoolean
        enableRedial PropertyBoolean
        redialTimeout PropertyInt
        redialMax PropertyInt
        initTimeout PropertyInt
        maxTimeout PropertyInt
        l2tpRetries PropertyInt
        enableHello PropertyBoolean
        helloTimeout PropertyInt
    }
    #----------------------------------------------------------------------
    # sessionsPerTunnel (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method sessionsPerTunnel {args} {$self _mProp $self sessionsPerTunnel $_propertyTypes(sessionsPerTunnel) $args}
    method _ctor_sessionsPerTunnel {args} {}
    method _dtor_sessionsPerTunnel {args} {}
    #----------------------------------------------------------------------
    # sessionAllocMethod (PropertyString)
    # 
    #----------------------------------------------------------------------
    method sessionAllocMethod {args} {$self _mProp $self sessionAllocMethod $_propertyTypes(sessionAllocMethod) $args}
    method _ctor_sessionAllocMethod {args} {}
    method _dtor_sessionAllocMethod {args} {}
    #----------------------------------------------------------------------
    # rws (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method rws {args} {$self _mProp $self rws $_propertyTypes(rws) $args}
    method _ctor_rws {args} {}
    method _dtor_rws {args} {}
    #----------------------------------------------------------------------
    # sourceUdpPort (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method sourceUdpPort {args} {$self _mProp $self sourceUdpPort $_propertyTypes(sourceUdpPort) $args}
    method _ctor_sourceUdpPort {args} {}
    method _dtor_sourceUdpPort {args} {}
    #----------------------------------------------------------------------
    # destinationUdpPort (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method destinationUdpPort {args} {$self _mProp $self destinationUdpPort $_propertyTypes(destinationUdpPort) $args}
    method _ctor_destinationUdpPort {args} {}
    method _dtor_destinationUdpPort {args} {}
    #----------------------------------------------------------------------
    # enableDataChecksum (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableDataChecksum {args} {$self _mProp $self enableDataChecksum $_propertyTypes(enableDataChecksum) $args}
    method _ctor_enableDataChecksum {args} {}
    method _dtor_enableDataChecksum {args} {}
    #----------------------------------------------------------------------
    # enableControlChecksum (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableControlChecksum {args} {$self _mProp $self enableControlChecksum $_propertyTypes(enableControlChecksum) $args}
    method _ctor_enableControlChecksum {args} {}
    method _dtor_enableControlChecksum {args} {}
    #----------------------------------------------------------------------
    # enableAvpHiding (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableAvpHiding {args} {$self _mProp $self enableAvpHiding $_propertyTypes(enableAvpHiding) $args}
    method _ctor_enableAvpHiding {args} {}
    method _dtor_enableAvpHiding {args} {}
    #----------------------------------------------------------------------
    # tunnelAuthMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method tunnelAuthMode {args} {$self _mProp $self tunnelAuthMode $_propertyTypes(tunnelAuthMode) $args}
    method _ctor_tunnelAuthMode {args} {}
    method _dtor_tunnelAuthMode {args} {}
    #----------------------------------------------------------------------
    # localHostName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localHostName {args} {$self _mProp $self localHostName $_propertyTypes(localHostName) $args}
    method _ctor_localHostName {args} {}
    method _dtor_localHostName {args} {}
    #----------------------------------------------------------------------
    # secret (PropertyString)
    # 
    #----------------------------------------------------------------------
    method secret {args} {$self _mProp $self secret $_propertyTypes(secret) $args}
    method _ctor_secret {args} {}
    method _dtor_secret {args} {}
    #----------------------------------------------------------------------
    # peerHostName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerHostName {args} {$self _mProp $self peerHostName $_propertyTypes(peerHostName) $args}
    method _ctor_peerHostName {args} {}
    method _dtor_peerHostName {args} {}
    #----------------------------------------------------------------------
    # tunnelStartId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tunnelStartId {args} {$self _mProp $self tunnelStartId $_propertyTypes(tunnelStartId) $args}
    method _ctor_tunnelStartId {args} {}
    method _dtor_tunnelStartId {args} {}
    #----------------------------------------------------------------------
    # noCallTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method noCallTimeout {args} {$self _mProp $self noCallTimeout $_propertyTypes(noCallTimeout) $args}
    method _ctor_noCallTimeout {args} {}
    method _dtor_noCallTimeout {args} {}
    #----------------------------------------------------------------------
    # framingCapability (PropertyString)
    # 
    #----------------------------------------------------------------------
    method framingCapability {args} {$self _mProp $self framingCapability $_propertyTypes(framingCapability) $args}
    method _ctor_framingCapability {args} {}
    method _dtor_framingCapability {args} {}
    #----------------------------------------------------------------------
    # bearerCapability (PropertyString)
    # 
    #----------------------------------------------------------------------
    method bearerCapability {args} {$self _mProp $self bearerCapability $_propertyTypes(bearerCapability) $args}
    method _ctor_bearerCapability {args} {}
    method _dtor_bearerCapability {args} {}
    #----------------------------------------------------------------------
    # sessionStartId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method sessionStartId {args} {$self _mProp $self sessionStartId $_propertyTypes(sessionStartId) $args}
    method _ctor_sessionStartId {args} {}
    method _dtor_sessionStartId {args} {}
    #----------------------------------------------------------------------
    # bearerType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method bearerType {args} {$self _mProp $self bearerType $_propertyTypes(bearerType) $args}
    method _ctor_bearerType {args} {}
    method _dtor_bearerType {args} {}
    #----------------------------------------------------------------------
    # txConnectSpeed (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method txConnectSpeed {args} {$self _mProp $self txConnectSpeed $_propertyTypes(txConnectSpeed) $args}
    method _ctor_txConnectSpeed {args} {}
    method _dtor_txConnectSpeed {args} {}
    #----------------------------------------------------------------------
    # rxConnectSpeed (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method rxConnectSpeed {args} {$self _mProp $self rxConnectSpeed $_propertyTypes(rxConnectSpeed) $args}
    method _ctor_rxConnectSpeed {args} {}
    method _dtor_rxConnectSpeed {args} {}
    #----------------------------------------------------------------------
    # enableOffsetBit (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableOffsetBit {args} {$self _mProp $self enableOffsetBit $_propertyTypes(enableOffsetBit) $args}
    method _ctor_enableOffsetBit {args} {}
    method _dtor_enableOffsetBit {args} {}
    #----------------------------------------------------------------------
    # offsetLen (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method offsetLen {args} {$self _mProp $self offsetLen $_propertyTypes(offsetLen) $args}
    method _ctor_offsetLen {args} {}
    method _dtor_offsetLen {args} {}
    #----------------------------------------------------------------------
    # offsetByte (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method offsetByte {args} {$self _mProp $self offsetByte $_propertyTypes(offsetByte) $args}
    method _ctor_offsetByte {args} {}
    method _dtor_offsetByte {args} {}
    #----------------------------------------------------------------------
    # enableLengthBit (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableLengthBit {args} {$self _mProp $self enableLengthBit $_propertyTypes(enableLengthBit) $args}
    method _ctor_enableLengthBit {args} {}
    method _dtor_enableLengthBit {args} {}
    #----------------------------------------------------------------------
    # enableProxy (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableProxy {args} {$self _mProp $self enableProxy $_propertyTypes(enableProxy) $args}
    method _ctor_enableProxy {args} {}
    method _dtor_enableProxy {args} {}
    #----------------------------------------------------------------------
    # enableSequenceBit (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableSequenceBit {args} {$self _mProp $self enableSequenceBit $_propertyTypes(enableSequenceBit) $args}
    method _ctor_enableSequenceBit {args} {}
    method _dtor_enableSequenceBit {args} {}
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
    # initTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method initTimeout {args} {$self _mProp $self initTimeout $_propertyTypes(initTimeout) $args}
    method _ctor_initTimeout {args} {}
    method _dtor_initTimeout {args} {}
    #----------------------------------------------------------------------
    # maxTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method maxTimeout {args} {$self _mProp $self maxTimeout $_propertyTypes(maxTimeout) $args}
    method _ctor_maxTimeout {args} {}
    method _dtor_maxTimeout {args} {}
    #----------------------------------------------------------------------
    # l2tpRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method l2tpRetries {args} {$self _mProp $self l2tpRetries $_propertyTypes(l2tpRetries) $args}
    method _ctor_l2tpRetries {args} {}
    method _dtor_l2tpRetries {args} {}
    #----------------------------------------------------------------------
    # enableHello (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableHello {args} {$self _mProp $self enableHello $_propertyTypes(enableHello) $args}
    method _ctor_enableHello {args} {}
    method _dtor_enableHello {args} {}
    #----------------------------------------------------------------------
    # helloTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method helloTimeout {args} {$self _mProp $self helloTimeout $_propertyTypes(helloTimeout) $args}
    method _ctor_helloTimeout {args} {}
    method _dtor_helloTimeout {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\metaschemas\L2tpPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::L2tpPlugin {
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
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        enabled PropertyBoolean
        role PropertyString
        setupRate PropertyInt
        enableThrottling PropertyBoolean
        maxOutstandingSessions PropertyInt
        teardownRate PropertyInt
        numSessions PropertyInt
        l2tp PropertyNode
        pppL2tp PropertyNode
        tunDestIpRanges PropertyNodeList
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
    # numSessions (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method numSessions {args} {$self _mProp $self numSessions $_propertyTypes(numSessions) $args}
    method _ctor_numSessions {args} {}
    method _dtor_numSessions {args} {}
    #----------------------------------------------------------------------
    # l2tp (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component l2tp -public l2tp
    method _ctor_l2tp {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype L2tp]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType l2tp]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set l2tp [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name l2tp \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_l2tp {args} {catch {$l2tp destroy}}
    #----------------------------------------------------------------------
    # pppL2tp (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component pppL2tp -public pppL2tp
    method _ctor_pppL2tp {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype PppL2tp]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType pppL2tp]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set pppL2tp [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name pppL2tp \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_pppL2tp {args} {catch {$pppL2tp destroy}}
    #----------------------------------------------------------------------
    # tunDestIpRanges (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component tunDestIpRanges -public tunDestIpRanges
    method _ctor_tunDestIpRanges {args} {
        set tunDestIpRanges [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype L2tpTunDestIpRange \
            -parent $self \
            -name tunDestIpRanges \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_tunDestIpRanges {args} {catch {$tunDestIpRanges destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


