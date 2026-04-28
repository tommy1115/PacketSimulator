#----------------------------------------------------------------------
# File: ImpairmentPlugin.tcl
# compiled from ImpairmentPlugin.xml
# Author: metacompiler.py
# Date: 09/23/08
# $Id: $
# (c) 2008 , Ixia.  All Rights Reserved.
#
#----------------------------------------------------------------------
package require Tcl 8.4
package require snit 1.0
#----------------------------------------------------------------------
# ..\Metaschema\ImpairmentPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ImpairmentPlugin {
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
        addDelay PropertyBoolean
        addReorder PropertyBoolean
        addDrop PropertyBoolean
        addDuplicate PropertyBoolean
        addBandwidth PropertyBoolean
        randomizeSeed PropertyBoolean
        delay PropertyInt
        reorder PropertyInt
        reorderLength PropertyInt
        destinationIp PropertyString
        sourcePort PropertyInt
        destinationPort PropertyInt
        protocol PropertyString
        typeOfService PropertyString
        bandwidthUnits PropertyString
        drop PropertyInt
        duplicate PropertyInt
        jitter PropertyInt
        gap PropertyInt
        bandwidth PropertyInt
        seed PropertyInt
        global PropertyBoolean
        impairGlobal PropertyBoolean
        addDropSequence PropertyBoolean
        dropSequenceSkip PropertyInt
        dropSequenceLength PropertyInt
        addReorderPI PropertyBoolean
        reorderPISkip PropertyInt
        reorderPILength PropertyInt
        reorderPIInterval PropertyInt
        reorderPITimeout PropertyInt
        operationOrder PropertyStringList
    }
    #----------------------------------------------------------------------
    # addDelay (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addDelay {args} {$self _mProp $self addDelay $_propertyTypes(addDelay) $args}
    method _ctor_addDelay {args} {}
    method _dtor_addDelay {args} {}
    #----------------------------------------------------------------------
    # addReorder (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addReorder {args} {$self _mProp $self addReorder $_propertyTypes(addReorder) $args}
    method _ctor_addReorder {args} {}
    method _dtor_addReorder {args} {}
    #----------------------------------------------------------------------
    # addDrop (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addDrop {args} {$self _mProp $self addDrop $_propertyTypes(addDrop) $args}
    method _ctor_addDrop {args} {}
    method _dtor_addDrop {args} {}
    #----------------------------------------------------------------------
    # addDuplicate (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addDuplicate {args} {$self _mProp $self addDuplicate $_propertyTypes(addDuplicate) $args}
    method _ctor_addDuplicate {args} {}
    method _dtor_addDuplicate {args} {}
    #----------------------------------------------------------------------
    # addBandwidth (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addBandwidth {args} {$self _mProp $self addBandwidth $_propertyTypes(addBandwidth) $args}
    method _ctor_addBandwidth {args} {}
    method _dtor_addBandwidth {args} {}
    #----------------------------------------------------------------------
    # randomizeSeed (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method randomizeSeed {args} {$self _mProp $self randomizeSeed $_propertyTypes(randomizeSeed) $args}
    method _ctor_randomizeSeed {args} {}
    method _dtor_randomizeSeed {args} {}
    #----------------------------------------------------------------------
    # delay (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method delay {args} {$self _mProp $self delay $_propertyTypes(delay) $args}
    method _ctor_delay {args} {}
    method _dtor_delay {args} {}
    #----------------------------------------------------------------------
    # reorder (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorder {args} {$self _mProp $self reorder $_propertyTypes(reorder) $args}
    method _ctor_reorder {args} {}
    method _dtor_reorder {args} {}
    #----------------------------------------------------------------------
    # reorderLength (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorderLength {args} {$self _mProp $self reorderLength $_propertyTypes(reorderLength) $args}
    method _ctor_reorderLength {args} {}
    method _dtor_reorderLength {args} {}
    #----------------------------------------------------------------------
    # destinationIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method destinationIp {args} {$self _mProp $self destinationIp $_propertyTypes(destinationIp) $args}
    method _ctor_destinationIp {args} {}
    method _dtor_destinationIp {args} {}
    #----------------------------------------------------------------------
    # sourcePort (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method sourcePort {args} {$self _mProp $self sourcePort $_propertyTypes(sourcePort) $args}
    method _ctor_sourcePort {args} {}
    method _dtor_sourcePort {args} {}
    #----------------------------------------------------------------------
    # destinationPort (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method destinationPort {args} {$self _mProp $self destinationPort $_propertyTypes(destinationPort) $args}
    method _ctor_destinationPort {args} {}
    method _dtor_destinationPort {args} {}
    #----------------------------------------------------------------------
    # protocol (PropertyString)
    # 
    #----------------------------------------------------------------------
    method protocol {args} {$self _mProp $self protocol $_propertyTypes(protocol) $args}
    method _ctor_protocol {args} {}
    method _dtor_protocol {args} {}
    #----------------------------------------------------------------------
    # typeOfService (PropertyString)
    # 
    #----------------------------------------------------------------------
    method typeOfService {args} {$self _mProp $self typeOfService $_propertyTypes(typeOfService) $args}
    method _ctor_typeOfService {args} {}
    method _dtor_typeOfService {args} {}
    #----------------------------------------------------------------------
    # bandwidthUnits (PropertyString)
    # 
    #----------------------------------------------------------------------
    method bandwidthUnits {args} {$self _mProp $self bandwidthUnits $_propertyTypes(bandwidthUnits) $args}
    method _ctor_bandwidthUnits {args} {}
    method _dtor_bandwidthUnits {args} {}
    #----------------------------------------------------------------------
    # drop (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method drop {args} {$self _mProp $self drop $_propertyTypes(drop) $args}
    method _ctor_drop {args} {}
    method _dtor_drop {args} {}
    #----------------------------------------------------------------------
    # duplicate (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method duplicate {args} {$self _mProp $self duplicate $_propertyTypes(duplicate) $args}
    method _ctor_duplicate {args} {}
    method _dtor_duplicate {args} {}
    #----------------------------------------------------------------------
    # jitter (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method jitter {args} {$self _mProp $self jitter $_propertyTypes(jitter) $args}
    method _ctor_jitter {args} {}
    method _dtor_jitter {args} {}
    #----------------------------------------------------------------------
    # gap (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method gap {args} {$self _mProp $self gap $_propertyTypes(gap) $args}
    method _ctor_gap {args} {}
    method _dtor_gap {args} {}
    #----------------------------------------------------------------------
    # bandwidth (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method bandwidth {args} {$self _mProp $self bandwidth $_propertyTypes(bandwidth) $args}
    method _ctor_bandwidth {args} {}
    method _dtor_bandwidth {args} {}
    #----------------------------------------------------------------------
    # seed (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method seed {args} {$self _mProp $self seed $_propertyTypes(seed) $args}
    method _ctor_seed {args} {}
    method _dtor_seed {args} {}
    #----------------------------------------------------------------------
    # global (PropertyBoolean)
    # OBSOLETE: global is obsoleted, please use impairGlobal instead
    #----------------------------------------------------------------------
    method global {args} {$self _mProp $self global $_propertyTypes(global) $args {message {global is obsoleted, please use impairGlobal instead}}}
    method _ctor_global {args} {}
    method _dtor_global {args} {}
    #----------------------------------------------------------------------
    # impairGlobal (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method impairGlobal {args} {$self _mProp $self impairGlobal $_propertyTypes(impairGlobal) $args}
    method _ctor_impairGlobal {args} {}
    method _dtor_impairGlobal {args} {}
    #----------------------------------------------------------------------
    # addDropSequence (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addDropSequence {args} {$self _mProp $self addDropSequence $_propertyTypes(addDropSequence) $args}
    method _ctor_addDropSequence {args} {}
    method _dtor_addDropSequence {args} {}
    #----------------------------------------------------------------------
    # dropSequenceSkip (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method dropSequenceSkip {args} {$self _mProp $self dropSequenceSkip $_propertyTypes(dropSequenceSkip) $args}
    method _ctor_dropSequenceSkip {args} {}
    method _dtor_dropSequenceSkip {args} {}
    #----------------------------------------------------------------------
    # dropSequenceLength (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method dropSequenceLength {args} {$self _mProp $self dropSequenceLength $_propertyTypes(dropSequenceLength) $args}
    method _ctor_dropSequenceLength {args} {}
    method _dtor_dropSequenceLength {args} {}
    #----------------------------------------------------------------------
    # addReorderPI (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method addReorderPI {args} {$self _mProp $self addReorderPI $_propertyTypes(addReorderPI) $args}
    method _ctor_addReorderPI {args} {}
    method _dtor_addReorderPI {args} {}
    #----------------------------------------------------------------------
    # reorderPISkip (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorderPISkip {args} {$self _mProp $self reorderPISkip $_propertyTypes(reorderPISkip) $args}
    method _ctor_reorderPISkip {args} {}
    method _dtor_reorderPISkip {args} {}
    #----------------------------------------------------------------------
    # reorderPILength (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorderPILength {args} {$self _mProp $self reorderPILength $_propertyTypes(reorderPILength) $args}
    method _ctor_reorderPILength {args} {}
    method _dtor_reorderPILength {args} {}
    #----------------------------------------------------------------------
    # reorderPIInterval (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorderPIInterval {args} {$self _mProp $self reorderPIInterval $_propertyTypes(reorderPIInterval) $args}
    method _ctor_reorderPIInterval {args} {}
    method _dtor_reorderPIInterval {args} {}
    #----------------------------------------------------------------------
    # reorderPITimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reorderPITimeout {args} {$self _mProp $self reorderPITimeout $_propertyTypes(reorderPITimeout) $args}
    method _ctor_reorderPITimeout {args} {}
    method _dtor_reorderPITimeout {args} {}
    #----------------------------------------------------------------------
    # operationOrder (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    method operationOrder {args} {$self _mProp $self operationOrder $_propertyTypes(operationOrder) $args}
    method _ctor_operationOrder {args} {}
    method _dtor_operationOrder {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


