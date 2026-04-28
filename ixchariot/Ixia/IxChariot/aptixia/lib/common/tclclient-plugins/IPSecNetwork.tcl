#----------------------------------------------------------------------
# File: IPSecNetwork.tcl
# compiled from IPSecPlugin.xml, IPSecNetwork.xml, IPSecPhase1.xml, IPSecPhase2.xml, IPSecTunnelSetup.xml
# Author: metacompiler.py
# Date: 09/23/08
# $Id: $
# (c) 2008 , Ixia.  All Rights Reserved.
#
#----------------------------------------------------------------------
package require Tcl 8.4
package require snit 1.0
#----------------------------------------------------------------------
# ..\Metaschema\IPSecPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IPSecPlugin {
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
        ipsecNetwork PropertyNodeList
        ipsecPhase1 PropertyNode
        ipsecPhase2 PropertyNode
        ipsecTunnelSetup PropertyNode
    }
    #----------------------------------------------------------------------
    # ipsecNetwork (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component ipsecNetwork -public ipsecNetwork
    method _ctor_ipsecNetwork {args} {
        set ipsecNetwork [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype IPSecNetwork \
            -parent $self \
            -name ipsecNetwork \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_ipsecNetwork {args} {catch {$ipsecNetwork destroy}}
    #----------------------------------------------------------------------
    # ipsecPhase1 (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component ipsecPhase1 -public ipsecPhase1
    method _ctor_ipsecPhase1 {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype IPSecPhase1]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType ipsecPhase1]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set ipsecPhase1 [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name ipsecPhase1 \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_ipsecPhase1 {args} {catch {$ipsecPhase1 destroy}}
    #----------------------------------------------------------------------
    # ipsecPhase2 (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component ipsecPhase2 -public ipsecPhase2
    method _ctor_ipsecPhase2 {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype IPSecPhase2]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType ipsecPhase2]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set ipsecPhase2 [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name ipsecPhase2 \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_ipsecPhase2 {args} {catch {$ipsecPhase2 destroy}}
    #----------------------------------------------------------------------
    # ipsecTunnelSetup (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component ipsecTunnelSetup -public ipsecTunnelSetup
    method _ctor_ipsecTunnelSetup {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype IPSecTunnelSetup]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType ipsecTunnelSetup]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set ipsecTunnelSetup [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name ipsecTunnelSetup \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_ipsecTunnelSetup {args} {catch {$ipsecTunnelSetup destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\Metaschema\IPSecNetwork.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IPSecNetwork {
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
        testType PropertyString
        role PropertyString
        emulatedSubnetIpType PropertyString
        numEHCount PropertyInt
        emulatedSubnet PropertyString
        protectedSubnet PropertyString
        emulatedSubnetSuffix PropertyInt
        protectedSubnetSuffix PropertyInt
        esnIncrementBy PropertyString
        psnIncrementBy PropertyString
        peerName PropertyString
        peerPublicIPType PropertyString
        peerPublicIP PropertyString
        singlePH PropertyBoolean
        egRange PropertyNode
    }
    #----------------------------------------------------------------------
    # testType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method testType {args} {$self _mProp $self testType $_propertyTypes(testType) $args}
    method _ctor_testType {args} {}
    method _dtor_testType {args} {}
    #----------------------------------------------------------------------
    # role (PropertyString)
    # 
    #----------------------------------------------------------------------
    method role {args} {$self _mProp $self role $_propertyTypes(role) $args}
    method _ctor_role {args} {}
    method _dtor_role {args} {}
    #----------------------------------------------------------------------
    # emulatedSubnetIpType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method emulatedSubnetIpType {args} {$self _mProp $self emulatedSubnetIpType $_propertyTypes(emulatedSubnetIpType) $args}
    method _ctor_emulatedSubnetIpType {args} {}
    method _dtor_emulatedSubnetIpType {args} {}
    #----------------------------------------------------------------------
    # numEHCount (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method numEHCount {args} {$self _mProp $self numEHCount $_propertyTypes(numEHCount) $args}
    method _ctor_numEHCount {args} {}
    method _dtor_numEHCount {args} {}
    #----------------------------------------------------------------------
    # emulatedSubnet (PropertyString)
    # 
    #----------------------------------------------------------------------
    method emulatedSubnet {args} {$self _mProp $self emulatedSubnet $_propertyTypes(emulatedSubnet) $args}
    method _ctor_emulatedSubnet {args} {}
    method _dtor_emulatedSubnet {args} {}
    #----------------------------------------------------------------------
    # protectedSubnet (PropertyString)
    # 
    #----------------------------------------------------------------------
    method protectedSubnet {args} {$self _mProp $self protectedSubnet $_propertyTypes(protectedSubnet) $args}
    method _ctor_protectedSubnet {args} {}
    method _dtor_protectedSubnet {args} {}
    #----------------------------------------------------------------------
    # emulatedSubnetSuffix (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method emulatedSubnetSuffix {args} {$self _mProp $self emulatedSubnetSuffix $_propertyTypes(emulatedSubnetSuffix) $args}
    method _ctor_emulatedSubnetSuffix {args} {}
    method _dtor_emulatedSubnetSuffix {args} {}
    #----------------------------------------------------------------------
    # protectedSubnetSuffix (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method protectedSubnetSuffix {args} {$self _mProp $self protectedSubnetSuffix $_propertyTypes(protectedSubnetSuffix) $args}
    method _ctor_protectedSubnetSuffix {args} {}
    method _dtor_protectedSubnetSuffix {args} {}
    #----------------------------------------------------------------------
    # esnIncrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method esnIncrementBy {args} {$self _mProp $self esnIncrementBy $_propertyTypes(esnIncrementBy) $args}
    method _ctor_esnIncrementBy {args} {}
    method _dtor_esnIncrementBy {args} {}
    #----------------------------------------------------------------------
    # psnIncrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method psnIncrementBy {args} {$self _mProp $self psnIncrementBy $_propertyTypes(psnIncrementBy) $args}
    method _ctor_psnIncrementBy {args} {}
    method _dtor_psnIncrementBy {args} {}
    #----------------------------------------------------------------------
    # peerName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerName {args} {$self _mProp $self peerName $_propertyTypes(peerName) $args}
    method _ctor_peerName {args} {}
    method _dtor_peerName {args} {}
    #----------------------------------------------------------------------
    # peerPublicIPType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerPublicIPType {args} {$self _mProp $self peerPublicIPType $_propertyTypes(peerPublicIPType) $args}
    method _ctor_peerPublicIPType {args} {}
    method _dtor_peerPublicIPType {args} {}
    #----------------------------------------------------------------------
    # peerPublicIP (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerPublicIP {args} {$self _mProp $self peerPublicIP $_propertyTypes(peerPublicIP) $args}
    method _ctor_peerPublicIP {args} {}
    method _dtor_peerPublicIP {args} {}
    #----------------------------------------------------------------------
    # singlePH (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method singlePH {args} {$self _mProp $self singlePH $_propertyTypes(singlePH) $args}
    method _ctor_singlePH {args} {}
    method _dtor_singlePH {args} {}
    #----------------------------------------------------------------------
    # egRange (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component egRange -public egRange
    method _ctor_egRange {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype IpV4V6Range]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType egRange]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set egRange [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name egRange \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_egRange {args} {catch {$egRange destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\Metaschema\IPSecPhase1.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IPSecPhase1 {
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
        psk PropertyString
        lifeTime PropertyString
        ikeMode PropertyString
        hashAlgo PropertyString
        dhGroup PropertyString
        encAlgo PropertyString
    }
    #----------------------------------------------------------------------
    # psk (PropertyString)
    # 
    #----------------------------------------------------------------------
    method psk {args} {$self _mProp $self psk $_propertyTypes(psk) $args}
    method _ctor_psk {args} {}
    method _dtor_psk {args} {}
    #----------------------------------------------------------------------
    # lifeTime (PropertyString)
    # 
    #----------------------------------------------------------------------
    method lifeTime {args} {$self _mProp $self lifeTime $_propertyTypes(lifeTime) $args}
    method _ctor_lifeTime {args} {}
    method _dtor_lifeTime {args} {}
    #----------------------------------------------------------------------
    # ikeMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ikeMode {args} {$self _mProp $self ikeMode $_propertyTypes(ikeMode) $args}
    method _ctor_ikeMode {args} {}
    method _dtor_ikeMode {args} {}
    #----------------------------------------------------------------------
    # hashAlgo (PropertyString)
    # 
    #----------------------------------------------------------------------
    method hashAlgo {args} {$self _mProp $self hashAlgo $_propertyTypes(hashAlgo) $args}
    method _ctor_hashAlgo {args} {}
    method _dtor_hashAlgo {args} {}
    #----------------------------------------------------------------------
    # dhGroup (PropertyString)
    # 
    #----------------------------------------------------------------------
    method dhGroup {args} {$self _mProp $self dhGroup $_propertyTypes(dhGroup) $args}
    method _ctor_dhGroup {args} {}
    method _dtor_dhGroup {args} {}
    #----------------------------------------------------------------------
    # encAlgo (PropertyString)
    # 
    #----------------------------------------------------------------------
    method encAlgo {args} {$self _mProp $self encAlgo $_propertyTypes(encAlgo) $args}
    method _ctor_encAlgo {args} {}
    method _dtor_encAlgo {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\Metaschema\IPSecPhase2.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IPSecPhase2 {
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
        enablePFS PropertyBoolean
        lifeTime PropertyString
        ahNespMode PropertyString
        encapMode PropertyString
        hashAlgo PropertyString
        pfsGroup PropertyString
        encAlgo PropertyString
    }
    #----------------------------------------------------------------------
    # enablePFS (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enablePFS {args} {$self _mProp $self enablePFS $_propertyTypes(enablePFS) $args}
    method _ctor_enablePFS {args} {}
    method _dtor_enablePFS {args} {}
    #----------------------------------------------------------------------
    # lifeTime (PropertyString)
    # 
    #----------------------------------------------------------------------
    method lifeTime {args} {$self _mProp $self lifeTime $_propertyTypes(lifeTime) $args}
    method _ctor_lifeTime {args} {}
    method _dtor_lifeTime {args} {}
    #----------------------------------------------------------------------
    # ahNespMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ahNespMode {args} {$self _mProp $self ahNespMode $_propertyTypes(ahNespMode) $args}
    method _ctor_ahNespMode {args} {}
    method _dtor_ahNespMode {args} {}
    #----------------------------------------------------------------------
    # encapMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method encapMode {args} {$self _mProp $self encapMode $_propertyTypes(encapMode) $args}
    method _ctor_encapMode {args} {}
    method _dtor_encapMode {args} {}
    #----------------------------------------------------------------------
    # hashAlgo (PropertyString)
    # 
    #----------------------------------------------------------------------
    method hashAlgo {args} {$self _mProp $self hashAlgo $_propertyTypes(hashAlgo) $args}
    method _ctor_hashAlgo {args} {}
    method _dtor_hashAlgo {args} {}
    #----------------------------------------------------------------------
    # pfsGroup (PropertyString)
    # 
    #----------------------------------------------------------------------
    method pfsGroup {args} {$self _mProp $self pfsGroup $_propertyTypes(pfsGroup) $args}
    method _ctor_pfsGroup {args} {}
    method _dtor_pfsGroup {args} {}
    #----------------------------------------------------------------------
    # encAlgo (PropertyString)
    # 
    #----------------------------------------------------------------------
    method encAlgo {args} {$self _mProp $self encAlgo $_propertyTypes(encAlgo) $args}
    method _ctor_encAlgo {args} {}
    method _dtor_encAlgo {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\Metaschema\IPSecTunnelSetup.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IPSecTunnelSetup {
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
        tunnelSweepSize PropertyInt
        tunnelSetupTimeout PropertyInt
        numRetries PropertyInt
        retryInterval PropertyInt
        retryDelay PropertyInt
    }
    #----------------------------------------------------------------------
    # tunnelSweepSize (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tunnelSweepSize {args} {$self _mProp $self tunnelSweepSize $_propertyTypes(tunnelSweepSize) $args}
    method _ctor_tunnelSweepSize {args} {}
    method _dtor_tunnelSweepSize {args} {}
    #----------------------------------------------------------------------
    # tunnelSetupTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tunnelSetupTimeout {args} {$self _mProp $self tunnelSetupTimeout $_propertyTypes(tunnelSetupTimeout) $args}
    method _ctor_tunnelSetupTimeout {args} {}
    method _dtor_tunnelSetupTimeout {args} {}
    #----------------------------------------------------------------------
    # numRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method numRetries {args} {$self _mProp $self numRetries $_propertyTypes(numRetries) $args}
    method _ctor_numRetries {args} {}
    method _dtor_numRetries {args} {}
    #----------------------------------------------------------------------
    # retryInterval (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method retryInterval {args} {$self _mProp $self retryInterval $_propertyTypes(retryInterval) $args}
    method _ctor_retryInterval {args} {}
    method _dtor_retryInterval {args} {}
    #----------------------------------------------------------------------
    # retryDelay (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method retryDelay {args} {$self _mProp $self retryDelay $_propertyTypes(retryDelay) $args}
    method _ctor_retryDelay {args} {}
    method _dtor_retryDelay {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


