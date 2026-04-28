#----------------------------------------------------------------------
# File: AptixiaClientTS.tcl
# compiled from StatConsumer.xml, StatViewTemplate.xml, StackManagerApp.xml, BranchToNic.xml, ATMPlugin.xml, AtmRange.xml, PvcRange.xml, AggregatedStat.xml, CardPlugin.xml, ChartAxis.xml, ChartXAxis.xml, ChartYAxis.xml, ChassisCard.xml, Chassis.xml, ChassisConfig.xml, DataStore.xml, CsvHeaderField.xml, CsvRequestOptions.xml, DDGTest.xml, DataDrivenFormBase.xml, DnsHost.xml, DnsNameServer.xml, DnsPlugin.xml, DnsSearch.xml, DodUnitTestPlugin.xml, DualPhyPlugin.xml, EmulatedRouterPlugin.xml, EthernetCardPlugin.xml, EthernetELMPlugin.xml, EthernetPlugin.xml, FilterPlugin.xml, GenericStatSource.xml, GlobalPlugin.xml, HardwarePlugin.xml, IpV4V6Plugin.xml, IpV4V6Range.xml, MacRange.xml, NodeTest.xml, NodeTestA.xml, NodeTestB.xml, PortGroup.xml, PortController.xml, PortControllerService.xml, Route.xml, RoutesPlugin.xml, ServiceExtension.xml, ServiceExtensionsWrapper.xml, Session.xml, SnmpPlugin.xml, SnmpStatSource.xml, SnmpStatVariable.xml, SonetATMBasePlugin.xml, StackElementPlugin.xml, StatAttribute.xml, StatAttributeList.xml, StatCatalogItem.xml, StatCatalogStat.xml, StatFilter.xml, StatFilterGroup.xml, StatManager.xml, StatSpec.xml, StatView.xml, StatViewer.xml, StatWatch.xml, TCPPlugin.xml, Test.xml, TestServer.xml, TestServerPrivate.xml, TestServerUnitTestNode.xml, TreeNode.xml, Vlan.xml, VlanIdRange.xml, Dhcp.xml, DhcpSettings.xml, XPBootstrap.xml, XPUnitTest.xml, XPUnitTestA.xml, XPUnitTestB.xml, XPUnitTestC.xml, XPUnitTestD.xml, XPUnitTestO.xml, XProtocolObject.xml, POSPayLoad.xml, PPPPayLoad.xml, POSPlugin.xml, PortWatch.xml, GenericTestModel.xml, TenGigabitWANPlugin.xml, TenGigabitLANPlugin.xml
# Author: metacompiler.py
# Date: 09/23/08
# $Id: $
# (c) 2008 , Ixia.  All Rights Reserved.
#
#----------------------------------------------------------------------
package require Tcl 8.4
package require snit 1.0
#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatConsumer.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- StatConsumer::eStatValueType
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::eStatValueType {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kInt
    typevariable kString
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kInt]} {
            set kInt [$type create %AUTO%];$kInt Set kInt
            set _tv [mytypevar kInt]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kString]} {
            set kString [$type create %AUTO%];$kString Set kString
            set _tv [mytypevar kString]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kInt
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kInt
      1 kString
    }
    typevariable m_encoder -array {
      kInt 0
      kString 1
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- StatConsumer::StatValue
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatValue {
    component c_Struct -inherit true
    delegate method id to c_Struct using "%c _dcall %m"
    delegate method type to c_Struct using "%c _dcall %m"
    delegate method intValue to c_Struct using "%c _dcall %m"
    delegate method stringValue to c_Struct using "%c _dcall %m"
    delegate method timestamp to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            id int32 {-1}
            type int32 {0}
            intValue int64 {0}
            stringValue string {}
            timestamp int64 {0}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatConsumer::StatValueList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatValueList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatConsumer.StatValue]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatConsumer::StatChange
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatChange {
    component c_Struct -inherit true
    delegate method newIndex to c_Struct using "%c _dcall %m"
    delegate method resultIndex to c_Struct using "%c _dcall %m"
    delegate method statSpecIndex to c_Struct using "%c _dcall %m"
    delegate method statSourceType to c_Struct using "%c _dcall %m"
    delegate method statName to c_Struct using "%c _dcall %m"
    delegate method statSpecCaption to c_Struct using "%c _dcall %m"
    delegate method csvStatLabel to c_Struct using "%c _dcall %m"
    delegate method csvFunctionLabel to c_Struct using "%c _dcall %m"
    delegate method filterGroupCaption to c_Struct using "%c _dcall %m"
    delegate method filterGroupToolTip to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            newIndex int64 {-1}
            resultIndex int64 {-1}
            statSpecIndex int64 {-1}
            statSourceType string {}
            statName string {}
            statSpecCaption string {}
            csvStatLabel string {}
            csvFunctionLabel string {}
            filterGroupCaption string {}
            filterGroupToolTip string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatConsumer::StatChangeList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatChangeList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatConsumer.StatChange]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatConsumer::StatSet
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatSet {
    component c_Struct -inherit true
    delegate method timestamp to c_Struct using "%c _dcall %m"
    delegate method stats to c_Struct using "%c _dcall %m"
    delegate method changes to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            timestamp int64 {0}
            stats StatConsumer.StatValueList {}
            changes StatConsumer.StatChangeList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatConsumer::StatSetList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatConsumer::StatSetList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatConsumer.StatSet]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::StatConsumer {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    # eStatValueType
    # StatValue
    # StatValueList
    # StatChange
    # StatChangeList
    # StatSet
    # StatSetList
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas\StatViewTemplate.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Struct -- StatViewTemplate::TemplateInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatViewTemplate::TemplateInfo {
    component c_Struct -inherit true
    delegate method name to c_Struct using "%c _dcall %m"
    delegate method statSourceTypes to c_Struct using "%c _dcall %m"
    delegate method userDefined to c_Struct using "%c _dcall %m"
    delegate method enabled to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            name string {}
            statSourceTypes string {}
            userDefined bool {}
            enabled bool {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatViewTemplate::TemplateInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatViewTemplate::TemplateInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatViewTemplate.TemplateInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::StatViewTemplate {
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
    component c_Base -public ServiceExtension -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::ServiceExtension %AUTO%}
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
    # TemplateInfo
    # TemplateInfoList
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
    typevariable _SIG_Create {
        {name statView type StatView direction out}
    }
    method Create {
        args
    } {
        $self _mCall $self $_SIG_Create Create args
    }
    typevariable _SIG_Add {
        {name templateInfo type StatViewTemplate.TemplateInfo direction inout}
        {name xml type string direction in}
    }
    method Add {
        args
    } {
        $self _mCall $self $_SIG_Add Add args
    }
    typevariable _SIG_Delete {
        {name name type string direction in}
    }
    method Delete {
        args
    } {
        $self _mCall $self $_SIG_Delete Delete args
    }
    typevariable _SIG_Exists {
        {name exists type bool direction out}
        {name name type string direction in}
    }
    method Exists {
        args
    } {
        $self _mCall $self $_SIG_Exists Exists args
    }
    typevariable _SIG_GetList {
        {name list type StatViewTemplate.TemplateInfoList direction out}
    }
    method GetList {
        args
    } {
        $self _mCall $self $_SIG_GetList GetList args
    }
    typevariable _SIG_GetViewXml {
        {name name type string direction in}
        {name xml type string direction out}
    }
    method GetViewXml {
        args
    } {
        $self _mCall $self $_SIG_GetViewXml GetViewXml args
    }
    typevariable _SIG_Rename {
        {name name type string direction in}
        {name newName type string direction in}
    }
    method Rename {
        args
    } {
        $self _mCall $self $_SIG_Rename Rename args
    }
    typevariable _SIG_Enable {
        {name name type string direction in}
        {name enable type bool direction in}
    }
    method Enable {
        args
    } {
        $self _mCall $self $_SIG_Enable Enable args
    }
    typevariable _SIG_SaveAs {
        {name name type string direction in}
        {name newName type string direction in}
    }
    method SaveAs {
        args
    } {
        $self _mCall $self $_SIG_SaveAs SaveAs args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas\StackManagerApp.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackManagerApp {
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
    component c_Base -public ServiceExtension -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::ServiceExtension %AUTO%}
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
        defaultImportExportDirectory PropertyString
    }
    #----------------------------------------------------------------------
    # defaultImportExportDirectory (PropertyString)
    # 
    #----------------------------------------------------------------------
    method defaultImportExportDirectory {args} {$self _mProp $self defaultImportExportDirectory $_propertyTypes(defaultImportExportDirectory) $args}
    method _ctor_defaultImportExportDirectory {args} {}
    method _dtor_defaultImportExportDirectory {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/BranchToNic.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::BranchToNic {
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
        firstPluginId PropertyString
        nicId PropertyString
        uniquePortId PropertyString
    }
    #----------------------------------------------------------------------
    # firstPluginId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method firstPluginId {args} {$self _mProp $self firstPluginId $_propertyTypes(firstPluginId) $args}
    method _ctor_firstPluginId {args} {}
    method _dtor_firstPluginId {args} {}
    #----------------------------------------------------------------------
    # nicId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method nicId {args} {$self _mProp $self nicId $_propertyTypes(nicId) $args}
    method _ctor_nicId {args} {}
    method _dtor_nicId {args} {}
    #----------------------------------------------------------------------
    # uniquePortId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method uniquePortId {args} {$self _mProp $self uniquePortId $_propertyTypes(uniquePortId) $args}
    method _ctor_uniquePortId {args} {}
    method _dtor_uniquePortId {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ATMPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ATMPlugin {
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
    component c_Base -public SonetATMBasePlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::SonetATMBasePlugin %AUTO%}
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
        firstVpi PropertyInt
        vpiStep PropertyInt
        vpiCount PropertyInt
        firstVci PropertyInt
        vciStep PropertyInt
        vciCount PropertyInt
        addressPerVci PropertyInt
        addressPerVpi PropertyInt
        atmPvcIncrMode PropertyInt
        encapsulation PropertyString
        mac PropertyString
        incrementBy PropertyString
        enabled PropertyBoolean
        atmInterfaceType PropertyString
        cosetEnable PropertyBoolean
        fillerCell PropertyString
        atmPatternMatching PropertyBoolean
        reassemblyTimeout PropertyInt
        atmRangeList PropertyNodeList
        pvcRangeList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # firstVpi (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents firstVpi for the first element in PvcRange list
    #----------------------------------------------------------------------
    method firstVpi {args} {$self _mProp $self firstVpi $_propertyTypes(firstVpi) $args {message {PvcRange list must be used instead. Represents firstVpi for the first element in PvcRange list}}}
    method _ctor_firstVpi {args} {}
    method _dtor_firstVpi {args} {}
    #----------------------------------------------------------------------
    # vpiStep (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents vpiStep for the first element in PvcRange list
    #----------------------------------------------------------------------
    method vpiStep {args} {$self _mProp $self vpiStep $_propertyTypes(vpiStep) $args {message {PvcRange list must be used instead. Represents vpiStep for the first element in PvcRange list}}}
    method _ctor_vpiStep {args} {}
    method _dtor_vpiStep {args} {}
    #----------------------------------------------------------------------
    # vpiCount (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents vpiCount for the first element in PvcRange list
    #----------------------------------------------------------------------
    method vpiCount {args} {$self _mProp $self vpiCount $_propertyTypes(vpiCount) $args {message {PvcRange list must be used instead. Represents vpiCount for the first element in PvcRange list}}}
    method _ctor_vpiCount {args} {}
    method _dtor_vpiCount {args} {}
    #----------------------------------------------------------------------
    # firstVci (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents firstVci for the first element in PvcRange list
    #----------------------------------------------------------------------
    method firstVci {args} {$self _mProp $self firstVci $_propertyTypes(firstVci) $args {message {PvcRange list must be used instead. Represents firstVci for the first element in PvcRange list}}}
    method _ctor_firstVci {args} {}
    method _dtor_firstVci {args} {}
    #----------------------------------------------------------------------
    # vciStep (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents vciStep for the first element in PvcRange list
    #----------------------------------------------------------------------
    method vciStep {args} {$self _mProp $self vciStep $_propertyTypes(vciStep) $args {message {PvcRange list must be used instead. Represents vciStep for the first element in PvcRange list}}}
    method _ctor_vciStep {args} {}
    method _dtor_vciStep {args} {}
    #----------------------------------------------------------------------
    # vciCount (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents vciCount for the first element in PvcRange list
    #----------------------------------------------------------------------
    method vciCount {args} {$self _mProp $self vciCount $_propertyTypes(vciCount) $args {message {PvcRange list must be used instead. Represents vciCount for the first element in PvcRange list}}}
    method _ctor_vciCount {args} {}
    method _dtor_vciCount {args} {}
    #----------------------------------------------------------------------
    # addressPerVci (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents addressPerVci for the first element in PvcRange list
    #----------------------------------------------------------------------
    method addressPerVci {args} {$self _mProp $self addressPerVci $_propertyTypes(addressPerVci) $args {message {PvcRange list must be used instead. Represents addressPerVci for the first element in PvcRange list}}}
    method _ctor_addressPerVci {args} {}
    method _dtor_addressPerVci {args} {}
    #----------------------------------------------------------------------
    # addressPerVpi (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents addressPerVpi for the first element in PvcRange list
    #----------------------------------------------------------------------
    method addressPerVpi {args} {$self _mProp $self addressPerVpi $_propertyTypes(addressPerVpi) $args {message {PvcRange list must be used instead. Represents addressPerVpi for the first element in PvcRange list}}}
    method _ctor_addressPerVpi {args} {}
    method _dtor_addressPerVpi {args} {}
    #----------------------------------------------------------------------
    # atmPvcIncrMode (PropertyInt)
    # OBSOLETE: PvcRange list must be used instead. Represents atmPvcIncrMode for the first element in PvcRange list
    #----------------------------------------------------------------------
    method atmPvcIncrMode {args} {$self _mProp $self atmPvcIncrMode $_propertyTypes(atmPvcIncrMode) $args {message {PvcRange list must be used instead. Represents atmPvcIncrMode for the first element in PvcRange list}}}
    method _ctor_atmPvcIncrMode {args} {}
    method _dtor_atmPvcIncrMode {args} {}
    #----------------------------------------------------------------------
    # encapsulation (PropertyString)
    # OBSOLETE: AtmRange list must be used instead. Represents encapsulation for the first element in AtmRange list
    #----------------------------------------------------------------------
    method encapsulation {args} {$self _mProp $self encapsulation $_propertyTypes(encapsulation) $args {message {AtmRange list must be used instead. Represents encapsulation for the first element in AtmRange list}}}
    method _ctor_encapsulation {args} {}
    method _dtor_encapsulation {args} {}
    #----------------------------------------------------------------------
    # mac (PropertyString)
    # OBSOLETE: AtmRange list must be used instead. Represents mac for the first element in AtmRange list
    #----------------------------------------------------------------------
    method mac {args} {$self _mProp $self mac $_propertyTypes(mac) $args {message {AtmRange list must be used instead. Represents mac for the first element in AtmRange list}}}
    method _ctor_mac {args} {}
    method _dtor_mac {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # OBSOLETE: AtmRange list must be used instead. Represents incrementBy for the first element in AtmRange list
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args {message {AtmRange list must be used instead. Represents incrementBy for the first element in AtmRange list}}}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # atmInterfaceType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method atmInterfaceType {args} {$self _mProp $self atmInterfaceType $_propertyTypes(atmInterfaceType) $args}
    method _ctor_atmInterfaceType {args} {}
    method _dtor_atmInterfaceType {args} {}
    #----------------------------------------------------------------------
    # cosetEnable (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method cosetEnable {args} {$self _mProp $self cosetEnable $_propertyTypes(cosetEnable) $args}
    method _ctor_cosetEnable {args} {}
    method _dtor_cosetEnable {args} {}
    #----------------------------------------------------------------------
    # fillerCell (PropertyString)
    # 
    #----------------------------------------------------------------------
    method fillerCell {args} {$self _mProp $self fillerCell $_propertyTypes(fillerCell) $args}
    method _ctor_fillerCell {args} {}
    method _dtor_fillerCell {args} {}
    #----------------------------------------------------------------------
    # atmPatternMatching (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method atmPatternMatching {args} {$self _mProp $self atmPatternMatching $_propertyTypes(atmPatternMatching) $args}
    method _ctor_atmPatternMatching {args} {}
    method _dtor_atmPatternMatching {args} {}
    #----------------------------------------------------------------------
    # reassemblyTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method reassemblyTimeout {args} {$self _mProp $self reassemblyTimeout $_propertyTypes(reassemblyTimeout) $args}
    method _ctor_reassemblyTimeout {args} {}
    method _dtor_reassemblyTimeout {args} {}
    #----------------------------------------------------------------------
    # atmRangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component atmRangeList -public atmRangeList
    method _ctor_atmRangeList {args} {
        set atmRangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype AtmRange \
            -parent $self \
            -name atmRangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_atmRangeList {args} {catch {$atmRangeList destroy}}
    #----------------------------------------------------------------------
    # pvcRangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component pvcRangeList -public pvcRangeList
    method _ctor_pvcRangeList {args} {
        set pvcRangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype PvcRange \
            -parent $self \
            -name pvcRangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_pvcRangeList {args} {catch {$pvcRangeList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/AtmRange.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::AtmRange {
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
        name PropertyString
        encapsulation PropertyString
        mac PropertyString
        incrementBy PropertyString
        mtu PropertyInt
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # encapsulation (PropertyString)
    # 
    #----------------------------------------------------------------------
    method encapsulation {args} {$self _mProp $self encapsulation $_propertyTypes(encapsulation) $args}
    method _ctor_encapsulation {args} {}
    method _dtor_encapsulation {args} {}
    #----------------------------------------------------------------------
    # mac (PropertyString)
    # 
    #----------------------------------------------------------------------
    method mac {args} {$self _mProp $self mac $_propertyTypes(mac) $args}
    method _ctor_mac {args} {}
    method _dtor_mac {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # mtu (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method mtu {args} {$self _mProp $self mtu $_propertyTypes(mtu) $args}
    method _ctor_mtu {args} {}
    method _dtor_mtu {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PvcRange.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PvcRange {
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
        name PropertyString
        vpiFirstId PropertyInt
        vpiIncrementStep PropertyInt
        vpiIncrement PropertyInt
        vpiUniqueCount PropertyInt
        vciFirstId PropertyInt
        vciIncrementStep PropertyInt
        vciIncrement PropertyInt
        vciUniqueCount PropertyInt
        incrementMode PropertyInt
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # vpiFirstId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vpiFirstId {args} {$self _mProp $self vpiFirstId $_propertyTypes(vpiFirstId) $args}
    method _ctor_vpiFirstId {args} {}
    method _dtor_vpiFirstId {args} {}
    #----------------------------------------------------------------------
    # vpiIncrementStep (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vpiIncrementStep {args} {$self _mProp $self vpiIncrementStep $_propertyTypes(vpiIncrementStep) $args}
    method _ctor_vpiIncrementStep {args} {}
    method _dtor_vpiIncrementStep {args} {}
    #----------------------------------------------------------------------
    # vpiIncrement (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vpiIncrement {args} {$self _mProp $self vpiIncrement $_propertyTypes(vpiIncrement) $args}
    method _ctor_vpiIncrement {args} {}
    method _dtor_vpiIncrement {args} {}
    #----------------------------------------------------------------------
    # vpiUniqueCount (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vpiUniqueCount {args} {$self _mProp $self vpiUniqueCount $_propertyTypes(vpiUniqueCount) $args}
    method _ctor_vpiUniqueCount {args} {}
    method _dtor_vpiUniqueCount {args} {}
    #----------------------------------------------------------------------
    # vciFirstId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vciFirstId {args} {$self _mProp $self vciFirstId $_propertyTypes(vciFirstId) $args}
    method _ctor_vciFirstId {args} {}
    method _dtor_vciFirstId {args} {}
    #----------------------------------------------------------------------
    # vciIncrementStep (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vciIncrementStep {args} {$self _mProp $self vciIncrementStep $_propertyTypes(vciIncrementStep) $args}
    method _ctor_vciIncrementStep {args} {}
    method _dtor_vciIncrementStep {args} {}
    #----------------------------------------------------------------------
    # vciIncrement (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vciIncrement {args} {$self _mProp $self vciIncrement $_propertyTypes(vciIncrement) $args}
    method _ctor_vciIncrement {args} {}
    method _dtor_vciIncrement {args} {}
    #----------------------------------------------------------------------
    # vciUniqueCount (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method vciUniqueCount {args} {$self _mProp $self vciUniqueCount $_propertyTypes(vciUniqueCount) $args}
    method _ctor_vciUniqueCount {args} {}
    method _dtor_vciUniqueCount {args} {}
    #----------------------------------------------------------------------
    # incrementMode (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method incrementMode {args} {$self _mProp $self incrementMode $_propertyTypes(incrementMode) $args}
    method _ctor_incrementMode {args} {}
    method _dtor_incrementMode {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/AggregatedStat.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::AggregatedStat {
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
    component c_Base -public StatSpec -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::StatSpec %AUTO%}
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
        statFilterList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # statFilterList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statFilterList -public statFilterList
    method _ctor_statFilterList {args} {
        set statFilterList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatFilter \
            -parent $self \
            -name statFilterList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statFilterList {args} {catch {$statFilterList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/CardPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::CardPlugin {
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
    component c_Base -public DataDrivenFormBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::DataDrivenFormBase %AUTO%}
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ChartAxis.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChartAxis {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ChartXAxis.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChartXAxis {
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
    component c_Base -public ChartAxis -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::ChartAxis %AUTO%}
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
        scrollScale PropertyBoolean
    }
    #----------------------------------------------------------------------
    # scrollScale (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method scrollScale {args} {$self _mProp $self scrollScale $_propertyTypes(scrollScale) $args}
    method _ctor_scrollScale {args} {}
    method _dtor_scrollScale {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ChartYAxis.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChartYAxis {
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
    component c_Base -public ChartAxis -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::ChartAxis %AUTO%}
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
        yAxisExtent PropertyInt
        yAxisRange PropertyString
        yAxisRangeMax PropertyInt
        yAxisRangeMin PropertyInt
        autoScale PropertyBoolean
        logScale PropertyBoolean
        yAxisScrollScale PropertyBoolean
    }
    #----------------------------------------------------------------------
    # yAxisExtent (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method yAxisExtent {args} {$self _mProp $self yAxisExtent $_propertyTypes(yAxisExtent) $args}
    method _ctor_yAxisExtent {args} {}
    method _dtor_yAxisExtent {args} {}
    #----------------------------------------------------------------------
    # yAxisRange (PropertyString)
    # 
    #----------------------------------------------------------------------
    method yAxisRange {args} {$self _mProp $self yAxisRange $_propertyTypes(yAxisRange) $args}
    method _ctor_yAxisRange {args} {}
    method _dtor_yAxisRange {args} {}
    #----------------------------------------------------------------------
    # yAxisRangeMax (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method yAxisRangeMax {args} {$self _mProp $self yAxisRangeMax $_propertyTypes(yAxisRangeMax) $args}
    method _ctor_yAxisRangeMax {args} {}
    method _dtor_yAxisRangeMax {args} {}
    #----------------------------------------------------------------------
    # yAxisRangeMin (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method yAxisRangeMin {args} {$self _mProp $self yAxisRangeMin $_propertyTypes(yAxisRangeMin) $args}
    method _ctor_yAxisRangeMin {args} {}
    method _dtor_yAxisRangeMin {args} {}
    #----------------------------------------------------------------------
    # autoScale (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method autoScale {args} {$self _mProp $self autoScale $_propertyTypes(autoScale) $args}
    method _ctor_autoScale {args} {}
    method _dtor_autoScale {args} {}
    #----------------------------------------------------------------------
    # logScale (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method logScale {args} {$self _mProp $self logScale $_propertyTypes(logScale) $args}
    method _ctor_logScale {args} {}
    method _dtor_logScale {args} {}
    #----------------------------------------------------------------------
    # yAxisScrollScale (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method yAxisScrollScale {args} {$self _mProp $self yAxisScrollScale $_propertyTypes(yAxisScrollScale) $args}
    method _ctor_yAxisScrollScale {args} {}
    method _dtor_yAxisScrollScale {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ChassisCard.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisCard {
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
        cardId PropertyInt
        cardType PropertyString
    }
    #----------------------------------------------------------------------
    # cardId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method cardId {args} {$self _mProp $self cardId $_propertyTypes(cardId) $args}
    method _ctor_cardId {args} {}
    method _dtor_cardId {args} {}
    #----------------------------------------------------------------------
    # cardType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method cardType {args} {$self _mProp $self cardType $_propertyTypes(cardType) $args}
    method _ctor_cardType {args} {}
    method _dtor_cardType {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Chassis.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Chassis {
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
        dns PropertyString
        cableLength PropertyDouble
        physicalChain PropertyBoolean
        masterChassis PropertyString
        managementIP PropertyString
        chassisType PropertyString
        cardList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # dns (PropertyString)
    # 
    #----------------------------------------------------------------------
    method dns {args} {$self _mProp $self dns $_propertyTypes(dns) $args}
    method _ctor_dns {args} {}
    method _dtor_dns {args} {}
    #----------------------------------------------------------------------
    # cableLength (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method cableLength {args} {$self _mProp $self cableLength $_propertyTypes(cableLength) $args}
    method _ctor_cableLength {args} {}
    method _dtor_cableLength {args} {}
    #----------------------------------------------------------------------
    # physicalChain (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method physicalChain {args} {$self _mProp $self physicalChain $_propertyTypes(physicalChain) $args}
    method _ctor_physicalChain {args} {}
    method _dtor_physicalChain {args} {}
    #----------------------------------------------------------------------
    # masterChassis (PropertyString)
    # 
    #----------------------------------------------------------------------
    method masterChassis {args} {$self _mProp $self masterChassis $_propertyTypes(masterChassis) $args}
    method _ctor_masterChassis {args} {}
    method _dtor_masterChassis {args} {}
    #----------------------------------------------------------------------
    # managementIP (PropertyString)
    # 
    #----------------------------------------------------------------------
    method managementIP {args} {$self _mProp $self managementIP $_propertyTypes(managementIP) $args}
    method _ctor_managementIP {args} {}
    method _dtor_managementIP {args} {}
    #----------------------------------------------------------------------
    # chassisType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method chassisType {args} {$self _mProp $self chassisType $_propertyTypes(chassisType) $args}
    method _ctor_chassisType {args} {}
    method _dtor_chassisType {args} {}
    #----------------------------------------------------------------------
    # cardList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component cardList -public cardList
    method _ctor_cardList {args} {
        set cardList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype ChassisCard \
            -parent $self \
            -name cardList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_cardList {args} {catch {$cardList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ChassisConfig.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Struct -- ChassisConfig::PortAddress
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortAddress {
    component c_Struct -inherit true
    delegate method chassisHostName to c_Struct using "%c _dcall %m"
    delegate method cardId to c_Struct using "%c _dcall %m"
    delegate method portId to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassisHostName string {}
            cardId int32 {0}
            portId int32 {0}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::PortAddressVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortAddressVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.PortAddress]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::eLinkState
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::eLinkState {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kLinkUp
    typevariable kLinkLoopBack
    typevariable kLinkPPPUp
    typevariable kLinkDown
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kLinkUp]} {
            set kLinkUp [$type create %AUTO%];$kLinkUp Set kLinkUp
            set _tv [mytypevar kLinkUp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kLinkLoopBack]} {
            set kLinkLoopBack [$type create %AUTO%];$kLinkLoopBack Set kLinkLoopBack
            set _tv [mytypevar kLinkLoopBack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kLinkPPPUp]} {
            set kLinkPPPUp [$type create %AUTO%];$kLinkPPPUp Set kLinkPPPUp
            set _tv [mytypevar kLinkPPPUp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kLinkDown]} {
            set kLinkDown [$type create %AUTO%];$kLinkDown Set kLinkDown
            set _tv [mytypevar kLinkDown]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kLinkUp
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kLinkUp
      1 kLinkLoopBack
      2 kLinkPPPUp
      3 kLinkDown
    }
    typevariable m_encoder -array {
      kLinkUp 0
      kLinkLoopBack 1
      kLinkPPPUp 2
      kLinkDown 3
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::eLayer1Type
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::eLayer1Type {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kLayer1GenericType
    typevariable kBasicEthernetGenericType
    typevariable kEthernetFiberType
    typevariable kEthernetFiberOnlyType
    typevariable kEthernetGenericType
    typevariable kEthernetELMType
    typevariable kEthernetDualPhyType
    typevariable kGigabitEthernetGenericType
    typevariable kGigabitXAUIType
    typevariable kGigabitXenPakType
    typevariable kFiberGenericType
    typevariable kATMGenericType
    typevariable kPOSGenericType
    typevariable kTenGigabitWANType
    typevariable kTenGigabitLANType
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kLayer1GenericType]} {
            set kLayer1GenericType [$type create %AUTO%];$kLayer1GenericType Set kLayer1GenericType
            set _tv [mytypevar kLayer1GenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kBasicEthernetGenericType]} {
            set kBasicEthernetGenericType [$type create %AUTO%];$kBasicEthernetGenericType Set kBasicEthernetGenericType
            set _tv [mytypevar kBasicEthernetGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEthernetFiberType]} {
            set kEthernetFiberType [$type create %AUTO%];$kEthernetFiberType Set kEthernetFiberType
            set _tv [mytypevar kEthernetFiberType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEthernetFiberOnlyType]} {
            set kEthernetFiberOnlyType [$type create %AUTO%];$kEthernetFiberOnlyType Set kEthernetFiberOnlyType
            set _tv [mytypevar kEthernetFiberOnlyType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEthernetGenericType]} {
            set kEthernetGenericType [$type create %AUTO%];$kEthernetGenericType Set kEthernetGenericType
            set _tv [mytypevar kEthernetGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEthernetELMType]} {
            set kEthernetELMType [$type create %AUTO%];$kEthernetELMType Set kEthernetELMType
            set _tv [mytypevar kEthernetELMType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEthernetDualPhyType]} {
            set kEthernetDualPhyType [$type create %AUTO%];$kEthernetDualPhyType Set kEthernetDualPhyType
            set _tv [mytypevar kEthernetDualPhyType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGigabitEthernetGenericType]} {
            set kGigabitEthernetGenericType [$type create %AUTO%];$kGigabitEthernetGenericType Set kGigabitEthernetGenericType
            set _tv [mytypevar kGigabitEthernetGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGigabitXAUIType]} {
            set kGigabitXAUIType [$type create %AUTO%];$kGigabitXAUIType Set kGigabitXAUIType
            set _tv [mytypevar kGigabitXAUIType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGigabitXenPakType]} {
            set kGigabitXenPakType [$type create %AUTO%];$kGigabitXenPakType Set kGigabitXenPakType
            set _tv [mytypevar kGigabitXenPakType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFiberGenericType]} {
            set kFiberGenericType [$type create %AUTO%];$kFiberGenericType Set kFiberGenericType
            set _tv [mytypevar kFiberGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kATMGenericType]} {
            set kATMGenericType [$type create %AUTO%];$kATMGenericType Set kATMGenericType
            set _tv [mytypevar kATMGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPOSGenericType]} {
            set kPOSGenericType [$type create %AUTO%];$kPOSGenericType Set kPOSGenericType
            set _tv [mytypevar kPOSGenericType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTenGigabitWANType]} {
            set kTenGigabitWANType [$type create %AUTO%];$kTenGigabitWANType Set kTenGigabitWANType
            set _tv [mytypevar kTenGigabitWANType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTenGigabitLANType]} {
            set kTenGigabitLANType [$type create %AUTO%];$kTenGigabitLANType Set kTenGigabitLANType
            set _tv [mytypevar kTenGigabitLANType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kLayer1GenericType
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kLayer1GenericType
      1 kBasicEthernetGenericType
      2 kEthernetFiberType
      3 kEthernetFiberOnlyType
      4 kEthernetGenericType
      5 kEthernetELMType
      6 kEthernetDualPhyType
      7 kGigabitEthernetGenericType
      8 kGigabitXAUIType
      9 kGigabitXenPakType
      10 kFiberGenericType
      11 kATMGenericType
      12 kPOSGenericType
      13 kTenGigabitWANType
      14 kTenGigabitLANType
    }
    typevariable m_encoder -array {
      kLayer1GenericType 0
      kBasicEthernetGenericType 1
      kEthernetFiberType 2
      kEthernetFiberOnlyType 3
      kEthernetGenericType 4
      kEthernetELMType 5
      kEthernetDualPhyType 6
      kGigabitEthernetGenericType 7
      kGigabitXAUIType 8
      kGigabitXenPakType 9
      kFiberGenericType 10
      kATMGenericType 11
      kPOSGenericType 12
      kTenGigabitWANType 13
      kTenGigabitLANType 14
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::eFileFormat
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::eFileFormat {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kTxtFormat
    typevariable kCapFormat
    typevariable kEncFormat
    typevariable kEncOldFormat
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kTxtFormat]} {
            set kTxtFormat [$type create %AUTO%];$kTxtFormat Set kTxtFormat
            set _tv [mytypevar kTxtFormat]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kCapFormat]} {
            set kCapFormat [$type create %AUTO%];$kCapFormat Set kCapFormat
            set _tv [mytypevar kCapFormat]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEncFormat]} {
            set kEncFormat [$type create %AUTO%];$kEncFormat Set kEncFormat
            set _tv [mytypevar kEncFormat]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEncOldFormat]} {
            set kEncOldFormat [$type create %AUTO%];$kEncOldFormat Set kEncOldFormat
            set _tv [mytypevar kEncOldFormat]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kTxtFormat
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kTxtFormat
      1 kCapFormat
      2 kEncFormat
      3 kEncOldFormat
    }
    typevariable m_encoder -array {
      kTxtFormat 0
      kCapFormat 1
      kEncFormat 2
      kEncOldFormat 3
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::Layer1TypeList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::Layer1TypeList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.eLayer1Type]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::Port
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::Port {
    component c_Struct -inherit true
    delegate method portAddr to c_Struct using "%c _dcall %m"
    delegate method typeName to c_Struct using "%c _dcall %m"
    delegate method owner to c_Struct using "%c _dcall %m"
    delegate method linkSt to c_Struct using "%c _dcall %m"
    delegate method speed to c_Struct using "%c _dcall %m"
    delegate method duplex to c_Struct using "%c _dcall %m"
    delegate method uniquePortNo to c_Struct using "%c _dcall %m"
    delegate method layer1Class to c_Struct using "%c _dcall %m"
    delegate method allowedLayer1Type to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            portAddr ChassisConfig.PortAddress {}
            typeName string {}
            owner string {}
            linkSt ChassisConfig.eLinkState {}
            speed int32 {}
            duplex int32 {}
            uniquePortNo string {}
            layer1Class string {}
            allowedLayer1Type ChassisConfig.Layer1TypeList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::PortVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.Port]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::Card
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::Card {
    component c_Struct -inherit true
    delegate method cardId to c_Struct using "%c _dcall %m"
    delegate method typeName to c_Struct using "%c _dcall %m"
    delegate method cardVersion to c_Struct using "%c _dcall %m"
    delegate method fpgaVersion to c_Struct using "%c _dcall %m"
    delegate method portVector to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            cardId int32 {}
            typeName string {}
            cardVersion int32 {}
            fpgaVersion int32 {}
            portVector ChassisConfig.PortVector {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::CardVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::CardVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.Card]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::StringVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::StringVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::XPChassis
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::XPChassis {
    component c_Struct -inherit true
    delegate method chassisId to c_Struct using "%c _dcall %m"
    delegate method chassisName to c_Struct using "%c _dcall %m"
    delegate method managementIp to c_Struct using "%c _dcall %m"
    delegate method typeName to c_Struct using "%c _dcall %m"
    delegate method sequenceNumber to c_Struct using "%c _dcall %m"
    delegate method cardVector to c_Struct using "%c _dcall %m"
    delegate method master to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassisId int32 {}
            chassisName string {}
            managementIp string {}
            typeName string {}
            sequenceNumber int32 {}
            cardVector ChassisConfig.CardVector {}
            master bool {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::eTimeSource
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::eTimeSource {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kInternal
    typevariable kGpsServer
    typevariable kCdma
    typevariable kGpsAfd1Server
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kInternal]} {
            set kInternal [$type create %AUTO%];$kInternal Set kInternal
            set _tv [mytypevar kInternal]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGpsServer]} {
            set kGpsServer [$type create %AUTO%];$kGpsServer Set kGpsServer
            set _tv [mytypevar kGpsServer]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kCdma]} {
            set kCdma [$type create %AUTO%];$kCdma Set kCdma
            set _tv [mytypevar kCdma]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGpsAfd1Server]} {
            set kGpsAfd1Server [$type create %AUTO%];$kGpsAfd1Server Set kGpsAfd1Server
            set _tv [mytypevar kGpsAfd1Server]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kInternal
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kInternal
      1 kGpsServer
      2 kCdma
      3 kGpsAfd1Server
    }
    typevariable m_encoder -array {
      kInternal 0
      kGpsServer 1
      kCdma 2
      kGpsAfd1Server 3
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::XPChassis2
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::XPChassis2 {
    component c_Struct -inherit true
    delegate method chassisId to c_Struct using "%c _dcall %m"
    delegate method chassisName to c_Struct using "%c _dcall %m"
    delegate method managementIp to c_Struct using "%c _dcall %m"
    delegate method typeName to c_Struct using "%c _dcall %m"
    delegate method sequenceNumber to c_Struct using "%c _dcall %m"
    delegate method cardVector to c_Struct using "%c _dcall %m"
    delegate method master to c_Struct using "%c _dcall %m"
    delegate method cableLength to c_Struct using "%c _dcall %m"
    delegate method timeSource to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassisId int32 {}
            chassisName string {}
            managementIp string {}
            typeName string {}
            sequenceNumber int32 {}
            cardVector ChassisConfig.CardVector {}
            master bool {}
            cableLength int32 {}
            timeSource ChassisConfig.eTimeSource {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::Layer1
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::Layer1 {
    component c_Struct -inherit true
    delegate method chassisHostName to c_Struct using "%c _dcall %m"
    delegate method xml to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassisHostName string {}
            xml string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::PackagePort
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PackagePort {
    component c_Struct -inherit true
    delegate method portAddr to c_Struct using "%c _dcall %m"
    delegate method packages to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            portAddr ChassisConfig.PortAddress {}
            packages ChassisConfig.StringVector {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::Layer1ConfigVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::Layer1ConfigVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.Layer1]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::PackagePortVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PackagePortVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.PackagePort]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::LongVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::LongVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int32]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::BoolVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::BoolVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype bool]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::ChNicAddress
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::ChNicAddress {
    component c_Struct -inherit true
    delegate method chassisIp to c_Struct using "%c _dcall %m"
    delegate method cardId to c_Struct using "%c _dcall %m"
    delegate method portId to c_Struct using "%c _dcall %m"
    delegate method nicId to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassisIp string {}
            cardId int32 {}
            portId int32 {}
            nicId int32 {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::ChNic
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::ChNic {
    component c_Struct -inherit true
    delegate method nicAddress to c_Struct using "%c _dcall %m"
    delegate method typeName to c_Struct using "%c _dcall %m"
    delegate method linkState to c_Struct using "%c _dcall %m"
    delegate method speed to c_Struct using "%c _dcall %m"
    delegate method duplex to c_Struct using "%c _dcall %m"
    delegate method physicalType to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            nicAddress ChassisConfig.ChNicAddress {}
            typeName string {}
            linkState int32 {}
            speed int32 {}
            duplex int32 {}
            physicalType ChassisConfig.eLayer1Type {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::SeqNicVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::SeqNicVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.ChNic]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::SeqNicAddressVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::SeqNicAddressVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.ChNicAddress]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::ePortAttribute
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::ePortAttribute {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kControlData
    typevariable kPacketGroup
    typevariable kDataCaptureCapability
    typevariable kMediaType
    typevariable kCardMode
    typevariable kSpeed
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kControlData]} {
            set kControlData [$type create %AUTO%];$kControlData Set kControlData
            set _tv [mytypevar kControlData]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPacketGroup]} {
            set kPacketGroup [$type create %AUTO%];$kPacketGroup Set kPacketGroup
            set _tv [mytypevar kPacketGroup]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDataCaptureCapability]} {
            set kDataCaptureCapability [$type create %AUTO%];$kDataCaptureCapability Set kDataCaptureCapability
            set _tv [mytypevar kDataCaptureCapability]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMediaType]} {
            set kMediaType [$type create %AUTO%];$kMediaType Set kMediaType
            set _tv [mytypevar kMediaType]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kCardMode]} {
            set kCardMode [$type create %AUTO%];$kCardMode Set kCardMode
            set _tv [mytypevar kCardMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kSpeed]} {
            set kSpeed [$type create %AUTO%];$kSpeed Set kSpeed
            set _tv [mytypevar kSpeed]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kControlData
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kControlData
      1 kPacketGroup
      2 kDataCaptureCapability
      3 kMediaType
      4 kCardMode
      5 kSpeed
    }
    typevariable m_encoder -array {
      kControlData 0
      kPacketGroup 1
      kDataCaptureCapability 2
      kMediaType 3
      kCardMode 4
      kSpeed 5
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- ChassisConfig::ePortCapabilityValues
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::ePortCapabilityValues {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kControl
    typevariable kData
    typevariable kRegularPacketGroup
    typevariable kWidePacketGroup
    typevariable kDataCaptureCapable
    typevariable kCopper
    typevariable kFiber
    typevariable kGenericEthernetMode
    typevariable kTenGigLANMode
    typevariable kTenGigWANMode
    typevariable kATMMode
    typevariable kPOSMode
    typevariable kOC48POSMode
    typevariable kOC192POSMode
    typevariable kHalf10
    typevariable kFull10
    typevariable kHalf100
    typevariable kFull100
    typevariable kFull1000
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kControl]} {
            set kControl [$type create %AUTO%];$kControl Set kControl
            set _tv [mytypevar kControl]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kData]} {
            set kData [$type create %AUTO%];$kData Set kData
            set _tv [mytypevar kData]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRegularPacketGroup]} {
            set kRegularPacketGroup [$type create %AUTO%];$kRegularPacketGroup Set kRegularPacketGroup
            set _tv [mytypevar kRegularPacketGroup]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kWidePacketGroup]} {
            set kWidePacketGroup [$type create %AUTO%];$kWidePacketGroup Set kWidePacketGroup
            set _tv [mytypevar kWidePacketGroup]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDataCaptureCapable]} {
            set kDataCaptureCapable [$type create %AUTO%];$kDataCaptureCapable Set kDataCaptureCapable
            set _tv [mytypevar kDataCaptureCapable]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kCopper]} {
            set kCopper [$type create %AUTO%];$kCopper Set kCopper
            set _tv [mytypevar kCopper]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFiber]} {
            set kFiber [$type create %AUTO%];$kFiber Set kFiber
            set _tv [mytypevar kFiber]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kGenericEthernetMode]} {
            set kGenericEthernetMode [$type create %AUTO%];$kGenericEthernetMode Set kGenericEthernetMode
            set _tv [mytypevar kGenericEthernetMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTenGigLANMode]} {
            set kTenGigLANMode [$type create %AUTO%];$kTenGigLANMode Set kTenGigLANMode
            set _tv [mytypevar kTenGigLANMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTenGigWANMode]} {
            set kTenGigWANMode [$type create %AUTO%];$kTenGigWANMode Set kTenGigWANMode
            set _tv [mytypevar kTenGigWANMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kATMMode]} {
            set kATMMode [$type create %AUTO%];$kATMMode Set kATMMode
            set _tv [mytypevar kATMMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPOSMode]} {
            set kPOSMode [$type create %AUTO%];$kPOSMode Set kPOSMode
            set _tv [mytypevar kPOSMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kOC48POSMode]} {
            set kOC48POSMode [$type create %AUTO%];$kOC48POSMode Set kOC48POSMode
            set _tv [mytypevar kOC48POSMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kOC192POSMode]} {
            set kOC192POSMode [$type create %AUTO%];$kOC192POSMode Set kOC192POSMode
            set _tv [mytypevar kOC192POSMode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kHalf10]} {
            set kHalf10 [$type create %AUTO%];$kHalf10 Set kHalf10
            set _tv [mytypevar kHalf10]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFull10]} {
            set kFull10 [$type create %AUTO%];$kFull10 Set kFull10
            set _tv [mytypevar kFull10]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kHalf100]} {
            set kHalf100 [$type create %AUTO%];$kHalf100 Set kHalf100
            set _tv [mytypevar kHalf100]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFull100]} {
            set kFull100 [$type create %AUTO%];$kFull100 Set kFull100
            set _tv [mytypevar kFull100]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFull1000]} {
            set kFull1000 [$type create %AUTO%];$kFull1000 Set kFull1000
            set _tv [mytypevar kFull1000]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kControl
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kControl
      1 kData
      2 kRegularPacketGroup
      3 kWidePacketGroup
      4 kDataCaptureCapable
      5 kCopper
      6 kFiber
      7 kGenericEthernetMode
      8 kTenGigLANMode
      9 kTenGigWANMode
      10 kATMMode
      11 kPOSMode
      12 kOC48POSMode
      13 kOC192POSMode
      14 kHalf10
      15 kFull10
      16 kHalf100
      17 kFull100
      18 kFull1000
    }
    typevariable m_encoder -array {
      kControl 0
      kData 1
      kRegularPacketGroup 2
      kWidePacketGroup 3
      kDataCaptureCapable 4
      kCopper 5
      kFiber 6
      kGenericEthernetMode 7
      kTenGigLANMode 8
      kTenGigWANMode 9
      kATMMode 10
      kPOSMode 11
      kOC48POSMode 12
      kOC192POSMode 13
      kHalf10 14
      kFull10 15
      kHalf100 16
      kFull100 17
      kFull1000 18
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::CapabilityMatrix
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::CapabilityMatrix {
    component c_Struct -inherit true
    delegate method portAttrib to c_Struct using "%c _dcall %m"
    delegate method featureCapability to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            portAttrib ChassisConfig.ePortCapabilityValues {}
            featureCapability bool {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::CapabilityMatrixVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::CapabilityMatrixVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.CapabilityMatrix]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::PortAddressWithProperties
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortAddressWithProperties {
    component c_Struct -inherit true
    delegate method cardID to c_Struct using "%c _dcall %m"
    delegate method portID to c_Struct using "%c _dcall %m"
    delegate method capabilityVector to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            cardID int32 {}
            portID int32 {}
            capabilityVector ChassisConfig.CapabilityMatrixVector {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::PortAddressWithPropertiesVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortAddressWithPropertiesVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.PortAddressWithProperties]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::PortCapabilityEnumVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::PortCapabilityEnumVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.ePortCapabilityValues]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- ChassisConfig::CPDNicAddress
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::CPDNicAddress {
    component c_Struct -inherit true
    delegate method machineIp to c_Struct using "%c _dcall %m"
    delegate method nicId to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            machineIp string {}
            nicId int32 {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- ChassisConfig::CPDNicAddressVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ChassisConfig::CPDNicAddressVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype ChassisConfig.CPDNicAddress]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::ChassisConfig {
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
    # PortAddress
    # PortAddressVector
    # eLinkState
    # eLayer1Type
    # eFileFormat
    # Layer1TypeList
    # Port
    # PortVector
    # Card
    # CardVector
    # StringVector
    # XPChassis
    # eTimeSource
    # XPChassis2
    # Layer1
    # PackagePort
    # Layer1ConfigVector
    # PackagePortVector
    # LongVector
    # BoolVector
    # ChNicAddress
    # ChNic
    # SeqNicVector
    # SeqNicAddressVector
    # ePortAttribute
    # ePortCapabilityValues
    # CapabilityMatrix
    # CapabilityMatrixVector
    # PortAddressWithProperties
    # PortAddressWithPropertiesVector
    # PortCapabilityEnumVector
    # CPDNicAddress
    # CPDNicAddressVector
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
    typevariable _SIG_EstablishConnection {
        {name chassisHostName type string direction in}
        {name retval type bool direction out}
    }
    method EstablishConnection {
        args
    } {
        $self _mCall $self $_SIG_EstablishConnection EstablishConnection args
    }
    typevariable _SIG_TakeOwnership {
        {name ports type ChassisConfig.StringVector direction in}
        {name forced type bool direction in}
    }
    method TakeOwnership {
        args
    } {
        $self _mCall $self $_SIG_TakeOwnership TakeOwnership args
    }
    typevariable _SIG_ClearOwnership {
        {name ports type ChassisConfig.StringVector direction in}
        {name forced type bool direction in}
    }
    method ClearOwnership {
        args
    } {
        $self _mCall $self $_SIG_ClearOwnership ClearOwnership args
    }
    typevariable _SIG_TakeOwnership_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name forced type bool direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method TakeOwnership_V2 {
        args
    } {
        $self _mCall $self $_SIG_TakeOwnership_V2 TakeOwnership_V2 args
    }
    typevariable _SIG_ClearOwnership_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name forced type bool direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method ClearOwnership_V2 {
        args
    } {
        $self _mCall $self $_SIG_ClearOwnership_V2 ClearOwnership_V2 args
    }
    typevariable _SIG_GetPortInformation {
        {name ports type ChassisConfig.StringVector direction in}
        {name portInfo type ChassisConfig.PortVector direction out}
    }
    method GetPortInformation {
        args
    } {
        $self _mCall $self $_SIG_GetPortInformation GetPortInformation args
    }
    typevariable _SIG_ResetPortCpu {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method ResetPortCpu {
        args
    } {
        $self _mCall $self $_SIG_ResetPortCpu ResetPortCpu args
    }
    typevariable _SIG_ResetPortCpu_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method ResetPortCpu_V2 {
        args
    } {
        $self _mCall $self $_SIG_ResetPortCpu_V2 ResetPortCpu_V2 args
    }
    typevariable _SIG_SetFactoryDefaults {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method SetFactoryDefaults {
        args
    } {
        $self _mCall $self $_SIG_SetFactoryDefaults SetFactoryDefaults args
    }
    typevariable _SIG_SetFactoryDefaults_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method SetFactoryDefaults_V2 {
        args
    } {
        $self _mCall $self $_SIG_SetFactoryDefaults_V2 SetFactoryDefaults_V2 args
    }
    typevariable _SIG_SetModeDefaults {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method SetModeDefaults {
        args
    } {
        $self _mCall $self $_SIG_SetModeDefaults SetModeDefaults args
    }
    typevariable _SIG_SetModeDefaults_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method SetModeDefaults_V2 {
        args
    } {
        $self _mCall $self $_SIG_SetModeDefaults_V2 SetModeDefaults_V2 args
    }
    typevariable _SIG_ConfigurePhysical {
        {name ports type ChassisConfig.StringVector direction in}
        {name xml type string direction in}
    }
    method ConfigurePhysical {
        args
    } {
        $self _mCall $self $_SIG_ConfigurePhysical ConfigurePhysical args
    }
    typevariable _SIG_SetBaseAddress {
        {name chassisHostName type string direction in}
        {name baseIpAddress type string direction in}
    }
    method SetBaseAddress {
        args
    } {
        $self _mCall $self $_SIG_SetBaseAddress SetBaseAddress args
    }
    typevariable _SIG_WriteChangesToPort {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method WriteChangesToPort {
        args
    } {
        $self _mCall $self $_SIG_WriteChangesToPort WriteChangesToPort args
    }
    typevariable _SIG_ClearPcpuGrpTimeStamp {
        {name chassisHostName type string direction in}
    }
    method ClearPcpuGrpTimeStamp {
        args
    } {
        $self _mCall $self $_SIG_ClearPcpuGrpTimeStamp ClearPcpuGrpTimeStamp args
    }
    typevariable _SIG_StartCapture {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StartCapture {
        args
    } {
        $self _mCall $self $_SIG_StartCapture StartCapture args
    }
    typevariable _SIG_StopCapture {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StopCapture {
        args
    } {
        $self _mCall $self $_SIG_StopCapture StopCapture args
    }
    typevariable _SIG_StartTransmit {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StartTransmit {
        args
    } {
        $self _mCall $self $_SIG_StartTransmit StartTransmit args
    }
    typevariable _SIG_StopTransmit {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StopTransmit {
        args
    } {
        $self _mCall $self $_SIG_StopTransmit StopTransmit args
    }
    typevariable _SIG_StartLatency {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StartLatency {
        args
    } {
        $self _mCall $self $_SIG_StartLatency StartLatency args
    }
    typevariable _SIG_StopLatency {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StopLatency {
        args
    } {
        $self _mCall $self $_SIG_StopLatency StopLatency args
    }
    typevariable _SIG_ClearTimeStamp {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method ClearTimeStamp {
        args
    } {
        $self _mCall $self $_SIG_ClearTimeStamp ClearTimeStamp args
    }
    typevariable _SIG_SwitchToCapture {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method SwitchToCapture {
        args
    } {
        $self _mCall $self $_SIG_SwitchToCapture SwitchToCapture args
    }
    typevariable _SIG_SwitchToPacketGroup {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method SwitchToPacketGroup {
        args
    } {
        $self _mCall $self $_SIG_SwitchToPacketGroup SwitchToPacketGroup args
    }
    typevariable _SIG_SwitchToWidePacketGroup {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method SwitchToWidePacketGroup {
        args
    } {
        $self _mCall $self $_SIG_SwitchToWidePacketGroup SwitchToWidePacketGroup args
    }
    typevariable _SIG_SwitchToPacketStreams {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method SwitchToPacketStreams {
        args
    } {
        $self _mCall $self $_SIG_SwitchToPacketStreams SwitchToPacketStreams args
    }
    typevariable _SIG_SwitchToAdvancedScheduler {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method SwitchToAdvancedScheduler {
        args
    } {
        $self _mCall $self $_SIG_SwitchToAdvancedScheduler SwitchToAdvancedScheduler args
    }
    typevariable _SIG_SimulateLinkState {
        {name ports type ChassisConfig.StringVector direction in}
        {name linkStateUp type bool direction in}
    }
    method SimulateLinkState {
        args
    } {
        $self _mCall $self $_SIG_SimulateLinkState SimulateLinkState args
    }
    typevariable _SIG_SetCaptureFile {
        {name port type string direction in}
        {name numPackets type int32 direction in}
        {name exportFileName type string direction in}
    }
    method SetCaptureFile {
        args
    } {
        $self _mCall $self $_SIG_SetCaptureFile SetCaptureFile args
    }
    typevariable _SIG_SetCaptureFile_V2 {
        {name port type string direction in}
        {name numPackets type int32 direction in}
        {name fileFormat type ChassisConfig.eFileFormat direction in}
        {name outFile type file direction out}
    }
    method SetCaptureFile_V2 {
        args
    } {
        $self _mCall $self $_SIG_SetCaptureFile_V2 SetCaptureFile_V2 args
    }
    typevariable _SIG_ImportPrtFile_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name inFile type file direction in}
    }
    method ImportPrtFile_V2 {
        args
    } {
        $self _mCall $self $_SIG_ImportPrtFile_V2 ImportPrtFile_V2 args
    }
    typevariable _SIG_GetPortMemory {
        {name port type string direction in}
        {name mbytes type int32 direction out}
    }
    method GetPortMemory {
        args
    } {
        $self _mCall $self $_SIG_GetPortMemory GetPortMemory args
    }
    typevariable _SIG_GetMemory {
        {name ports type ChassisConfig.StringVector direction in}
        {name mbytesVector type ChassisConfig.LongVector direction out}
    }
    method GetMemory {
        args
    } {
        $self _mCall $self $_SIG_GetMemory GetMemory args
    }
    typevariable _SIG_FileBeginDownLoad {
        {name filename type string direction in}
        {name sessionId type int32 direction out}
    }
    method FileBeginDownLoad {
        args
    } {
        $self _mCall $self $_SIG_FileBeginDownLoad FileBeginDownLoad args
    }
    typevariable _SIG_FileUploadSegment {
        {name sessionID type int32 direction in}
        {name segment type octets direction in}
    }
    method FileUploadSegment {
        args
    } {
        $self _mCall $self $_SIG_FileUploadSegment FileUploadSegment args
    }
    typevariable _SIG_FileEndDownLoad {
        {name sessionID type int32 direction in}
    }
    method FileEndDownLoad {
        args
    } {
        $self _mCall $self $_SIG_FileEndDownLoad FileEndDownLoad args
    }
    typevariable _SIG_ImportPrtFile {
        {name ports type ChassisConfig.StringVector direction in}
        {name sessionID type int32 direction in}
        {name retval type bool direction out}
    }
    method ImportPrtFile {
        args
    } {
        $self _mCall $self $_SIG_ImportPrtFile ImportPrtFile args
    }
    typevariable _SIG_GetChassisTopology {
        {name chassisHostName type string direction in}
        {name chassis type ChassisConfig.XPChassis direction out}
    }
    method GetChassisTopology {
        args
    } {
        $self _mCall $self $_SIG_GetChassisTopology GetChassisTopology args
    }
    typevariable _SIG_GetDetailedChassisTopology {
        {name chassisHostName type string direction in}
        {name chassis type ChassisConfig.XPChassis2 direction out}
        {name portVec type ChassisConfig.PortAddressWithPropertiesVector direction out}
    }
    method GetDetailedChassisTopology {
        args
    } {
        $self _mCall $self $_SIG_GetDetailedChassisTopology GetDetailedChassisTopology args
    }
    typevariable _SIG_CreateChassisChain {
    }
    method CreateChassisChain {
        args
    } {
        $self _mCall $self $_SIG_CreateChassisChain CreateChassisChain args
    }
    typevariable _SIG_EstablishChassisConnection {
        {name chassisHostName type string direction in}
        {name retval type string direction out}
    }
    method EstablishChassisConnection {
        args
    } {
        $self _mCall $self $_SIG_EstablishChassisConnection EstablishChassisConnection args
    }
    typevariable _SIG_ClearStatistics {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method ClearStatistics {
        args
    } {
        $self _mCall $self $_SIG_ClearStatistics ClearStatistics args
    }
    typevariable _SIG_ClearStatistics_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method ClearStatistics_V2 {
        args
    } {
        $self _mCall $self $_SIG_ClearStatistics_V2 ClearStatistics_V2 args
    }
    typevariable _SIG_GetNicVector {
        {name uniquePortId type string direction in}
        {name nics type ChassisConfig.SeqNicVector direction out}
    }
    method GetNicVector {
        args
    } {
        $self _mCall $self $_SIG_GetNicVector GetNicVector args
    }
    typevariable _SIG_SetFactoryDefaultsForNics {
        {name nics type ChassisConfig.SeqNicAddressVector direction in}
    }
    method SetFactoryDefaultsForNics {
        args
    } {
        $self _mCall $self $_SIG_SetFactoryDefaultsForNics SetFactoryDefaultsForNics args
    }
    typevariable _SIG_ConfigurePhysicalForNics {
        {name nics type ChassisConfig.SeqNicAddressVector direction in}
        {name xml type string direction in}
    }
    method ConfigurePhysicalForNics {
        args
    } {
        $self _mCall $self $_SIG_ConfigurePhysicalForNics ConfigurePhysicalForNics args
    }
    typevariable _SIG_StartTrafficGeneration {
        {name ports type ChassisConfig.StringVector direction in}
    }
    method StartTrafficGeneration {
        args
    } {
        $self _mCall $self $_SIG_StartTrafficGeneration StartTrafficGeneration args
    }
    typevariable _SIG_InvokeTranslatorModuleFunc {
        {name chassisHostName type string direction in}
        {name xml_in type string direction in}
        {name xmlStream type string direction out}
    }
    method InvokeTranslatorModuleFunc {
        args
    } {
        $self _mCall $self $_SIG_InvokeTranslatorModuleFunc InvokeTranslatorModuleFunc args
    }
    typevariable _SIG_DownloadPackagesToPorts {
        {name ports type ChassisConfig.StringVector direction in}
        {name File type file direction in}
        {name fileName type string direction in}
    }
    method DownloadPackagesToPorts {
        args
    } {
        $self _mCall $self $_SIG_DownloadPackagesToPorts DownloadPackagesToPorts args
    }
    typevariable _SIG_DeletePackagesFromPorts {
        {name ports type ChassisConfig.StringVector direction in}
        {name packages type ChassisConfig.StringVector direction in}
    }
    method DeletePackagesFromPorts {
        args
    } {
        $self _mCall $self $_SIG_DeletePackagesFromPorts DeletePackagesFromPorts args
    }
    typevariable _SIG_InvokeTranslatorModuleFuncWithCompression {
        {name chassisHostName type string direction in}
        {name xml_in type file direction in}
        {name xmlStream type file direction out}
    }
    method InvokeTranslatorModuleFuncWithCompression {
        args
    } {
        $self _mCall $self $_SIG_InvokeTranslatorModuleFuncWithCompression InvokeTranslatorModuleFuncWithCompression args
    }
    typevariable _SIG_RebootPortCpuAndBlockUntilReady {
        {name portsIn type ChassisConfig.StringVector direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method RebootPortCpuAndBlockUntilReady {
        args
    } {
        $self _mCall $self $_SIG_RebootPortCpuAndBlockUntilReady RebootPortCpuAndBlockUntilReady args
    }
    typevariable _SIG_ConfigurePhysical_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name xml type string direction in}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method ConfigurePhysical_V2 {
        args
    } {
        $self _mCall $self $_SIG_ConfigurePhysical_V2 ConfigurePhysical_V2 args
    }
    typevariable _SIG_PingChassis {
        {name chassisHostName type string direction in}
        {name retval type bool direction out}
    }
    method PingChassis {
        args
    } {
        $self _mCall $self $_SIG_PingChassis PingChassis args
    }
    typevariable _SIG_GetPortInformation_V2 {
        {name ports type ChassisConfig.StringVector direction in}
        {name portInfo type ChassisConfig.PortVector direction out}
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method GetPortInformation_V2 {
        args
    } {
        $self _mCall $self $_SIG_GetPortInformation_V2 GetPortInformation_V2 args
    }
    typevariable _SIG_GetFailedPortsForLayer1 {
        {name portsFailed type ChassisConfig.StringVector direction out}
    }
    method GetFailedPortsForLayer1 {
        args
    } {
        $self _mCall $self $_SIG_GetFailedPortsForLayer1 GetFailedPortsForLayer1 args
    }
    typevariable _SIG_RemoveChassisConnectionCache {
        {name chassisHostName type string direction in}
    }
    method RemoveChassisConnectionCache {
        args
    } {
        $self _mCall $self $_SIG_RemoveChassisConnectionCache RemoveChassisConnectionCache args
    }
    typevariable _SIG_GetVersion {
        {name machineIp type string direction in}
        {name version type string direction out}
    }
    method GetVersion {
        args
    } {
        $self _mCall $self $_SIG_GetVersion GetVersion args
    }
    typevariable _SIG_GetManagementNicVector {
        {name machineIp type string direction in}
        {name nicVector type ChassisConfig.CPDNicAddressVector direction out}
    }
    method GetManagementNicVector {
        args
    } {
        $self _mCall $self $_SIG_GetManagementNicVector GetManagementNicVector args
    }
    typevariable _SIG_SetHostname {
        {name machineIp type string direction in}
        {name hostname type string direction in}
    }
    method SetHostname {
        args
    } {
        $self _mCall $self $_SIG_SetHostname SetHostname args
    }
    typevariable _SIG_SetDnsServer {
        {name machineIp type string direction in}
        {name dnsServer type int32 direction in}
    }
    method SetDnsServer {
        args
    } {
        $self _mCall $self $_SIG_SetDnsServer SetDnsServer args
    }
    typevariable _SIG_GetHardwareManagerBuildVersion {
        {name machineIp type string direction in}
        {name version type string direction out}
    }
    method GetHardwareManagerBuildVersion {
        args
    } {
        $self _mCall $self $_SIG_GetHardwareManagerBuildVersion GetHardwareManagerBuildVersion args
    }
    typevariable _SIG_SetDhcp {
        {name nicAddress type ChassisConfig.CPDNicAddress direction in}
    }
    method SetDhcp {
        args
    } {
        $self _mCall $self $_SIG_SetDhcp SetDhcp args
    }
    typevariable _SIG_SetStaticIp {
        {name nicAddress type ChassisConfig.CPDNicAddress direction in}
        {name ip type int32 direction in}
        {name netmask type int32 direction in}
        {name gateway type int32 direction in}
    }
    method SetStaticIp {
        args
    } {
        $self _mCall $self $_SIG_SetStaticIp SetStaticIp args
    }
    typevariable _SIG_GetKernelCrashDump {
        {name machineIp type string direction in}
        {name crashDump type string direction out}
    }
    method GetKernelCrashDump {
        args
    } {
        $self _mCall $self $_SIG_GetKernelCrashDump GetKernelCrashDump args
    }
    typevariable _SIG_CPDConfigurePhysical {
        {name nicAddressVector type ChassisConfig.CPDNicAddressVector direction in}
        {name configuration type string direction in}
    }
    method CPDConfigurePhysical {
        args
    } {
        $self _mCall $self $_SIG_CPDConfigurePhysical CPDConfigurePhysical args
    }
    typevariable _SIG_DoesChassisSupportMultiNic {
        {name chassisHostName type string direction in}
        {name retVal type bool direction out}
    }
    method DoesChassisSupportMultiNic {
        args
    } {
        $self _mCall $self $_SIG_DoesChassisSupportMultiNic DoesChassisSupportMultiNic args
    }
    typevariable _SIG_GetIxOSVersion {
        {name machineIp type string direction in}
        {name version type string direction out}
    }
    method GetIxOSVersion {
        args
    } {
        $self _mCall $self $_SIG_GetIxOSVersion GetIxOSVersion args
    }
    typevariable _SIG_SetDelayStartTransmitTime {
        {name masterChassisIp type string direction in}
        {name delay type int32 direction in}
    }
    method SetDelayStartTransmitTime {
        args
    } {
        $self _mCall $self $_SIG_SetDelayStartTransmitTime SetDelayStartTransmitTime args
    }
    typevariable _SIG_GetDelayStartTransmitTime {
        {name masterChassisIp type string direction in}
        {name delay type int32 direction out}
    }
    method GetDelayStartTransmitTime {
        args
    } {
        $self _mCall $self $_SIG_GetDelayStartTransmitTime GetDelayStartTransmitTime args
    }
    typevariable _SIG_GetChassisTimeSource {
        {name chassisIp type string direction in}
        {name source type ChassisConfig.eTimeSource direction out}
    }
    method GetChassisTimeSource {
        args
    } {
        $self _mCall $self $_SIG_GetChassisTimeSource GetChassisTimeSource args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        chassisChain PropertyNodeList
        useConfigLayerV2 PropertyBoolean
    }
    #----------------------------------------------------------------------
    # chassisChain (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component chassisChain -public chassisChain
    method _ctor_chassisChain {args} {
        set chassisChain [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype Chassis \
            -parent $self \
            -name chassisChain \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_chassisChain {args} {catch {$chassisChain destroy}}
    #----------------------------------------------------------------------
    # useConfigLayerV2 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method useConfigLayerV2 {args} {$self _mProp $self useConfigLayerV2 $_propertyTypes(useConfigLayerV2) $args}
    method _ctor_useConfigLayerV2 {args} {}
    method _dtor_useConfigLayerV2 {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DataStore.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Struct -- DataStore::ArchiveTimeOfDay
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DataStore::ArchiveTimeOfDay {
    component c_Struct -inherit true
    delegate method hour to c_Struct using "%c _dcall %m"
    delegate method minute to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            hour int16 {-1}
            minute int16 {-1}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- DataStore::TestResultIdList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DataStore::TestResultIdList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int32]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::DataStore {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    # ArchiveTimeOfDay
    # TestResultIdList
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
    typevariable _SIG_ArchiveTestResults {
        {name idList type DataStore.TestResultIdList direction in}
    }
    method ArchiveTestResults {
        args
    } {
        $self _mCall $self $_SIG_ArchiveTestResults ArchiveTestResults args
    }
    typevariable _SIG_ArchiveTestResult {
        {name testResultId type int32 direction in}
    }
    method ArchiveTestResult {
        args
    } {
        $self _mCall $self $_SIG_ArchiveTestResult ArchiveTestResult args
    }
    typevariable _SIG_GetArchiveTimeOfDay {
        {name timeOfDay type DataStore.ArchiveTimeOfDay direction out}
    }
    method GetArchiveTimeOfDay {
        args
    } {
        $self _mCall $self $_SIG_GetArchiveTimeOfDay GetArchiveTimeOfDay args
    }
    typevariable _SIG_SetArchiveTimeOfDay {
        {name timeOfDay type DataStore.ArchiveTimeOfDay direction in}
    }
    method SetArchiveTimeOfDay {
        args
    } {
        $self _mCall $self $_SIG_SetArchiveTimeOfDay SetArchiveTimeOfDay args
    }
    typevariable _SIG_GetMaxSize {
        {name maxSize type int32 direction out}
    }
    method GetMaxSize {
        args
    } {
        $self _mCall $self $_SIG_GetMaxSize GetMaxSize args
    }
    typevariable _SIG_SetMaxSize {
        {name maxSize type int32 direction in}
    }
    method SetMaxSize {
        args
    } {
        $self _mCall $self $_SIG_SetMaxSize SetMaxSize args
    }
    typevariable _SIG_GetReporterDSN {
        {name reporterDsn type string direction out}
    }
    method GetReporterDSN {
        args
    } {
        $self _mCall $self $_SIG_GetReporterDSN GetReporterDSN args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/CsvHeaderField.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::CsvHeaderField {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
        sequenceNumber PropertyInt
        fieldName PropertyString
        fieldValue PropertyString
    }
    #----------------------------------------------------------------------
    # sequenceNumber (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method sequenceNumber {args} {$self _mProp $self sequenceNumber $_propertyTypes(sequenceNumber) $args}
    method _ctor_sequenceNumber {args} {}
    method _dtor_sequenceNumber {args} {}
    #----------------------------------------------------------------------
    # fieldName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method fieldName {args} {$self _mProp $self fieldName $_propertyTypes(fieldName) $args}
    method _ctor_fieldName {args} {}
    method _dtor_fieldName {args} {}
    #----------------------------------------------------------------------
    # fieldValue (PropertyString)
    # 
    #----------------------------------------------------------------------
    method fieldValue {args} {$self _mProp $self fieldValue $_propertyTypes(fieldValue) $args}
    method _ctor_fieldValue {args} {}
    method _dtor_fieldValue {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/CsvRequestOptions.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::CsvRequestOptions {
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
        outputCsv PropertyBoolean
        outputFileHeader PropertyBoolean
        outputColumnHeader PropertyBoolean
        outputFunctionHeader PropertyBoolean
        outputLabelHeader PropertyBoolean
    }
    #----------------------------------------------------------------------
    # outputCsv (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method outputCsv {args} {$self _mProp $self outputCsv $_propertyTypes(outputCsv) $args}
    method _ctor_outputCsv {args} {}
    method _dtor_outputCsv {args} {}
    #----------------------------------------------------------------------
    # outputFileHeader (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method outputFileHeader {args} {$self _mProp $self outputFileHeader $_propertyTypes(outputFileHeader) $args}
    method _ctor_outputFileHeader {args} {}
    method _dtor_outputFileHeader {args} {}
    #----------------------------------------------------------------------
    # outputColumnHeader (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method outputColumnHeader {args} {$self _mProp $self outputColumnHeader $_propertyTypes(outputColumnHeader) $args}
    method _ctor_outputColumnHeader {args} {}
    method _dtor_outputColumnHeader {args} {}
    #----------------------------------------------------------------------
    # outputFunctionHeader (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method outputFunctionHeader {args} {$self _mProp $self outputFunctionHeader $_propertyTypes(outputFunctionHeader) $args}
    method _ctor_outputFunctionHeader {args} {}
    method _dtor_outputFunctionHeader {args} {}
    #----------------------------------------------------------------------
    # outputLabelHeader (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method outputLabelHeader {args} {$self _mProp $self outputLabelHeader $_propertyTypes(outputLabelHeader) $args}
    method _ctor_outputLabelHeader {args} {}
    method _dtor_outputLabelHeader {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DDGTest.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DDGTest {
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
    component c_Base -public DataDrivenFormBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::DataDrivenFormBase %AUTO%}
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
        intVar1 PropertyInt
        intVar2 PropertyInt
        booleanVar1 PropertyBoolean
        booleanVar2 PropertyBoolean
        doubleVar1 PropertyDouble
        doubleVar2 PropertyDouble
        stringVar1 PropertyString
        stringVar2 PropertyString
        stringVar3 PropertyString
        list PropertyNodeList
    }
    #----------------------------------------------------------------------
    # intVar1 (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method intVar1 {args} {$self _mProp $self intVar1 $_propertyTypes(intVar1) $args}
    method _ctor_intVar1 {args} {}
    method _dtor_intVar1 {args} {}
    #----------------------------------------------------------------------
    # intVar2 (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method intVar2 {args} {$self _mProp $self intVar2 $_propertyTypes(intVar2) $args}
    method _ctor_intVar2 {args} {}
    method _dtor_intVar2 {args} {}
    #----------------------------------------------------------------------
    # booleanVar1 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method booleanVar1 {args} {$self _mProp $self booleanVar1 $_propertyTypes(booleanVar1) $args}
    method _ctor_booleanVar1 {args} {}
    method _dtor_booleanVar1 {args} {}
    #----------------------------------------------------------------------
    # booleanVar2 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method booleanVar2 {args} {$self _mProp $self booleanVar2 $_propertyTypes(booleanVar2) $args}
    method _ctor_booleanVar2 {args} {}
    method _dtor_booleanVar2 {args} {}
    #----------------------------------------------------------------------
    # doubleVar1 (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method doubleVar1 {args} {$self _mProp $self doubleVar1 $_propertyTypes(doubleVar1) $args}
    method _ctor_doubleVar1 {args} {}
    method _dtor_doubleVar1 {args} {}
    #----------------------------------------------------------------------
    # doubleVar2 (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method doubleVar2 {args} {$self _mProp $self doubleVar2 $_propertyTypes(doubleVar2) $args}
    method _ctor_doubleVar2 {args} {}
    method _dtor_doubleVar2 {args} {}
    #----------------------------------------------------------------------
    # stringVar1 (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar1 {args} {$self _mProp $self stringVar1 $_propertyTypes(stringVar1) $args}
    method _ctor_stringVar1 {args} {}
    method _dtor_stringVar1 {args} {}
    #----------------------------------------------------------------------
    # stringVar2 (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar2 {args} {$self _mProp $self stringVar2 $_propertyTypes(stringVar2) $args}
    method _ctor_stringVar2 {args} {}
    method _dtor_stringVar2 {args} {}
    #----------------------------------------------------------------------
    # stringVar3 (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar3 {args} {$self _mProp $self stringVar3 $_propertyTypes(stringVar3) $args}
    method _ctor_stringVar3 {args} {}
    method _dtor_stringVar3 {args} {}
    #----------------------------------------------------------------------
    # list (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component list -public list
    method _ctor_list {args} {
        set list [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype NodeTestB \
            -parent $self \
            -name list \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_list {args} {catch {$list destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DataDrivenFormBase.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DataDrivenFormBase {
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
    typevariable _SIG_GetFormLayout {
        {name filename type string direction in}
        {name xml type string direction out}
    }
    method GetFormLayout {
        args
    } {
        $self _mCall $self $_SIG_GetFormLayout GetFormLayout args
    }
    typevariable _SIG_SetFormLayout {
        {name filename type string direction in}
        {name xml type string direction in}
    }
    method SetFormLayout {
        args
    } {
        $self _mCall $self $_SIG_SetFormLayout SetFormLayout args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DnsHost.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DnsHost {
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
        hostIP PropertyString
        hostName PropertyString
        alias1 PropertyString
        alias2 PropertyString
    }
    #----------------------------------------------------------------------
    # hostIP (PropertyString)
    # 
    #----------------------------------------------------------------------
    method hostIP {args} {$self _mProp $self hostIP $_propertyTypes(hostIP) $args}
    method _ctor_hostIP {args} {}
    method _dtor_hostIP {args} {}
    #----------------------------------------------------------------------
    # hostName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method hostName {args} {$self _mProp $self hostName $_propertyTypes(hostName) $args}
    method _ctor_hostName {args} {}
    method _dtor_hostName {args} {}
    #----------------------------------------------------------------------
    # alias1 (PropertyString)
    # 
    #----------------------------------------------------------------------
    method alias1 {args} {$self _mProp $self alias1 $_propertyTypes(alias1) $args}
    method _ctor_alias1 {args} {}
    method _dtor_alias1 {args} {}
    #----------------------------------------------------------------------
    # alias2 (PropertyString)
    # 
    #----------------------------------------------------------------------
    method alias2 {args} {$self _mProp $self alias2 $_propertyTypes(alias2) $args}
    method _ctor_alias2 {args} {}
    method _dtor_alias2 {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DnsNameServer.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DnsNameServer {
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
        nameServer PropertyString
    }
    #----------------------------------------------------------------------
    # nameServer (PropertyString)
    # 
    #----------------------------------------------------------------------
    method nameServer {args} {$self _mProp $self nameServer $_propertyTypes(nameServer) $args}
    method _ctor_nameServer {args} {}
    method _dtor_nameServer {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DnsPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DnsPlugin {
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
    component c_Base -public GlobalPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::GlobalPlugin %AUTO%}
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
        domain PropertyString
        timeout PropertyInt
        nameServerList PropertyNodeList
        searchList PropertyNodeList
        hostList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # domain (PropertyString)
    # 
    #----------------------------------------------------------------------
    method domain {args} {$self _mProp $self domain $_propertyTypes(domain) $args}
    method _ctor_domain {args} {}
    method _dtor_domain {args} {}
    #----------------------------------------------------------------------
    # timeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method timeout {args} {$self _mProp $self timeout $_propertyTypes(timeout) $args}
    method _ctor_timeout {args} {}
    method _dtor_timeout {args} {}
    #----------------------------------------------------------------------
    # nameServerList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component nameServerList -public nameServerList
    method _ctor_nameServerList {args} {
        set nameServerList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype DnsNameServer \
            -parent $self \
            -name nameServerList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_nameServerList {args} {catch {$nameServerList destroy}}
    #----------------------------------------------------------------------
    # searchList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component searchList -public searchList
    method _ctor_searchList {args} {
        set searchList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype DnsSearch \
            -parent $self \
            -name searchList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_searchList {args} {catch {$searchList destroy}}
    #----------------------------------------------------------------------
    # hostList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component hostList -public hostList
    method _ctor_hostList {args} {
        set hostList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype DnsHost \
            -parent $self \
            -name hostList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_hostList {args} {catch {$hostList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DnsSearch.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DnsSearch {
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
        search PropertyString
    }
    #----------------------------------------------------------------------
    # search (PropertyString)
    # 
    #----------------------------------------------------------------------
    method search {args} {$self _mProp $self search $_propertyTypes(search) $args}
    method _ctor_search {args} {}
    method _dtor_search {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DodUnitTestPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DodUnitTestPlugin {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DualPhyPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DualPhyPlugin {
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
    component c_Base -public CardPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::CardPlugin %AUTO%}
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
        medium PropertyString
    }
    #----------------------------------------------------------------------
    # medium (PropertyString)
    # 
    #----------------------------------------------------------------------
    method medium {args} {$self _mProp $self medium $_propertyTypes(medium) $args}
    method _ctor_medium {args} {}
    method _dtor_medium {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/EmulatedRouterPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::EmulatedRouterPlugin {
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
        ipType PropertyString
        ipAddress PropertyString
        incrementBy PropertyString
        gatewayAddress PropertyString
        prefix PropertyInt
        vlan PropertyNode
        rangeList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # ipType (PropertyString)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents ipType of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    method ipType {args} {$self _mProp $self ipType $_propertyTypes(ipType) $args {message {IpV4V6Range list must be used instead. Represents ipType of the first element in IpV4V6Range list}}}
    method _ctor_ipType {args} {}
    method _dtor_ipType {args} {}
    #----------------------------------------------------------------------
    # ipAddress (PropertyString)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents ipAddress of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    method ipAddress {args} {$self _mProp $self ipAddress $_propertyTypes(ipAddress) $args {message {IpV4V6Range list must be used instead. Represents ipAddress of the first element in IpV4V6Range list}}}
    method _ctor_ipAddress {args} {}
    method _dtor_ipAddress {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents incrementBy of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args {message {IpV4V6Range list must be used instead. Represents incrementBy of the first element in IpV4V6Range list}}}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # gatewayAddress (PropertyString)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents gatewayAddress of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    method gatewayAddress {args} {$self _mProp $self gatewayAddress $_propertyTypes(gatewayAddress) $args {message {IpV4V6Range list must be used instead. Represents gatewayAddress of the first element in IpV4V6Range list}}}
    method _ctor_gatewayAddress {args} {}
    method _dtor_gatewayAddress {args} {}
    #----------------------------------------------------------------------
    # prefix (PropertyInt)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents prefix of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    method prefix {args} {$self _mProp $self prefix $_propertyTypes(prefix) $args {message {IpV4V6Range list must be used instead. Represents prefix of the first element in IpV4V6Range list}}}
    method _ctor_prefix {args} {}
    method _dtor_prefix {args} {}
    #----------------------------------------------------------------------
    # vlan (PropertyNode)
    # OBSOLETE: IpV4V6Range list must be used instead. Represents vlan of the first element in IpV4V6Range list
    #----------------------------------------------------------------------
    component vlan -public vlan
    method _ctor_vlan {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Vlan]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType vlan]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set vlan [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name vlan \
        -transactioncontext $options(-transactioncontext) \
        -obsolete {message {IpV4V6Range list must be used instead. Represents vlan of the first element in IpV4V6Range list}} \
      ]
    }
    method _dtor_vlan {args} {catch {$vlan destroy}}
    #----------------------------------------------------------------------
    # rangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component rangeList -public rangeList
    method _ctor_rangeList {args} {
        set rangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype IpV4V6Range \
            -parent $self \
            -name rangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_rangeList {args} {catch {$rangeList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/EthernetCardPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::EthernetCardPlugin {
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
    component c_Base -public CardPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::CardPlugin %AUTO%}
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/EthernetELMPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::EthernetELMPlugin {
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
    component c_Base -public CardPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::CardPlugin %AUTO%}
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
        negotiateMasterSlave PropertyBoolean
        negotiationType PropertyString
    }
    #----------------------------------------------------------------------
    # negotiateMasterSlave (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method negotiateMasterSlave {args} {$self _mProp $self negotiateMasterSlave $_propertyTypes(negotiateMasterSlave) $args}
    method _ctor_negotiateMasterSlave {args} {}
    method _dtor_negotiateMasterSlave {args} {}
    #----------------------------------------------------------------------
    # negotiationType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method negotiationType {args} {$self _mProp $self negotiationType $_propertyTypes(negotiationType) $args}
    method _ctor_negotiationType {args} {}
    method _dtor_negotiationType {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/EthernetPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::EthernetPlugin {
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
    component c_Base -public HardwarePlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::HardwarePlugin %AUTO%}
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
        mac PropertyString
        incrementBy PropertyString
        macRangeList PropertyNodeList
        vlanRangeList PropertyNodeList
        enabled PropertyBoolean
        autoNegotiate PropertyBoolean
        speed PropertyString
        advertise10Half PropertyBoolean
        advertise10Full PropertyBoolean
        advertise100Half PropertyBoolean
        advertise100Full PropertyBoolean
        advertise1000Full PropertyBoolean
    }
    #----------------------------------------------------------------------
    # mac (PropertyString)
    # OBSOLETE: MacRange list must be used instead. Represents mac for the first element in MacRange list
    #----------------------------------------------------------------------
    method mac {args} {$self _mProp $self mac $_propertyTypes(mac) $args {message {MacRange list must be used instead. Represents mac for the first element in MacRange list}}}
    method _ctor_mac {args} {}
    method _dtor_mac {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # OBSOLETE: MacRange list must be used instead. Represents incrementBy for the first element in MacRange list
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args {message {MacRange list must be used instead. Represents incrementBy for the first element in MacRange list}}}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # macRangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component macRangeList -public macRangeList
    method _ctor_macRangeList {args} {
        set macRangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype MacRange \
            -parent $self \
            -name macRangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_macRangeList {args} {catch {$macRangeList destroy}}
    #----------------------------------------------------------------------
    # vlanRangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component vlanRangeList -public vlanRangeList
    method _ctor_vlanRangeList {args} {
        set vlanRangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype VlanIdRange \
            -parent $self \
            -name vlanRangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_vlanRangeList {args} {catch {$vlanRangeList destroy}}
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # autoNegotiate (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method autoNegotiate {args} {$self _mProp $self autoNegotiate $_propertyTypes(autoNegotiate) $args}
    method _ctor_autoNegotiate {args} {}
    method _dtor_autoNegotiate {args} {}
    #----------------------------------------------------------------------
    # speed (PropertyString)
    # 
    #----------------------------------------------------------------------
    method speed {args} {$self _mProp $self speed $_propertyTypes(speed) $args}
    method _ctor_speed {args} {}
    method _dtor_speed {args} {}
    #----------------------------------------------------------------------
    # advertise10Half (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method advertise10Half {args} {$self _mProp $self advertise10Half $_propertyTypes(advertise10Half) $args}
    method _ctor_advertise10Half {args} {}
    method _dtor_advertise10Half {args} {}
    #----------------------------------------------------------------------
    # advertise10Full (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method advertise10Full {args} {$self _mProp $self advertise10Full $_propertyTypes(advertise10Full) $args}
    method _ctor_advertise10Full {args} {}
    method _dtor_advertise10Full {args} {}
    #----------------------------------------------------------------------
    # advertise100Half (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method advertise100Half {args} {$self _mProp $self advertise100Half $_propertyTypes(advertise100Half) $args}
    method _ctor_advertise100Half {args} {}
    method _dtor_advertise100Half {args} {}
    #----------------------------------------------------------------------
    # advertise100Full (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method advertise100Full {args} {$self _mProp $self advertise100Full $_propertyTypes(advertise100Full) $args}
    method _ctor_advertise100Full {args} {}
    method _dtor_advertise100Full {args} {}
    #----------------------------------------------------------------------
    # advertise1000Full (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method advertise1000Full {args} {$self _mProp $self advertise1000Full $_propertyTypes(advertise1000Full) $args}
    method _ctor_advertise1000Full {args} {}
    method _dtor_advertise1000Full {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/FilterPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::FilterPlugin {
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
    component c_Base -public GlobalPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::GlobalPlugin %AUTO%}
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
        initialAction PropertyString
        all PropertyBoolean
        pppoecontrol PropertyBoolean
        pppoenetwork PropertyBoolean
        isis PropertyBoolean
        ip PropertyString
        tcp PropertyString
        udp PropertyString
        mac PropertyString
        icmp PropertyString
    }
    #----------------------------------------------------------------------
    # initialAction (PropertyString)
    # 
    #----------------------------------------------------------------------
    method initialAction {args} {$self _mProp $self initialAction $_propertyTypes(initialAction) $args}
    method _ctor_initialAction {args} {}
    method _dtor_initialAction {args} {}
    #----------------------------------------------------------------------
    # all (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method all {args} {$self _mProp $self all $_propertyTypes(all) $args}
    method _ctor_all {args} {}
    method _dtor_all {args} {}
    #----------------------------------------------------------------------
    # pppoecontrol (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method pppoecontrol {args} {$self _mProp $self pppoecontrol $_propertyTypes(pppoecontrol) $args}
    method _ctor_pppoecontrol {args} {}
    method _dtor_pppoecontrol {args} {}
    #----------------------------------------------------------------------
    # pppoenetwork (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method pppoenetwork {args} {$self _mProp $self pppoenetwork $_propertyTypes(pppoenetwork) $args}
    method _ctor_pppoenetwork {args} {}
    method _dtor_pppoenetwork {args} {}
    #----------------------------------------------------------------------
    # isis (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method isis {args} {$self _mProp $self isis $_propertyTypes(isis) $args}
    method _ctor_isis {args} {}
    method _dtor_isis {args} {}
    #----------------------------------------------------------------------
    # ip (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ip {args} {$self _mProp $self ip $_propertyTypes(ip) $args}
    method _ctor_ip {args} {}
    method _dtor_ip {args} {}
    #----------------------------------------------------------------------
    # tcp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method tcp {args} {$self _mProp $self tcp $_propertyTypes(tcp) $args}
    method _ctor_tcp {args} {}
    method _dtor_tcp {args} {}
    #----------------------------------------------------------------------
    # udp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method udp {args} {$self _mProp $self udp $_propertyTypes(udp) $args}
    method _ctor_udp {args} {}
    method _dtor_udp {args} {}
    #----------------------------------------------------------------------
    # mac (PropertyString)
    # 
    #----------------------------------------------------------------------
    method mac {args} {$self _mProp $self mac $_propertyTypes(mac) $args}
    method _ctor_mac {args} {}
    method _dtor_mac {args} {}
    #----------------------------------------------------------------------
    # icmp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method icmp {args} {$self _mProp $self icmp $_propertyTypes(icmp) $args}
    method _ctor_icmp {args} {}
    method _dtor_icmp {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/GenericStatSource.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericStatSource {
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
    component c_Base -public DataDrivenFormBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::DataDrivenFormBase %AUTO%}
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
    typevariable _SIG_Configure {
    }
    method Configure {
        args
    } {
        $self _mCall $self $_SIG_Configure Configure args
    }
    typevariable _SIG_Start {
    }
    method Start {
        args
    } {
        $self _mCall $self $_SIG_Start Start args
    }
    typevariable _SIG_Stop {
    }
    method Stop {
        args
    } {
        $self _mCall $self $_SIG_Stop Stop args
    }
    typevariable _SIG_Deconfigure {
    }
    method Deconfigure {
        args
    } {
        $self _mCall $self $_SIG_Deconfigure Deconfigure args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/GlobalPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GlobalPlugin {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/HardwarePlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::HardwarePlugin {
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
    typevariable _SIG_GetCardClassification {
        {name classification type string direction out}
    }
    method GetCardClassification {
        args
    } {
        $self _mCall $self $_SIG_GetCardClassification GetCardClassification args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        card PropertyNode
    }
    #----------------------------------------------------------------------
    # card (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component card -public card
    method _ctor_card {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype CardPlugin]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType card]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set card [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name card \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_card {args} {catch {$card destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/IpV4V6Plugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IpV4V6Plugin {
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
        rangeList PropertyNodeList
        dhcp PropertyNode
    }
    #----------------------------------------------------------------------
    # rangeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component rangeList -public rangeList
    method _ctor_rangeList {args} {
        set rangeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype IpV4V6Range \
            -parent $self \
            -name rangeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_rangeList {args} {catch {$rangeList destroy}}
    #----------------------------------------------------------------------
    # dhcp (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component dhcp -public dhcp
    method _ctor_dhcp {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Dhcp]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType dhcp]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set dhcp [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name dhcp \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_dhcp {args} {catch {$dhcp destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/IpV4V6Range.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::IpV4V6Range {
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
    typevariable _SIG_AutoGenerateMacRange {
        {name generate type bool direction in}
        {name success type bool direction out}
    }
    method AutoGenerateMacRange {
        args
    } {
        $self _mCall $self $_SIG_AutoGenerateMacRange AutoGenerateMacRange args
    }
    typevariable _SIG_AutoGenerateAtmRange {
        {name success type bool direction out}
    }
    method AutoGenerateAtmRange {
        args
    } {
        $self _mCall $self $_SIG_AutoGenerateAtmRange AutoGenerateAtmRange args
    }
    typevariable _SIG_AutoGeneratePvcRange {
        {name success type bool direction out}
    }
    method AutoGeneratePvcRange {
        args
    } {
        $self _mCall $self $_SIG_AutoGeneratePvcRange AutoGeneratePvcRange args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        name PropertyString
        vlan PropertyNode
        macRange PropertyNode
        vlanRange PropertyNode
        atmRange PropertyNode
        pvcRange PropertyNode
        generateStatistics PropertyBoolean
        enabled PropertyBoolean
        ipType PropertyString
        ipAddress PropertyString
        incrementBy PropertyString
        gatewayAddress PropertyString
        prefix PropertyInt
        count PropertyInt
        mss PropertyInt
        dhcpSettings PropertyNode
        addressAllocationMechanism PropertyString
        autoMacGeneration PropertyBoolean
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # vlan (PropertyNode)
    # OBSOLETE: use ethernet instead
    #----------------------------------------------------------------------
    component vlan -public vlan
    method _ctor_vlan {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Vlan]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType vlan]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set vlan [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name vlan \
        -transactioncontext $options(-transactioncontext) \
        -obsolete {message {use ethernet instead}} \
      ]
    }
    method _dtor_vlan {args} {catch {$vlan destroy}}
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
    # generateStatistics (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method generateStatistics {args} {$self _mProp $self generateStatistics $_propertyTypes(generateStatistics) $args}
    method _ctor_generateStatistics {args} {}
    method _dtor_generateStatistics {args} {}
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # ipType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ipType {args} {$self _mProp $self ipType $_propertyTypes(ipType) $args}
    method _ctor_ipType {args} {}
    method _dtor_ipType {args} {}
    #----------------------------------------------------------------------
    # ipAddress (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ipAddress {args} {$self _mProp $self ipAddress $_propertyTypes(ipAddress) $args}
    method _ctor_ipAddress {args} {}
    method _dtor_ipAddress {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # gatewayAddress (PropertyString)
    # 
    #----------------------------------------------------------------------
    method gatewayAddress {args} {$self _mProp $self gatewayAddress $_propertyTypes(gatewayAddress) $args}
    method _ctor_gatewayAddress {args} {}
    method _dtor_gatewayAddress {args} {}
    #----------------------------------------------------------------------
    # prefix (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method prefix {args} {$self _mProp $self prefix $_propertyTypes(prefix) $args}
    method _ctor_prefix {args} {}
    method _dtor_prefix {args} {}
    #----------------------------------------------------------------------
    # count (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method count {args} {$self _mProp $self count $_propertyTypes(count) $args}
    method _ctor_count {args} {}
    method _dtor_count {args} {}
    #----------------------------------------------------------------------
    # mss (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method mss {args} {$self _mProp $self mss $_propertyTypes(mss) $args}
    method _ctor_mss {args} {}
    method _dtor_mss {args} {}
    #----------------------------------------------------------------------
    # dhcpSettings (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component dhcpSettings -public dhcpSettings
    method _ctor_dhcpSettings {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype DhcpSettings]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType dhcpSettings]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set dhcpSettings [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name dhcpSettings \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_dhcpSettings {args} {catch {$dhcpSettings destroy}}
    #----------------------------------------------------------------------
    # addressAllocationMechanism (PropertyString)
    # 
    #----------------------------------------------------------------------
    method addressAllocationMechanism {args} {$self _mProp $self addressAllocationMechanism $_propertyTypes(addressAllocationMechanism) $args}
    method _ctor_addressAllocationMechanism {args} {}
    method _dtor_addressAllocationMechanism {args} {}
    #----------------------------------------------------------------------
    # autoMacGeneration (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method autoMacGeneration {args} {$self _mProp $self autoMacGeneration $_propertyTypes(autoMacGeneration) $args}
    method _ctor_autoMacGeneration {args} {}
    method _dtor_autoMacGeneration {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/MacRange.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::MacRange {
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
        name PropertyString
        mac PropertyString
        incrementBy PropertyString
        mtu PropertyInt
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # mac (PropertyString)
    # 
    #----------------------------------------------------------------------
    method mac {args} {$self _mProp $self mac $_propertyTypes(mac) $args}
    method _ctor_mac {args} {}
    method _dtor_mac {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # mtu (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method mtu {args} {$self _mProp $self mtu $_propertyTypes(mtu) $args}
    method _ctor_mtu {args} {}
    method _dtor_mtu {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/NodeTest.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::NodeTest {
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
        intVar PropertyInt
        intVarNoLimits PropertyInt
        booleanVar PropertyBoolean
        doubleVar PropertyDouble
        doubleVarNoLimits PropertyDouble
        stringVar PropertyString
        intListVar PropertyIntList
        doubleListVar PropertyDoubleList
        stringListVar PropertyStringList
        subNode PropertyNode
        subNodeList PropertyNodeList
        subNodePolymorphic PropertyNode
    }
    #----------------------------------------------------------------------
    # intVar (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method intVar {args} {$self _mProp $self intVar $_propertyTypes(intVar) $args}
    method _ctor_intVar {args} {}
    method _dtor_intVar {args} {}
    #----------------------------------------------------------------------
    # intVarNoLimits (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method intVarNoLimits {args} {$self _mProp $self intVarNoLimits $_propertyTypes(intVarNoLimits) $args}
    method _ctor_intVarNoLimits {args} {}
    method _dtor_intVarNoLimits {args} {}
    #----------------------------------------------------------------------
    # booleanVar (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method booleanVar {args} {$self _mProp $self booleanVar $_propertyTypes(booleanVar) $args}
    method _ctor_booleanVar {args} {}
    method _dtor_booleanVar {args} {}
    #----------------------------------------------------------------------
    # doubleVar (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method doubleVar {args} {$self _mProp $self doubleVar $_propertyTypes(doubleVar) $args}
    method _ctor_doubleVar {args} {}
    method _dtor_doubleVar {args} {}
    #----------------------------------------------------------------------
    # doubleVarNoLimits (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method doubleVarNoLimits {args} {$self _mProp $self doubleVarNoLimits $_propertyTypes(doubleVarNoLimits) $args}
    method _ctor_doubleVarNoLimits {args} {}
    method _dtor_doubleVarNoLimits {args} {}
    #----------------------------------------------------------------------
    # stringVar (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar {args} {$self _mProp $self stringVar $_propertyTypes(stringVar) $args}
    method _ctor_stringVar {args} {}
    method _dtor_stringVar {args} {}
    #----------------------------------------------------------------------
    # intListVar (PropertyIntList)
    # 
    #----------------------------------------------------------------------
    method intListVar {args} {$self _mProp $self intListVar $_propertyTypes(intListVar) $args}
    method _ctor_intListVar {args} {}
    method _dtor_intListVar {args} {}
    #----------------------------------------------------------------------
    # doubleListVar (PropertyDoubleList)
    # 
    #----------------------------------------------------------------------
    method doubleListVar {args} {$self _mProp $self doubleListVar $_propertyTypes(doubleListVar) $args}
    method _ctor_doubleListVar {args} {}
    method _dtor_doubleListVar {args} {}
    #----------------------------------------------------------------------
    # stringListVar (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    method stringListVar {args} {$self _mProp $self stringListVar $_propertyTypes(stringListVar) $args}
    method _ctor_stringListVar {args} {}
    method _dtor_stringListVar {args} {}
    #----------------------------------------------------------------------
    # subNode (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component subNode -public subNode
    method _ctor_subNode {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype NodeTestB]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType subNode]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set subNode [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name subNode \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_subNode {args} {catch {$subNode destroy}}
    #----------------------------------------------------------------------
    # subNodeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component subNodeList -public subNodeList
    method _ctor_subNodeList {args} {
        set subNodeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype NodeTestB \
            -parent $self \
            -name subNodeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_subNodeList {args} {catch {$subNodeList destroy}}
    #----------------------------------------------------------------------
    # subNodePolymorphic (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component subNodePolymorphic -public subNodePolymorphic
    method _ctor_subNodePolymorphic {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype NodeTestA]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType subNodePolymorphic]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set subNodePolymorphic [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name subNodePolymorphic \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_subNodePolymorphic {args} {catch {$subNodePolymorphic destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/NodeTestA.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::NodeTestA {
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
        stringVarA PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarA (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarA {args} {$self _mProp $self stringVarA $_propertyTypes(stringVarA) $args}
    method _ctor_stringVarA {args} {}
    method _dtor_stringVarA {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/NodeTestB.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::NodeTestB {
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
    component c_Base -public NodeTestA -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::NodeTestA %AUTO%}
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
        stringVarB PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarB (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarB {args} {$self _mProp $self stringVarB $_propertyTypes(stringVarB) $args}
    method _ctor_stringVarB {args} {}
    method _dtor_stringVarB {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PortGroup.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- PortGroup::StringVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::StringVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::Port
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::Port {
    component c_Struct -inherit true
    delegate method chassis to c_Struct using "%c _dcall %m"
    delegate method card to c_Struct using "%c _dcall %m"
    delegate method port to c_Struct using "%c _dcall %m"
    delegate method managementIp to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassis string {}
            card int32 {0}
            port int32 {0}
            managementIp string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::VlanInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::VlanInfo {
    component c_Struct -inherit true
    delegate method vlanId to c_Struct using "%c _dcall %m"
    delegate method vlanPriority to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            vlanId int64 {1}
            vlanPriority int64 {1}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::VlanInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::VlanInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.VlanInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::InterfaceInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::InterfaceInfo {
    component c_Struct -inherit true
    delegate method ipAddress to c_Struct using "%c _dcall %m"
    delegate method prefix to c_Struct using "%c _dcall %m"
    delegate method macAddress to c_Struct using "%c _dcall %m"
    delegate method isConnectedInterface to c_Struct using "%c _dcall %m"
    delegate method vlanList to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            ipAddress string {}
            prefix string {}
            macAddress string {}
            isConnectedInterface bool {1}
            vlanList PortGroup.VlanInfoList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::IpRangeInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpRangeInfo {
    component c_Struct -inherit true
    delegate method startingIp to c_Struct using "%c _dcall %m"
    delegate method incrementIpBy to c_Struct using "%c _dcall %m"
    delegate method count to c_Struct using "%c _dcall %m"
    delegate method ipType to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            startingIp string {}
            incrementIpBy string {}
            count int32 {}
            ipType string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::MacRangeInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::MacRangeInfo {
    component c_Struct -inherit true
    delegate method startingMac to c_Struct using "%c _dcall %m"
    delegate method incrementMacBy to c_Struct using "%c _dcall %m"
    delegate method startingInterfaceId to c_Struct using "%c _dcall %m"
    delegate method incrementInterfaceIdBy to c_Struct using "%c _dcall %m"
    delegate method isConnected to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            startingMac string {}
            incrementMacBy string {}
            startingInterfaceId int32 {}
            incrementInterfaceIdBy int32 {}
            isConnected bool {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::VlanRangeInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::VlanRangeInfo {
    component c_Struct -inherit true
    delegate method enable to c_Struct using "%c _dcall %m"
    delegate method firstId to c_Struct using "%c _dcall %m"
    delegate method incrementStep to c_Struct using "%c _dcall %m"
    delegate method increment to c_Struct using "%c _dcall %m"
    delegate method uniqueCount to c_Struct using "%c _dcall %m"
    delegate method priority to c_Struct using "%c _dcall %m"
    delegate method innerEnable to c_Struct using "%c _dcall %m"
    delegate method innerFirstId to c_Struct using "%c _dcall %m"
    delegate method innerIncrementStep to c_Struct using "%c _dcall %m"
    delegate method innerIncrement to c_Struct using "%c _dcall %m"
    delegate method innerUniqueCount to c_Struct using "%c _dcall %m"
    delegate method innerPriority to c_Struct using "%c _dcall %m"
    delegate method idIncrMode to c_Struct using "%c _dcall %m"
    delegate method etherType to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            enable bool {}
            firstId int32 {}
            incrementStep int32 {}
            increment int32 {}
            uniqueCount int32 {}
            priority int32 {}
            innerEnable bool {}
            innerFirstId int32 {}
            innerIncrementStep int32 {}
            innerIncrement int32 {}
            innerUniqueCount int32 {}
            innerPriority int32 {}
            idIncrMode int32 {}
            etherType string {0x8100}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::RangeInformation
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::RangeInformation {
    component c_Struct -inherit true
    delegate method ipRangeInfo to c_Struct using "%c _dcall %m"
    delegate method macRangeInfo to c_Struct using "%c _dcall %m"
    delegate method vlanRangeInfo to c_Struct using "%c _dcall %m"
    delegate method port to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            ipRangeInfo PortGroup.IpRangeInfo {}
            macRangeInfo PortGroup.MacRangeInfo {}
            vlanRangeInfo PortGroup.VlanRangeInfo {}
            port PortGroup.Port {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::RangeInformationList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::RangeInformationList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.RangeInformation]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::PortList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::PortList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.Port]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::InterfaceInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::InterfaceInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.InterfaceInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::IPort
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IPort {
    component c_Struct -inherit true
    delegate method chassis to c_Struct using "%c _dcall %m"
    delegate method card to c_Struct using "%c _dcall %m"
    delegate method port to c_Struct using "%c _dcall %m"
    delegate method managementIp to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            chassis string {}
            card int32 {0}
            port int32 {0}
            managementIp string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- PortGroup::ePluginType
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::ePluginType {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kIpSec
    typevariable kIp
    typevariable kEmulatedRouter
    typevariable kPpp
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kIpSec]} {
            set kIpSec [$type create %AUTO%];$kIpSec Set kIpSec
            set _tv [mytypevar kIpSec]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kIp]} {
            set kIp [$type create %AUTO%];$kIp Set kIp
            set _tv [mytypevar kIp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEmulatedRouter]} {
            set kEmulatedRouter [$type create %AUTO%];$kEmulatedRouter Set kEmulatedRouter
            set _tv [mytypevar kEmulatedRouter]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPpp]} {
            set kPpp [$type create %AUTO%];$kPpp Set kPpp
            set _tv [mytypevar kPpp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kIpSec
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kIpSec
      1 kIp
      1 kEmulatedRouter
      1 kPpp
    }
    typevariable m_encoder -array {
      kIpSec 0
      kIp 1
      kEmulatedRouter 1
      kPpp 1
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- PortGroup::eIpAllocationMechanism
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::eIpAllocationMechanism {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kStatic
    typevariable kDynamic
    typevariable kAll
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kStatic]} {
            set kStatic [$type create %AUTO%];$kStatic Set kStatic
            set _tv [mytypevar kStatic]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDynamic]} {
            set kDynamic [$type create %AUTO%];$kDynamic Set kDynamic
            set _tv [mytypevar kDynamic]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kAll]} {
            set kAll [$type create %AUTO%];$kAll Set kAll
            set _tv [mytypevar kAll]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kStatic
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kStatic
      1 kDynamic
      2 kAll
    }
    typevariable m_encoder -array {
      kStatic 0
      kDynamic 1
      kAll 2
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- PortGroup::eProtocol
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::eProtocol {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kIpv4
    typevariable kIpv6
    typevariable kAll
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kIpv4]} {
            set kIpv4 [$type create %AUTO%];$kIpv4 Set kIpv4
            set _tv [mytypevar kIpv4]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kIpv6]} {
            set kIpv6 [$type create %AUTO%];$kIpv6 Set kIpv6
            set _tv [mytypevar kIpv6]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kAll]} {
            set kAll [$type create %AUTO%];$kAll Set kAll
            set _tv [mytypevar kAll]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kIpv4
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kIpv4
      1 kIpv6
      2 kAll
    }
    typevariable m_encoder -array {
      kIpv4 0
      kIpv6 1
      kAll 2
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::IpPairInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpPairInfo {
    component c_Struct -inherit true
    delegate method ip1 to c_Struct using "%c _dcall %m"
    delegate method ip2 to c_Struct using "%c _dcall %m"
    delegate method pluginType to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            ip1 string {}
            ip2 string {}
            pluginType PortGroup.ePluginType {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::IpPairInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpPairInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.IpPairInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::IpAddressList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpAddressList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::StackElementPluginList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::StackElementPluginList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StackElementPlugin]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- PortGroup::IpV4V6RangeInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpV4V6RangeInfo {
    component c_Struct -inherit true
    delegate method ipType to c_Struct using "%c _dcall %m"
    delegate method startingIp to c_Struct using "%c _dcall %m"
    delegate method incrementBy to c_Struct using "%c _dcall %m"
    delegate method count to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            ipType string {}
            startingIp string {}
            incrementBy string {}
            count int32 {0}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- PortGroup::IpV4V6RangeInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortGroup::IpV4V6RangeInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortGroup.IpV4V6RangeInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::PortGroup {
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
    # StringVector
    # Port
    # VlanInfo
    # VlanInfoList
    # InterfaceInfo
    # IpRangeInfo
    # MacRangeInfo
    # VlanRangeInfo
    # RangeInformation
    # RangeInformationList
    # PortList
    # InterfaceInfoList
    # IPort
    # ePluginType
    # eIpAllocationMechanism
    # eProtocol
    # IpPairInfo
    # IpPairInfoList
    # IpAddressList
    # StackElementPluginList
    # IpV4V6RangeInfo
    # IpV4V6RangeInfoList
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
    typevariable _SIG_DodBeginDownLoad {
        {name name type string direction in}
        {name timeOut type int32 direction in}
        {name sessionId type int32 direction out}
    }
    method DodBeginDownLoad {
        args
    } {
        $self _mCall $self $_SIG_DodBeginDownLoad DodBeginDownLoad args
    }
    typevariable _SIG_DodUpLoadFileSegment {
        {name sessionID type int32 direction in}
        {name segment type octets direction in}
    }
    method DodUpLoadFileSegment {
        args
    } {
        $self _mCall $self $_SIG_DodUpLoadFileSegment DodUpLoadFileSegment args
    }
    typevariable _SIG_DodEndDownLoad {
        {name sessionID type int32 direction in}
    }
    method DodEndDownLoad {
        args
    } {
        $self _mCall $self $_SIG_DodEndDownLoad DodEndDownLoad args
    }
    typevariable _SIG_GetIps {
        {name allocationMechanism type PortGroup.eIpAllocationMechanism direction in}
        {name protocol type PortGroup.eProtocol direction in}
        {name count type int32 direction in}
        {name pairInfoList type PortGroup.IpPairInfoList direction out}
    }
    method GetIps {
        args
    } {
        $self _mCall $self $_SIG_GetIps GetIps args
    }
    typevariable _SIG_HasDynamicIps {
        {name hasDynamicIps type bool direction out}
    }
    method HasDynamicIps {
        args
    } {
        $self _mCall $self $_SIG_HasDynamicIps HasDynamicIps args
    }
    typevariable _SIG_GetIpCount {
        {name ipCount type int32 direction out}
    }
    method GetIpCount {
        args
    } {
        $self _mCall $self $_SIG_GetIpCount GetIpCount args
    }
    typevariable _SIG_GetIpCount {
        {name allocationMechanism type PortGroup.eIpAllocationMechanism direction in}
        {name protocol type PortGroup.eProtocol direction in}
        {name ipCount type int32 direction out}
    }
    method GetIpCount {
        args
    } {
        $self _mCall $self $_SIG_GetIpCount GetIpCount args
    }
    typevariable _SIG_GetRangeInformationList {
        {name rangeInformationList type PortGroup.RangeInformationList direction out}
    }
    method GetRangeInformationList {
        args
    } {
        $self _mCall $self $_SIG_GetRangeInformationList GetRangeInformationList args
    }
    typevariable _SIG_GetPorts {
        {name portList type PortGroup.PortList direction out}
    }
    method GetPorts {
        args
    } {
        $self _mCall $self $_SIG_GetPorts GetPorts args
    }
    typevariable _SIG_GetTestIpAddresses {
        {name portList type PortGroup.PortList direction in}
        {name ipAddressList type PortGroup.IpAddressList direction out}
    }
    method GetTestIpAddresses {
        args
    } {
        $self _mCall $self $_SIG_GetTestIpAddresses GetTestIpAddresses args
    }
    typevariable _SIG_GetTestIpAddresses {
        {name portList type PortGroup.PortList direction in}
        {name ipAddressList type PortGroup.InterfaceInfoList direction out}
    }
    method GetTestIpAddresses {
        args
    } {
        $self _mCall $self $_SIG_GetTestIpAddresses GetTestIpAddresses args
    }
    typevariable _SIG_GetTestIpAddresses {
        {name portList type PortGroup.PortList direction in}
        {name allocationMechanism type PortGroup.eIpAllocationMechanism direction in}
        {name protocol type PortGroup.eProtocol direction in}
        {name ipAddressList type PortGroup.IpAddressList direction out}
    }
    method GetTestIpAddresses {
        args
    } {
        $self _mCall $self $_SIG_GetTestIpAddresses GetTestIpAddresses args
    }
    typevariable _SIG_GetShortForm {
        {name ipAddresses type PortGroup.IpAddressList direction in}
        {name shortIpAddresses type PortGroup.IpAddressList direction out}
    }
    method GetShortForm {
        args
    } {
        $self _mCall $self $_SIG_GetShortForm GetShortForm args
    }
    typevariable _SIG_GetAllIpAddresses {
        {name ipAddressList type PortGroup.IpAddressList direction out}
    }
    method GetAllIpAddresses {
        args
    } {
        $self _mCall $self $_SIG_GetAllIpAddresses GetAllIpAddresses args
    }
    typevariable _SIG_GetIpAddressInfo {
        {name ipAddressList type PortGroup.IpAddressList direction in}
        {name portList type PortGroup.PortList direction out}
    }
    method GetIpAddressInfo {
        args
    } {
        $self _mCall $self $_SIG_GetIpAddressInfo GetIpAddressInfo args
    }
    typevariable _SIG_GetInterfaceInfoForIps {
        {name ipAddressList type PortGroup.IpAddressList direction in}
        {name interfaceInfoList type PortGroup.InterfaceInfoList direction out}
    }
    method GetInterfaceInfoForIps {
        args
    } {
        $self _mCall $self $_SIG_GetInterfaceInfoForIps GetInterfaceInfoForIps args
    }
    typevariable _SIG_StackElementPluginInfo {
        {name retval type StackElementPlugin.PluginInfoList direction out}
    }
    method StackElementPluginInfo {
        args
    } {
        $self _mCall $self $_SIG_StackElementPluginInfo StackElementPluginInfo args
    }
    typevariable _SIG_CandidateStackPointRefs {
        {name pluginType type string direction in}
        {name candidateList type PortGroup.StackElementPluginList direction out}
    }
    method CandidateStackPointRefs {
        args
    } {
        $self _mCall $self $_SIG_CandidateStackPointRefs CandidateStackPointRefs args
    }
    typevariable _SIG_DodPackageToPortGroup {
        {name packageName type PortGroup.StringVector direction in}
    }
    method DodPackageToPortGroup {
        args
    } {
        $self _mCall $self $_SIG_DodPackageToPortGroup DodPackageToPortGroup args
    }
    typevariable _SIG_SetArpForGateway {
        {name ipAddress type string direction in}
        {name val type bool direction in}
    }
    method SetArpForGateway {
        args
    } {
        $self _mCall $self $_SIG_SetArpForGateway SetArpForGateway args
    }
    typevariable _SIG_GetGatewayMacForIp {
        {name ipAddress type string direction in}
        {name gatewayMac type string direction out}
    }
    method GetGatewayMacForIp {
        args
    } {
        $self _mCall $self $_SIG_GetGatewayMacForIp GetGatewayMacForIp args
    }
    typevariable _SIG_ForceARPCacheRefresh {
    }
    method ForceARPCacheRefresh {
        args
    } {
        $self _mCall $self $_SIG_ForceARPCacheRefresh ForceARPCacheRefresh args
    }
    typevariable _SIG_GetIpV4V6RangeList {
        {name port type string direction in}
        {name ipRangeList type PortGroup.IpV4V6RangeInfoList direction out}
    }
    method GetIpV4V6RangeList {
        args
    } {
        $self _mCall $self $_SIG_GetIpV4V6RangeList GetIpV4V6RangeList args
    }
    typevariable _SIG_GetStackConfigurationsPerformed {
        {name count type int32 direction out}
    }
    method GetStackConfigurationsPerformed {
        args
    } {
        $self _mCall $self $_SIG_GetStackConfigurationsPerformed GetStackConfigurationsPerformed args
    }
    typevariable _SIG_RunScript {
        {name scriptFile type file direction in}
    }
    method RunScript {
        args
    } {
        $self _mCall $self $_SIG_RunScript RunScript args
    }
    typevariable _SIG_RunScriptOnPort {
        {name uniquePortId type string direction in}
        {name scriptFile type file direction in}
    }
    method RunScriptOnPort {
        args
    } {
        $self _mCall $self $_SIG_RunScriptOnPort RunScriptOnPort args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        name PropertyString
        category PropertyString
        stack PropertyNode
        globalPluginList PropertyNodeList
        portList PropertyStringList
        portController PropertyNode
        doAutoGratArpForIPv4 PropertyBoolean
        doAutoGratArpForIPv6 PropertyBoolean
        neighborTargetList PropertyStringList
        branchToNicMap PropertyNodeList
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # category (PropertyString)
    # 
    #----------------------------------------------------------------------
    method category {args} {$self _mProp $self category $_propertyTypes(category) $args}
    method _ctor_category {args} {}
    method _dtor_category {args} {}
    #----------------------------------------------------------------------
    # stack (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component stack -public stack
    method _ctor_stack {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype StackElementPlugin]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType stack]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set stack [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name stack \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_stack {args} {catch {$stack destroy}}
    #----------------------------------------------------------------------
    # globalPluginList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component globalPluginList -public globalPluginList
    method _ctor_globalPluginList {args} {
        set globalPluginList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StackElementPlugin \
            -parent $self \
            -name globalPluginList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_globalPluginList {args} {catch {$globalPluginList destroy}}
    #----------------------------------------------------------------------
    # portList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component portList -public portList
    method _ctor_portList {args} {
        set portList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name portList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_portList {args} {catch {$portList destroy}}
    #----------------------------------------------------------------------
    # portController (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component portController -public portController
    method _ctor_portController {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype PortController]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType portController]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set portController [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name portController \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_portController {args} {catch {$portController destroy}}
    #----------------------------------------------------------------------
    # doAutoGratArpForIPv4 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method doAutoGratArpForIPv4 {args} {$self _mProp $self doAutoGratArpForIPv4 $_propertyTypes(doAutoGratArpForIPv4) $args}
    method _ctor_doAutoGratArpForIPv4 {args} {}
    method _dtor_doAutoGratArpForIPv4 {args} {}
    #----------------------------------------------------------------------
    # doAutoGratArpForIPv6 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method doAutoGratArpForIPv6 {args} {$self _mProp $self doAutoGratArpForIPv6 $_propertyTypes(doAutoGratArpForIPv6) $args}
    method _ctor_doAutoGratArpForIPv6 {args} {}
    method _dtor_doAutoGratArpForIPv6 {args} {}
    #----------------------------------------------------------------------
    # neighborTargetList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component neighborTargetList -public neighborTargetList
    method _ctor_neighborTargetList {args} {
        set neighborTargetList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name neighborTargetList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_neighborTargetList {args} {catch {$neighborTargetList destroy}}
    #----------------------------------------------------------------------
    # branchToNicMap (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component branchToNicMap -public branchToNicMap
    method _ctor_branchToNicMap {args} {
        set branchToNicMap [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype BranchToNic \
            -parent $self \
            -name branchToNicMap \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_branchToNicMap {args} {catch {$branchToNicMap destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PortController.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortController {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PortControllerService.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortControllerService {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Route.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Route {
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
        protocol PropertyString
        targetType PropertyString
        destinationIp PropertyString
        gateway PropertyString
        mask PropertyString
        prefixLength PropertyInt
    }
    #----------------------------------------------------------------------
    # protocol (PropertyString)
    # 
    #----------------------------------------------------------------------
    method protocol {args} {$self _mProp $self protocol $_propertyTypes(protocol) $args}
    method _ctor_protocol {args} {}
    method _dtor_protocol {args} {}
    #----------------------------------------------------------------------
    # targetType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method targetType {args} {$self _mProp $self targetType $_propertyTypes(targetType) $args}
    method _ctor_targetType {args} {}
    method _dtor_targetType {args} {}
    #----------------------------------------------------------------------
    # destinationIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method destinationIp {args} {$self _mProp $self destinationIp $_propertyTypes(destinationIp) $args}
    method _ctor_destinationIp {args} {}
    method _dtor_destinationIp {args} {}
    #----------------------------------------------------------------------
    # gateway (PropertyString)
    # 
    #----------------------------------------------------------------------
    method gateway {args} {$self _mProp $self gateway $_propertyTypes(gateway) $args}
    method _ctor_gateway {args} {}
    method _dtor_gateway {args} {}
    #----------------------------------------------------------------------
    # mask (PropertyString)
    # OBSOLETE: Please use prefix instead.
    #----------------------------------------------------------------------
    method mask {args} {$self _mProp $self mask $_propertyTypes(mask) $args {message {Please use prefix instead.}}}
    method _ctor_mask {args} {}
    method _dtor_mask {args} {}
    #----------------------------------------------------------------------
    # prefixLength (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method prefixLength {args} {$self _mProp $self prefixLength $_propertyTypes(prefixLength) $args}
    method _ctor_prefixLength {args} {}
    method _dtor_prefixLength {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/RoutesPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::RoutesPlugin {
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
    component c_Base -public GlobalPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::GlobalPlugin %AUTO%}
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
        routes PropertyNodeList
    }
    #----------------------------------------------------------------------
    # routes (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component routes -public routes
    method _ctor_routes {args} {
        set routes [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype Route \
            -parent $self \
            -name routes \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_routes {args} {catch {$routes destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ServiceExtension.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ServiceExtension {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/ServiceExtensionsWrapper.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::ServiceExtensionsWrapper {
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
        serviceExtensions PropertyNodeList
    }
    #----------------------------------------------------------------------
    # serviceExtensions (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component serviceExtensions -public serviceExtensions
    method _ctor_serviceExtensions {args} {
        set serviceExtensions [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype ServiceExtension \
            -parent $self \
            -name serviceExtensions \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_serviceExtensions {args} {catch {$serviceExtensions destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Session.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- Session::SupportedCardList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::SupportedCardList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- Session::SupportedPluginList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::SupportedPluginList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- Session::TestInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::TestInfo {
    component c_Struct -inherit true
    delegate method id to c_Struct using "%c _dcall %m"
    delegate method testName to c_Struct using "%c _dcall %m"
    delegate method userName to c_Struct using "%c _dcall %m"
    delegate method dateTime to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            id int32 {0}
            testName string {}
            userName string {}
            dateTime int64 {0}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- Session::TestInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::TestInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype Session.TestInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- Session::eEventType
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::eEventType {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kFsmEnteredStateUnconfigured
    typevariable kFsmEnteredStateRebootPorts
    typevariable kFsmEnteredStateTakeOwnership
    typevariable kFsmEnteredStateReset
    typevariable kFsmEnteredStateDodPackagesLoadStack
    typevariable kFsmEnteredStateDodPackagesUnloadStack
    typevariable kFsmEnteredStateConfigured
    typevariable kFsmEnteredStateConfigStack
    typevariable kFsmEnteredStatePostConfigStack
    typevariable kFsmEnteredStateDeconfigStack
    typevariable kFsmEnteredStateReleaseOwnership
    typevariable kFsmEnteredStateOther
    typevariable kFsmEnteredStateResetStack
    typevariable kFsmEnteredRunStateGratArp
    typevariable kFsmEnteredRunStateWaitLinkUp
    typevariable kFsmEnteredRunStateConfigured
    typevariable kUnconfigured
    typevariable kConfigured
    typevariable kTakeOwnership
    typevariable kReleaseOwnership
    typevariable kReset
    typevariable kDodPackagesLoad
    typevariable kDodPackagesUnload
    typevariable kConfiguredPhysical
    typevariable kRunning
    typevariable kReady
    typevariable kValidate
    typevariable kRemovedConfig
    typevariable kPluginInfo
    typevariable kPluginError
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kFsmEnteredStateUnconfigured]} {
            set kFsmEnteredStateUnconfigured [$type create %AUTO%];$kFsmEnteredStateUnconfigured Set kFsmEnteredStateUnconfigured
            set _tv [mytypevar kFsmEnteredStateUnconfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateRebootPorts]} {
            set kFsmEnteredStateRebootPorts [$type create %AUTO%];$kFsmEnteredStateRebootPorts Set kFsmEnteredStateRebootPorts
            set _tv [mytypevar kFsmEnteredStateRebootPorts]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateTakeOwnership]} {
            set kFsmEnteredStateTakeOwnership [$type create %AUTO%];$kFsmEnteredStateTakeOwnership Set kFsmEnteredStateTakeOwnership
            set _tv [mytypevar kFsmEnteredStateTakeOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateReset]} {
            set kFsmEnteredStateReset [$type create %AUTO%];$kFsmEnteredStateReset Set kFsmEnteredStateReset
            set _tv [mytypevar kFsmEnteredStateReset]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDodPackagesLoadStack]} {
            set kFsmEnteredStateDodPackagesLoadStack [$type create %AUTO%];$kFsmEnteredStateDodPackagesLoadStack Set kFsmEnteredStateDodPackagesLoadStack
            set _tv [mytypevar kFsmEnteredStateDodPackagesLoadStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDodPackagesUnloadStack]} {
            set kFsmEnteredStateDodPackagesUnloadStack [$type create %AUTO%];$kFsmEnteredStateDodPackagesUnloadStack Set kFsmEnteredStateDodPackagesUnloadStack
            set _tv [mytypevar kFsmEnteredStateDodPackagesUnloadStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateConfigured]} {
            set kFsmEnteredStateConfigured [$type create %AUTO%];$kFsmEnteredStateConfigured Set kFsmEnteredStateConfigured
            set _tv [mytypevar kFsmEnteredStateConfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateConfigStack]} {
            set kFsmEnteredStateConfigStack [$type create %AUTO%];$kFsmEnteredStateConfigStack Set kFsmEnteredStateConfigStack
            set _tv [mytypevar kFsmEnteredStateConfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStatePostConfigStack]} {
            set kFsmEnteredStatePostConfigStack [$type create %AUTO%];$kFsmEnteredStatePostConfigStack Set kFsmEnteredStatePostConfigStack
            set _tv [mytypevar kFsmEnteredStatePostConfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDeconfigStack]} {
            set kFsmEnteredStateDeconfigStack [$type create %AUTO%];$kFsmEnteredStateDeconfigStack Set kFsmEnteredStateDeconfigStack
            set _tv [mytypevar kFsmEnteredStateDeconfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateReleaseOwnership]} {
            set kFsmEnteredStateReleaseOwnership [$type create %AUTO%];$kFsmEnteredStateReleaseOwnership Set kFsmEnteredStateReleaseOwnership
            set _tv [mytypevar kFsmEnteredStateReleaseOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateOther]} {
            set kFsmEnteredStateOther [$type create %AUTO%];$kFsmEnteredStateOther Set kFsmEnteredStateOther
            set _tv [mytypevar kFsmEnteredStateOther]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateResetStack]} {
            set kFsmEnteredStateResetStack [$type create %AUTO%];$kFsmEnteredStateResetStack Set kFsmEnteredStateResetStack
            set _tv [mytypevar kFsmEnteredStateResetStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateGratArp]} {
            set kFsmEnteredRunStateGratArp [$type create %AUTO%];$kFsmEnteredRunStateGratArp Set kFsmEnteredRunStateGratArp
            set _tv [mytypevar kFsmEnteredRunStateGratArp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateWaitLinkUp]} {
            set kFsmEnteredRunStateWaitLinkUp [$type create %AUTO%];$kFsmEnteredRunStateWaitLinkUp Set kFsmEnteredRunStateWaitLinkUp
            set _tv [mytypevar kFsmEnteredRunStateWaitLinkUp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateConfigured]} {
            set kFsmEnteredRunStateConfigured [$type create %AUTO%];$kFsmEnteredRunStateConfigured Set kFsmEnteredRunStateConfigured
            set _tv [mytypevar kFsmEnteredRunStateConfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kUnconfigured]} {
            set kUnconfigured [$type create %AUTO%];$kUnconfigured Set kUnconfigured
            set _tv [mytypevar kUnconfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kConfigured]} {
            set kConfigured [$type create %AUTO%];$kConfigured Set kConfigured
            set _tv [mytypevar kConfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTakeOwnership]} {
            set kTakeOwnership [$type create %AUTO%];$kTakeOwnership Set kTakeOwnership
            set _tv [mytypevar kTakeOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kReleaseOwnership]} {
            set kReleaseOwnership [$type create %AUTO%];$kReleaseOwnership Set kReleaseOwnership
            set _tv [mytypevar kReleaseOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kReset]} {
            set kReset [$type create %AUTO%];$kReset Set kReset
            set _tv [mytypevar kReset]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDodPackagesLoad]} {
            set kDodPackagesLoad [$type create %AUTO%];$kDodPackagesLoad Set kDodPackagesLoad
            set _tv [mytypevar kDodPackagesLoad]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDodPackagesUnload]} {
            set kDodPackagesUnload [$type create %AUTO%];$kDodPackagesUnload Set kDodPackagesUnload
            set _tv [mytypevar kDodPackagesUnload]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kConfiguredPhysical]} {
            set kConfiguredPhysical [$type create %AUTO%];$kConfiguredPhysical Set kConfiguredPhysical
            set _tv [mytypevar kConfiguredPhysical]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRunning]} {
            set kRunning [$type create %AUTO%];$kRunning Set kRunning
            set _tv [mytypevar kRunning]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kReady]} {
            set kReady [$type create %AUTO%];$kReady Set kReady
            set _tv [mytypevar kReady]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kValidate]} {
            set kValidate [$type create %AUTO%];$kValidate Set kValidate
            set _tv [mytypevar kValidate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRemovedConfig]} {
            set kRemovedConfig [$type create %AUTO%];$kRemovedConfig Set kRemovedConfig
            set _tv [mytypevar kRemovedConfig]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPluginInfo]} {
            set kPluginInfo [$type create %AUTO%];$kPluginInfo Set kPluginInfo
            set _tv [mytypevar kPluginInfo]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPluginError]} {
            set kPluginError [$type create %AUTO%];$kPluginError Set kPluginError
            set _tv [mytypevar kPluginError]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kFsmEnteredStateUnconfigured
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kFsmEnteredStateUnconfigured
      1 kFsmEnteredStateRebootPorts
      2 kFsmEnteredStateTakeOwnership
      3 kFsmEnteredStateReset
      4 kFsmEnteredStateDodPackagesLoadStack
      5 kFsmEnteredStateDodPackagesUnloadStack
      6 kFsmEnteredStateConfigured
      7 kFsmEnteredStateConfigStack
      8 kFsmEnteredStatePostConfigStack
      9 kFsmEnteredStateDeconfigStack
      10 kFsmEnteredStateReleaseOwnership
      11 kFsmEnteredStateOther
      12 kFsmEnteredStateResetStack
      13 kFsmEnteredRunStateGratArp
      14 kFsmEnteredRunStateWaitLinkUp
      15 kFsmEnteredRunStateConfigured
      16 kUnconfigured
      17 kConfigured
      18 kTakeOwnership
      19 kReleaseOwnership
      20 kReset
      21 kDodPackagesLoad
      22 kDodPackagesUnload
      23 kConfiguredPhysical
      24 kRunning
      25 kReady
      26 kValidate
      27 kRemovedConfig
      28 kPluginInfo
      29 kPluginError
    }
    typevariable m_encoder -array {
      kFsmEnteredStateUnconfigured 0
      kFsmEnteredStateRebootPorts 1
      kFsmEnteredStateTakeOwnership 2
      kFsmEnteredStateReset 3
      kFsmEnteredStateDodPackagesLoadStack 4
      kFsmEnteredStateDodPackagesUnloadStack 5
      kFsmEnteredStateConfigured 6
      kFsmEnteredStateConfigStack 7
      kFsmEnteredStatePostConfigStack 8
      kFsmEnteredStateDeconfigStack 9
      kFsmEnteredStateReleaseOwnership 10
      kFsmEnteredStateOther 11
      kFsmEnteredStateResetStack 12
      kFsmEnteredRunStateGratArp 13
      kFsmEnteredRunStateWaitLinkUp 14
      kFsmEnteredRunStateConfigured 15
      kUnconfigured 16
      kConfigured 17
      kTakeOwnership 18
      kReleaseOwnership 19
      kReset 20
      kDodPackagesLoad 21
      kDodPackagesUnload 22
      kConfiguredPhysical 23
      kRunning 24
      kReady 25
      kValidate 26
      kRemovedConfig 27
      kPluginInfo 28
      kPluginError 29
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- Session::EventData
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Session::EventData {
    component c_Struct -inherit true
    delegate method eventType to c_Struct using "%c _dcall %m"
    delegate method eventMessage to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            eventType Session.eEventType {}
            eventMessage string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::Session {
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
    # SupportedCardList
    # SupportedPluginList
    # TestInfo
    # TestInfoList
    # eEventType
    # EventData
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
    typevariable _SIG_SetErrorInjectionTags {
        {name i_errorTags type string direction in}
    }
    method SetErrorInjectionTags {
        args
    } {
        $self _mCall $self $_SIG_SetErrorInjectionTags SetErrorInjectionTags args
    }
    typevariable _SIG_SetCardsSupportedByApplication {
        {name supportedCardList type Session.SupportedCardList direction in}
    }
    method SetCardsSupportedByApplication {
        args
    } {
        $self _mCall $self $_SIG_SetCardsSupportedByApplication SetCardsSupportedByApplication args
    }
    typevariable _SIG_SetPluginsSupportedByApplication {
        {name supportedPluginList type Session.SupportedPluginList direction in}
    }
    method SetPluginsSupportedByApplication {
        args
    } {
        $self _mCall $self $_SIG_SetPluginsSupportedByApplication SetPluginsSupportedByApplication args
    }
    typevariable _SIG_ClearHardwareTimeStamp {
    }
    method ClearHardwareTimeStamp {
        args
    } {
        $self _mCall $self $_SIG_ClearHardwareTimeStamp ClearHardwareTimeStamp args
    }
    typevariable _SIG_ConfigureTest {
    }
    method ConfigureTest {
        args
    } {
        $self _mCall $self $_SIG_ConfigureTest ConfigureTest args
    }
    typevariable _SIG_DeconfigureTest {
    }
    method DeconfigureTest {
        args
    } {
        $self _mCall $self $_SIG_DeconfigureTest DeconfigureTest args
    }
    typevariable _SIG_StartTest {
    }
    method StartTest {
        args
    } {
        $self _mCall $self $_SIG_StartTest StartTest args
    }
    typevariable _SIG_StopTest {
    }
    method StopTest {
        args
    } {
        $self _mCall $self $_SIG_StopTest StopTest args
    }
    typevariable _SIG_CancelTest {
    }
    method CancelTest {
        args
    } {
        $self _mCall $self $_SIG_CancelTest CancelTest args
    }
    typevariable _SIG_CloseTest {
    }
    method CloseTest {
        args
    } {
        $self _mCall $self $_SIG_CloseTest CloseTest args
    }
    typevariable _SIG_Ping {
    }
    method Ping {
        args
    } {
        $self _mCall $self $_SIG_Ping Ping args
    }
    typevariable _SIG_Close {
    }
    method Close {
        args
    } {
        $self _mCall $self $_SIG_Close Close args
    }
    typevariable _SIG_CreateTest {
        {name test type Test direction out}
    }
    method CreateTest {
        args
    } {
        $self _mCall $self $_SIG_CreateTest CreateTest args
    }
    typevariable _SIG_DeleteTest {
        {name testId type int32 direction in}
    }
    method DeleteTest {
        args
    } {
        $self _mCall $self $_SIG_DeleteTest DeleteTest args
    }
    typevariable _SIG_RenameTest {
        {name testId type int32 direction in}
        {name name type string direction in}
    }
    method RenameTest {
        args
    } {
        $self _mCall $self $_SIG_RenameTest RenameTest args
    }
    typevariable _SIG_OpenTest {
        {name testId type int32 direction in}
        {name test type Test direction out}
    }
    method OpenTest {
        args
    } {
        $self _mCall $self $_SIG_OpenTest OpenTest args
    }
    typevariable _SIG_OpenTestByName {
        {name filename type string direction in}
        {name test type Test direction out}
    }
    method OpenTestByName {
        args
    } {
        $self _mCall $self $_SIG_OpenTestByName OpenTestByName args
    }
    typevariable _SIG_OpenTestResult {
        {name testResultId type int32 direction in}
        {name test type Test direction out}
    }
    method OpenTestResult {
        args
    } {
        $self _mCall $self $_SIG_OpenTestResult OpenTestResult args
    }
    typevariable _SIG_OpenTestResultByName {
        {name filename type string direction in}
        {name test type Test direction out}
    }
    method OpenTestResultByName {
        args
    } {
        $self _mCall $self $_SIG_OpenTestResultByName OpenTestResultByName args
    }
    typevariable _SIG_GetTestList {
        {name testName type string direction in}
        {name userName type string direction in}
        {name dateTimeBegin type int64 direction in}
        {name dateTimeEnd type int64 direction in}
        {name testInfoList type Session.TestInfoList direction out}
    }
    method GetTestList {
        args
    } {
        $self _mCall $self $_SIG_GetTestList GetTestList args
    }
    typevariable _SIG_GetTestResultList {
        {name testName type string direction in}
        {name userName type string direction in}
        {name dateTimeBegin type int64 direction in}
        {name dateTimeEnd type int64 direction in}
        {name testInfoList type Session.TestInfoList direction out}
    }
    method GetTestResultList {
        args
    } {
        $self _mCall $self $_SIG_GetTestResultList GetTestResultList args
    }
    typevariable _SIG_GetAppName {
        {name name type string direction out}
    }
    method GetAppName {
        args
    } {
        $self _mCall $self $_SIG_GetAppName GetAppName args
    }
    typevariable _SIG_GetTestXml {
        {name testId  type int32 direction in}
        {name xml type string direction out}
    }
    method GetTestXml {
        args
    } {
        $self _mCall $self $_SIG_GetTestXml GetTestXml args
    }
    typevariable _SIG_GetTestResultXml {
        {name testId  type int32 direction in}
        {name xml type string direction out}
    }
    method GetTestResultXml {
        args
    } {
        $self _mCall $self $_SIG_GetTestResultXml GetTestResultXml args
    }
    typevariable _SIG_SetPortGroupDefault {
        {name xml type string direction in}
    }
    method SetPortGroupDefault {
        args
    } {
        $self _mCall $self $_SIG_SetPortGroupDefault SetPortGroupDefault args
    }
    typevariable _SIG_SetUserName {
        {name userName type string direction in}
    }
    method SetUserName {
        args
    } {
        $self _mCall $self $_SIG_SetUserName SetUserName args
    }
    typevariable _SIG_SetActivityModels {
        {name activityModels type ActivityConfig.ActivityModelVector direction in}
    }
    method SetActivityModels {
        args
    } {
        $self _mCall $self $_SIG_SetActivityModels SetActivityModels args
    }
    typevariable _SIG_GetActivityModels {
        {name activityModels type ActivityConfig.ActivityModelVector direction out}
    }
    method GetActivityModels {
        args
    } {
        $self _mCall $self $_SIG_GetActivityModels GetActivityModels args
    }
    typevariable _SIG_CreateTestServerUnitTestNode {
        {name unitTestNode type TestServerUnitTestNode direction out}
    }
    method CreateTestServerUnitTestNode {
        args
    } {
        $self _mCall $self $_SIG_CreateTestServerUnitTestNode CreateTestServerUnitTestNode args
    }
    typevariable _SIG_AddLicense {
        {name featureId type string direction in}
    }
    method AddLicense {
        args
    } {
        $self _mCall $self $_SIG_AddLicense AddLicense args
    }
    typevariable _SIG_Internal_EnableActionBehaviorMessages {
        {name enable type bool direction in}
    }
    method Internal_EnableActionBehaviorMessages {
        args
    } {
        $self _mCall $self $_SIG_Internal_EnableActionBehaviorMessages Internal_EnableActionBehaviorMessages args
    }
    typevariable _SIG_Internal_GetActionBehaviorMessages {
        {name clear type bool direction in}
        {name messagelist type GenericTestModel.StringVector direction out}
    }
    method Internal_GetActionBehaviorMessages {
        args
    } {
        $self _mCall $self $_SIG_Internal_GetActionBehaviorMessages Internal_GetActionBehaviorMessages args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_PostConfigError {
        {name i_errorMessage type string direction out}
    }
    method Request_PostConfigError {args} {
        set args [concat -event PostConfigError $args]
        $self _eEvent request $self $_SIG_PostConfigError args
    }
    method Cancel_PostConfigError {requestid args} {
        set args [concat -requestid $requestid -event PostConfigError $args]
        $self _eEvent cancellation $self $_SIG_PostConfigError args
    }
    typevariable _SIG_SystemEvent {
        {name i_eventData type Session.EventData direction out}
    }
    method Request_SystemEvent {args} {
        set args [concat -event SystemEvent $args]
        $self _eEvent request $self $_SIG_SystemEvent args
    }
    method Cancel_SystemEvent {requestid args} {
        set args [concat -requestid $requestid -event SystemEvent $args]
        $self _eEvent cancellation $self $_SIG_SystemEvent args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        runningTest PropertyNode
        editableTest PropertyNode
        doWaitLinkUp PropertyBoolean
        doGratArp PropertyBoolean
        doInterfaceCheck PropertyBoolean
        serviceExtensionList PropertyNodeList
        waitForLinkUp PropertyBoolean
    }
    #----------------------------------------------------------------------
    # runningTest (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component runningTest -public runningTest
    method _ctor_runningTest {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Test]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType runningTest]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set runningTest [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name runningTest \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_runningTest {args} {catch {$runningTest destroy}}
    #----------------------------------------------------------------------
    # editableTest (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component editableTest -public editableTest
    method _ctor_editableTest {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype Test]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType editableTest]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set editableTest [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name editableTest \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_editableTest {args} {catch {$editableTest destroy}}
    #----------------------------------------------------------------------
    # doWaitLinkUp (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method doWaitLinkUp {args} {$self _mProp $self doWaitLinkUp $_propertyTypes(doWaitLinkUp) $args}
    method _ctor_doWaitLinkUp {args} {}
    method _dtor_doWaitLinkUp {args} {}
    #----------------------------------------------------------------------
    # doGratArp (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method doGratArp {args} {$self _mProp $self doGratArp $_propertyTypes(doGratArp) $args}
    method _ctor_doGratArp {args} {}
    method _dtor_doGratArp {args} {}
    #----------------------------------------------------------------------
    # doInterfaceCheck (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method doInterfaceCheck {args} {$self _mProp $self doInterfaceCheck $_propertyTypes(doInterfaceCheck) $args}
    method _ctor_doInterfaceCheck {args} {}
    method _dtor_doInterfaceCheck {args} {}
    #----------------------------------------------------------------------
    # serviceExtensionList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component serviceExtensionList -public serviceExtensionList
    method _ctor_serviceExtensionList {args} {
        set serviceExtensionList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype ServiceExtension \
            -parent $self \
            -name serviceExtensionList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_serviceExtensionList {args} {catch {$serviceExtensionList destroy}}
    #----------------------------------------------------------------------
    # waitForLinkUp (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method waitForLinkUp {args} {$self _mProp $self waitForLinkUp $_propertyTypes(waitForLinkUp) $args}
    method _ctor_waitForLinkUp {args} {}
    method _dtor_waitForLinkUp {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/SnmpPlugin.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- SnmpPlugin::MibVars
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SnmpPlugin::MibVars {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- SnmpPlugin::SnmpTemplate
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SnmpPlugin::SnmpTemplate {
    component c_Struct -inherit true
    delegate method m_Name to c_Struct using "%c _dcall %m"
    delegate method m_Description to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            m_Name string {}
            m_Description string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- SnmpPlugin::SnmpTemplates
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SnmpPlugin::SnmpTemplates {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype SnmpPlugin.SnmpTemplate]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::SnmpPlugin {
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
    component c_Base -public GenericStatSource -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::GenericStatSource %AUTO%}
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
    # MibVars
    # SnmpTemplate
    # SnmpTemplates
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
    typevariable _SIG_MibGetChildren {
        {name sPath type string direction in}
        {name childNodes type SnmpPlugin.MibVars direction out}
    }
    method MibGetChildren {
        args
    } {
        $self _mCall $self $_SIG_MibGetChildren MibGetChildren args
    }
    typevariable _SIG_MibGetType {
        {name sPath type string direction in}
        {name type type string direction out}
    }
    method MibGetType {
        args
    } {
        $self _mCall $self $_SIG_MibGetType MibGetType args
    }
    typevariable _SIG_MibGetDescription {
        {name sPath type string direction in}
        {name description type string direction out}
    }
    method MibGetDescription {
        args
    } {
        $self _mCall $self $_SIG_MibGetDescription MibGetDescription args
    }
    typevariable _SIG_MibResolveToName {
        {name sPath type string direction in}
        {name name type string direction out}
    }
    method MibResolveToName {
        args
    } {
        $self _mCall $self $_SIG_MibResolveToName MibResolveToName args
    }
    typevariable _SIG_MibResolveToOID {
        {name sPath type string direction in}
        {name oid type string direction out}
    }
    method MibResolveToOID {
        args
    } {
        $self _mCall $self $_SIG_MibResolveToOID MibResolveToOID args
    }
    typevariable _SIG_MibAddNewMib {
        {name FileName type string direction in}
        {name body type string direction in}
    }
    method MibAddNewMib {
        args
    } {
        $self _mCall $self $_SIG_MibAddNewMib MibAddNewMib args
    }
    typevariable _SIG_Init {
    }
    method Init {
        args
    } {
        $self _mCall $self $_SIG_Init Init args
    }
    typevariable _SIG_PopulateStatCatalog {
    }
    method PopulateStatCatalog {
        args
    } {
        $self _mCall $self $_SIG_PopulateStatCatalog PopulateStatCatalog args
    }
    typevariable _SIG_TmplGetTemplates {
        {name templates type SnmpPlugin.SnmpTemplates direction out}
    }
    method TmplGetTemplates {
        args
    } {
        $self _mCall $self $_SIG_TmplGetTemplates TmplGetTemplates args
    }
    typevariable _SIG_TmplRename {
        {name oldName type string direction in}
        {name newName type string direction in}
        {name description type string direction in}
    }
    method TmplRename {
        args
    } {
        $self _mCall $self $_SIG_TmplRename TmplRename args
    }
    typevariable _SIG_TmplLoad {
        {name name type string direction in}
        {name result type string direction out}
    }
    method TmplLoad {
        args
    } {
        $self _mCall $self $_SIG_TmplLoad TmplLoad args
    }
    typevariable _SIG_TmplSave {
        {name name type string direction in}
        {name body type string direction in}
        {name result type string direction out}
    }
    method TmplSave {
        args
    } {
        $self _mCall $self $_SIG_TmplSave TmplSave args
    }
    typevariable _SIG_TmplRemove {
        {name name type string direction in}
    }
    method TmplRemove {
        args
    } {
        $self _mCall $self $_SIG_TmplRemove TmplRemove args
    }
    typevariable _SIG_IsStarted {
        {name result type bool direction out}
    }
    method IsStarted {
        args
    } {
        $self _mCall $self $_SIG_IsStarted IsStarted args
    }
    typevariable _SIG_IsSourceInUse {
        {name name type string direction in}
        {name result type bool direction out}
    }
    method IsSourceInUse {
        args
    } {
        $self _mCall $self $_SIG_IsSourceInUse IsSourceInUse args
    }
    typevariable _SIG_IsStatInUse {
        {name source type string direction in}
        {name stat type string direction in}
        {name result type bool direction out}
    }
    method IsStatInUse {
        args
    } {
        $self _mCall $self $_SIG_IsStatInUse IsStatInUse args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        snmpStatSources PropertyNodeList
    }
    #----------------------------------------------------------------------
    # snmpStatSources (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component snmpStatSources -public snmpStatSources
    method _ctor_snmpStatSources {args} {
        set snmpStatSources [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype SnmpStatSource \
            -parent $self \
            -name snmpStatSources \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_snmpStatSources {args} {catch {$snmpStatSources destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/SnmpStatSource.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SnmpStatSource {
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
        name PropertyString
        description PropertyString
        snmpHost PropertyString
        snmpPort PropertyInt
        snmpVersion PropertyInt
        community PropertyString
        ysePort PropertyString
        destination PropertyString
        snmpVariables PropertyNodeList
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # description (PropertyString)
    # 
    #----------------------------------------------------------------------
    method description {args} {$self _mProp $self description $_propertyTypes(description) $args}
    method _ctor_description {args} {}
    method _dtor_description {args} {}
    #----------------------------------------------------------------------
    # snmpHost (PropertyString)
    # 
    #----------------------------------------------------------------------
    method snmpHost {args} {$self _mProp $self snmpHost $_propertyTypes(snmpHost) $args}
    method _ctor_snmpHost {args} {}
    method _dtor_snmpHost {args} {}
    #----------------------------------------------------------------------
    # snmpPort (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method snmpPort {args} {$self _mProp $self snmpPort $_propertyTypes(snmpPort) $args}
    method _ctor_snmpPort {args} {}
    method _dtor_snmpPort {args} {}
    #----------------------------------------------------------------------
    # snmpVersion (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method snmpVersion {args} {$self _mProp $self snmpVersion $_propertyTypes(snmpVersion) $args}
    method _ctor_snmpVersion {args} {}
    method _dtor_snmpVersion {args} {}
    #----------------------------------------------------------------------
    # community (PropertyString)
    # 
    #----------------------------------------------------------------------
    method community {args} {$self _mProp $self community $_propertyTypes(community) $args}
    method _ctor_community {args} {}
    method _dtor_community {args} {}
    #----------------------------------------------------------------------
    # ysePort (PropertyString)
    # 
    #----------------------------------------------------------------------
    method ysePort {args} {$self _mProp $self ysePort $_propertyTypes(ysePort) $args}
    method _ctor_ysePort {args} {}
    method _dtor_ysePort {args} {}
    #----------------------------------------------------------------------
    # destination (PropertyString)
    # 
    #----------------------------------------------------------------------
    method destination {args} {$self _mProp $self destination $_propertyTypes(destination) $args}
    method _ctor_destination {args} {}
    method _dtor_destination {args} {}
    #----------------------------------------------------------------------
    # snmpVariables (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component snmpVariables -public snmpVariables
    method _ctor_snmpVariables {args} {
        set snmpVariables [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype SnmpStatVariable \
            -parent $self \
            -name snmpVariables \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_snmpVariables {args} {catch {$snmpVariables destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/SnmpStatVariable.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SnmpStatVariable {
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
        name PropertyString
        oidText PropertyString
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # oidText (PropertyString)
    # 
    #----------------------------------------------------------------------
    method oidText {args} {$self _mProp $self oidText $_propertyTypes(oidText) $args}
    method _ctor_oidText {args} {}
    method _dtor_oidText {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/SonetATMBasePlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::SonetATMBasePlugin {
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
    component c_Base -public HardwarePlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::HardwarePlugin %AUTO%}
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
        interfaceType PropertyString
        c2Transmit PropertyInt
        c2Expected PropertyInt
        transmitClocking PropertyString
        crc PropertyString
        dataScrambling PropertyBoolean
    }
    #----------------------------------------------------------------------
    # interfaceType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method interfaceType {args} {$self _mProp $self interfaceType $_propertyTypes(interfaceType) $args}
    method _ctor_interfaceType {args} {}
    method _dtor_interfaceType {args} {}
    #----------------------------------------------------------------------
    # c2Transmit (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method c2Transmit {args} {$self _mProp $self c2Transmit $_propertyTypes(c2Transmit) $args}
    method _ctor_c2Transmit {args} {}
    method _dtor_c2Transmit {args} {}
    #----------------------------------------------------------------------
    # c2Expected (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method c2Expected {args} {$self _mProp $self c2Expected $_propertyTypes(c2Expected) $args}
    method _ctor_c2Expected {args} {}
    method _dtor_c2Expected {args} {}
    #----------------------------------------------------------------------
    # transmitClocking (PropertyString)
    # 
    #----------------------------------------------------------------------
    method transmitClocking {args} {$self _mProp $self transmitClocking $_propertyTypes(transmitClocking) $args}
    method _ctor_transmitClocking {args} {}
    method _dtor_transmitClocking {args} {}
    #----------------------------------------------------------------------
    # crc (PropertyString)
    # 
    #----------------------------------------------------------------------
    method crc {args} {$self _mProp $self crc $_propertyTypes(crc) $args}
    method _ctor_crc {args} {}
    method _dtor_crc {args} {}
    #----------------------------------------------------------------------
    # dataScrambling (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method dataScrambling {args} {$self _mProp $self dataScrambling $_propertyTypes(dataScrambling) $args}
    method _ctor_dataScrambling {args} {}
    method _dtor_dataScrambling {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StackElementPlugin.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Struct -- StackElementPlugin::CardPluginInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::CardPluginInfo {
    component c_Struct -inherit true
    delegate method name to c_Struct using "%c _dcall %m"
    delegate method type to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            name string {}
            type string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StackElementPlugin::SupportedCardInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::SupportedCardInfo {
    component c_Struct -inherit true
    delegate method type to c_Struct using "%c _dcall %m"
    delegate method maxInterfaces to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            type string {}
            maxInterfaces int32 {99999}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StackElementPlugin::CardPluginInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::CardPluginInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StackElementPlugin.CardPluginInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StackElementPlugin::BaseStyleList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::BaseStyleList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StackElementPlugin::SupportedCardList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::SupportedCardList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StackElementPlugin.SupportedCardInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StackElementPlugin::PluginInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::PluginInfo {
    component c_Struct -inherit true
    delegate method sourceLocation to c_Struct using "%c _dcall %m"
    delegate method version to c_Struct using "%c _dcall %m"
    delegate method type to c_Struct using "%c _dcall %m"
    delegate method name to c_Struct using "%c _dcall %m"
    delegate method pluginClass to c_Struct using "%c _dcall %m"
    delegate method compatibleCards to c_Struct using "%c _dcall %m"
    delegate method canStackOnBaseStyles to c_Struct using "%c _dcall %m"
    delegate method canProvideBaseStyles to c_Struct using "%c _dcall %m"
    delegate method supportedCards to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            sourceLocation string {}
            version string {}
            type string {}
            name string {}
            pluginClass string {}
            compatibleCards StackElementPlugin.CardPluginInfoList {}
            canStackOnBaseStyles StackElementPlugin.BaseStyleList {}
            canProvideBaseStyles StackElementPlugin.BaseStyleList {}
            supportedCards StackElementPlugin.SupportedCardList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StackElementPlugin::PluginInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StackElementPlugin::PluginInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StackElementPlugin.PluginInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::StackElementPlugin {
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
    component c_Base -public DataDrivenFormBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::DataDrivenFormBase %AUTO%}
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
    # CardPluginInfo
    # SupportedCardInfo
    # CardPluginInfoList
    # BaseStyleList
    # SupportedCardList
    # PluginInfo
    # PluginInfoList
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
    typevariable _SIG_Echo {
        {name value type string direction in}
        {name rval type string direction out}
    }
    method Echo {
        args
    } {
        $self _mCall $self $_SIG_Echo Echo args
    }
    typevariable _SIG_DirectoryInfo {
        {name rval type StackElementPlugin.PluginInfo direction out}
    }
    method DirectoryInfo {
        args
    } {
        $self _mCall $self $_SIG_DirectoryInfo DirectoryInfo args
    }
    typevariable _SIG_InsertPluginParent {
        {name pluginType type string direction in}
        {name newPlugin type StackElementPlugin direction out}
    }
    method InsertPluginParent {
        args
    } {
        $self _mCall $self $_SIG_InsertPluginParent InsertPluginParent args
    }
    typevariable _SIG_InsertBeforeCandidates {
        {name candidates type StackElementPlugin.PluginInfoList direction out}
    }
    method InsertBeforeCandidates {
        args
    } {
        $self _mCall $self $_SIG_InsertBeforeCandidates InsertBeforeCandidates args
    }
    typevariable _SIG_RemovePluginChild {
        {name index type int32 direction in}
    }
    method RemovePluginChild {
        args
    } {
        $self _mCall $self $_SIG_RemovePluginChild RemovePluginChild args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        childrenList PropertyNodeList
        internalStackElementId PropertyString
        comment PropertyString
    }
    #----------------------------------------------------------------------
    # childrenList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component childrenList -public childrenList
    method _ctor_childrenList {args} {
        set childrenList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StackElementPlugin \
            -parent $self \
            -name childrenList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_childrenList {args} {catch {$childrenList destroy}}
    #----------------------------------------------------------------------
    # internalStackElementId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method internalStackElementId {args} {$self _mProp $self internalStackElementId $_propertyTypes(internalStackElementId) $args}
    method _ctor_internalStackElementId {args} {}
    method _dtor_internalStackElementId {args} {}
    #----------------------------------------------------------------------
    # comment (PropertyString)
    # 
    #----------------------------------------------------------------------
    method comment {args} {$self _mProp $self comment $_propertyTypes(comment) $args}
    method _ctor_comment {args} {}
    method _dtor_comment {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatAttribute.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatAttribute {
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
        color PropertyString
    }
    #----------------------------------------------------------------------
    # color (PropertyString)
    # 
    #----------------------------------------------------------------------
    method color {args} {$self _mProp $self color $_propertyTypes(color) $args}
    method _ctor_color {args} {}
    method _dtor_color {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatAttributeList.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatAttributeList {
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
        statAttributeList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # statAttributeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statAttributeList -public statAttributeList
    method _ctor_statAttributeList {args} {
        set statAttributeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatAttribute \
            -parent $self \
            -name statAttributeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statAttributeList {args} {catch {$statAttributeList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatCatalogItem.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatCatalogItem {
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
        statSourceType PropertyString
        id PropertyInt
        statPublisher PropertyString
        statList PropertyNodeList
        statFilterList PropertyNodeList
        description PropertyString
    }
    #----------------------------------------------------------------------
    # statSourceType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method statSourceType {args} {$self _mProp $self statSourceType $_propertyTypes(statSourceType) $args}
    method _ctor_statSourceType {args} {}
    method _dtor_statSourceType {args} {}
    #----------------------------------------------------------------------
    # id (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method id {args} {$self _mProp $self id $_propertyTypes(id) $args}
    method _ctor_id {args} {}
    method _dtor_id {args} {}
    #----------------------------------------------------------------------
    # statPublisher (PropertyString)
    # 
    #----------------------------------------------------------------------
    method statPublisher {args} {$self _mProp $self statPublisher $_propertyTypes(statPublisher) $args}
    method _ctor_statPublisher {args} {}
    method _dtor_statPublisher {args} {}
    #----------------------------------------------------------------------
    # statList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statList -public statList
    method _ctor_statList {args} {
        set statList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatCatalogStat \
            -parent $self \
            -name statList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statList {args} {catch {$statList destroy}}
    #----------------------------------------------------------------------
    # statFilterList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statFilterList -public statFilterList
    method _ctor_statFilterList {args} {
        set statFilterList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatFilter \
            -parent $self \
            -name statFilterList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statFilterList {args} {catch {$statFilterList destroy}}
    #----------------------------------------------------------------------
    # description (PropertyString)
    # 
    #----------------------------------------------------------------------
    method description {args} {$self _mProp $self description $_propertyTypes(description) $args}
    method _ctor_description {args} {}
    method _dtor_description {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatCatalogStat.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatCatalogStat {
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
        name PropertyString
        id PropertyInt
        valueType PropertyInt
        statType PropertyInt
        indexMin PropertyInt
        indexMax PropertyInt
        availableAggregationTypeList PropertyIntList
        statEnginePath PropertyString
        description PropertyString
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # id (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method id {args} {$self _mProp $self id $_propertyTypes(id) $args}
    method _ctor_id {args} {}
    method _dtor_id {args} {}
    #----------------------------------------------------------------------
    # valueType (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method valueType {args} {$self _mProp $self valueType $_propertyTypes(valueType) $args}
    method _ctor_valueType {args} {}
    method _dtor_valueType {args} {}
    #----------------------------------------------------------------------
    # statType (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method statType {args} {$self _mProp $self statType $_propertyTypes(statType) $args}
    method _ctor_statType {args} {}
    method _dtor_statType {args} {}
    #----------------------------------------------------------------------
    # indexMin (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method indexMin {args} {$self _mProp $self indexMin $_propertyTypes(indexMin) $args}
    method _ctor_indexMin {args} {}
    method _dtor_indexMin {args} {}
    #----------------------------------------------------------------------
    # indexMax (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method indexMax {args} {$self _mProp $self indexMax $_propertyTypes(indexMax) $args}
    method _ctor_indexMax {args} {}
    method _dtor_indexMax {args} {}
    #----------------------------------------------------------------------
    # availableAggregationTypeList (PropertyIntList)
    # 
    #----------------------------------------------------------------------
    component availableAggregationTypeList -public availableAggregationTypeList
    method _ctor_availableAggregationTypeList {args} {
        set availableAggregationTypeList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype Int \
            -name availableAggregationTypeList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_availableAggregationTypeList {args} {catch {$availableAggregationTypeList destroy}}
    #----------------------------------------------------------------------
    # statEnginePath (PropertyString)
    # 
    #----------------------------------------------------------------------
    method statEnginePath {args} {$self _mProp $self statEnginePath $_propertyTypes(statEnginePath) $args}
    method _ctor_statEnginePath {args} {}
    method _dtor_statEnginePath {args} {}
    #----------------------------------------------------------------------
    # description (PropertyString)
    # 
    #----------------------------------------------------------------------
    method description {args} {$self _mProp $self description $_propertyTypes(description) $args}
    method _ctor_description {args} {}
    method _dtor_description {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatFilter.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatFilter {
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
        name PropertyString
        valueList PropertyStringList
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # valueList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component valueList -public valueList
    method _ctor_valueList {args} {
        set valueList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name valueList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_valueList {args} {catch {$valueList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatFilterGroup.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatFilterGroup {
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
        caption PropertyString
        statFilterList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # caption (PropertyString)
    # 
    #----------------------------------------------------------------------
    method caption {args} {$self _mProp $self caption $_propertyTypes(caption) $args}
    method _ctor_caption {args} {}
    method _dtor_caption {args} {}
    #----------------------------------------------------------------------
    # statFilterList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statFilterList -public statFilterList
    method _ctor_statFilterList {args} {
        set statFilterList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatFilter \
            -parent $self \
            -name statFilterList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statFilterList {args} {catch {$statFilterList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatManager.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- StatManager::StatPathList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::StatPathList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::ResolvedStat
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::ResolvedStat {
    component c_Struct -inherit true
    delegate method tag to c_Struct using "%c _dcall %m"
    delegate method statPathList to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            tag string {}
            statPathList StatManager.StatPathList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::ResolvedStatList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::ResolvedStatList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.ResolvedStat]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::ValueList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::ValueList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::StatFilter
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::StatFilter {
    component c_Struct -inherit true
    delegate method name to c_Struct using "%c _dcall %m"
    delegate method valueList to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            name string {}
            valueList StatManager.ValueList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::StatFilterList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::StatFilterList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.StatFilter]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::AggregatedStat
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::AggregatedStat {
    component c_Struct -inherit true
    delegate method tag to c_Struct using "%c _dcall %m"
    delegate method statSourceType to c_Struct using "%c _dcall %m"
    delegate method statName to c_Struct using "%c _dcall %m"
    delegate method filters to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            tag string {}
            statSourceType string {}
            statName string {}
            filters StatManager.StatFilterList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::AggregatedStatList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::AggregatedStatList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.AggregatedStat]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::AggregatedStatInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::AggregatedStatInfo {
    component c_Struct -inherit true
    delegate method tag to c_Struct using "%c _dcall %m"
    delegate method statSourceType to c_Struct using "%c _dcall %m"
    delegate method statName to c_Struct using "%c _dcall %m"
    delegate method statType to c_Struct using "%c _dcall %m"
    delegate method index to c_Struct using "%c _dcall %m"
    delegate method indexLast to c_Struct using "%c _dcall %m"
    delegate method filters to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            tag string {}
            statSourceType string {}
            statName string {}
            statType int64 {0}
            index int64 {0}
            indexLast int64 {0}
            filters StatManager.StatFilterList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::AggregatedStatInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::AggregatedStatInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.AggregatedStatInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::PgidRange
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::PgidRange {
    component c_Struct -inherit true
    delegate method firstIndex to c_Struct using "%c _dcall %m"
    delegate method lastIndex to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            firstIndex int32 {-1}
            lastIndex int32 {-1}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::PgidRangeList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::PgidRangeList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.PgidRange]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::PortList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::PortList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::StreamInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::StreamInfo {
    component c_Struct -inherit true
    delegate method id to c_Struct using "%c _dcall %m"
    delegate method lineRate to c_Struct using "%c _dcall %m"
    delegate method txPort to c_Struct using "%c _dcall %m"
    delegate method rxPortList to c_Struct using "%c _dcall %m"
    delegate method pgidRangeList to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            id int32 {-1}
            lineRate double {0}
            txPort string {}
            rxPortList StatManager.PortList {}
            pgidRangeList StatManager.PgidRangeList {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::StreamInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::StreamInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.StreamInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::FlowInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::FlowInfo {
    component c_Struct -inherit true
    delegate method pgid to c_Struct using "%c _dcall %m"
    delegate method name to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            pgid int32 {-1}
            name string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::FlowInfoList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::FlowInfoList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.FlowInfo]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- StatManager::eViewChangeActionEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::eViewChangeActionEnum {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kAdd
    typevariable kRemove
    typevariable kEnable
    typevariable kDisable
    typevariable kUpdate
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kAdd]} {
            set kAdd [$type create %AUTO%];$kAdd Set kAdd
            set _tv [mytypevar kAdd]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRemove]} {
            set kRemove [$type create %AUTO%];$kRemove Set kRemove
            set _tv [mytypevar kRemove]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kEnable]} {
            set kEnable [$type create %AUTO%];$kEnable Set kEnable
            set _tv [mytypevar kEnable]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDisable]} {
            set kDisable [$type create %AUTO%];$kDisable Set kDisable
            set _tv [mytypevar kDisable]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kUpdate]} {
            set kUpdate [$type create %AUTO%];$kUpdate Set kUpdate
            set _tv [mytypevar kUpdate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kAdd
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kAdd
      1 kRemove
      2 kEnable
      3 kDisable
      4 kUpdate
    }
    typevariable m_encoder -array {
      kAdd 0
      kRemove 1
      kEnable 2
      kDisable 3
      kUpdate 4
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- StatManager::ViewChange
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::ViewChange {
    component c_Struct -inherit true
    delegate method caption to c_Struct using "%c _dcall %m"
    delegate method action to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            caption string {}
            action int32 {0}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- StatManager::ViewChangeList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatManager::ViewChangeList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype StatManager.ViewChange]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::StatManager {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    # StatPathList
    # ResolvedStat
    # ResolvedStatList
    # ValueList
    # StatFilter
    # StatFilterList
    # AggregatedStat
    # AggregatedStatList
    # AggregatedStatInfo
    # AggregatedStatInfoList
    # PgidRange
    # PgidRangeList
    # PortList
    # StreamInfo
    # StreamInfoList
    # FlowInfo
    # FlowInfoList
    # eViewChangeActionEnum
    # ViewChange
    # ViewChangeList
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
    typevariable _SIG_ElapsedTime {
        {name elapsedTime type int64 direction out}
    }
    method ElapsedTime {
        args
    } {
        $self _mCall $self $_SIG_ElapsedTime ElapsedTime args
    }
    typevariable _SIG_CommitCatalog {
    }
    method CommitCatalog {
        args
    } {
        $self _mCall $self $_SIG_CommitCatalog CommitCatalog args
    }
    typevariable _SIG_RegisterStatEnginePaths {
        {name resolvedStatList type StatManager.ResolvedStatList direction in}
    }
    method RegisterStatEnginePaths {
        args
    } {
        $self _mCall $self $_SIG_RegisterStatEnginePaths RegisterStatEnginePaths args
    }
    typevariable _SIG_GetRegisteredStatEnginePaths {
        {name resolvedStatList type StatManager.ResolvedStatList direction out}
    }
    method GetRegisteredStatEnginePaths {
        args
    } {
        $self _mCall $self $_SIG_GetRegisteredStatEnginePaths GetRegisteredStatEnginePaths args
    }
    typevariable _SIG_GetAggregatedStatList {
        {name aggregatedStatList type StatManager.AggregatedStatList direction out}
    }
    method GetAggregatedStatList {
        args
    } {
        $self _mCall $self $_SIG_GetAggregatedStatList GetAggregatedStatList args
    }
    typevariable _SIG_GetAggregatedStatInfoList {
        {name aggregatedStatInfoList type StatManager.AggregatedStatInfoList direction out}
    }
    method GetAggregatedStatInfoList {
        args
    } {
        $self _mCall $self $_SIG_GetAggregatedStatInfoList GetAggregatedStatInfoList args
    }
    typevariable _SIG_SetStreamFlowInfo {
        {name publisher type string direction in}
        {name streamTable type StatManager.StreamInfoList direction in}
        {name flowTable type StatManager.FlowInfoList direction in}
    }
    method SetStreamFlowInfo {
        args
    } {
        $self _mCall $self $_SIG_SetStreamFlowInfo SetStreamFlowInfo args
    }
    typevariable _SIG_RegisterStatPublisher {
        {name name type string direction in}
    }
    method RegisterStatPublisher {
        args
    } {
        $self _mCall $self $_SIG_RegisterStatPublisher RegisterStatPublisher args
    }
    typevariable _SIG_DeregisterStatPublisher {
        {name name type string direction in}
    }
    method DeregisterStatPublisher {
        args
    } {
        $self _mCall $self $_SIG_DeregisterStatPublisher DeregisterStatPublisher args
    }
    typevariable _SIG_UpdateStatCatalog {
        {name eventId type int32 direction in}
        {name publisher type string direction in}
        {name success type bool direction in}
    }
    method UpdateStatCatalog {
        args
    } {
        $self _mCall $self $_SIG_UpdateStatCatalog UpdateStatCatalog args
    }
    typevariable _SIG_ResolveAggregatedStat {
        {name eventId type int32 direction in}
        {name publisher type string direction in}
        {name resolvedStat type StatManager.ResolvedStat direction in}
    }
    method ResolveAggregatedStat {
        args
    } {
        $self _mCall $self $_SIG_ResolveAggregatedStat ResolveAggregatedStat args
    }
    typevariable _SIG_ConfigBuildInPublisher {
        {name name type string direction in}
        {name enable type bool direction in}
    }
    method ConfigBuildInPublisher {
        args
    } {
        $self _mCall $self $_SIG_ConfigBuildInPublisher ConfigBuildInPublisher args
    }
    typevariable _SIG_CommitViewChange {
        {name changeList type StatManager.ViewChangeList direction in}
    }
    method CommitViewChange {
        args
    } {
        $self _mCall $self $_SIG_CommitViewChange CommitViewChange args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_CatalogUpdateEvent {
        {name i_id type int32 direction out}
        {name i_publisher type string direction out}
    }
    method Request_CatalogUpdateEvent {args} {
        set args [concat -event CatalogUpdateEvent $args]
        $self _eEvent request $self $_SIG_CatalogUpdateEvent args
    }
    method Cancel_CatalogUpdateEvent {requestid args} {
        set args [concat -requestid $requestid -event CatalogUpdateEvent $args]
        $self _eEvent cancellation $self $_SIG_CatalogUpdateEvent args
    }
    typevariable _SIG_PathResolutionEvent {
        {name i_id type int32 direction out}
        {name i_publisher type string direction out}
        {name i_aggregatedStat type StatManager.AggregatedStatInfo direction out}
    }
    method Request_PathResolutionEvent {args} {
        set args [concat -event PathResolutionEvent $args]
        $self _eEvent request $self $_SIG_PathResolutionEvent args
    }
    method Cancel_PathResolutionEvent {requestid args} {
        set args [concat -requestid $requestid -event PathResolutionEvent $args]
        $self _eEvent cancellation $self $_SIG_PathResolutionEvent args
    }
    typevariable _SIG_LogStatsEvent {
        {name i_name type string direction out}
        {name i_statSetList type StatConsumer.StatSetList direction out}
    }
    method Request_LogStatsEvent {args} {
        set args [concat -event LogStatsEvent $args]
        $self _eEvent request $self $_SIG_LogStatsEvent args
    }
    method Cancel_LogStatsEvent {requestid args} {
        set args [concat -requestid $requestid -event LogStatsEvent $args]
        $self _eEvent cancellation $self $_SIG_LogStatsEvent args
    }
    typevariable _SIG_ClearStatsEvent {
        {name i_name type string direction out}
    }
    method Request_ClearStatsEvent {args} {
        set args [concat -event ClearStatsEvent $args]
        $self _eEvent request $self $_SIG_ClearStatsEvent args
    }
    method Cancel_ClearStatsEvent {requestid args} {
        set args [concat -requestid $requestid -event ClearStatsEvent $args]
        $self _eEvent cancellation $self $_SIG_ClearStatsEvent args
    }
    typevariable _SIG_CatalogChangeEvent {
        {name i_id type int32 direction out}
    }
    method Request_CatalogChangeEvent {args} {
        set args [concat -event CatalogChangeEvent $args]
        $self _eEvent request $self $_SIG_CatalogChangeEvent args
    }
    method Cancel_CatalogChangeEvent {requestid args} {
        set args [concat -requestid $requestid -event CatalogChangeEvent $args]
        $self _eEvent cancellation $self $_SIG_CatalogChangeEvent args
    }
    typevariable _SIG_ViewChangeEvent {
        {name i_id type int32 direction out}
        {name i_changeList type StatManager.ViewChangeList direction out}
    }
    method Request_ViewChangeEvent {args} {
        set args [concat -event ViewChangeEvent $args]
        $self _eEvent request $self $_SIG_ViewChangeEvent args
    }
    method Cancel_ViewChangeEvent {requestid args} {
        set args [concat -requestid $requestid -event ViewChangeEvent $args]
        $self _eEvent cancellation $self $_SIG_ViewChangeEvent args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        statCatalog PropertyNodeList
        statViewer PropertyNode
        dbLogging PropertyBoolean
        statWatchList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # statCatalog (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statCatalog -public statCatalog
    method _ctor_statCatalog {args} {
        set statCatalog [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatCatalogItem \
            -parent $self \
            -name statCatalog \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statCatalog {args} {catch {$statCatalog destroy}}
    #----------------------------------------------------------------------
    # statViewer (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component statViewer -public statViewer
    method _ctor_statViewer {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype StatViewer]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType statViewer]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set statViewer [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name statViewer \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_statViewer {args} {catch {$statViewer destroy}}
    #----------------------------------------------------------------------
    # dbLogging (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method dbLogging {args} {$self _mProp $self dbLogging $_propertyTypes(dbLogging) $args}
    method _ctor_dbLogging {args} {}
    method _dtor_dbLogging {args} {}
    #----------------------------------------------------------------------
    # statWatchList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statWatchList -public statWatchList
    method _ctor_statWatchList {args} {
        set statWatchList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatWatch \
            -parent $self \
            -name statWatchList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statWatchList {args} {catch {$statWatchList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatSpec.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- StatSpec::eAggregationTypeEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatSpec::eAggregationTypeEnum {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kSum
    typevariable kMax
    typevariable kMin
    typevariable kAverage
    typevariable kWeightedAverage
    typevariable kRate
    typevariable kMaxRate
    typevariable kMinRate
    typevariable kAverageRate
    typevariable kNone
    typevariable kRunStateAgg
    typevariable kRunStateAggIgnoreRamp
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kSum]} {
            set kSum [$type create %AUTO%];$kSum Set kSum
            set _tv [mytypevar kSum]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMax]} {
            set kMax [$type create %AUTO%];$kMax Set kMax
            set _tv [mytypevar kMax]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMin]} {
            set kMin [$type create %AUTO%];$kMin Set kMin
            set _tv [mytypevar kMin]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kAverage]} {
            set kAverage [$type create %AUTO%];$kAverage Set kAverage
            set _tv [mytypevar kAverage]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kWeightedAverage]} {
            set kWeightedAverage [$type create %AUTO%];$kWeightedAverage Set kWeightedAverage
            set _tv [mytypevar kWeightedAverage]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRate]} {
            set kRate [$type create %AUTO%];$kRate Set kRate
            set _tv [mytypevar kRate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMaxRate]} {
            set kMaxRate [$type create %AUTO%];$kMaxRate Set kMaxRate
            set _tv [mytypevar kMaxRate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMinRate]} {
            set kMinRate [$type create %AUTO%];$kMinRate Set kMinRate
            set _tv [mytypevar kMinRate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kAverageRate]} {
            set kAverageRate [$type create %AUTO%];$kAverageRate Set kAverageRate
            set _tv [mytypevar kAverageRate]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kNone]} {
            set kNone [$type create %AUTO%];$kNone Set kNone
            set _tv [mytypevar kNone]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRunStateAgg]} {
            set kRunStateAgg [$type create %AUTO%];$kRunStateAgg Set kRunStateAgg
            set _tv [mytypevar kRunStateAgg]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kRunStateAggIgnoreRamp]} {
            set kRunStateAggIgnoreRamp [$type create %AUTO%];$kRunStateAggIgnoreRamp Set kRunStateAggIgnoreRamp
            set _tv [mytypevar kRunStateAggIgnoreRamp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kSum
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kSum
      1 kMax
      2 kMin
      3 kAverage
      4 kWeightedAverage
      5 kRate
      6 kMaxRate
      7 kMinRate
      8 kAverageRate
      9 kNone
      10 kRunStateAgg
      11 kRunStateAggIgnoreRamp
    }
    typevariable m_encoder -array {
      kSum 0
      kMax 1
      kMin 2
      kAverage 3
      kWeightedAverage 4
      kRate 5
      kMaxRate 6
      kMinRate 7
      kAverageRate 8
      kNone 9
      kRunStateAgg 10
      kRunStateAggIgnoreRamp 11
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- StatSpec::eStatTypeEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatSpec::eStatTypeEnum {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kDefault
    typevariable kArray
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kDefault]} {
            set kDefault [$type create %AUTO%];$kDefault Set kDefault
            set _tv [mytypevar kDefault]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kArray]} {
            set kArray [$type create %AUTO%];$kArray Set kArray
            set _tv [mytypevar kArray]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kDefault
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kDefault
      1 kArray
    }
    typevariable m_encoder -array {
      kDefault 0
      kArray 1
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
snit::type ::AptixiaClient::StatSpec {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    # eAggregationTypeEnum
    # eStatTypeEnum
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
        removed PropertyBoolean
        caption PropertyString
        statSourceType PropertyString
        statName PropertyString
        aggregationType PropertyInt
        enumerated PropertyBoolean
        interpolated PropertyBoolean
        index PropertyInt
        indexLast PropertyInt
        statType PropertyInt
        yAxisRange PropertyString
        csvStatLabel PropertyString
        csvFunctionLabel PropertyString
    }
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # removed (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method removed {args} {$self _mProp $self removed $_propertyTypes(removed) $args}
    method _ctor_removed {args} {}
    method _dtor_removed {args} {}
    #----------------------------------------------------------------------
    # caption (PropertyString)
    # 
    #----------------------------------------------------------------------
    method caption {args} {$self _mProp $self caption $_propertyTypes(caption) $args}
    method _ctor_caption {args} {}
    method _dtor_caption {args} {}
    #----------------------------------------------------------------------
    # statSourceType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method statSourceType {args} {$self _mProp $self statSourceType $_propertyTypes(statSourceType) $args}
    method _ctor_statSourceType {args} {}
    method _dtor_statSourceType {args} {}
    #----------------------------------------------------------------------
    # statName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method statName {args} {$self _mProp $self statName $_propertyTypes(statName) $args}
    method _ctor_statName {args} {}
    method _dtor_statName {args} {}
    #----------------------------------------------------------------------
    # aggregationType (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method aggregationType {args} {$self _mProp $self aggregationType $_propertyTypes(aggregationType) $args}
    method _ctor_aggregationType {args} {}
    method _dtor_aggregationType {args} {}
    #----------------------------------------------------------------------
    # enumerated (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enumerated {args} {$self _mProp $self enumerated $_propertyTypes(enumerated) $args}
    method _ctor_enumerated {args} {}
    method _dtor_enumerated {args} {}
    #----------------------------------------------------------------------
    # interpolated (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method interpolated {args} {$self _mProp $self interpolated $_propertyTypes(interpolated) $args}
    method _ctor_interpolated {args} {}
    method _dtor_interpolated {args} {}
    #----------------------------------------------------------------------
    # index (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method index {args} {$self _mProp $self index $_propertyTypes(index) $args}
    method _ctor_index {args} {}
    method _dtor_index {args} {}
    #----------------------------------------------------------------------
    # indexLast (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method indexLast {args} {$self _mProp $self indexLast $_propertyTypes(indexLast) $args}
    method _ctor_indexLast {args} {}
    method _dtor_indexLast {args} {}
    #----------------------------------------------------------------------
    # statType (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method statType {args} {$self _mProp $self statType $_propertyTypes(statType) $args}
    method _ctor_statType {args} {}
    method _dtor_statType {args} {}
    #----------------------------------------------------------------------
    # yAxisRange (PropertyString)
    # 
    #----------------------------------------------------------------------
    method yAxisRange {args} {$self _mProp $self yAxisRange $_propertyTypes(yAxisRange) $args}
    method _ctor_yAxisRange {args} {}
    method _dtor_yAxisRange {args} {}
    #----------------------------------------------------------------------
    # csvStatLabel (PropertyString)
    # 
    #----------------------------------------------------------------------
    method csvStatLabel {args} {$self _mProp $self csvStatLabel $_propertyTypes(csvStatLabel) $args}
    method _ctor_csvStatLabel {args} {}
    method _dtor_csvStatLabel {args} {}
    #----------------------------------------------------------------------
    # csvFunctionLabel (PropertyString)
    # 
    #----------------------------------------------------------------------
    method csvFunctionLabel {args} {$self _mProp $self csvFunctionLabel $_propertyTypes(csvFunctionLabel) $args}
    method _ctor_csvFunctionLabel {args} {}
    method _dtor_csvFunctionLabel {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatView.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatView {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    typevariable _SIG_MaxViewTime {
        {name time type int64 direction out}
    }
    method MaxViewTime {
        args
    } {
        $self _mCall $self $_SIG_MaxViewTime MaxViewTime args
    }
    typevariable _SIG_Commit {
    }
    method Commit {
        args
    } {
        $self _mCall $self $_SIG_Commit Commit args
    }
    typevariable _SIG_SaveAsTemplate {
        {name name type string direction in}
    }
    method SaveAsTemplate {
        args
    } {
        $self _mCall $self $_SIG_SaveAsTemplate SaveAsTemplate args
    }
    typevariable _SIG_GetStatSourceTypes {
        {name statSourceTypes type string direction out}
    }
    method GetStatSourceTypes {
        args
    } {
        $self _mCall $self $_SIG_GetStatSourceTypes GetStatSourceTypes args
    }
    typevariable _SIG_GetResultStartTime {
        {name time type int64 direction out}
    }
    method GetResultStartTime {
        args
    } {
        $self _mCall $self $_SIG_GetResultStartTime GetResultStartTime args
    }
    typevariable _SIG_ExportCsv {
        {name fileName type string direction in}
    }
    method ExportCsv {
        args
    } {
        $self _mCall $self $_SIG_ExportCsv ExportCsv args
    }
    typevariable _SIG_GetStats {
        {name statSetList type StatConsumer.StatSetList direction out}
        {name beginTimestamp type int64 direction in}
        {name endTimestamp type int64 direction in}
    }
    method GetStats {
        args
    } {
        $self _mCall $self $_SIG_GetStats GetStats args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        caption PropertyString
        enabled PropertyBoolean
        useCaption PropertyBoolean
        autoColumnWidth PropertyBoolean
        windowPosition PropertyString
        allowUserEdit PropertyBoolean
        frequency PropertyDouble
        timeSamples PropertyInt
        viewType PropertyString
        showGridLines PropertyBoolean
        grayScale PropertyBoolean
        xAxis PropertyNode
        yAxis PropertyNode
        legendEnabled PropertyBoolean
        dataLegendEnabled PropertyBoolean
        legendPosition PropertyString
        legendSpanPercentage PropertyInt
        backgroundColor PropertyString
        fontColor PropertyString
        title PropertyBoolean
        statFilterGroupList PropertyNodeList
        statSpecList PropertyNodeList
        swapRowsColumns PropertyBoolean
        matrixConfiguration PropertyBoolean
        publisherLabels PropertyBoolean
        threeD PropertyBoolean
        threeDRotate PropertyBoolean
        threeDRotateX PropertyInt
        threeDRotateY PropertyInt
        statAttributeListList PropertyNodeList
        lineStyle PropertyString
        csvHeaderFieldList PropertyNodeList
        csvRequestOptions PropertyNode
        visible PropertyBoolean
        sampleDataRequired PropertyBoolean
    }
    #----------------------------------------------------------------------
    # caption (PropertyString)
    # 
    #----------------------------------------------------------------------
    method caption {args} {$self _mProp $self caption $_propertyTypes(caption) $args}
    method _ctor_caption {args} {}
    method _dtor_caption {args} {}
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # useCaption (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method useCaption {args} {$self _mProp $self useCaption $_propertyTypes(useCaption) $args}
    method _ctor_useCaption {args} {}
    method _dtor_useCaption {args} {}
    #----------------------------------------------------------------------
    # autoColumnWidth (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method autoColumnWidth {args} {$self _mProp $self autoColumnWidth $_propertyTypes(autoColumnWidth) $args}
    method _ctor_autoColumnWidth {args} {}
    method _dtor_autoColumnWidth {args} {}
    #----------------------------------------------------------------------
    # windowPosition (PropertyString)
    # 
    #----------------------------------------------------------------------
    method windowPosition {args} {$self _mProp $self windowPosition $_propertyTypes(windowPosition) $args}
    method _ctor_windowPosition {args} {}
    method _dtor_windowPosition {args} {}
    #----------------------------------------------------------------------
    # allowUserEdit (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method allowUserEdit {args} {$self _mProp $self allowUserEdit $_propertyTypes(allowUserEdit) $args}
    method _ctor_allowUserEdit {args} {}
    method _dtor_allowUserEdit {args} {}
    #----------------------------------------------------------------------
    # frequency (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method frequency {args} {$self _mProp $self frequency $_propertyTypes(frequency) $args}
    method _ctor_frequency {args} {}
    method _dtor_frequency {args} {}
    #----------------------------------------------------------------------
    # timeSamples (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method timeSamples {args} {$self _mProp $self timeSamples $_propertyTypes(timeSamples) $args}
    method _ctor_timeSamples {args} {}
    method _dtor_timeSamples {args} {}
    #----------------------------------------------------------------------
    # viewType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method viewType {args} {$self _mProp $self viewType $_propertyTypes(viewType) $args}
    method _ctor_viewType {args} {}
    method _dtor_viewType {args} {}
    #----------------------------------------------------------------------
    # showGridLines (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method showGridLines {args} {$self _mProp $self showGridLines $_propertyTypes(showGridLines) $args}
    method _ctor_showGridLines {args} {}
    method _dtor_showGridLines {args} {}
    #----------------------------------------------------------------------
    # grayScale (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method grayScale {args} {$self _mProp $self grayScale $_propertyTypes(grayScale) $args}
    method _ctor_grayScale {args} {}
    method _dtor_grayScale {args} {}
    #----------------------------------------------------------------------
    # xAxis (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component xAxis -public xAxis
    method _ctor_xAxis {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype ChartXAxis]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType xAxis]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set xAxis [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name xAxis \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_xAxis {args} {catch {$xAxis destroy}}
    #----------------------------------------------------------------------
    # yAxis (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component yAxis -public yAxis
    method _ctor_yAxis {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype ChartYAxis]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType yAxis]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set yAxis [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name yAxis \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_yAxis {args} {catch {$yAxis destroy}}
    #----------------------------------------------------------------------
    # legendEnabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method legendEnabled {args} {$self _mProp $self legendEnabled $_propertyTypes(legendEnabled) $args}
    method _ctor_legendEnabled {args} {}
    method _dtor_legendEnabled {args} {}
    #----------------------------------------------------------------------
    # dataLegendEnabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method dataLegendEnabled {args} {$self _mProp $self dataLegendEnabled $_propertyTypes(dataLegendEnabled) $args}
    method _ctor_dataLegendEnabled {args} {}
    method _dtor_dataLegendEnabled {args} {}
    #----------------------------------------------------------------------
    # legendPosition (PropertyString)
    # 
    #----------------------------------------------------------------------
    method legendPosition {args} {$self _mProp $self legendPosition $_propertyTypes(legendPosition) $args}
    method _ctor_legendPosition {args} {}
    method _dtor_legendPosition {args} {}
    #----------------------------------------------------------------------
    # legendSpanPercentage (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method legendSpanPercentage {args} {$self _mProp $self legendSpanPercentage $_propertyTypes(legendSpanPercentage) $args}
    method _ctor_legendSpanPercentage {args} {}
    method _dtor_legendSpanPercentage {args} {}
    #----------------------------------------------------------------------
    # backgroundColor (PropertyString)
    # 
    #----------------------------------------------------------------------
    method backgroundColor {args} {$self _mProp $self backgroundColor $_propertyTypes(backgroundColor) $args}
    method _ctor_backgroundColor {args} {}
    method _dtor_backgroundColor {args} {}
    #----------------------------------------------------------------------
    # fontColor (PropertyString)
    # 
    #----------------------------------------------------------------------
    method fontColor {args} {$self _mProp $self fontColor $_propertyTypes(fontColor) $args}
    method _ctor_fontColor {args} {}
    method _dtor_fontColor {args} {}
    #----------------------------------------------------------------------
    # title (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method title {args} {$self _mProp $self title $_propertyTypes(title) $args}
    method _ctor_title {args} {}
    method _dtor_title {args} {}
    #----------------------------------------------------------------------
    # statFilterGroupList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statFilterGroupList -public statFilterGroupList
    method _ctor_statFilterGroupList {args} {
        set statFilterGroupList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatFilterGroup \
            -parent $self \
            -name statFilterGroupList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statFilterGroupList {args} {catch {$statFilterGroupList destroy}}
    #----------------------------------------------------------------------
    # statSpecList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statSpecList -public statSpecList
    method _ctor_statSpecList {args} {
        set statSpecList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatSpec \
            -parent $self \
            -name statSpecList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statSpecList {args} {catch {$statSpecList destroy}}
    #----------------------------------------------------------------------
    # swapRowsColumns (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method swapRowsColumns {args} {$self _mProp $self swapRowsColumns $_propertyTypes(swapRowsColumns) $args}
    method _ctor_swapRowsColumns {args} {}
    method _dtor_swapRowsColumns {args} {}
    #----------------------------------------------------------------------
    # matrixConfiguration (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method matrixConfiguration {args} {$self _mProp $self matrixConfiguration $_propertyTypes(matrixConfiguration) $args}
    method _ctor_matrixConfiguration {args} {}
    method _dtor_matrixConfiguration {args} {}
    #----------------------------------------------------------------------
    # publisherLabels (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method publisherLabels {args} {$self _mProp $self publisherLabels $_propertyTypes(publisherLabels) $args}
    method _ctor_publisherLabels {args} {}
    method _dtor_publisherLabels {args} {}
    #----------------------------------------------------------------------
    # threeD (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method threeD {args} {$self _mProp $self threeD $_propertyTypes(threeD) $args}
    method _ctor_threeD {args} {}
    method _dtor_threeD {args} {}
    #----------------------------------------------------------------------
    # threeDRotate (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method threeDRotate {args} {$self _mProp $self threeDRotate $_propertyTypes(threeDRotate) $args}
    method _ctor_threeDRotate {args} {}
    method _dtor_threeDRotate {args} {}
    #----------------------------------------------------------------------
    # threeDRotateX (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method threeDRotateX {args} {$self _mProp $self threeDRotateX $_propertyTypes(threeDRotateX) $args}
    method _ctor_threeDRotateX {args} {}
    method _dtor_threeDRotateX {args} {}
    #----------------------------------------------------------------------
    # threeDRotateY (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method threeDRotateY {args} {$self _mProp $self threeDRotateY $_propertyTypes(threeDRotateY) $args}
    method _ctor_threeDRotateY {args} {}
    method _dtor_threeDRotateY {args} {}
    #----------------------------------------------------------------------
    # statAttributeListList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statAttributeListList -public statAttributeListList
    method _ctor_statAttributeListList {args} {
        set statAttributeListList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatAttributeList \
            -parent $self \
            -name statAttributeListList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statAttributeListList {args} {catch {$statAttributeListList destroy}}
    #----------------------------------------------------------------------
    # lineStyle (PropertyString)
    # 
    #----------------------------------------------------------------------
    method lineStyle {args} {$self _mProp $self lineStyle $_propertyTypes(lineStyle) $args}
    method _ctor_lineStyle {args} {}
    method _dtor_lineStyle {args} {}
    #----------------------------------------------------------------------
    # csvHeaderFieldList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component csvHeaderFieldList -public csvHeaderFieldList
    method _ctor_csvHeaderFieldList {args} {
        set csvHeaderFieldList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype CsvHeaderField \
            -parent $self \
            -name csvHeaderFieldList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_csvHeaderFieldList {args} {catch {$csvHeaderFieldList destroy}}
    #----------------------------------------------------------------------
    # csvRequestOptions (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component csvRequestOptions -public csvRequestOptions
    method _ctor_csvRequestOptions {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype CsvRequestOptions]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType csvRequestOptions]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set csvRequestOptions [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name csvRequestOptions \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_csvRequestOptions {args} {catch {$csvRequestOptions destroy}}
    #----------------------------------------------------------------------
    # visible (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method visible {args} {$self _mProp $self visible $_propertyTypes(visible) $args}
    method _ctor_visible {args} {}
    method _dtor_visible {args} {}
    #----------------------------------------------------------------------
    # sampleDataRequired (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method sampleDataRequired {args} {$self _mProp $self sampleDataRequired $_propertyTypes(sampleDataRequired) $args}
    method _ctor_sampleDataRequired {args} {}
    method _dtor_sampleDataRequired {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatViewer.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- StatViewer::eMode
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatViewer::eMode {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kModeDesign
    typevariable kModeRun
    typevariable kModeResult
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kModeDesign]} {
            set kModeDesign [$type create %AUTO%];$kModeDesign Set kModeDesign
            set _tv [mytypevar kModeDesign]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kModeRun]} {
            set kModeRun [$type create %AUTO%];$kModeRun Set kModeRun
            set _tv [mytypevar kModeRun]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kModeResult]} {
            set kModeResult [$type create %AUTO%];$kModeResult Set kModeResult
            set _tv [mytypevar kModeResult]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kModeDesign
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kModeDesign
      1 kModeRun
      2 kModeResult
    }
    typevariable m_encoder -array {
      kModeDesign 0
      kModeRun 1
      kModeResult 2
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- StatViewer::eNotify
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatViewer::eNotify {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kViewDataChanged
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kViewDataChanged]} {
            set kViewDataChanged [$type create %AUTO%];$kViewDataChanged Set kViewDataChanged
            set _tv [mytypevar kViewDataChanged]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kViewDataChanged
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kViewDataChanged
    }
    typevariable m_encoder -array {
      kViewDataChanged 0
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- StatViewer::eWindowState
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatViewer::eWindowState {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kNormal
    typevariable kMaximized
    typevariable kMinimized
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kNormal]} {
            set kNormal [$type create %AUTO%];$kNormal Set kNormal
            set _tv [mytypevar kNormal]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMaximized]} {
            set kMaximized [$type create %AUTO%];$kMaximized Set kMaximized
            set _tv [mytypevar kMaximized]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kMinimized]} {
            set kMinimized [$type create %AUTO%];$kMinimized Set kMinimized
            set _tv [mytypevar kMinimized]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kNormal
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kNormal
      1 kMaximized
      2 kMinimized
    }
    typevariable m_encoder -array {
      kNormal 0
      kMaximized 1
      kMinimized 2
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
snit::type ::AptixiaClient::StatViewer {
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
    component c_Base -public StatConsumer -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::StatConsumer %AUTO%}
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
    # eMode
    # eNotify
    # eWindowState
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
    typevariable _SIG_ViewExists {
        {name name type string direction in}
        {name exists type bool direction out}
    }
    method ViewExists {
        args
    } {
        $self _mCall $self $_SIG_ViewExists ViewExists args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        statViewList PropertyNodeList
        windowPositions PropertyString
    }
    #----------------------------------------------------------------------
    # statViewList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statViewList -public statViewList
    method _ctor_statViewList {args} {
        set statViewList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype StatView \
            -parent $self \
            -name statViewList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statViewList {args} {catch {$statViewList destroy}}
    #----------------------------------------------------------------------
    # windowPositions (PropertyString)
    # 
    #----------------------------------------------------------------------
    method windowPositions {args} {$self _mProp $self windowPositions $_propertyTypes(windowPositions) $args}
    method _ctor_windowPositions {args} {}
    method _dtor_windowPositions {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/StatWatch.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::StatWatch {
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
    component c_Base -public StatConsumer -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::StatConsumer %AUTO%}
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
        name PropertyString
        frequency PropertyDouble
        aggregatedStatList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # frequency (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method frequency {args} {$self _mProp $self frequency $_propertyTypes(frequency) $args}
    method _ctor_frequency {args} {}
    method _dtor_frequency {args} {}
    #----------------------------------------------------------------------
    # aggregatedStatList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component aggregatedStatList -public aggregatedStatList
    method _ctor_aggregatedStatList {args} {
        set aggregatedStatList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype AggregatedStat \
            -parent $self \
            -name aggregatedStatList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_aggregatedStatList {args} {catch {$aggregatedStatList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TCPPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TCPPlugin {
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
    component c_Base -public GlobalPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::GlobalPlugin %AUTO%}
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
        tcp_abort_on_overflow PropertyBoolean
        tcp_adv_win_scale PropertyInt
        tcp_app_win PropertyInt
        tcp_bic PropertyInt
        tcp_bic_fast_convergence PropertyInt
        tcp_bic_low_window PropertyInt
        tcp_dsack PropertyBoolean
        tcp_ecn PropertyBoolean
        tcp_fack PropertyBoolean
        tcp_fin_timeout PropertyInt
        tcp_frto PropertyInt
        tcp_keepalive_intvl PropertyInt
        tcp_keepalive_probes PropertyInt
        tcp_keepalive_time PropertyInt
        tcp_low_latency PropertyInt
        tcp_max_orphans PropertyInt
        tcp_max_syn_backlog PropertyInt
        tcp_max_tw_buckets PropertyInt
        tcp_mem_low PropertyInt
        tcp_mem_pressure PropertyInt
        tcp_mem_high PropertyInt
        tcp_moderate_rcvbuf PropertyInt
        tcp_no_metrics_save PropertyBoolean
        tcp_orphan_retries PropertyInt
        tcp_reordering PropertyInt
        tcp_retrans_collapse PropertyBoolean
        tcp_retries1 PropertyInt
        tcp_retries2 PropertyInt
        tcp_rfc1337 PropertyBoolean
        tcp_rmem_min PropertyInt
        tcp_rmem_default PropertyInt
        tcp_rmem_max PropertyInt
        tcp_sack PropertyBoolean
        tcp_stdurg PropertyBoolean
        tcp_synack_retries PropertyInt
        tcp_syn_retries PropertyInt
        tcp_timestamps PropertyBoolean
        tcp_tw_recycle PropertyBoolean
        tcp_tw_reuse PropertyBoolean
        tcp_vegas_alpha PropertyInt
        tcp_vegas_beta PropertyInt
        tcp_vegas_cong_avoid PropertyInt
        tcp_vegas_gamma PropertyInt
        tcp_westwood PropertyInt
        tcp_window_scaling PropertyBoolean
        tcp_wmem_min PropertyInt
        tcp_wmem_default PropertyInt
        tcp_wmem_max PropertyInt
        tcp_ipfrag_time PropertyInt
        tcp_port_min PropertyInt
        tcp_port_max PropertyInt
        rmem_max PropertyInt
        wmem_max PropertyInt
    }
    #----------------------------------------------------------------------
    # tcp_abort_on_overflow (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_abort_on_overflow {args} {$self _mProp $self tcp_abort_on_overflow $_propertyTypes(tcp_abort_on_overflow) $args}
    method _ctor_tcp_abort_on_overflow {args} {}
    method _dtor_tcp_abort_on_overflow {args} {}
    #----------------------------------------------------------------------
    # tcp_adv_win_scale (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_adv_win_scale {args} {$self _mProp $self tcp_adv_win_scale $_propertyTypes(tcp_adv_win_scale) $args}
    method _ctor_tcp_adv_win_scale {args} {}
    method _dtor_tcp_adv_win_scale {args} {}
    #----------------------------------------------------------------------
    # tcp_app_win (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_app_win {args} {$self _mProp $self tcp_app_win $_propertyTypes(tcp_app_win) $args}
    method _ctor_tcp_app_win {args} {}
    method _dtor_tcp_app_win {args} {}
    #----------------------------------------------------------------------
    # tcp_bic (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_bic {args} {$self _mProp $self tcp_bic $_propertyTypes(tcp_bic) $args}
    method _ctor_tcp_bic {args} {}
    method _dtor_tcp_bic {args} {}
    #----------------------------------------------------------------------
    # tcp_bic_fast_convergence (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_bic_fast_convergence {args} {$self _mProp $self tcp_bic_fast_convergence $_propertyTypes(tcp_bic_fast_convergence) $args}
    method _ctor_tcp_bic_fast_convergence {args} {}
    method _dtor_tcp_bic_fast_convergence {args} {}
    #----------------------------------------------------------------------
    # tcp_bic_low_window (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_bic_low_window {args} {$self _mProp $self tcp_bic_low_window $_propertyTypes(tcp_bic_low_window) $args}
    method _ctor_tcp_bic_low_window {args} {}
    method _dtor_tcp_bic_low_window {args} {}
    #----------------------------------------------------------------------
    # tcp_dsack (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_dsack {args} {$self _mProp $self tcp_dsack $_propertyTypes(tcp_dsack) $args}
    method _ctor_tcp_dsack {args} {}
    method _dtor_tcp_dsack {args} {}
    #----------------------------------------------------------------------
    # tcp_ecn (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_ecn {args} {$self _mProp $self tcp_ecn $_propertyTypes(tcp_ecn) $args}
    method _ctor_tcp_ecn {args} {}
    method _dtor_tcp_ecn {args} {}
    #----------------------------------------------------------------------
    # tcp_fack (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_fack {args} {$self _mProp $self tcp_fack $_propertyTypes(tcp_fack) $args}
    method _ctor_tcp_fack {args} {}
    method _dtor_tcp_fack {args} {}
    #----------------------------------------------------------------------
    # tcp_fin_timeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_fin_timeout {args} {$self _mProp $self tcp_fin_timeout $_propertyTypes(tcp_fin_timeout) $args}
    method _ctor_tcp_fin_timeout {args} {}
    method _dtor_tcp_fin_timeout {args} {}
    #----------------------------------------------------------------------
    # tcp_frto (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_frto {args} {$self _mProp $self tcp_frto $_propertyTypes(tcp_frto) $args}
    method _ctor_tcp_frto {args} {}
    method _dtor_tcp_frto {args} {}
    #----------------------------------------------------------------------
    # tcp_keepalive_intvl (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_keepalive_intvl {args} {$self _mProp $self tcp_keepalive_intvl $_propertyTypes(tcp_keepalive_intvl) $args}
    method _ctor_tcp_keepalive_intvl {args} {}
    method _dtor_tcp_keepalive_intvl {args} {}
    #----------------------------------------------------------------------
    # tcp_keepalive_probes (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_keepalive_probes {args} {$self _mProp $self tcp_keepalive_probes $_propertyTypes(tcp_keepalive_probes) $args}
    method _ctor_tcp_keepalive_probes {args} {}
    method _dtor_tcp_keepalive_probes {args} {}
    #----------------------------------------------------------------------
    # tcp_keepalive_time (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_keepalive_time {args} {$self _mProp $self tcp_keepalive_time $_propertyTypes(tcp_keepalive_time) $args}
    method _ctor_tcp_keepalive_time {args} {}
    method _dtor_tcp_keepalive_time {args} {}
    #----------------------------------------------------------------------
    # tcp_low_latency (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_low_latency {args} {$self _mProp $self tcp_low_latency $_propertyTypes(tcp_low_latency) $args}
    method _ctor_tcp_low_latency {args} {}
    method _dtor_tcp_low_latency {args} {}
    #----------------------------------------------------------------------
    # tcp_max_orphans (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_max_orphans {args} {$self _mProp $self tcp_max_orphans $_propertyTypes(tcp_max_orphans) $args}
    method _ctor_tcp_max_orphans {args} {}
    method _dtor_tcp_max_orphans {args} {}
    #----------------------------------------------------------------------
    # tcp_max_syn_backlog (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_max_syn_backlog {args} {$self _mProp $self tcp_max_syn_backlog $_propertyTypes(tcp_max_syn_backlog) $args}
    method _ctor_tcp_max_syn_backlog {args} {}
    method _dtor_tcp_max_syn_backlog {args} {}
    #----------------------------------------------------------------------
    # tcp_max_tw_buckets (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_max_tw_buckets {args} {$self _mProp $self tcp_max_tw_buckets $_propertyTypes(tcp_max_tw_buckets) $args}
    method _ctor_tcp_max_tw_buckets {args} {}
    method _dtor_tcp_max_tw_buckets {args} {}
    #----------------------------------------------------------------------
    # tcp_mem_low (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_mem_low {args} {$self _mProp $self tcp_mem_low $_propertyTypes(tcp_mem_low) $args}
    method _ctor_tcp_mem_low {args} {}
    method _dtor_tcp_mem_low {args} {}
    #----------------------------------------------------------------------
    # tcp_mem_pressure (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_mem_pressure {args} {$self _mProp $self tcp_mem_pressure $_propertyTypes(tcp_mem_pressure) $args}
    method _ctor_tcp_mem_pressure {args} {}
    method _dtor_tcp_mem_pressure {args} {}
    #----------------------------------------------------------------------
    # tcp_mem_high (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_mem_high {args} {$self _mProp $self tcp_mem_high $_propertyTypes(tcp_mem_high) $args}
    method _ctor_tcp_mem_high {args} {}
    method _dtor_tcp_mem_high {args} {}
    #----------------------------------------------------------------------
    # tcp_moderate_rcvbuf (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_moderate_rcvbuf {args} {$self _mProp $self tcp_moderate_rcvbuf $_propertyTypes(tcp_moderate_rcvbuf) $args}
    method _ctor_tcp_moderate_rcvbuf {args} {}
    method _dtor_tcp_moderate_rcvbuf {args} {}
    #----------------------------------------------------------------------
    # tcp_no_metrics_save (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_no_metrics_save {args} {$self _mProp $self tcp_no_metrics_save $_propertyTypes(tcp_no_metrics_save) $args}
    method _ctor_tcp_no_metrics_save {args} {}
    method _dtor_tcp_no_metrics_save {args} {}
    #----------------------------------------------------------------------
    # tcp_orphan_retries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_orphan_retries {args} {$self _mProp $self tcp_orphan_retries $_propertyTypes(tcp_orphan_retries) $args}
    method _ctor_tcp_orphan_retries {args} {}
    method _dtor_tcp_orphan_retries {args} {}
    #----------------------------------------------------------------------
    # tcp_reordering (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_reordering {args} {$self _mProp $self tcp_reordering $_propertyTypes(tcp_reordering) $args}
    method _ctor_tcp_reordering {args} {}
    method _dtor_tcp_reordering {args} {}
    #----------------------------------------------------------------------
    # tcp_retrans_collapse (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_retrans_collapse {args} {$self _mProp $self tcp_retrans_collapse $_propertyTypes(tcp_retrans_collapse) $args}
    method _ctor_tcp_retrans_collapse {args} {}
    method _dtor_tcp_retrans_collapse {args} {}
    #----------------------------------------------------------------------
    # tcp_retries1 (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_retries1 {args} {$self _mProp $self tcp_retries1 $_propertyTypes(tcp_retries1) $args}
    method _ctor_tcp_retries1 {args} {}
    method _dtor_tcp_retries1 {args} {}
    #----------------------------------------------------------------------
    # tcp_retries2 (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_retries2 {args} {$self _mProp $self tcp_retries2 $_propertyTypes(tcp_retries2) $args}
    method _ctor_tcp_retries2 {args} {}
    method _dtor_tcp_retries2 {args} {}
    #----------------------------------------------------------------------
    # tcp_rfc1337 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_rfc1337 {args} {$self _mProp $self tcp_rfc1337 $_propertyTypes(tcp_rfc1337) $args}
    method _ctor_tcp_rfc1337 {args} {}
    method _dtor_tcp_rfc1337 {args} {}
    #----------------------------------------------------------------------
    # tcp_rmem_min (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_rmem_min {args} {$self _mProp $self tcp_rmem_min $_propertyTypes(tcp_rmem_min) $args}
    method _ctor_tcp_rmem_min {args} {}
    method _dtor_tcp_rmem_min {args} {}
    #----------------------------------------------------------------------
    # tcp_rmem_default (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_rmem_default {args} {$self _mProp $self tcp_rmem_default $_propertyTypes(tcp_rmem_default) $args}
    method _ctor_tcp_rmem_default {args} {}
    method _dtor_tcp_rmem_default {args} {}
    #----------------------------------------------------------------------
    # tcp_rmem_max (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_rmem_max {args} {$self _mProp $self tcp_rmem_max $_propertyTypes(tcp_rmem_max) $args}
    method _ctor_tcp_rmem_max {args} {}
    method _dtor_tcp_rmem_max {args} {}
    #----------------------------------------------------------------------
    # tcp_sack (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_sack {args} {$self _mProp $self tcp_sack $_propertyTypes(tcp_sack) $args}
    method _ctor_tcp_sack {args} {}
    method _dtor_tcp_sack {args} {}
    #----------------------------------------------------------------------
    # tcp_stdurg (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_stdurg {args} {$self _mProp $self tcp_stdurg $_propertyTypes(tcp_stdurg) $args}
    method _ctor_tcp_stdurg {args} {}
    method _dtor_tcp_stdurg {args} {}
    #----------------------------------------------------------------------
    # tcp_synack_retries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_synack_retries {args} {$self _mProp $self tcp_synack_retries $_propertyTypes(tcp_synack_retries) $args}
    method _ctor_tcp_synack_retries {args} {}
    method _dtor_tcp_synack_retries {args} {}
    #----------------------------------------------------------------------
    # tcp_syn_retries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_syn_retries {args} {$self _mProp $self tcp_syn_retries $_propertyTypes(tcp_syn_retries) $args}
    method _ctor_tcp_syn_retries {args} {}
    method _dtor_tcp_syn_retries {args} {}
    #----------------------------------------------------------------------
    # tcp_timestamps (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_timestamps {args} {$self _mProp $self tcp_timestamps $_propertyTypes(tcp_timestamps) $args}
    method _ctor_tcp_timestamps {args} {}
    method _dtor_tcp_timestamps {args} {}
    #----------------------------------------------------------------------
    # tcp_tw_recycle (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_tw_recycle {args} {$self _mProp $self tcp_tw_recycle $_propertyTypes(tcp_tw_recycle) $args}
    method _ctor_tcp_tw_recycle {args} {}
    method _dtor_tcp_tw_recycle {args} {}
    #----------------------------------------------------------------------
    # tcp_tw_reuse (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_tw_reuse {args} {$self _mProp $self tcp_tw_reuse $_propertyTypes(tcp_tw_reuse) $args}
    method _ctor_tcp_tw_reuse {args} {}
    method _dtor_tcp_tw_reuse {args} {}
    #----------------------------------------------------------------------
    # tcp_vegas_alpha (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_vegas_alpha {args} {$self _mProp $self tcp_vegas_alpha $_propertyTypes(tcp_vegas_alpha) $args}
    method _ctor_tcp_vegas_alpha {args} {}
    method _dtor_tcp_vegas_alpha {args} {}
    #----------------------------------------------------------------------
    # tcp_vegas_beta (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_vegas_beta {args} {$self _mProp $self tcp_vegas_beta $_propertyTypes(tcp_vegas_beta) $args}
    method _ctor_tcp_vegas_beta {args} {}
    method _dtor_tcp_vegas_beta {args} {}
    #----------------------------------------------------------------------
    # tcp_vegas_cong_avoid (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_vegas_cong_avoid {args} {$self _mProp $self tcp_vegas_cong_avoid $_propertyTypes(tcp_vegas_cong_avoid) $args}
    method _ctor_tcp_vegas_cong_avoid {args} {}
    method _dtor_tcp_vegas_cong_avoid {args} {}
    #----------------------------------------------------------------------
    # tcp_vegas_gamma (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_vegas_gamma {args} {$self _mProp $self tcp_vegas_gamma $_propertyTypes(tcp_vegas_gamma) $args}
    method _ctor_tcp_vegas_gamma {args} {}
    method _dtor_tcp_vegas_gamma {args} {}
    #----------------------------------------------------------------------
    # tcp_westwood (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_westwood {args} {$self _mProp $self tcp_westwood $_propertyTypes(tcp_westwood) $args}
    method _ctor_tcp_westwood {args} {}
    method _dtor_tcp_westwood {args} {}
    #----------------------------------------------------------------------
    # tcp_window_scaling (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method tcp_window_scaling {args} {$self _mProp $self tcp_window_scaling $_propertyTypes(tcp_window_scaling) $args}
    method _ctor_tcp_window_scaling {args} {}
    method _dtor_tcp_window_scaling {args} {}
    #----------------------------------------------------------------------
    # tcp_wmem_min (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_wmem_min {args} {$self _mProp $self tcp_wmem_min $_propertyTypes(tcp_wmem_min) $args}
    method _ctor_tcp_wmem_min {args} {}
    method _dtor_tcp_wmem_min {args} {}
    #----------------------------------------------------------------------
    # tcp_wmem_default (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_wmem_default {args} {$self _mProp $self tcp_wmem_default $_propertyTypes(tcp_wmem_default) $args}
    method _ctor_tcp_wmem_default {args} {}
    method _dtor_tcp_wmem_default {args} {}
    #----------------------------------------------------------------------
    # tcp_wmem_max (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_wmem_max {args} {$self _mProp $self tcp_wmem_max $_propertyTypes(tcp_wmem_max) $args}
    method _ctor_tcp_wmem_max {args} {}
    method _dtor_tcp_wmem_max {args} {}
    #----------------------------------------------------------------------
    # tcp_ipfrag_time (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_ipfrag_time {args} {$self _mProp $self tcp_ipfrag_time $_propertyTypes(tcp_ipfrag_time) $args}
    method _ctor_tcp_ipfrag_time {args} {}
    method _dtor_tcp_ipfrag_time {args} {}
    #----------------------------------------------------------------------
    # tcp_port_min (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_port_min {args} {$self _mProp $self tcp_port_min $_propertyTypes(tcp_port_min) $args}
    method _ctor_tcp_port_min {args} {}
    method _dtor_tcp_port_min {args} {}
    #----------------------------------------------------------------------
    # tcp_port_max (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method tcp_port_max {args} {$self _mProp $self tcp_port_max $_propertyTypes(tcp_port_max) $args}
    method _ctor_tcp_port_max {args} {}
    method _dtor_tcp_port_max {args} {}
    #----------------------------------------------------------------------
    # rmem_max (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method rmem_max {args} {$self _mProp $self rmem_max $_propertyTypes(rmem_max) $args}
    method _ctor_rmem_max {args} {}
    method _dtor_rmem_max {args} {}
    #----------------------------------------------------------------------
    # wmem_max (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method wmem_max {args} {$self _mProp $self wmem_max $_propertyTypes(wmem_max) $args}
    method _ctor_wmem_max {args} {}
    method _dtor_wmem_max {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Test.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- Test::eMode
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Test::eMode {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kMonitor
    typevariable kTest
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kMonitor]} {
            set kMonitor [$type create %AUTO%];$kMonitor Set kMonitor
            set _tv [mytypevar kMonitor]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTest]} {
            set kTest [$type create %AUTO%];$kTest Set kTest
            set _tv [mytypevar kTest]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kMonitor
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kMonitor
      1 kTest
    }
    typevariable m_encoder -array {
      kMonitor 0
      kTest 1
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
snit::type ::AptixiaClient::Test {
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
    component c_Base -public TreeNode -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TreeNode %AUTO%}
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
    # eMode
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
    typevariable _SIG_Ping {
    }
    method Ping {
        args
    } {
        $self _mCall $self $_SIG_Ping Ping args
    }
    typevariable _SIG_Start {
    }
    method Start {
        args
    } {
        $self _mCall $self $_SIG_Start Start args
    }
    typevariable _SIG_Stop {
    }
    method Stop {
        args
    } {
        $self _mCall $self $_SIG_Stop Stop args
    }
    typevariable _SIG_Save {
        {name appXml type string direction in}
    }
    method Save {
        args
    } {
        $self _mCall $self $_SIG_Save Save args
    }
    typevariable _SIG_SaveAs {
        {name name type string direction in}
        {name appXml type string direction in}
        {name id type int32 direction out}
    }
    method SaveAs {
        args
    } {
        $self _mCall $self $_SIG_SaveAs SaveAs args
    }
    typevariable _SIG_Close {
    }
    method Close {
        args
    } {
        $self _mCall $self $_SIG_Close Close args
    }
    typevariable _SIG_GetAppXml {
        {name id type int32 direction in}
        {name appXml type string direction out}
    }
    method GetAppXml {
        args
    } {
        $self _mCall $self $_SIG_GetAppXml GetAppXml args
    }
    typevariable _SIG_GetReporterXmd {
        {name reporterXmd type string direction out}
    }
    method GetReporterXmd {
        args
    } {
        $self _mCall $self $_SIG_GetReporterXmd GetReporterXmd args
    }
    typevariable _SIG_SetReporterXmd {
        {name reporterXmd type string direction in}
    }
    method SetReporterXmd {
        args
    } {
        $self _mCall $self $_SIG_SetReporterXmd SetReporterXmd args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        mode PropertyInt
        statManager PropertyNode
        name PropertyString
        userName PropertyString
        resultsFolderPath PropertyString
    }
    #----------------------------------------------------------------------
    # mode (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method mode {args} {$self _mProp $self mode $_propertyTypes(mode) $args}
    method _ctor_mode {args} {}
    method _dtor_mode {args} {}
    #----------------------------------------------------------------------
    # statManager (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component statManager -public statManager
    method _ctor_statManager {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype StatManager]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType statManager]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set statManager [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name statManager \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_statManager {args} {catch {$statManager destroy}}
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # userName (PropertyString)
    # 
    #----------------------------------------------------------------------
    method userName {args} {$self _mProp $self userName $_propertyTypes(userName) $args}
    method _ctor_userName {args} {}
    method _dtor_userName {args} {}
    #----------------------------------------------------------------------
    # resultsFolderPath (PropertyString)
    # 
    #----------------------------------------------------------------------
    method resultsFolderPath {args} {$self _mProp $self resultsFolderPath $_propertyTypes(resultsFolderPath) $args}
    method _ctor_resultsFolderPath {args} {}
    method _dtor_resultsFolderPath {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TestServer.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TestServer {
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
    typevariable _SIG_GetClassMetaSchema {
        {name type type string direction in}
        {name metaschema type string direction out}
    }
    method GetClassMetaSchema {
        args
    } {
        $self _mCall $self $_SIG_GetClassMetaSchema GetClassMetaSchema args
    }
    typevariable _SIG_GetVersion {
        {name version type string direction out}
    }
    method GetVersion {
        args
    } {
        $self _mCall $self $_SIG_GetVersion GetVersion args
    }
    typevariable _SIG_Ping {
    }
    method Ping {
        args
    } {
        $self _mCall $self $_SIG_Ping Ping args
    }
    typevariable _SIG_OpenSession {
        {name userName type string direction in}
        {name sessionName type string direction in}
        {name inactivityTimeout type int32 direction in}
        {name session type Session direction out}
    }
    method OpenSession {
        args
    } {
        $self _mCall $self $_SIG_OpenSession OpenSession args
    }
    typevariable _SIG_OpenSession {
        {name appName type string direction in}
        {name userName type string direction in}
        {name sessionName type string direction in}
        {name inactivityTimeout type int32 direction in}
        {name session type Session direction out}
    }
    method OpenSession {
        args
    } {
        $self _mCall $self $_SIG_OpenSession OpenSession args
    }
    typevariable _SIG_Shutdown {
    }
    method Shutdown {
        args
    } {
        $self _mCall $self $_SIG_Shutdown Shutdown args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_InvalidateObjectEvent {
        {name i_objectId type int64 direction out}
    }
    method Request_InvalidateObjectEvent {args} {
        set args [concat -event InvalidateObjectEvent $args]
        $self _eEvent request $self $_SIG_InvalidateObjectEvent args
    }
    method Cancel_InvalidateObjectEvent {requestid args} {
        set args [concat -requestid $requestid -event InvalidateObjectEvent $args]
        $self _eEvent cancellation $self $_SIG_InvalidateObjectEvent args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TestServerPrivate.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TestServerPrivate {
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
    component c_Base -public TestServer -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::TestServer %AUTO%}
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
    typevariable _SIG_CreateTestObject {
        {name bootstrap type XPBootstrap direction out}
    }
    method CreateTestObject {
        args
    } {
        $self _mCall $self $_SIG_CreateTestObject CreateTestObject args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TestServerUnitTestNode.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TestServerUnitTestNode {
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
        stackElementPlugin PropertyNode
    }
    #----------------------------------------------------------------------
    # stackElementPlugin (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component stackElementPlugin -public stackElementPlugin
    method _ctor_stackElementPlugin {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype StackElementPlugin]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType stackElementPlugin]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set stackElementPlugin [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name stackElementPlugin \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_stackElementPlugin {args} {catch {$stackElementPlugin destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TreeNode.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TreeNode {
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
        expanded PropertyBoolean
    }
    #----------------------------------------------------------------------
    # expanded (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method expanded {args} {$self _mProp $self expanded $_propertyTypes(expanded) $args}
    method _ctor_expanded {args} {}
    method _dtor_expanded {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Vlan.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Vlan {
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
        id PropertyInt
        priority PropertyInt
        stepSize PropertyInt
        incrementBy PropertyInt
    }
    #----------------------------------------------------------------------
    # enabled (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enabled {args} {$self _mProp $self enabled $_propertyTypes(enabled) $args}
    method _ctor_enabled {args} {}
    method _dtor_enabled {args} {}
    #----------------------------------------------------------------------
    # id (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method id {args} {$self _mProp $self id $_propertyTypes(id) $args}
    method _ctor_id {args} {}
    method _dtor_id {args} {}
    #----------------------------------------------------------------------
    # priority (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method priority {args} {$self _mProp $self priority $_propertyTypes(priority) $args}
    method _ctor_priority {args} {}
    method _dtor_priority {args} {}
    #----------------------------------------------------------------------
    # stepSize (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method stepSize {args} {$self _mProp $self stepSize $_propertyTypes(stepSize) $args}
    method _ctor_stepSize {args} {}
    method _dtor_stepSize {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyInt)
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
# ..\..\data\metaschemas/VlanIdRange.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::VlanIdRange {
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
        name PropertyString
        enable PropertyBoolean
        firstId PropertyInt
        incrementStep PropertyInt
        increment PropertyInt
        uniqueCount PropertyInt
        priority PropertyInt
        innerEnable PropertyBoolean
        innerFirstId PropertyInt
        innerIncrementStep PropertyInt
        innerIncrement PropertyInt
        innerUniqueCount PropertyInt
        innerPriority PropertyInt
        idIncrMode PropertyInt
        etherType PropertyString
    }
    #----------------------------------------------------------------------
    # name (PropertyString)
    # 
    #----------------------------------------------------------------------
    method name {args} {$self _mProp $self name $_propertyTypes(name) $args}
    method _ctor_name {args} {}
    method _dtor_name {args} {}
    #----------------------------------------------------------------------
    # enable (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enable {args} {$self _mProp $self enable $_propertyTypes(enable) $args}
    method _ctor_enable {args} {}
    method _dtor_enable {args} {}
    #----------------------------------------------------------------------
    # firstId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method firstId {args} {$self _mProp $self firstId $_propertyTypes(firstId) $args}
    method _ctor_firstId {args} {}
    method _dtor_firstId {args} {}
    #----------------------------------------------------------------------
    # incrementStep (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method incrementStep {args} {$self _mProp $self incrementStep $_propertyTypes(incrementStep) $args}
    method _ctor_incrementStep {args} {}
    method _dtor_incrementStep {args} {}
    #----------------------------------------------------------------------
    # increment (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method increment {args} {$self _mProp $self increment $_propertyTypes(increment) $args}
    method _ctor_increment {args} {}
    method _dtor_increment {args} {}
    #----------------------------------------------------------------------
    # uniqueCount (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method uniqueCount {args} {$self _mProp $self uniqueCount $_propertyTypes(uniqueCount) $args}
    method _ctor_uniqueCount {args} {}
    method _dtor_uniqueCount {args} {}
    #----------------------------------------------------------------------
    # priority (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method priority {args} {$self _mProp $self priority $_propertyTypes(priority) $args}
    method _ctor_priority {args} {}
    method _dtor_priority {args} {}
    #----------------------------------------------------------------------
    # innerEnable (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method innerEnable {args} {$self _mProp $self innerEnable $_propertyTypes(innerEnable) $args}
    method _ctor_innerEnable {args} {}
    method _dtor_innerEnable {args} {}
    #----------------------------------------------------------------------
    # innerFirstId (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method innerFirstId {args} {$self _mProp $self innerFirstId $_propertyTypes(innerFirstId) $args}
    method _ctor_innerFirstId {args} {}
    method _dtor_innerFirstId {args} {}
    #----------------------------------------------------------------------
    # innerIncrementStep (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method innerIncrementStep {args} {$self _mProp $self innerIncrementStep $_propertyTypes(innerIncrementStep) $args}
    method _ctor_innerIncrementStep {args} {}
    method _dtor_innerIncrementStep {args} {}
    #----------------------------------------------------------------------
    # innerIncrement (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method innerIncrement {args} {$self _mProp $self innerIncrement $_propertyTypes(innerIncrement) $args}
    method _ctor_innerIncrement {args} {}
    method _dtor_innerIncrement {args} {}
    #----------------------------------------------------------------------
    # innerUniqueCount (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method innerUniqueCount {args} {$self _mProp $self innerUniqueCount $_propertyTypes(innerUniqueCount) $args}
    method _ctor_innerUniqueCount {args} {}
    method _dtor_innerUniqueCount {args} {}
    #----------------------------------------------------------------------
    # innerPriority (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method innerPriority {args} {$self _mProp $self innerPriority $_propertyTypes(innerPriority) $args}
    method _ctor_innerPriority {args} {}
    method _dtor_innerPriority {args} {}
    #----------------------------------------------------------------------
    # idIncrMode (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method idIncrMode {args} {$self _mProp $self idIncrMode $_propertyTypes(idIncrMode) $args}
    method _ctor_idIncrMode {args} {}
    method _dtor_idIncrMode {args} {}
    #----------------------------------------------------------------------
    # etherType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method etherType {args} {$self _mProp $self etherType $_propertyTypes(etherType) $args}
    method _ctor_etherType {args} {}
    method _dtor_etherType {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/Dhcp.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::Dhcp {
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/DhcpSettings.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::DhcpSettings {
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
        dhcpServerIp PropertyString
        timeOut PropertyInt
        iaType PropertyString
    }
    #----------------------------------------------------------------------
    # dhcpServerIp (PropertyString)
    # 
    #----------------------------------------------------------------------
    method dhcpServerIp {args} {$self _mProp $self dhcpServerIp $_propertyTypes(dhcpServerIp) $args}
    method _ctor_dhcpServerIp {args} {}
    method _dtor_dhcpServerIp {args} {}
    #----------------------------------------------------------------------
    # timeOut (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method timeOut {args} {$self _mProp $self timeOut $_propertyTypes(timeOut) $args}
    method _ctor_timeOut {args} {}
    method _dtor_timeOut {args} {}
    #----------------------------------------------------------------------
    # iaType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method iaType {args} {$self _mProp $self iaType $_propertyTypes(iaType) $args}
    method _ctor_iaType {args} {}
    method _dtor_iaType {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPBootstrap.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- XPBootstrap::eMyEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::eMyEnum {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kSymbol1
    typevariable kSymbol2
    typevariable kSymbol3
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kSymbol1]} {
            set kSymbol1 [$type create %AUTO%];$kSymbol1 Set kSymbol1
            set _tv [mytypevar kSymbol1]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kSymbol2]} {
            set kSymbol2 [$type create %AUTO%];$kSymbol2 Set kSymbol2
            set _tv [mytypevar kSymbol2]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kSymbol3]} {
            set kSymbol3 [$type create %AUTO%];$kSymbol3 Set kSymbol3
            set _tv [mytypevar kSymbol3]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kSymbol1
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      5 kSymbol1
      6 kSymbol2
      9 kSymbol3
    }
    typevariable m_encoder -array {
      kSymbol1 5
      kSymbol2 6
      kSymbol3 9
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- XPBootstrap::InnerStruct
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::InnerStruct {
    component c_Struct -inherit true
    delegate method anInt32 to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            anInt32 int32 {931}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 2]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListInt8
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListInt8 {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int8]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- XPBootstrap::MyStruct
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::MyStruct {
    component c_Struct -inherit true
    delegate method anInt8 to c_Struct using "%c _dcall %m"
    delegate method anInt16 to c_Struct using "%c _dcall %m"
    delegate method anInt32 to c_Struct using "%c _dcall %m"
    delegate method anInt64 to c_Struct using "%c _dcall %m"
    delegate method aBool to c_Struct using "%c _dcall %m"
    delegate method aDouble to c_Struct using "%c _dcall %m"
    delegate method aString to c_Struct using "%c _dcall %m"
    delegate method anOctets to c_Struct using "%c _dcall %m"
    delegate method anEnum to c_Struct using "%c _dcall %m"
    delegate method aStruct to c_Struct using "%c _dcall %m"
    delegate method aList to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            anInt8 int8 {3}
            anInt16 int16 {8}
            anInt32 int32 {1}
            anInt64 int64 {999}
            aBool bool {1}
            aDouble double {3.5}
            aString string {abcdef}
            anOctets octets {}
            anEnum XPBootstrap.eMyEnum {}
            aStruct XPBootstrap.InnerStruct {}
            aList XPBootstrap.ListInt8 {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 2]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListInt16
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListInt16 {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int16]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListInt32
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListInt32 {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int32]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListInt64
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListInt64 {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int64]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListBool
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListBool {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype bool]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListDouble
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListDouble {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype double]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListString
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListString {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListOctets
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListOctets {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype octets]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListEnum {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype XPBootstrap.eMyEnum]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListStruct
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListStruct {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype XPBootstrap.MyStruct]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPBootstrap::ListList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPBootstrap::ListList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype XPBootstrap.ListInt8]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::XPBootstrap {
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
    # eMyEnum
    # InnerStruct
    # ListInt8
    # MyStruct
    # ListInt16
    # ListInt32
    # ListInt64
    # ListBool
    # ListDouble
    # ListString
    # ListOctets
    # ListEnum
    # ListStruct
    # ListList
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
    typevariable _SIG_Ping {
    }
    method Ping {
        args
    } {
        $self _mCall $self $_SIG_Ping Ping args
    }
    typevariable _SIG_Int8Test {
        {name inInt8 type int8 direction in}
        {name inoutInt8 type int8 direction inout}
        {name outInt8 type int8 direction out}
    }
    method Int8Test {
        args
    } {
        $self _mCall $self $_SIG_Int8Test Int8Test args
    }
    typevariable _SIG_Int16Test {
        {name inInt16 type int16 direction in}
        {name inoutInt16 type int16 direction inout}
        {name outInt16 type int16 direction out}
    }
    method Int16Test {
        args
    } {
        $self _mCall $self $_SIG_Int16Test Int16Test args
    }
    typevariable _SIG_Int32Test {
        {name inInt32 type int32 direction in}
        {name inoutInt32 type int32 direction inout}
        {name outInt32 type int32 direction out}
    }
    method Int32Test {
        args
    } {
        $self _mCall $self $_SIG_Int32Test Int32Test args
    }
    typevariable _SIG_Int64Test {
        {name inInt64 type int64 direction in}
        {name inoutInt64 type int64 direction inout}
        {name outInt64 type int64 direction out}
    }
    method Int64Test {
        args
    } {
        $self _mCall $self $_SIG_Int64Test Int64Test args
    }
    typevariable _SIG_BoolTest {
        {name inBool type bool direction in}
        {name inoutBool type bool direction inout}
        {name outBool type bool direction out}
    }
    method BoolTest {
        args
    } {
        $self _mCall $self $_SIG_BoolTest BoolTest args
    }
    typevariable _SIG_DoubleTest {
        {name inDouble type double direction in}
        {name inoutDouble type double direction inout}
        {name outDouble type double direction out}
    }
    method DoubleTest {
        args
    } {
        $self _mCall $self $_SIG_DoubleTest DoubleTest args
    }
    typevariable _SIG_StringTest {
        {name inString type string direction in}
        {name inoutString type string direction inout}
        {name outString type string direction out}
    }
    method StringTest {
        args
    } {
        $self _mCall $self $_SIG_StringTest StringTest args
    }
    typevariable _SIG_OctetsTest {
        {name inOctets type octets direction in}
        {name inoutOctets type octets direction inout}
        {name outOctets type octets direction out}
    }
    method OctetsTest {
        args
    } {
        $self _mCall $self $_SIG_OctetsTest OctetsTest args
    }
    typevariable _SIG_FileTest {
        {name inFile type file direction in}
        {name outFile type file direction out}
    }
    method FileTest {
        args
    } {
        $self _mCall $self $_SIG_FileTest FileTest args
    }
    typevariable _SIG_EnumTest {
        {name inEnum type XPBootstrap.eMyEnum direction in}
        {name inoutEnum type XPBootstrap.eMyEnum direction inout}
        {name outEnum type XPBootstrap.eMyEnum direction out}
    }
    method EnumTest {
        args
    } {
        $self _mCall $self $_SIG_EnumTest EnumTest args
    }
    typevariable _SIG_StructTest {
        {name inStruct type XPBootstrap.MyStruct direction in}
        {name inoutStruct type XPBootstrap.MyStruct direction inout}
        {name outStruct type XPBootstrap.MyStruct direction out}
    }
    method StructTest {
        args
    } {
        $self _mCall $self $_SIG_StructTest StructTest args
    }
    typevariable _SIG_ListTestInt8 {
        {name inList type XPBootstrap.ListInt8 direction in}
        {name inoutList type XPBootstrap.ListInt8 direction inout}
        {name outList type XPBootstrap.ListInt8 direction out}
    }
    method ListTestInt8 {
        args
    } {
        $self _mCall $self $_SIG_ListTestInt8 ListTestInt8 args
    }
    typevariable _SIG_ListTestInt16 {
        {name inList type XPBootstrap.ListInt16 direction in}
        {name inoutList type XPBootstrap.ListInt16 direction inout}
        {name outList type XPBootstrap.ListInt16 direction out}
    }
    method ListTestInt16 {
        args
    } {
        $self _mCall $self $_SIG_ListTestInt16 ListTestInt16 args
    }
    typevariable _SIG_ListTestInt32 {
        {name inList type XPBootstrap.ListInt32 direction in}
        {name inoutList type XPBootstrap.ListInt32 direction inout}
        {name outList type XPBootstrap.ListInt32 direction out}
    }
    method ListTestInt32 {
        args
    } {
        $self _mCall $self $_SIG_ListTestInt32 ListTestInt32 args
    }
    typevariable _SIG_ListTestInt64 {
        {name inList type XPBootstrap.ListInt64 direction in}
        {name inoutList type XPBootstrap.ListInt64 direction inout}
        {name outList type XPBootstrap.ListInt64 direction out}
    }
    method ListTestInt64 {
        args
    } {
        $self _mCall $self $_SIG_ListTestInt64 ListTestInt64 args
    }
    typevariable _SIG_ListTestBool {
        {name inList type XPBootstrap.ListBool direction in}
        {name inoutList type XPBootstrap.ListBool direction inout}
        {name outList type XPBootstrap.ListBool direction out}
    }
    method ListTestBool {
        args
    } {
        $self _mCall $self $_SIG_ListTestBool ListTestBool args
    }
    typevariable _SIG_ListTestDouble {
        {name inList type XPBootstrap.ListDouble direction in}
        {name inoutList type XPBootstrap.ListDouble direction inout}
        {name outList type XPBootstrap.ListDouble direction out}
    }
    method ListTestDouble {
        args
    } {
        $self _mCall $self $_SIG_ListTestDouble ListTestDouble args
    }
    typevariable _SIG_ListTestString {
        {name inList type XPBootstrap.ListString direction in}
        {name inoutList type XPBootstrap.ListString direction inout}
        {name outList type XPBootstrap.ListString direction out}
    }
    method ListTestString {
        args
    } {
        $self _mCall $self $_SIG_ListTestString ListTestString args
    }
    typevariable _SIG_ListTestOctets {
        {name inList type XPBootstrap.ListOctets direction in}
        {name inoutList type XPBootstrap.ListOctets direction inout}
        {name outList type XPBootstrap.ListOctets direction out}
    }
    method ListTestOctets {
        args
    } {
        $self _mCall $self $_SIG_ListTestOctets ListTestOctets args
    }
    typevariable _SIG_ListTestEnum {
        {name inList type XPBootstrap.ListEnum direction in}
        {name inoutList type XPBootstrap.ListEnum direction inout}
        {name outList type XPBootstrap.ListEnum direction out}
    }
    method ListTestEnum {
        args
    } {
        $self _mCall $self $_SIG_ListTestEnum ListTestEnum args
    }
    typevariable _SIG_ListTestStruct {
        {name inList type XPBootstrap.ListStruct direction in}
        {name inoutList type XPBootstrap.ListStruct direction inout}
        {name outList type XPBootstrap.ListStruct direction out}
    }
    method ListTestStruct {
        args
    } {
        $self _mCall $self $_SIG_ListTestStruct ListTestStruct args
    }
    typevariable _SIG_ListTestList {
        {name inList type XPBootstrap.ListList direction in}
        {name inoutList type XPBootstrap.ListList direction inout}
        {name outList type XPBootstrap.ListList direction out}
    }
    method ListTestList {
        args
    } {
        $self _mCall $self $_SIG_ListTestList ListTestList args
    }
    typevariable _SIG_ObjectTest {
        {name outObject type XPBootstrap direction out}
    }
    method ObjectTest {
        args
    } {
        $self _mCall $self $_SIG_ObjectTest ObjectTest args
    }
    typevariable _SIG_CreateTestObject {
        {name unitTest type XPUnitTest direction out}
    }
    method CreateTestObject {
        args
    } {
        $self _mCall $self $_SIG_CreateTestObject CreateTestObject args
    }
    typevariable _SIG_TestUserDefinedTypeScope {
        {name anEnum type XPUnitTest.eUnitTestEnum direction inout}
        {name aStruct type XPUnitTest.UnitTestStruct direction inout}
        {name aList type XPUnitTest.UnitTestList direction inout}
    }
    method TestUserDefinedTypeScope {
        args
    } {
        $self _mCall $self $_SIG_TestUserDefinedTypeScope TestUserDefinedTypeScope args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTest.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- XPUnitTest::eUnitTestEnum
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTest::eUnitTestEnum {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kSymbol1
    typevariable kSymbol2
    typevariable kSymbol3
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kSymbol1]} {
            set kSymbol1 [$type create %AUTO%];$kSymbol1 Set kSymbol1
            set _tv [mytypevar kSymbol1]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kSymbol2]} {
            set kSymbol2 [$type create %AUTO%];$kSymbol2 Set kSymbol2
            set _tv [mytypevar kSymbol2]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kSymbol3]} {
            set kSymbol3 [$type create %AUTO%];$kSymbol3 Set kSymbol3
            set _tv [mytypevar kSymbol3]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kSymbol1
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      5 kSymbol1
      6 kSymbol2
      9 kSymbol3
    }
    typevariable m_encoder -array {
      kSymbol1 5
      kSymbol2 6
      kSymbol3 9
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- XPUnitTest::UnitTestStruct
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTest::UnitTestStruct {
    component c_Struct -inherit true
    delegate method anInt8 to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            anInt8 int8 {3}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 2]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XPUnitTest::UnitTestList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTest::UnitTestList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int8]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::XPUnitTest {
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
    # eUnitTestEnum
    # UnitTestStruct
    # UnitTestList
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
    typevariable _SIG_GetTestString {
        {name v type string direction out}
    }
    method GetTestString {
        args
    } {
        $self _mCall $self $_SIG_GetTestString GetTestString args
    }
    typevariable _SIG_SetTestString {
        {name v type string direction in}
    }
    method SetTestString {
        args
    } {
        $self _mCall $self $_SIG_SetTestString SetTestString args
    }
    typevariable _SIG_GetTestInt {
        {name v type int64 direction out}
    }
    method GetTestInt {
        args
    } {
        $self _mCall $self $_SIG_GetTestInt GetTestInt args
    }
    typevariable _SIG_GetTestBool {
        {name v type bool direction out}
    }
    method GetTestBool {
        args
    } {
        $self _mCall $self $_SIG_GetTestBool GetTestBool args
    }
    typevariable _SIG_GetTestDouble {
        {name v type double direction out}
    }
    method GetTestDouble {
        args
    } {
        $self _mCall $self $_SIG_GetTestDouble GetTestDouble args
    }
    typevariable _SIG_TestSimpleEvent {
        {name aString type string direction in}
    }
    method TestSimpleEvent {
        args
    } {
        $self _mCall $self $_SIG_TestSimpleEvent TestSimpleEvent args
    }
    typevariable _SIG_TestEventNoArgs {
    }
    method TestEventNoArgs {
        args
    } {
        $self _mCall $self $_SIG_TestEventNoArgs TestEventNoArgs args
    }
    typevariable _SIG_TestEvent {
        {name anInt8 type int8 direction in}
        {name anInt16 type int16 direction in}
        {name anInt32 type int32 direction in}
        {name anInt64 type int64 direction in}
        {name aBool type bool direction in}
        {name aDouble type double direction in}
        {name aString type string direction in}
        {name anOctets type octets direction in}
        {name anEnum type XPUnitTest.eUnitTestEnum direction in}
        {name aStruct type XPUnitTest.UnitTestStruct direction in}
        {name aList type XPUnitTest.UnitTestList direction in}
    }
    method TestEvent {
        args
    } {
        $self _mCall $self $_SIG_TestEvent TestEvent args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_MySimpleEvent {
        {name i_aString type string direction out}
    }
    method Request_MySimpleEvent {args} {
        set args [concat -event MySimpleEvent $args]
        $self _eEvent request $self $_SIG_MySimpleEvent args
    }
    method Cancel_MySimpleEvent {requestid args} {
        set args [concat -requestid $requestid -event MySimpleEvent $args]
        $self _eEvent cancellation $self $_SIG_MySimpleEvent args
    }
    typevariable _SIG_MyEvent {
        {name i_anInt8 type int8 direction out}
        {name i_anInt16 type int16 direction out}
        {name i_anInt32 type int32 direction out}
        {name i_anInt64 type int64 direction out}
        {name i_aBool type bool direction out}
        {name i_aDouble type double direction out}
        {name i_aString type string direction out}
        {name i_anOctets type octets direction out}
        {name i_anEnum type XPUnitTest.eUnitTestEnum direction out}
        {name i_aStruct type XPUnitTest.UnitTestStruct direction out}
        {name i_aList type XPUnitTest.UnitTestList direction out}
    }
    method Request_MyEvent {args} {
        set args [concat -event MyEvent $args]
        $self _eEvent request $self $_SIG_MyEvent args
    }
    method Cancel_MyEvent {requestid args} {
        set args [concat -requestid $requestid -event MyEvent $args]
        $self _eEvent cancellation $self $_SIG_MyEvent args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        stringVar PropertyString
        intVar PropertyInt
        boolVar PropertyBoolean
        doubleVar PropertyDouble
        intList PropertyIntList
        stringList PropertyStringList
        doubleList PropertyDoubleList
        subNode PropertyNode
        polymorphicSubNode PropertyNode
        polymorphicSubNodeList PropertyNodeList
        subNodeList PropertyNodeList
        subNodeListD PropertyNodeList
        obsoleteStringList PropertyStringList
        stringListBehindObsoleteStringList PropertyStringList
        obsoleteString PropertyString
        obsoleteSubNode PropertyNode
        obsoleteSubNodeList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # stringVar (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar {args} {$self _mProp $self stringVar $_propertyTypes(stringVar) $args}
    method _ctor_stringVar {args} {}
    method _dtor_stringVar {args} {}
    #----------------------------------------------------------------------
    # intVar (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method intVar {args} {$self _mProp $self intVar $_propertyTypes(intVar) $args}
    method _ctor_intVar {args} {}
    method _dtor_intVar {args} {}
    #----------------------------------------------------------------------
    # boolVar (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method boolVar {args} {$self _mProp $self boolVar $_propertyTypes(boolVar) $args}
    method _ctor_boolVar {args} {}
    method _dtor_boolVar {args} {}
    #----------------------------------------------------------------------
    # doubleVar (PropertyDouble)
    # 
    #----------------------------------------------------------------------
    method doubleVar {args} {$self _mProp $self doubleVar $_propertyTypes(doubleVar) $args}
    method _ctor_doubleVar {args} {}
    method _dtor_doubleVar {args} {}
    #----------------------------------------------------------------------
    # intList (PropertyIntList)
    # 
    #----------------------------------------------------------------------
    component intList -public intList
    method _ctor_intList {args} {
        set intList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype Int \
            -name intList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_intList {args} {catch {$intList destroy}}
    #----------------------------------------------------------------------
    # stringList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component stringList -public stringList
    method _ctor_stringList {args} {
        set stringList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name stringList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_stringList {args} {catch {$stringList destroy}}
    #----------------------------------------------------------------------
    # doubleList (PropertyDoubleList)
    # 
    #----------------------------------------------------------------------
    component doubleList -public doubleList
    method _ctor_doubleList {args} {
        set doubleList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype Double \
            -name doubleList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_doubleList {args} {catch {$doubleList destroy}}
    #----------------------------------------------------------------------
    # subNode (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component subNode -public subNode
    method _ctor_subNode {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype XPUnitTestA]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType subNode]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set subNode [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name subNode \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_subNode {args} {catch {$subNode destroy}}
    #----------------------------------------------------------------------
    # polymorphicSubNode (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component polymorphicSubNode -public polymorphicSubNode
    method _ctor_polymorphicSubNode {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype XPUnitTestA]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType polymorphicSubNode]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set polymorphicSubNode [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name polymorphicSubNode \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_polymorphicSubNode {args} {catch {$polymorphicSubNode destroy}}
    #----------------------------------------------------------------------
    # polymorphicSubNodeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component polymorphicSubNodeList -public polymorphicSubNodeList
    method _ctor_polymorphicSubNodeList {args} {
        set polymorphicSubNodeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype XPUnitTestA \
            -parent $self \
            -name polymorphicSubNodeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_polymorphicSubNodeList {args} {catch {$polymorphicSubNodeList destroy}}
    #----------------------------------------------------------------------
    # subNodeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component subNodeList -public subNodeList
    method _ctor_subNodeList {args} {
        set subNodeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype XPUnitTestC \
            -parent $self \
            -name subNodeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_subNodeList {args} {catch {$subNodeList destroy}}
    #----------------------------------------------------------------------
    # subNodeListD (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component subNodeListD -public subNodeListD
    method _ctor_subNodeListD {args} {
        set subNodeListD [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype XPUnitTestD \
            -parent $self \
            -name subNodeListD \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_subNodeListD {args} {catch {$subNodeListD destroy}}
    #----------------------------------------------------------------------
    # obsoleteStringList (PropertyStringList)
    # OBSOLETE: obsolete string list
    #----------------------------------------------------------------------
    component obsoleteStringList -public obsoleteStringList
    method _ctor_obsoleteStringList {args} {
        set obsoleteStringList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name obsoleteStringList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
            -obsolete {message {obsolete string list}} \
        ]
    }
    method _dtor_obsoleteStringList {args} {catch {$obsoleteStringList destroy}}
    #----------------------------------------------------------------------
    # stringListBehindObsoleteStringList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component stringListBehindObsoleteStringList -public stringListBehindObsoleteStringList
    method _ctor_stringListBehindObsoleteStringList {args} {
        set stringListBehindObsoleteStringList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name stringListBehindObsoleteStringList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_stringListBehindObsoleteStringList {args} {catch {$stringListBehindObsoleteStringList destroy}}
    #----------------------------------------------------------------------
    # obsoleteString (PropertyString)
    # OBSOLETE: obsolete string
    #----------------------------------------------------------------------
    method obsoleteString {args} {$self _mProp $self obsoleteString $_propertyTypes(obsoleteString) $args {message {obsolete string}}}
    method _ctor_obsoleteString {args} {}
    method _dtor_obsoleteString {args} {}
    #----------------------------------------------------------------------
    # obsoleteSubNode (PropertyNode)
    # OBSOLETE: obsolete node
    #----------------------------------------------------------------------
    component obsoleteSubNode -public obsoleteSubNode
    method _ctor_obsoleteSubNode {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype XPUnitTestO]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType obsoleteSubNode]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set obsoleteSubNode [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name obsoleteSubNode \
        -transactioncontext $options(-transactioncontext) \
        -obsolete {message {obsolete node}} \
      ]
    }
    method _dtor_obsoleteSubNode {args} {catch {$obsoleteSubNode destroy}}
    #----------------------------------------------------------------------
    # obsoleteSubNodeList (PropertyNodeList)
    # OBSOLETE: obsolete PropertyNode of type XPUnitTestO
    #----------------------------------------------------------------------
    component obsoleteSubNodeList -public obsoleteSubNodeList
    method _ctor_obsoleteSubNodeList {args} {
        set obsoleteSubNodeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype XPUnitTestO \
            -parent $self \
            -name obsoleteSubNodeList \
            -transactioncontext $options(-transactioncontext) \
            -obsolete {message {obsolete PropertyNode of type XPUnitTestO}} \
        ]
    }
    method _dtor_obsoleteSubNodeList {args} {catch {$obsoleteSubNodeList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTestA.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTestA {
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
    typevariable _SIG_GetTestStringA {
        {name v type string direction out}
    }
    method GetTestStringA {
        args
    } {
        $self _mCall $self $_SIG_GetTestStringA GetTestStringA args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        stringVar PropertyString
        subNode PropertyNode
        secondReference PropertyNode
        subNodeList PropertyNodeList
    }
    #----------------------------------------------------------------------
    # stringVar (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVar {args} {$self _mProp $self stringVar $_propertyTypes(stringVar) $args}
    method _ctor_stringVar {args} {}
    method _dtor_stringVar {args} {}
    #----------------------------------------------------------------------
    # subNode (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component subNode -public subNode
    method _ctor_subNode {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype XPUnitTestD]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType subNode]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set subNode [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name subNode \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_subNode {args} {catch {$subNode destroy}}
    #----------------------------------------------------------------------
    # secondReference (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component secondReference -public secondReference
    method _ctor_secondReference {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype XPUnitTestD]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType secondReference]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set secondReference [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name secondReference \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_secondReference {args} {catch {$secondReference destroy}}
    #----------------------------------------------------------------------
    # subNodeList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component subNodeList -public subNodeList
    method _ctor_subNodeList {args} {
        set subNodeList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype XPUnitTestD \
            -parent $self \
            -name subNodeList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_subNodeList {args} {catch {$subNodeList destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTestB.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTestB {
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
    component c_Base -public XPUnitTestA -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::XPUnitTestA %AUTO%}
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
    typevariable _SIG_GetTestStringB {
        {name v type string direction out}
    }
    method GetTestStringB {
        args
    } {
        $self _mCall $self $_SIG_GetTestStringB GetTestStringB args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        stringVarB PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarB (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarB {args} {$self _mProp $self stringVarB $_propertyTypes(stringVarB) $args}
    method _ctor_stringVarB {args} {}
    method _dtor_stringVarB {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTestC.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTestC {
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
    component c_Base -public XPUnitTestA -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::XPUnitTestA %AUTO%}
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
    typevariable _SIG_GetTestStringC {
        {name v type string direction out}
    }
    method GetTestStringC {
        args
    } {
        $self _mCall $self $_SIG_GetTestStringC GetTestStringC args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        stringVarC PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarC (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarC {args} {$self _mProp $self stringVarC $_propertyTypes(stringVarC) $args}
    method _ctor_stringVarC {args} {}
    method _dtor_stringVarC {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTestD.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTestD {
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
        stringVarD PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarD (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarD {args} {$self _mProp $self stringVarD $_propertyTypes(stringVarD) $args}
    method _ctor_stringVarD {args} {}
    method _dtor_stringVarD {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XPUnitTestO.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XPUnitTestO {
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
    typevariable _SIG_GetTestStringO {
        {name v type string direction out}
    }
    method GetTestStringO {
        args
    } {
        $self _mCall $self $_SIG_GetTestStringO GetTestStringO args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        stringVarO PropertyString
    }
    #----------------------------------------------------------------------
    # stringVarO (PropertyString)
    # 
    #----------------------------------------------------------------------
    method stringVarO {args} {$self _mProp $self stringVarO $_propertyTypes(stringVarO) $args}
    method _ctor_stringVarO {args} {}
    method _dtor_stringVarO {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/XProtocolObject.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- XProtocolObject::ObjectIdList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::ObjectIdList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype int64]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XProtocolObject::XmlList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::XmlList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- XProtocolObject::eSerializationDepth
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::eSerializationDepth {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kShallow
    typevariable kNode
    typevariable kDeep
    typevariable kPrefetch
    typevariable kIdOnly
    typevariable kInterfaceManager
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kShallow]} {
            set kShallow [$type create %AUTO%];$kShallow Set kShallow
            set _tv [mytypevar kShallow]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kNode]} {
            set kNode [$type create %AUTO%];$kNode Set kNode
            set _tv [mytypevar kNode]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kDeep]} {
            set kDeep [$type create %AUTO%];$kDeep Set kDeep
            set _tv [mytypevar kDeep]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPrefetch]} {
            set kPrefetch [$type create %AUTO%];$kPrefetch Set kPrefetch
            set _tv [mytypevar kPrefetch]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kIdOnly]} {
            set kIdOnly [$type create %AUTO%];$kIdOnly Set kIdOnly
            set _tv [mytypevar kIdOnly]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kInterfaceManager]} {
            set kInterfaceManager [$type create %AUTO%];$kInterfaceManager Set kInterfaceManager
            set _tv [mytypevar kInterfaceManager]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kShallow
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kShallow
      1 kNode
      2 kDeep
      3 kPrefetch
      4 kIdOnly
      5 kInterfaceManager
    }
    typevariable m_encoder -array {
      kShallow 0
      kNode 1
      kDeep 2
      kPrefetch 3
      kIdOnly 4
      kInterfaceManager 5
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- XProtocolObject::eValidateMode
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::eValidateMode {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kDefaultValidation
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kDefaultValidation]} {
            set kDefaultValidation [$type create %AUTO%];$kDefaultValidation Set kDefaultValidation
            set _tv [mytypevar kDefaultValidation]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kDefaultValidation
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      100 kDefaultValidation
    }
    typevariable m_encoder -array {
      kDefaultValidation 100
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- XProtocolObject::ClassVersion
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::ClassVersion {
    component c_Struct -inherit true
    delegate method name to c_Struct using "%c _dcall %m"
    delegate method version to c_Struct using "%c _dcall %m"
    delegate method serverInstantiate to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            name string {}
            version int32 {1}
            serverInstantiate bool {1}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# List -- XProtocolObject::ClassVersionList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::XProtocolObject::ClassVersionList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype XProtocolObject.ClassVersion]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::XProtocolObject {
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
    component c_Base -public ClientObjectBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::Core::ClientObjectBase %AUTO%}
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
    # ObjectIdList
    # XmlList
    # eSerializationDepth
    # eValidateMode
    # ClassVersion
    # ClassVersionList
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
    typevariable _SIG__GetXml {
        {name depth type XProtocolObject.eSerializationDepth direction in}
        {name forPersistentStorage type bool direction in}
        {name xml type string direction out}
    }
    method _GetXml {
        args
    } {
        $self _mCall $self $_SIG__GetXml _GetXml args
    }
    typevariable _SIG__SetXml {
        {name xml type string direction in}
        {name merge type bool direction in}
    }
    method _SetXml {
        args
    } {
        $self _mCall $self $_SIG__SetXml _SetXml args
    }
    typevariable _SIG__ImportXml {
        {name xml type string direction in}
        {name merge type bool direction in}
    }
    method _ImportXml {
        args
    } {
        $self _mCall $self $_SIG__ImportXml _ImportXml args
    }
    typevariable _SIG__Disposed {
    }
    method _Disposed {
        args
    } {
        $self _mCall $self $_SIG__Disposed _Disposed args
    }
    typevariable _SIG__GetObjectListXml {
        {name listName type string direction in}
        {name depth type XProtocolObject.eSerializationDepth direction in}
        {name forPersistentStorage type bool direction in}
        {name xml type string direction out}
    }
    method _GetObjectListXml {
        args
    } {
        $self _mCall $self $_SIG__GetObjectListXml _GetObjectListXml args
    }
    typevariable _SIG__SetObjectListXml {
        {name listName type string direction in}
        {name xml type string direction in}
        {name merge type bool direction in}
    }
    method _SetObjectListXml {
        args
    } {
        $self _mCall $self $_SIG__SetObjectListXml _SetObjectListXml args
    }
    typevariable _SIG__GetManagedDataXml {
        {name isDeep type bool direction in}
        {name xml type string direction out}
    }
    method _GetManagedDataXml {
        args
    } {
        $self _mCall $self $_SIG__GetManagedDataXml _GetManagedDataXml args
    }
    typevariable _SIG__SetManagedDataXml {
        {name xml type string direction in}
    }
    method _SetManagedDataXml {
        args
    } {
        $self _mCall $self $_SIG__SetManagedDataXml _SetManagedDataXml args
    }
    typevariable _SIG__GetInstantiationXml {
        {name typeName type string direction in}
        {name xml type string direction out}
    }
    method _GetInstantiationXml {
        args
    } {
        $self _mCall $self $_SIG__GetInstantiationXml _GetInstantiationXml args
    }
    typevariable _SIG__AppendListMember {
        {name listName type string direction in}
        {name objecType type string direction in}
        {name clientObjectId type int64 direction in}
        {name xml type string direction in}
    }
    method _AppendListMember {
        args
    } {
        $self _mCall $self $_SIG__AppendListMember _AppendListMember args
    }
    typevariable _SIG__DeleteListMember {
        {name listName type string direction in}
        {name id type int64 direction in}
    }
    method _DeleteListMember {
        args
    } {
        $self _mCall $self $_SIG__DeleteListMember _DeleteListMember args
    }
    typevariable _SIG__PrefetchListMembers {
        {name listName type string direction in}
        {name idList type XProtocolObject.ObjectIdList direction in}
        {name xmlList type XProtocolObject.XmlList direction out}
    }
    method _PrefetchListMembers {
        args
    } {
        $self _mCall $self $_SIG__PrefetchListMembers _PrefetchListMembers args
    }
    typevariable _SIG__GetClassVersionList {
        {name versionList type XProtocolObject.ClassVersionList direction out}
    }
    method _GetClassVersionList {
        args
    } {
        $self _mCall $self $_SIG__GetClassVersionList _GetClassVersionList args
    }
    typevariable _SIG__GetNewObjectIdRange {
        {name start type int64 direction out}
        {name count type int64 direction out}
    }
    method _GetNewObjectIdRange {
        args
    } {
        $self _mCall $self $_SIG__GetNewObjectIdRange _GetNewObjectIdRange args
    }
    typevariable _SIG__GetCorbaIor {
        {name ior type string direction out}
    }
    method _GetCorbaIor {
        args
    } {
        $self _mCall $self $_SIG__GetCorbaIor _GetCorbaIor args
    }
    typevariable _SIG__Validate {
        {name mode type XProtocolObject.eValidateMode direction in}
    }
    method _Validate {
        args
    } {
        $self _mCall $self $_SIG__Validate _Validate args
    }
    typevariable _SIG__CreateFileTransferContext {
        {name id type int64 direction out}
    }
    method _CreateFileTransferContext {
        args
    } {
        $self _mCall $self $_SIG__CreateFileTransferContext _CreateFileTransferContext args
    }
    typevariable _SIG__WriteFileBlock {
        {name id type int64 direction in}
        {name data type octets direction in}
    }
    method _WriteFileBlock {
        args
    } {
        $self _mCall $self $_SIG__WriteFileBlock _WriteFileBlock args
    }
    typevariable _SIG__ReadFileBlock {
        {name id type int64 direction in}
        {name maxBytes type int32 direction in}
        {name data type octets direction out}
    }
    method _ReadFileBlock {
        args
    } {
        $self _mCall $self $_SIG__ReadFileBlock _ReadFileBlock args
    }
    typevariable _SIG__CloseFileTransferContext {
        {name id type int64 direction in}
    }
    method _CloseFileTransferContext {
        args
    } {
        $self _mCall $self $_SIG__CloseFileTransferContext _CloseFileTransferContext args
    }
    typevariable _SIG__WriteLock {
        {name timeout type int32 direction in}
    }
    method _WriteLock {
        args
    } {
        $self _mCall $self $_SIG__WriteLock _WriteLock args
    }
    typevariable _SIG__GetThisId {
        {name id type int64 direction out}
    }
    method _GetThisId {
        args
    } {
        $self _mCall $self $_SIG__GetThisId _GetThisId args
    }
    typevariable _SIG__GetPropertyObjectId {
        {name name type string direction in}
        {name id type int64 direction out}
    }
    method _GetPropertyObjectId {
        args
    } {
        $self _mCall $self $_SIG__GetPropertyObjectId _GetPropertyObjectId args
    }
    typevariable _SIG__GetPropertyObjectIdAndType {
        {name name type string direction in}
        {name id type int64 direction out}
        {name type type string direction out}
    }
    method _GetPropertyObjectIdAndType {
        args
    } {
        $self _mCall $self $_SIG__GetPropertyObjectIdAndType _GetPropertyObjectIdAndType args
    }
    typevariable _SIG__PropertyNodeInstantiate {
        {name name type string direction in}
        {name type type string direction in}
        {name id type int64 direction out}
    }
    method _PropertyNodeInstantiate {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeInstantiate _PropertyNodeInstantiate args
    }
    typevariable _SIG__PropertyNodeBind {
        {name name type string direction in}
        {name id type int64 direction in}
        {name type type string direction out}
    }
    method _PropertyNodeBind {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeBind _PropertyNodeBind args
    }
    typevariable _SIG__PropertyNodeCharacterizationData {
        {name name type string direction in}
        {name type type string direction out}
        {name id type int64 direction out}
    }
    method _PropertyNodeCharacterizationData {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeCharacterizationData _PropertyNodeCharacterizationData args
    }
    typevariable _SIG__PropertyNodeListEmpty {
        {name name type string direction in}
    }
    method _PropertyNodeListEmpty {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListEmpty _PropertyNodeListEmpty args
    }
    typevariable _SIG__PropertyNodeListSize {
        {name name type string direction in}
        {name size type int32 direction out}
    }
    method _PropertyNodeListSize {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListSize _PropertyNodeListSize args
    }
    typevariable _SIG__PropertyNodeListDelete {
        {name name type string direction in}
        {name index type int32 direction in}
    }
    method _PropertyNodeListDelete {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListDelete _PropertyNodeListDelete args
    }
    typevariable _SIG__PropertyNodeListPopHead {
        {name name type string direction in}
    }
    method _PropertyNodeListPopHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListPopHead _PropertyNodeListPopHead args
    }
    typevariable _SIG__PropertyNodeListPopTail {
        {name name type string direction in}
    }
    method _PropertyNodeListPopTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListPopTail _PropertyNodeListPopTail args
    }
    typevariable _SIG__PropertyNodeListAddHead {
        {name name type string direction in}
        {name type type string direction in}
    }
    method _PropertyNodeListAddHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListAddHead _PropertyNodeListAddHead args
    }
    typevariable _SIG__PropertyNodeListAddTail {
        {name name type string direction in}
        {name type type string direction in}
    }
    method _PropertyNodeListAddTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListAddTail _PropertyNodeListAddTail args
    }
    typevariable _SIG__PropertyNodeListGet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name type type string direction out}
        {name id type int64 direction out}
    }
    method _PropertyNodeListGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyNodeListGet _PropertyNodeListGet args
    }
    typevariable _SIG__PropertyIntSet {
        {name name type string direction in}
        {name value type int64 direction in}
    }
    method _PropertyIntSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntSet _PropertyIntSet args
    }
    typevariable _SIG__PropertyIntGet {
        {name name type string direction in}
        {name value type int64 direction out}
    }
    method _PropertyIntGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntGet _PropertyIntGet args
    }
    typevariable _SIG__PropertyDoubleSet {
        {name name type string direction in}
        {name value type double direction in}
    }
    method _PropertyDoubleSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleSet _PropertyDoubleSet args
    }
    typevariable _SIG__PropertyDoubleGet {
        {name name type string direction in}
        {name value type double direction out}
    }
    method _PropertyDoubleGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleGet _PropertyDoubleGet args
    }
    typevariable _SIG__PropertyStringSet {
        {name name type string direction in}
        {name value type string direction in}
    }
    method _PropertyStringSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringSet _PropertyStringSet args
    }
    typevariable _SIG__PropertyStringGet {
        {name name type string direction in}
        {name value type string direction out}
    }
    method _PropertyStringGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringGet _PropertyStringGet args
    }
    typevariable _SIG__PropertyBooleanSet {
        {name name type string direction in}
        {name value type bool direction in}
    }
    method _PropertyBooleanSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyBooleanSet _PropertyBooleanSet args
    }
    typevariable _SIG__PropertyBooleanGet {
        {name name type string direction in}
        {name value type bool direction out}
    }
    method _PropertyBooleanGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyBooleanGet _PropertyBooleanGet args
    }
    typevariable _SIG__PropertyIntListEmpty {
        {name name type string direction in}
    }
    method _PropertyIntListEmpty {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListEmpty _PropertyIntListEmpty args
    }
    typevariable _SIG__PropertyIntListSize {
        {name name type string direction in}
        {name size type int32 direction out}
    }
    method _PropertyIntListSize {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListSize _PropertyIntListSize args
    }
    typevariable _SIG__PropertyIntListGet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type int64 direction out}
    }
    method _PropertyIntListGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListGet _PropertyIntListGet args
    }
    typevariable _SIG__PropertyIntListSet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type int64 direction in}
    }
    method _PropertyIntListSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListSet _PropertyIntListSet args
    }
    typevariable _SIG__PropertyIntListDelete {
        {name name type string direction in}
        {name index type int32 direction in}
    }
    method _PropertyIntListDelete {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListDelete _PropertyIntListDelete args
    }
    typevariable _SIG__PropertyIntListAddHead {
        {name name type string direction in}
        {name value type int64 direction in}
    }
    method _PropertyIntListAddHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListAddHead _PropertyIntListAddHead args
    }
    typevariable _SIG__PropertyIntListAddTail {
        {name name type string direction in}
        {name value type int64 direction in}
    }
    method _PropertyIntListAddTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListAddTail _PropertyIntListAddTail args
    }
    typevariable _SIG__PropertyIntListPopHead {
        {name name type string direction in}
    }
    method _PropertyIntListPopHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListPopHead _PropertyIntListPopHead args
    }
    typevariable _SIG__PropertyIntListPopTail {
        {name name type string direction in}
    }
    method _PropertyIntListPopTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyIntListPopTail _PropertyIntListPopTail args
    }
    typevariable _SIG__PropertyDoubleListEmpty {
        {name name type string direction in}
    }
    method _PropertyDoubleListEmpty {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListEmpty _PropertyDoubleListEmpty args
    }
    typevariable _SIG__PropertyDoubleListSize {
        {name name type string direction in}
        {name size type int32 direction out}
    }
    method _PropertyDoubleListSize {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListSize _PropertyDoubleListSize args
    }
    typevariable _SIG__PropertyDoubleListGet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type double direction out}
    }
    method _PropertyDoubleListGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListGet _PropertyDoubleListGet args
    }
    typevariable _SIG__PropertyDoubleListSet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type double direction in}
    }
    method _PropertyDoubleListSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListSet _PropertyDoubleListSet args
    }
    typevariable _SIG__PropertyDoubleListDelete {
        {name name type string direction in}
        {name index type int32 direction in}
    }
    method _PropertyDoubleListDelete {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListDelete _PropertyDoubleListDelete args
    }
    typevariable _SIG__PropertyDoubleListAddHead {
        {name name type string direction in}
        {name value type double direction in}
    }
    method _PropertyDoubleListAddHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListAddHead _PropertyDoubleListAddHead args
    }
    typevariable _SIG__PropertyDoubleListAddTail {
        {name name type string direction in}
        {name value type double direction in}
    }
    method _PropertyDoubleListAddTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListAddTail _PropertyDoubleListAddTail args
    }
    typevariable _SIG__PropertyDoubleListPopHead {
        {name name type string direction in}
    }
    method _PropertyDoubleListPopHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListPopHead _PropertyDoubleListPopHead args
    }
    typevariable _SIG__PropertyDoubleListPopTail {
        {name name type string direction in}
    }
    method _PropertyDoubleListPopTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyDoubleListPopTail _PropertyDoubleListPopTail args
    }
    typevariable _SIG__PropertyStringListEmpty {
        {name name type string direction in}
    }
    method _PropertyStringListEmpty {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListEmpty _PropertyStringListEmpty args
    }
    typevariable _SIG__PropertyStringListSize {
        {name name type string direction in}
        {name size type int32 direction out}
    }
    method _PropertyStringListSize {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListSize _PropertyStringListSize args
    }
    typevariable _SIG__PropertyStringListGet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type string direction out}
    }
    method _PropertyStringListGet {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListGet _PropertyStringListGet args
    }
    typevariable _SIG__PropertyStringListSet {
        {name name type string direction in}
        {name index type int32 direction in}
        {name value type string direction in}
    }
    method _PropertyStringListSet {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListSet _PropertyStringListSet args
    }
    typevariable _SIG__PropertyStringListDelete {
        {name name type string direction in}
        {name index type int32 direction in}
    }
    method _PropertyStringListDelete {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListDelete _PropertyStringListDelete args
    }
    typevariable _SIG__PropertyStringListAddHead {
        {name name type string direction in}
        {name value type string direction in}
    }
    method _PropertyStringListAddHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListAddHead _PropertyStringListAddHead args
    }
    typevariable _SIG__PropertyStringListAddTail {
        {name name type string direction in}
        {name value type string direction in}
    }
    method _PropertyStringListAddTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListAddTail _PropertyStringListAddTail args
    }
    typevariable _SIG__PropertyStringListPopHead {
        {name name type string direction in}
    }
    method _PropertyStringListPopHead {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListPopHead _PropertyStringListPopHead args
    }
    typevariable _SIG__PropertyStringListPopTail {
        {name name type string direction in}
    }
    method _PropertyStringListPopTail {
        args
    } {
        $self _mCall $self $_SIG__PropertyStringListPopTail _PropertyStringListPopTail args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/POSPayLoad.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::POSPayLoad {
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
    component c_Base -public DataDrivenFormBase -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::DataDrivenFormBase %AUTO%}
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
    }
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PPPPayLoad.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PPPPayLoad {
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
    component c_Base -public POSPayLoad -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::POSPayLoad %AUTO%}
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
        enablePPP PropertyBoolean
        transmitUnit PropertyInt
        receiveUnit PropertyInt
        configurationRetries PropertyInt
        terminationRetries PropertyInt
        retryTimeout PropertyInt
        useMagicNumber PropertyBoolean
        enableACCM PropertyBoolean
        linkQualityMonitoring PropertyBoolean
        lqmReceiveInterval PropertyInt
        ip PropertyBoolean
        localIPAddress PropertyString
        ipv6 PropertyBoolean
        localNegotiationMode PropertyString
        localIdType PropertyString
        localMACInterfaceId PropertyString
        localIPv6InterfaceId PropertyString
        peerNegotiationMode PropertyString
        peerIdType PropertyString
        peerMACInterfaceId PropertyString
        peerIPv6InterfaceId PropertyString
        osi PropertyBoolean
        transmitAlignment PropertyInt
        receiveAlignment PropertyInt
        mpls PropertyBoolean
    }
    #----------------------------------------------------------------------
    # enablePPP (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enablePPP {args} {$self _mProp $self enablePPP $_propertyTypes(enablePPP) $args}
    method _ctor_enablePPP {args} {}
    method _dtor_enablePPP {args} {}
    #----------------------------------------------------------------------
    # transmitUnit (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method transmitUnit {args} {$self _mProp $self transmitUnit $_propertyTypes(transmitUnit) $args}
    method _ctor_transmitUnit {args} {}
    method _dtor_transmitUnit {args} {}
    #----------------------------------------------------------------------
    # receiveUnit (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method receiveUnit {args} {$self _mProp $self receiveUnit $_propertyTypes(receiveUnit) $args}
    method _ctor_receiveUnit {args} {}
    method _dtor_receiveUnit {args} {}
    #----------------------------------------------------------------------
    # configurationRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method configurationRetries {args} {$self _mProp $self configurationRetries $_propertyTypes(configurationRetries) $args}
    method _ctor_configurationRetries {args} {}
    method _dtor_configurationRetries {args} {}
    #----------------------------------------------------------------------
    # terminationRetries (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method terminationRetries {args} {$self _mProp $self terminationRetries $_propertyTypes(terminationRetries) $args}
    method _ctor_terminationRetries {args} {}
    method _dtor_terminationRetries {args} {}
    #----------------------------------------------------------------------
    # retryTimeout (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method retryTimeout {args} {$self _mProp $self retryTimeout $_propertyTypes(retryTimeout) $args}
    method _ctor_retryTimeout {args} {}
    method _dtor_retryTimeout {args} {}
    #----------------------------------------------------------------------
    # useMagicNumber (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method useMagicNumber {args} {$self _mProp $self useMagicNumber $_propertyTypes(useMagicNumber) $args}
    method _ctor_useMagicNumber {args} {}
    method _dtor_useMagicNumber {args} {}
    #----------------------------------------------------------------------
    # enableACCM (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableACCM {args} {$self _mProp $self enableACCM $_propertyTypes(enableACCM) $args}
    method _ctor_enableACCM {args} {}
    method _dtor_enableACCM {args} {}
    #----------------------------------------------------------------------
    # linkQualityMonitoring (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method linkQualityMonitoring {args} {$self _mProp $self linkQualityMonitoring $_propertyTypes(linkQualityMonitoring) $args}
    method _ctor_linkQualityMonitoring {args} {}
    method _dtor_linkQualityMonitoring {args} {}
    #----------------------------------------------------------------------
    # lqmReceiveInterval (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method lqmReceiveInterval {args} {$self _mProp $self lqmReceiveInterval $_propertyTypes(lqmReceiveInterval) $args}
    method _ctor_lqmReceiveInterval {args} {}
    method _dtor_lqmReceiveInterval {args} {}
    #----------------------------------------------------------------------
    # ip (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method ip {args} {$self _mProp $self ip $_propertyTypes(ip) $args}
    method _ctor_ip {args} {}
    method _dtor_ip {args} {}
    #----------------------------------------------------------------------
    # localIPAddress (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localIPAddress {args} {$self _mProp $self localIPAddress $_propertyTypes(localIPAddress) $args}
    method _ctor_localIPAddress {args} {}
    method _dtor_localIPAddress {args} {}
    #----------------------------------------------------------------------
    # ipv6 (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method ipv6 {args} {$self _mProp $self ipv6 $_propertyTypes(ipv6) $args}
    method _ctor_ipv6 {args} {}
    method _dtor_ipv6 {args} {}
    #----------------------------------------------------------------------
    # localNegotiationMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localNegotiationMode {args} {$self _mProp $self localNegotiationMode $_propertyTypes(localNegotiationMode) $args}
    method _ctor_localNegotiationMode {args} {}
    method _dtor_localNegotiationMode {args} {}
    #----------------------------------------------------------------------
    # localIdType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localIdType {args} {$self _mProp $self localIdType $_propertyTypes(localIdType) $args}
    method _ctor_localIdType {args} {}
    method _dtor_localIdType {args} {}
    #----------------------------------------------------------------------
    # localMACInterfaceId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localMACInterfaceId {args} {$self _mProp $self localMACInterfaceId $_propertyTypes(localMACInterfaceId) $args}
    method _ctor_localMACInterfaceId {args} {}
    method _dtor_localMACInterfaceId {args} {}
    #----------------------------------------------------------------------
    # localIPv6InterfaceId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method localIPv6InterfaceId {args} {$self _mProp $self localIPv6InterfaceId $_propertyTypes(localIPv6InterfaceId) $args}
    method _ctor_localIPv6InterfaceId {args} {}
    method _dtor_localIPv6InterfaceId {args} {}
    #----------------------------------------------------------------------
    # peerNegotiationMode (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerNegotiationMode {args} {$self _mProp $self peerNegotiationMode $_propertyTypes(peerNegotiationMode) $args}
    method _ctor_peerNegotiationMode {args} {}
    method _dtor_peerNegotiationMode {args} {}
    #----------------------------------------------------------------------
    # peerIdType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerIdType {args} {$self _mProp $self peerIdType $_propertyTypes(peerIdType) $args}
    method _ctor_peerIdType {args} {}
    method _dtor_peerIdType {args} {}
    #----------------------------------------------------------------------
    # peerMACInterfaceId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerMACInterfaceId {args} {$self _mProp $self peerMACInterfaceId $_propertyTypes(peerMACInterfaceId) $args}
    method _ctor_peerMACInterfaceId {args} {}
    method _dtor_peerMACInterfaceId {args} {}
    #----------------------------------------------------------------------
    # peerIPv6InterfaceId (PropertyString)
    # 
    #----------------------------------------------------------------------
    method peerIPv6InterfaceId {args} {$self _mProp $self peerIPv6InterfaceId $_propertyTypes(peerIPv6InterfaceId) $args}
    method _ctor_peerIPv6InterfaceId {args} {}
    method _dtor_peerIPv6InterfaceId {args} {}
    #----------------------------------------------------------------------
    # osi (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method osi {args} {$self _mProp $self osi $_propertyTypes(osi) $args}
    method _ctor_osi {args} {}
    method _dtor_osi {args} {}
    #----------------------------------------------------------------------
    # transmitAlignment (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method transmitAlignment {args} {$self _mProp $self transmitAlignment $_propertyTypes(transmitAlignment) $args}
    method _ctor_transmitAlignment {args} {}
    method _dtor_transmitAlignment {args} {}
    #----------------------------------------------------------------------
    # receiveAlignment (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method receiveAlignment {args} {$self _mProp $self receiveAlignment $_propertyTypes(receiveAlignment) $args}
    method _ctor_receiveAlignment {args} {}
    method _dtor_receiveAlignment {args} {}
    #----------------------------------------------------------------------
    # mpls (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method mpls {args} {$self _mProp $self mpls $_propertyTypes(mpls) $args}
    method _ctor_mpls {args} {}
    method _dtor_mpls {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/POSPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::POSPlugin {
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
    component c_Base -public SonetATMBasePlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::SonetATMBasePlugin %AUTO%}
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
        eui PropertyString
        incrementBy PropertyString
        payLoadType PropertyString
        address PropertyString
        control PropertyString
        payLoad PropertyNode
    }
    #----------------------------------------------------------------------
    # eui (PropertyString)
    # 
    #----------------------------------------------------------------------
    method eui {args} {$self _mProp $self eui $_propertyTypes(eui) $args}
    method _ctor_eui {args} {}
    method _dtor_eui {args} {}
    #----------------------------------------------------------------------
    # incrementBy (PropertyString)
    # 
    #----------------------------------------------------------------------
    method incrementBy {args} {$self _mProp $self incrementBy $_propertyTypes(incrementBy) $args}
    method _ctor_incrementBy {args} {}
    method _dtor_incrementBy {args} {}
    #----------------------------------------------------------------------
    # payLoadType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method payLoadType {args} {$self _mProp $self payLoadType $_propertyTypes(payLoadType) $args}
    method _ctor_payLoadType {args} {}
    method _dtor_payLoadType {args} {}
    #----------------------------------------------------------------------
    # address (PropertyString)
    # 
    #----------------------------------------------------------------------
    method address {args} {$self _mProp $self address $_propertyTypes(address) $args}
    method _ctor_address {args} {}
    method _dtor_address {args} {}
    #----------------------------------------------------------------------
    # control (PropertyString)
    # 
    #----------------------------------------------------------------------
    method control {args} {$self _mProp $self control $_propertyTypes(control) $args}
    method _ctor_control {args} {}
    method _dtor_control {args} {}
    #----------------------------------------------------------------------
    # payLoad (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component payLoad -public payLoad
    method _ctor_payLoad {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype POSPayLoad]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType payLoad]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set payLoad [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name payLoad \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_payLoad {args} {catch {$payLoad destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/PortWatch.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# Enum -- PortWatch::eEventType
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortWatch::eEventType {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kLink
    typevariable kTransmit
    typevariable kCapture
    typevariable kOwnership
    typevariable kPortCpuStatus
    typevariable kPortCpuDodStatus
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kLink]} {
            set kLink [$type create %AUTO%];$kLink Set kLink
            set _tv [mytypevar kLink]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kTransmit]} {
            set kTransmit [$type create %AUTO%];$kTransmit Set kTransmit
            set _tv [mytypevar kTransmit]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kCapture]} {
            set kCapture [$type create %AUTO%];$kCapture Set kCapture
            set _tv [mytypevar kCapture]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kOwnership]} {
            set kOwnership [$type create %AUTO%];$kOwnership Set kOwnership
            set _tv [mytypevar kOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPortCpuStatus]} {
            set kPortCpuStatus [$type create %AUTO%];$kPortCpuStatus Set kPortCpuStatus
            set _tv [mytypevar kPortCpuStatus]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kPortCpuDodStatus]} {
            set kPortCpuDodStatus [$type create %AUTO%];$kPortCpuDodStatus Set kPortCpuDodStatus
            set _tv [mytypevar kPortCpuDodStatus]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kLink
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      1 kLink
      2 kTransmit
      4 kCapture
      8 kOwnership
      16 kPortCpuStatus
      32 kPortCpuDodStatus
    }
    typevariable m_encoder -array {
      kLink 1
      kTransmit 2
      kCapture 4
      kOwnership 8
      kPortCpuStatus 16
      kPortCpuDodStatus 32
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# List -- PortWatch::EventList
#----------------------------------------------------------------------
snit::type ::AptixiaClient::PortWatch::EventList {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype PortWatch.eEventType]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
snit::type ::AptixiaClient::PortWatch {
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
    # eEventType
    # EventList
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
    typevariable _SIG_SetEvents {
        {name eventList type PortWatch.EventList direction in}
    }
    method SetEvents {
        args
    } {
        $self _mCall $self $_SIG_SetEvents SetEvents args
    }
    typevariable _SIG_Apply {
    }
    method Apply {
        args
    } {
        $self _mCall $self $_SIG_Apply Apply args
    }
    typevariable _SIG_Destroy {
    }
    method Destroy {
        args
    } {
        $self _mCall $self $_SIG_Destroy Destroy args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_StateChanged {
        {name i_port type PortGroup.Port direction out}
        {name i_eventType type PortWatch.eEventType direction out}
        {name i_oldValue type string direction out}
        {name i_currentValue type string direction out}
    }
    method Request_StateChanged {args} {
        set args [concat -event StateChanged $args]
        $self _eEvent request $self $_SIG_StateChanged args
    }
    method Cancel_StateChanged {requestid args} {
        set args [concat -requestid $requestid -event StateChanged $args]
        $self _eEvent cancellation $self $_SIG_StateChanged args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        portList PropertyStringList
        needInitialValues PropertyBoolean
    }
    #----------------------------------------------------------------------
    # portList (PropertyStringList)
    # 
    #----------------------------------------------------------------------
    component portList -public portList
    method _ctor_portList {args} {
        set portList [${ClientNS}::Core::PropertyListBase %AUTO% \
            -itemtype String \
            -name portList \
            -parent $self \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_portList {args} {catch {$portList destroy}}
    #----------------------------------------------------------------------
    # needInitialValues (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method needInitialValues {args} {$self _mProp $self needInitialValues $_propertyTypes(needInitialValues) $args}
    method _ctor_needInitialValues {args} {}
    method _dtor_needInitialValues {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/GenericTestModel.xml
#----------------------------------------------------------------------
#----------------------------------------------------------------------
# List -- GenericTestModel::StringVector
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::StringVector {
    component c_List -inherit true
    constructor {args} {
        set c_List [::AptixiaClient::Core::UdtList %AUTO% -itemtype string]
    }
    destructor {catch {$c_List destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtList _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtList _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- GenericTestModel::eEventType
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::eEventType {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kFsmEnteredStateUnconfigured
    typevariable kFsmEnteredStateRebootPorts
    typevariable kFsmEnteredStateTakeOwnership
    typevariable kFsmEnteredStateReset
    typevariable kFsmEnteredStateDodPackagesLoadStack
    typevariable kFsmEnteredStateDodPackagesUnloadStack
    typevariable kFsmEnteredStateConfigured
    typevariable kFsmEnteredStateConfigStack
    typevariable kFsmEnteredStatePostConfigStack
    typevariable kFsmEnteredStateDeconfigStack
    typevariable kFsmEnteredStateReleaseOwnership
    typevariable kFsmEnteredStateOther
    typevariable kFsmEnteredRunStateGratArp
    typevariable kFsmEnteredRunStateWaitLinkUp
    typevariable kFsmEnteredRunStateConfigured
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kFsmEnteredStateUnconfigured]} {
            set kFsmEnteredStateUnconfigured [$type create %AUTO%];$kFsmEnteredStateUnconfigured Set kFsmEnteredStateUnconfigured
            set _tv [mytypevar kFsmEnteredStateUnconfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateRebootPorts]} {
            set kFsmEnteredStateRebootPorts [$type create %AUTO%];$kFsmEnteredStateRebootPorts Set kFsmEnteredStateRebootPorts
            set _tv [mytypevar kFsmEnteredStateRebootPorts]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateTakeOwnership]} {
            set kFsmEnteredStateTakeOwnership [$type create %AUTO%];$kFsmEnteredStateTakeOwnership Set kFsmEnteredStateTakeOwnership
            set _tv [mytypevar kFsmEnteredStateTakeOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateReset]} {
            set kFsmEnteredStateReset [$type create %AUTO%];$kFsmEnteredStateReset Set kFsmEnteredStateReset
            set _tv [mytypevar kFsmEnteredStateReset]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDodPackagesLoadStack]} {
            set kFsmEnteredStateDodPackagesLoadStack [$type create %AUTO%];$kFsmEnteredStateDodPackagesLoadStack Set kFsmEnteredStateDodPackagesLoadStack
            set _tv [mytypevar kFsmEnteredStateDodPackagesLoadStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDodPackagesUnloadStack]} {
            set kFsmEnteredStateDodPackagesUnloadStack [$type create %AUTO%];$kFsmEnteredStateDodPackagesUnloadStack Set kFsmEnteredStateDodPackagesUnloadStack
            set _tv [mytypevar kFsmEnteredStateDodPackagesUnloadStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateConfigured]} {
            set kFsmEnteredStateConfigured [$type create %AUTO%];$kFsmEnteredStateConfigured Set kFsmEnteredStateConfigured
            set _tv [mytypevar kFsmEnteredStateConfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateConfigStack]} {
            set kFsmEnteredStateConfigStack [$type create %AUTO%];$kFsmEnteredStateConfigStack Set kFsmEnteredStateConfigStack
            set _tv [mytypevar kFsmEnteredStateConfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStatePostConfigStack]} {
            set kFsmEnteredStatePostConfigStack [$type create %AUTO%];$kFsmEnteredStatePostConfigStack Set kFsmEnteredStatePostConfigStack
            set _tv [mytypevar kFsmEnteredStatePostConfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateDeconfigStack]} {
            set kFsmEnteredStateDeconfigStack [$type create %AUTO%];$kFsmEnteredStateDeconfigStack Set kFsmEnteredStateDeconfigStack
            set _tv [mytypevar kFsmEnteredStateDeconfigStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateReleaseOwnership]} {
            set kFsmEnteredStateReleaseOwnership [$type create %AUTO%];$kFsmEnteredStateReleaseOwnership Set kFsmEnteredStateReleaseOwnership
            set _tv [mytypevar kFsmEnteredStateReleaseOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredStateOther]} {
            set kFsmEnteredStateOther [$type create %AUTO%];$kFsmEnteredStateOther Set kFsmEnteredStateOther
            set _tv [mytypevar kFsmEnteredStateOther]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateGratArp]} {
            set kFsmEnteredRunStateGratArp [$type create %AUTO%];$kFsmEnteredRunStateGratArp Set kFsmEnteredRunStateGratArp
            set _tv [mytypevar kFsmEnteredRunStateGratArp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateWaitLinkUp]} {
            set kFsmEnteredRunStateWaitLinkUp [$type create %AUTO%];$kFsmEnteredRunStateWaitLinkUp Set kFsmEnteredRunStateWaitLinkUp
            set _tv [mytypevar kFsmEnteredRunStateWaitLinkUp]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kFsmEnteredRunStateConfigured]} {
            set kFsmEnteredRunStateConfigured [$type create %AUTO%];$kFsmEnteredRunStateConfigured Set kFsmEnteredRunStateConfigured
            set _tv [mytypevar kFsmEnteredRunStateConfigured]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kFsmEnteredStateUnconfigured
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      0 kFsmEnteredStateUnconfigured
      1 kFsmEnteredStateRebootPorts
      2 kFsmEnteredStateTakeOwnership
      3 kFsmEnteredStateReset
      4 kFsmEnteredStateDodPackagesLoadStack
      5 kFsmEnteredStateDodPackagesUnloadStack
      6 kFsmEnteredStateConfigured
      7 kFsmEnteredStateConfigStack
      8 kFsmEnteredStatePostConfigStack
      9 kFsmEnteredStateDeconfigStack
      10 kFsmEnteredStateReleaseOwnership
      11 kFsmEnteredStateOther
      13 kFsmEnteredRunStateGratArp
      14 kFsmEnteredRunStateWaitLinkUp
      15 kFsmEnteredRunStateConfigured
    }
    typevariable m_encoder -array {
      kFsmEnteredStateUnconfigured 0
      kFsmEnteredStateRebootPorts 1
      kFsmEnteredStateTakeOwnership 2
      kFsmEnteredStateReset 3
      kFsmEnteredStateDodPackagesLoadStack 4
      kFsmEnteredStateDodPackagesUnloadStack 5
      kFsmEnteredStateConfigured 6
      kFsmEnteredStateConfigStack 7
      kFsmEnteredStatePostConfigStack 8
      kFsmEnteredStateDeconfigStack 9
      kFsmEnteredStateReleaseOwnership 10
      kFsmEnteredStateOther 11
      kFsmEnteredRunStateGratArp 13
      kFsmEnteredRunStateWaitLinkUp 14
      kFsmEnteredRunStateConfigured 15
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Struct -- GenericTestModel::EventData
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::EventData {
    component c_Struct -inherit true
    delegate method eventType to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            eventType GenericTestModel.eEventType {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Struct -- GenericTestModel::TestInfo
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::TestInfo {
    component c_Struct -inherit true
    delegate method appName to c_Struct using "%c _dcall %m"
    delegate method userName to c_Struct using "%c _dcall %m"
    delegate method sessionName to c_Struct using "%c _dcall %m"
    constructor {args} {
        set spec {
            appName string {}
            userName string {}
            sessionName string {}
        }
        set c_Struct [::AptixiaClient::Core::UdtStruct %AUTO% \
            -spec $spec -version 1]
    }
    destructor {catch {$c_Struct destroy}}
    typemethod _enc_ {i_val} {::AptixiaClient::Core::UdtStruct _enc_ $i_val}
    typemethod _dec_ {i_context i_type i_elem i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::UdtStruct _dec_ $i_context $i_type $i_elem v
    }
}
#----------------------------------------------------------------------
# Enum -- GenericTestModel::eActionBehavior
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::eActionBehavior {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kActionBehaviorSmart
    typevariable kActionBehaviorAlways
    typevariable kActionBehaviorNever
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kActionBehaviorSmart]} {
            set kActionBehaviorSmart [$type create %AUTO%];$kActionBehaviorSmart Set kActionBehaviorSmart
            set _tv [mytypevar kActionBehaviorSmart]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionBehaviorAlways]} {
            set kActionBehaviorAlways [$type create %AUTO%];$kActionBehaviorAlways Set kActionBehaviorAlways
            set _tv [mytypevar kActionBehaviorAlways]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionBehaviorNever]} {
            set kActionBehaviorNever [$type create %AUTO%];$kActionBehaviorNever Set kActionBehaviorNever
            set _tv [mytypevar kActionBehaviorNever]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kActionBehaviorSmart
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      10 kActionBehaviorSmart
      20 kActionBehaviorAlways
      30 kActionBehaviorNever
    }
    typevariable m_encoder -array {
      kActionBehaviorSmart 10
      kActionBehaviorAlways 20
      kActionBehaviorNever 30
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
#----------------------------------------------------------------------
# Enum -- GenericTestModel::eAction
#----------------------------------------------------------------------
snit::type ::AptixiaClient::GenericTestModel::eAction {
    constructor {args} {}
    destructor {}
    #----------------------------------------------------------------------
    # Make a typevariable for each choice
    # that can be uses as as pseudo-const's
    #----------------------------------------------------------------------
    typevariable kActionTakeOwnership
    typevariable kActionConfigurePhysical
    typevariable kActionApplicationDOD
    typevariable kActionApplicationDODUnload
    typevariable kActionConfigureStack
    typeconstructor {
        #----------------------------------------------------------------------
        # Notice the time & hair-saving tricks in making read only variables
        # 
        # -- Using [list] to construct a guaranteed safe command for
        # later execution.
        # -- Using colon notation to force a reference to a global variable
        #  whatever the context.
        # -- Inserting the global name of the variable in the trace command
        # instead of working with its local referent.
        # -- Using a trailing ";#" to trim the undesirable extra arguments
        # from the trace command.
        # 
        # Additional Note: skip creation of read-only vars if they are already
        # present. This may occur if the package is getting re-sourced due to a
        # 'package forget' call.
        #----------------------------------------------------------------------
        if {![info exists kActionTakeOwnership]} {
            set kActionTakeOwnership [$type create %AUTO%];$kActionTakeOwnership Set kActionTakeOwnership
            set _tv [mytypevar kActionTakeOwnership]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionConfigurePhysical]} {
            set kActionConfigurePhysical [$type create %AUTO%];$kActionConfigurePhysical Set kActionConfigurePhysical
            set _tv [mytypevar kActionConfigurePhysical]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionApplicationDOD]} {
            set kActionApplicationDOD [$type create %AUTO%];$kActionApplicationDOD Set kActionApplicationDOD
            set _tv [mytypevar kActionApplicationDOD]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionApplicationDODUnload]} {
            set kActionApplicationDODUnload [$type create %AUTO%];$kActionApplicationDODUnload Set kActionApplicationDODUnload
            set _tv [mytypevar kActionApplicationDODUnload]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
        if {![info exists kActionConfigureStack]} {
            set kActionConfigureStack [$type create %AUTO%];$kActionConfigureStack Set kActionConfigureStack
            set _tv [mytypevar kActionConfigureStack]
            trace variable $_tv w \
                "[list set $_tv [set $_tv]];error read-only;#"
        }
    }
    variable m_Value kActionTakeOwnership
    method _enc_ {} {return $m_encoder($m_Value)}
    method _decset_ {v} {set m_Value $m_decoder($v)}
    method _dec_ {i_context i_type i_lnode i_varN} {
      error BARF
    }
    method Get {} {return $m_Value}
    method Set {i_value} {set m_Value $i_value}
    typevariable m_decoder -array {
      100 kActionTakeOwnership
      200 kActionConfigurePhysical
      300 kActionApplicationDOD
      310 kActionApplicationDODUnload
      400 kActionConfigureStack
    }
    typevariable m_encoder -array {
      kActionTakeOwnership 100
      kActionConfigurePhysical 200
      kActionApplicationDOD 300
      kActionApplicationDODUnload 310
      kActionConfigureStack 400
    }
    typemethod Symbols {} {array names m_encoder}
    typemethod Symbol {i_val} {return $m_decoder($i_val)}
    typemethod Value {i_sym} {return $m_encoder($i_sym)}
    typemethod _enc_ {i_val} {$i_val _enc_}
    # note: i_lnode is of form {#text NNN}
    typemethod _dec_ {i_context i_type i_lnode i_varN} {
      upvar 1 $i_varN v
      ::AptixiaClient::Core::XPS::_dec_UdtEnum $i_context $i_type $i_lnode v
    }
}
snit::type ::AptixiaClient::GenericTestModel {
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
    component c_Base -public Test -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::Test %AUTO%}
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
    # StringVector
    # eEventType
    # EventData
    # TestInfo
    # eActionBehavior
    # eAction
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
    typevariable _SIG_ImportItsConfig {
        {name itsLines type string direction in}
        {name warningMessages type GenericTestModel.StringVector direction out}
    }
    method ImportItsConfig {
        args
    } {
        $self _mCall $self $_SIG_ImportItsConfig ImportItsConfig args
    }
    typevariable _SIG_GetPluginList {
        {name pluginList type GenericTestModel.StringVector direction out}
    }
    method GetPluginList {
        args
    } {
        $self _mCall $self $_SIG_GetPluginList GetPluginList args
    }
    typevariable _SIG_TestConfigure {
    }
    method TestConfigure {
        args
    } {
        $self _mCall $self $_SIG_TestConfigure TestConfigure args
    }
    typevariable _SIG_TestDeconfigure {
    }
    method TestDeconfigure {
        args
    } {
        $self _mCall $self $_SIG_TestDeconfigure TestDeconfigure args
    }
    typevariable _SIG_TestStart {
    }
    method TestStart {
        args
    } {
        $self _mCall $self $_SIG_TestStart TestStart args
    }
    typevariable _SIG_TestStop {
    }
    method TestStop {
        args
    } {
        $self _mCall $self $_SIG_TestStop TestStop args
    }
    typevariable _SIG_GetTestInfo {
        {name testInfo type GenericTestModel.TestInfo direction out}
    }
    method GetTestInfo {
        args
    } {
        $self _mCall $self $_SIG_GetTestInfo GetTestInfo args
    }
    typevariable _SIG_CreatePortWatch {
        {name newPortWatch type PortWatch direction out}
    }
    method CreatePortWatch {
        args
    } {
        $self _mCall $self $_SIG_CreatePortWatch CreatePortWatch args
    }
    typevariable _SIG_CreateChassisWatch {
        {name newChassisWatch type PortWatch direction out}
    }
    method CreateChassisWatch {
        args
    } {
        $self _mCall $self $_SIG_CreateChassisWatch CreateChassisWatch args
    }
    typevariable _SIG_GetActionBehavior {
        {name action type GenericTestModel.eAction direction in}
        {name behavior type GenericTestModel.eActionBehavior direction out}
    }
    method GetActionBehavior {
        args
    } {
        $self _mCall $self $_SIG_GetActionBehavior GetActionBehavior args
    }
    typevariable _SIG_SetActionBehavior {
        {name action type GenericTestModel.eActionBehavior direction in}
        {name behavior type GenericTestModel.eActionBehavior direction in}
    }
    method SetActionBehavior {
        args
    } {
        $self _mCall $self $_SIG_SetActionBehavior SetActionBehavior args
    }
    typevariable _SIG_SetActionBehaviorForAllActions {
        {name behavior type GenericTestModel.eActionBehavior direction in}
    }
    method SetActionBehaviorForAllActions {
        args
    } {
        $self _mCall $self $_SIG_SetActionBehaviorForAllActions SetActionBehaviorForAllActions args
    }
    #----------------------------------------------------------------------
    # Events
    #----------------------------------------------------------------------
    typevariable _SIG_SystemEvent {
        {name i_eventData type GenericTestModel.EventData direction out}
    }
    method Request_SystemEvent {args} {
        set args [concat -event SystemEvent $args]
        $self _eEvent request $self $_SIG_SystemEvent args
    }
    method Cancel_SystemEvent {requestid args} {
        set args [concat -requestid $requestid -event SystemEvent $args]
        $self _eEvent cancellation $self $_SIG_SystemEvent args
    }
    #----------------------------------------------------------------------
    # Property Declarations
    #----------------------------------------------------------------------
    typevariable _propertyTypes -array {
        rebootPortsBeforeConfigure PropertyBoolean
        testDuration PropertyInt
        checkLinkState PropertyBoolean
        portGroupList PropertyNodeList
        chassisConfig PropertyNode
        statSourcesList PropertyNodeList
        activityModels PropertyNodeList
    }
    #----------------------------------------------------------------------
    # rebootPortsBeforeConfigure (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method rebootPortsBeforeConfigure {args} {$self _mProp $self rebootPortsBeforeConfigure $_propertyTypes(rebootPortsBeforeConfigure) $args}
    method _ctor_rebootPortsBeforeConfigure {args} {}
    method _dtor_rebootPortsBeforeConfigure {args} {}
    #----------------------------------------------------------------------
    # testDuration (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method testDuration {args} {$self _mProp $self testDuration $_propertyTypes(testDuration) $args}
    method _ctor_testDuration {args} {}
    method _dtor_testDuration {args} {}
    #----------------------------------------------------------------------
    # checkLinkState (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method checkLinkState {args} {$self _mProp $self checkLinkState $_propertyTypes(checkLinkState) $args}
    method _ctor_checkLinkState {args} {}
    method _dtor_checkLinkState {args} {}
    #----------------------------------------------------------------------
    # portGroupList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component portGroupList -public portGroupList
    method _ctor_portGroupList {args} {
        set portGroupList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype PortGroup \
            -parent $self \
            -name portGroupList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_portGroupList {args} {catch {$portGroupList destroy}}
    #----------------------------------------------------------------------
    # chassisConfig (PropertyNode)
    # 
    #----------------------------------------------------------------------
    component chassisConfig -public chassisConfig
    method _ctor_chassisConfig {args} {
      set oid [from args -objectid -1]
      set itemtype [from args -itemtype ChassisConfig]
      if {$oid < 0} {
       catch {
        set r [$self _GetPropertyObjectIdAndType chassisConfig]
        set oid [lindex $r 0]; set t [lindex $r 1]
        if {[string length $t]} {set itemtype $t}
       }
      }
      set chassisConfig [${ClientNS}::${itemtype} %AUTO% \
        -objectid $oid \
        -name chassisConfig \
        -transactioncontext $options(-transactioncontext) \
      ]
    }
    method _dtor_chassisConfig {args} {catch {$chassisConfig destroy}}
    #----------------------------------------------------------------------
    # statSourcesList (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component statSourcesList -public statSourcesList
    method _ctor_statSourcesList {args} {
        set statSourcesList [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype GenericStatSource \
            -parent $self \
            -name statSourcesList \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_statSourcesList {args} {catch {$statSourcesList destroy}}
    #----------------------------------------------------------------------
    # activityModels (PropertyNodeList)
    # 
    #----------------------------------------------------------------------
    component activityModels -public activityModels
    method _ctor_activityModels {args} {
        set activityModels [${ClientNS}::Core::PropertyNodeList %AUTO% \
            -itemtype ActivityModelInstance \
            -parent $self \
            -name activityModels \
            -transactioncontext $options(-transactioncontext) \
        ]
    }
    method _dtor_activityModels {args} {catch {$activityModels destroy}}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TenGigabitWANPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TenGigabitWANPlugin {
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
    component c_Base -public CardPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::CardPlugin %AUTO%}
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
        interfaceType PropertyString
        c2Transmit PropertyInt
        c2Expected PropertyInt
        transmitClocking PropertyString
        enableFlowControl PropertyBoolean
        directedAddress PropertyString
        txIgnoresRxLinkFaults PropertyBoolean
    }
    #----------------------------------------------------------------------
    # interfaceType (PropertyString)
    # 
    #----------------------------------------------------------------------
    method interfaceType {args} {$self _mProp $self interfaceType $_propertyTypes(interfaceType) $args}
    method _ctor_interfaceType {args} {}
    method _dtor_interfaceType {args} {}
    #----------------------------------------------------------------------
    # c2Transmit (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method c2Transmit {args} {$self _mProp $self c2Transmit $_propertyTypes(c2Transmit) $args}
    method _ctor_c2Transmit {args} {}
    method _dtor_c2Transmit {args} {}
    #----------------------------------------------------------------------
    # c2Expected (PropertyInt)
    # 
    #----------------------------------------------------------------------
    method c2Expected {args} {$self _mProp $self c2Expected $_propertyTypes(c2Expected) $args}
    method _ctor_c2Expected {args} {}
    method _dtor_c2Expected {args} {}
    #----------------------------------------------------------------------
    # transmitClocking (PropertyString)
    # 
    #----------------------------------------------------------------------
    method transmitClocking {args} {$self _mProp $self transmitClocking $_propertyTypes(transmitClocking) $args}
    method _ctor_transmitClocking {args} {}
    method _dtor_transmitClocking {args} {}
    #----------------------------------------------------------------------
    # enableFlowControl (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableFlowControl {args} {$self _mProp $self enableFlowControl $_propertyTypes(enableFlowControl) $args}
    method _ctor_enableFlowControl {args} {}
    method _dtor_enableFlowControl {args} {}
    #----------------------------------------------------------------------
    # directedAddress (PropertyString)
    # 
    #----------------------------------------------------------------------
    method directedAddress {args} {$self _mProp $self directedAddress $_propertyTypes(directedAddress) $args}
    method _ctor_directedAddress {args} {}
    method _dtor_directedAddress {args} {}
    #----------------------------------------------------------------------
    # txIgnoresRxLinkFaults (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method txIgnoresRxLinkFaults {args} {$self _mProp $self txIgnoresRxLinkFaults $_propertyTypes(txIgnoresRxLinkFaults) $args}
    method _ctor_txIgnoresRxLinkFaults {args} {}
    method _dtor_txIgnoresRxLinkFaults {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


#----------------------------------------------------------------------
# ..\..\data\metaschemas/TenGigabitLANPlugin.xml
#----------------------------------------------------------------------
snit::type ::AptixiaClient::TenGigabitLANPlugin {
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
    component c_Base -public CardPlugin -inherit true
    #delegate option * to c_Base; delegate method * to c_Base
    #
    # constructor and destructor related code
    #
    constructor {args} {
        $self configurelist $args
        set cmd {::AptixiaClient::CardPlugin %AUTO%}
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
        enableFlowControl PropertyBoolean
        directedAddress PropertyString
        txIgnoresRxLinkFaults PropertyBoolean
        transmitClocking PropertyString
        recoveredClock PropertyBoolean
        laserOn PropertyBoolean
    }
    #----------------------------------------------------------------------
    # enableFlowControl (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method enableFlowControl {args} {$self _mProp $self enableFlowControl $_propertyTypes(enableFlowControl) $args}
    method _ctor_enableFlowControl {args} {}
    method _dtor_enableFlowControl {args} {}
    #----------------------------------------------------------------------
    # directedAddress (PropertyString)
    # 
    #----------------------------------------------------------------------
    method directedAddress {args} {$self _mProp $self directedAddress $_propertyTypes(directedAddress) $args}
    method _ctor_directedAddress {args} {}
    method _dtor_directedAddress {args} {}
    #----------------------------------------------------------------------
    # txIgnoresRxLinkFaults (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method txIgnoresRxLinkFaults {args} {$self _mProp $self txIgnoresRxLinkFaults $_propertyTypes(txIgnoresRxLinkFaults) $args}
    method _ctor_txIgnoresRxLinkFaults {args} {}
    method _dtor_txIgnoresRxLinkFaults {args} {}
    #----------------------------------------------------------------------
    # transmitClocking (PropertyString)
    # 
    #----------------------------------------------------------------------
    method transmitClocking {args} {$self _mProp $self transmitClocking $_propertyTypes(transmitClocking) $args}
    method _ctor_transmitClocking {args} {}
    method _dtor_transmitClocking {args} {}
    #----------------------------------------------------------------------
    # recoveredClock (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method recoveredClock {args} {$self _mProp $self recoveredClock $_propertyTypes(recoveredClock) $args}
    method _ctor_recoveredClock {args} {}
    method _dtor_recoveredClock {args} {}
    #----------------------------------------------------------------------
    # laserOn (PropertyBoolean)
    # 
    #----------------------------------------------------------------------
    method laserOn {args} {$self _mProp $self laserOn $_propertyTypes(laserOn) $args}
    method _ctor_laserOn {args} {}
    method _dtor_laserOn {args} {}
    
    #----------------------------------------------------------------------
    # END
    #----------------------------------------------------------------------
}


