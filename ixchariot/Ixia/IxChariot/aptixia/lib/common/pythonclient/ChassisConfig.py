import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import Chassis


class ChassisConfig( XProtocolObject.XProtocolObject ):
	""" ChassisConfig object provides services to obtain Chassis and port configuration information,perform certain functions on the ports like takeOwnership, reboot port cpu etc.,, andconfigure port's layer1 parameters. """
	# Enums
	class eLinkState (Aptixia.IxEnum):
		kLinkUp = 0
		kLinkLoopBack = 1
		kLinkPPPUp = 2
		kLinkDown = 3
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.eLinkState"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eLayer1Type (Aptixia.IxEnum):
		kLayer1GenericType = 0
		kBasicEthernetGenericType = 1
		kEthernetFiberType = 2
		kEthernetFiberOnlyType = 3
		kEthernetGenericType = 4
		kEthernetELMType = 5
		kEthernetDualPhyType = 6
		kGigabitEthernetGenericType = 7
		kGigabitXAUIType = 8
		kGigabitXenPakType = 9
		kFiberGenericType = 10
		kATMGenericType = 11
		kPOSGenericType = 12
		kTenGigabitWANType = 13
		kTenGigabitLANType = 14
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.eLayer1Type"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eFileFormat (Aptixia.IxEnum):
		kTxtFormat = 0
		kCapFormat = 1
		kEncFormat = 2
		kEncOldFormat = 3
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.eFileFormat"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eTimeSource (Aptixia.IxEnum):
		kInternal = 0
		kGpsServer = 1
		kCdma = 2
		kGpsAfd1Server = 3
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.eTimeSource"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class ePortAttribute (Aptixia.IxEnum):
		kControlData = 0
		kPacketGroup = 1
		kDataCaptureCapability = 2
		kMediaType = 3
		kCardMode = 4
		kSpeed = 5
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.ePortAttribute"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class ePortCapabilityValues (Aptixia.IxEnum):
		kControl = 0
		kData = 1
		kRegularPacketGroup = 2
		kWidePacketGroup = 3
		kDataCaptureCapable = 4
		kCopper = 5
		kFiber = 6
		kGenericEthernetMode = 7
		kTenGigLANMode = 8
		kTenGigWANMode = 9
		kATMMode = 10
		kPOSMode = 11
		kOC48POSMode = 12
		kOC192POSMode = 13
		kHalf10 = 14
		kFull10 = 15
		kHalf100 = 16
		kFull100 = 17
		kFull1000 = 18
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ChassisConfig.ePortCapabilityValues"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class PortAddressVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.PortAddress")
		if "ChassisConfig.PortAddressVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.PortAddressVector" )
		def getType():
			return "ChassisConfig.PortAddressVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.PortAddress"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.PortAddress
		getElementClass = staticmethod(getElementClass)
	class Layer1TypeList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.eLayer1Type")
		if "ChassisConfig.Layer1TypeList" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.Layer1TypeList" )
		def getType():
			return "ChassisConfig.Layer1TypeList"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.eLayer1Type"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.eLayer1Type
		getElementClass = staticmethod(getElementClass)
	class PortVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.Port")
		if "ChassisConfig.PortVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.PortVector" )
		def getType():
			return "ChassisConfig.PortVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.Port"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.Port
		getElementClass = staticmethod(getElementClass)
	class CardVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.Card")
		if "ChassisConfig.CardVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.CardVector" )
		def getType():
			return "ChassisConfig.CardVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.Card"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.Card
		getElementClass = staticmethod(getElementClass)
	class StringVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "ChassisConfig.StringVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.StringVector" )
		def getType():
			return "ChassisConfig.StringVector"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class Layer1ConfigVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.Layer1")
		if "ChassisConfig.Layer1ConfigVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.Layer1ConfigVector" )
		def getType():
			return "ChassisConfig.Layer1ConfigVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.Layer1"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.Layer1
		getElementClass = staticmethod(getElementClass)
	class PackagePortVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.PackagePort")
		if "ChassisConfig.PackagePortVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.PackagePortVector" )
		def getType():
			return "ChassisConfig.PackagePortVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.PackagePort"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.PackagePort
		getElementClass = staticmethod(getElementClass)
	class LongVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int32")
		if "ChassisConfig.LongVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.LongVector" )
		def getType():
			return "ChassisConfig.LongVector"
		getType = staticmethod(getType)
		def getElementType():
			return "int32"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class BoolVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "bool")
		if "ChassisConfig.BoolVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.BoolVector" )
		def getType():
			return "ChassisConfig.BoolVector"
		getType = staticmethod(getType)
		def getElementType():
			return "bool"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class SeqNicVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.ChNic")
		if "ChassisConfig.SeqNicVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.SeqNicVector" )
		def getType():
			return "ChassisConfig.SeqNicVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.ChNic"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.ChNic
		getElementClass = staticmethod(getElementClass)
	class SeqNicAddressVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.ChNicAddress")
		if "ChassisConfig.SeqNicAddressVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.SeqNicAddressVector" )
		def getType():
			return "ChassisConfig.SeqNicAddressVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.ChNicAddress"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.ChNicAddress
		getElementClass = staticmethod(getElementClass)
	class CapabilityMatrixVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.CapabilityMatrix")
		if "ChassisConfig.CapabilityMatrixVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.CapabilityMatrixVector" )
		def getType():
			return "ChassisConfig.CapabilityMatrixVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.CapabilityMatrix"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.CapabilityMatrix
		getElementClass = staticmethod(getElementClass)
	class PortAddressWithPropertiesVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.PortAddressWithProperties")
		if "ChassisConfig.PortAddressWithPropertiesVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.PortAddressWithPropertiesVector" )
		def getType():
			return "ChassisConfig.PortAddressWithPropertiesVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.PortAddressWithProperties"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.PortAddressWithProperties
		getElementClass = staticmethod(getElementClass)
	class PortCapabilityEnumVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.ePortCapabilityValues")
		if "ChassisConfig.PortCapabilityEnumVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.PortCapabilityEnumVector" )
		def getType():
			return "ChassisConfig.PortCapabilityEnumVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.ePortCapabilityValues"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.ePortCapabilityValues
		getElementClass = staticmethod(getElementClass)
	class CPDNicAddressVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ChassisConfig.CPDNicAddress")
		if "ChassisConfig.CPDNicAddressVector" not in Aptixia.lists:
			Aptixia.lists.append( "ChassisConfig.CPDNicAddressVector" )
		def getType():
			return "ChassisConfig.CPDNicAddressVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ChassisConfig.CPDNicAddress"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ChassisConfig.CPDNicAddress
		getElementClass = staticmethod(getElementClass)

	# Structs
	class PortAddress( Aptixia.IxStruct ):
		""" Structure to hold information about the complete address of a port in a chassis. """
		if "ChassisConfig.PortAddress" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.PortAddress")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassisHostName = ""
			self.cardId = 0
			self.portId = 0
			self._version = "1"
			self._types = { "chassisHostName":"string",
				 "cardId":"int32",
				 "portId":"int32" }
		def getType( self ):
			return "ChassisConfig.PortAddress"

	class Port( Aptixia.IxStruct ):
		""" Structure to hold information about a port. """
		if "ChassisConfig.Port" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.Port")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.portAddr = ChassisConfig.PortAddress()
			self.typeName = ""
			self.owner = ""
			self.linkSt = ChassisConfig.eLinkState()
			self.speed = 0
			self.duplex = 0
			self.uniquePortNo = ""
			self.layer1Class = ""
			self.allowedLayer1Type = ChassisConfig.Layer1TypeList()
			self._version = "1"
			self._types = { "portAddr":"ChassisConfig.PortAddress",
				 "typeName":"string",
				 "owner":"string",
				 "linkSt":"ChassisConfig.eLinkState",
				 "speed":"int32",
				 "duplex":"int32",
				 "uniquePortNo":"string",
				 "layer1Class":"string",
				 "allowedLayer1Type":"ChassisConfig.Layer1TypeList" }
		def getType( self ):
			return "ChassisConfig.Port"

	class Card( Aptixia.IxStruct ):
		""" Structure to hold information about a card in a chassis. """
		if "ChassisConfig.Card" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.Card")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.cardId = 0
			self.typeName = ""
			self.cardVersion = 0
			self.fpgaVersion = 0
			self.portVector = ChassisConfig.PortVector()
			self._version = "1"
			self._types = { "cardId":"int32",
				 "typeName":"string",
				 "cardVersion":"int32",
				 "fpgaVersion":"int32",
				 "portVector":"ChassisConfig.PortVector" }
		def getType( self ):
			return "ChassisConfig.Card"

	class XPChassis( Aptixia.IxStruct ):
		""" Structure to hold the complete information about a Chassis. """
		if "ChassisConfig.XPChassis" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.XPChassis")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassisId = 0
			self.chassisName = ""
			self.managementIp = ""
			self.typeName = ""
			self.sequenceNumber = 0
			self.cardVector = ChassisConfig.CardVector()
			self.master = False
			self._version = "1"
			self._types = { "chassisId":"int32",
				 "chassisName":"string",
				 "managementIp":"string",
				 "typeName":"string",
				 "sequenceNumber":"int32",
				 "cardVector":"ChassisConfig.CardVector",
				 "master":"bool" }
		def getType( self ):
			return "ChassisConfig.XPChassis"

	class XPChassis2( Aptixia.IxStruct ):
		""" Structure to hold the complete information about a Chassis. """
		if "ChassisConfig.XPChassis2" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.XPChassis2")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassisId = 0
			self.chassisName = ""
			self.managementIp = ""
			self.typeName = ""
			self.sequenceNumber = 0
			self.cardVector = ChassisConfig.CardVector()
			self.master = False
			self.cableLength = 0
			self.timeSource = ChassisConfig.eTimeSource()
			self._version = "1"
			self._types = { "chassisId":"int32",
				 "chassisName":"string",
				 "managementIp":"string",
				 "typeName":"string",
				 "sequenceNumber":"int32",
				 "cardVector":"ChassisConfig.CardVector",
				 "master":"bool",
				 "cableLength":"int32",
				 "timeSource":"ChassisConfig.eTimeSource" }
		def getType( self ):
			return "ChassisConfig.XPChassis2"

	class Layer1( Aptixia.IxStruct ):
		""" Structure to hold information to set Layer1 information for the chassis. """
		if "ChassisConfig.Layer1" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.Layer1")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassisHostName = ""
			self.xml = ""
			self._version = "1"
			self._types = { "chassisHostName":"string",
				 "xml":"string" }
		def getType( self ):
			return "ChassisConfig.Layer1"

	class PackagePort( Aptixia.IxStruct ):
		""" Structure to hold information on Dod packages to download and the ports to download to.. """
		if "ChassisConfig.PackagePort" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.PackagePort")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.portAddr = ChassisConfig.PortAddress()
			self.packages = ChassisConfig.StringVector()
			self._version = "1"
			self._types = { "portAddr":"ChassisConfig.PortAddress",
				 "packages":"ChassisConfig.StringVector" }
		def getType( self ):
			return "ChassisConfig.PackagePort"

	class ChNicAddress( Aptixia.IxStruct ):
		""" Struct to represent Nic Address """
		if "ChassisConfig.ChNicAddress" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.ChNicAddress")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassisIp = ""
			self.cardId = 0
			self.portId = 0
			self.nicId = 0
			self._version = "1"
			self._types = { "chassisIp":"string",
				 "cardId":"int32",
				 "portId":"int32",
				 "nicId":"int32" }
		def getType( self ):
			return "ChassisConfig.ChNicAddress"

	class ChNic( Aptixia.IxStruct ):
		""" Struct representing a NIC """
		if "ChassisConfig.ChNic" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.ChNic")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.nicAddress = ChassisConfig.ChNicAddress()
			self.typeName = ""
			self.linkState = 0
			self.speed = 0
			self.duplex = 0
			self.physicalType = ChassisConfig.eLayer1Type()
			self._version = "1"
			self._types = { "nicAddress":"ChassisConfig.ChNicAddress",
				 "typeName":"string",
				 "linkState":"int32",
				 "speed":"int32",
				 "duplex":"int32",
				 "physicalType":"ChassisConfig.eLayer1Type" }
		def getType( self ):
			return "ChassisConfig.ChNic"

	class CapabilityMatrix( Aptixia.IxStruct ):
		""" Structure containing an enumerator denoting a particular kind of capability and a boolean that is true if theport has that capability. For example if the enum if kFiber and boolean is true it means the port supports fiber mode. """
		if "ChassisConfig.CapabilityMatrix" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.CapabilityMatrix")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.portAttrib = ChassisConfig.ePortCapabilityValues()
			self.featureCapability = False
			self._version = "1"
			self._types = { "portAttrib":"ChassisConfig.ePortCapabilityValues",
				 "featureCapability":"bool" }
		def getType( self ):
			return "ChassisConfig.CapabilityMatrix"

	class PortAddressWithProperties( Aptixia.IxStruct ):
		""" Structure representing the capability values of one port. """
		if "ChassisConfig.PortAddressWithProperties" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.PortAddressWithProperties")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.cardID = 0
			self.portID = 0
			self.capabilityVector = ChassisConfig.CapabilityMatrixVector()
			self._version = "1"
			self._types = { "cardID":"int32",
				 "portID":"int32",
				 "capabilityVector":"ChassisConfig.CapabilityMatrixVector" }
		def getType( self ):
			return "ChassisConfig.PortAddressWithProperties"

	class CPDNicAddress( Aptixia.IxStruct ):
		""" Struct representing a NIC """
		if "ChassisConfig.CPDNicAddress" not in Aptixia.structs:
			Aptixia.structs.append("ChassisConfig.CPDNicAddress")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.machineIp = ""
			self.nicId = 0
			self._version = "1"
			self._types = { "machineIp":"string",
				 "nicId":"int32" }
		def getType( self ):
			return "ChassisConfig.CPDNicAddress"


	# Class Properties
	def _get_chassisChain (self):
		return self.getListVar ("chassisChain")
	chassisChain = property (_get_chassisChain, None, None, "chassisChain property")
	def _get_useConfigLayerV2 (self):
		return self.getVar ("useConfigLayerV2")
	def _set_useConfigLayerV2 (self, value):
		self.setVar ("useConfigLayerV2", value)
	useConfigLayerV2 = property (_get_useConfigLayerV2, _set_useConfigLayerV2, None, "useConfigLayerV2 property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ChassisConfig, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["chassisChain"] = Aptixia.IxObjectList (self.transactionContext, "Chassis")
			self.managedProperties["useConfigLayerV2"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ChassisConfig"

	# Class Methods
	def EstablishConnection( self, chassisHostName, callback = None, callbackArg = None ):
		""" Make a connection to the hardware manager.
			chassisHostName: List of ports of which to take ownership.
			Returns retval: List of ports of which to take ownership. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EstablishConnection", argTuple, callback, callbackArg )
	def EstablishConnection_Sync( self, chassisHostName ):
		""" Make a connection to the hardware manager.
			chassisHostName: List of ports of which to take ownership.
			Returns retval: List of ports of which to take ownership. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EstablishConnection", argTuple)
		return context.Sync()

	def TakeOwnership( self, ports, forced, callback = None, callbackArg = None ):
		""" -deprecated- Take the ownership( optionally can force the taking of ownership)of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TakeOwnership", argTuple, callback, callbackArg )
	def TakeOwnership_Sync( self, ports, forced ):
		""" -deprecated- Take the ownership( optionally can force the taking of ownership)of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TakeOwnership", argTuple)
		return context.Sync()

	def ClearOwnership( self, ports, forced, callback = None, callbackArg = None ):
		""" -deprecated- Clear the ownership( optionally can force the clearing of ownership)of a set of ports.
			ports: List of ports of which to clear ownership.
			forced: Whether ownership should be force cleared. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearOwnership", argTuple, callback, callbackArg )
	def ClearOwnership_Sync( self, ports, forced ):
		""" -deprecated- Clear the ownership( optionally can force the clearing of ownership)of a set of ports.
			ports: List of ports of which to clear ownership.
			forced: Whether ownership should be force cleared. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearOwnership", argTuple)
		return context.Sync()

	def TakeOwnership_V2( self, ports, forced, callback = None, callbackArg = None ):
		""" Take the ownership( optionally can force the taking of ownership) of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced.
			Returns portsFailed: List of ports that could not be taken. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TakeOwnership_V2", argTuple, callback, callbackArg )
	def TakeOwnership_V2_Sync( self, ports, forced ):
		""" Take the ownership( optionally can force the taking of ownership) of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced.
			Returns portsFailed: List of ports that could not be taken. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TakeOwnership_V2", argTuple)
		return context.Sync()

	def ClearOwnership_V2( self, ports, forced, callback = None, callbackArg = None ):
		""" Take the ownership( optionally can force the taking of ownership)of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced.
			Returns portsFailed: List of ports that could not be cleared. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearOwnership_V2", argTuple, callback, callbackArg )
	def ClearOwnership_V2_Sync( self, ports, forced ):
		""" Take the ownership( optionally can force the taking of ownership)of a set of ports.
			ports: List of ports of which to take ownership.
			forced: Whether ownership should be taken forced.
			Returns portsFailed: List of ports that could not be cleared. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "forced", forced, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearOwnership_V2", argTuple)
		return context.Sync()

	def GetPortInformation( self, ports, callback = None, callbackArg = None ):
		""" Get the current port information such as speed, link state etc., for a set of ports.
			ports: Set of ports to get information.
			Returns portInfo: Reference to the port info structure. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portInfo", None, "out", "ChassisConfig.PortVector", ChassisConfig.PortVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortInformation", argTuple, callback, callbackArg )
	def GetPortInformation_Sync( self, ports ):
		""" Get the current port information such as speed, link state etc., for a set of ports.
			ports: Set of ports to get information.
			Returns portInfo: Reference to the port info structure. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portInfo", None, "out", "ChassisConfig.PortVector", ChassisConfig.PortVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortInformation", argTuple)
		return context.Sync()

	def ResetPortCpu( self, ports, callback = None, callbackArg = None ):
		""" Reboot the port CPU
			ports: Set of ports to reboot. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResetPortCpu", argTuple, callback, callbackArg )
	def ResetPortCpu_Sync( self, ports ):
		""" Reboot the port CPU
			ports: Set of ports to reboot. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResetPortCpu", argTuple)
		return context.Sync()

	def ResetPortCpu_V2( self, ports, callback = None, callbackArg = None ):
		""" Reboot the port CPU
			ports: Set of ports to reboot.
			Returns portsFailed: List of ports that failed to reboot. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResetPortCpu_V2", argTuple, callback, callbackArg )
	def ResetPortCpu_V2_Sync( self, ports ):
		""" Reboot the port CPU
			ports: Set of ports to reboot.
			Returns portsFailed: List of ports that failed to reboot. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResetPortCpu_V2", argTuple)
		return context.Sync()

	def SetFactoryDefaults( self, ports, callback = None, callbackArg = None ):
		""" Set the settings on the ports back to what was in factory defaults.
			ports: Set of Ports to set the factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaults", argTuple, callback, callbackArg )
	def SetFactoryDefaults_Sync( self, ports ):
		""" Set the settings on the ports back to what was in factory defaults.
			ports: Set of Ports to set the factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaults", argTuple)
		return context.Sync()

	def SetFactoryDefaults_V2( self, ports, callback = None, callbackArg = None ):
		""" Set the settings on the ports back to what was in factory defaults.
			ports: Set of Ports to set the factory defaults.
			Returns portsFailed: List of ports that failed to set to factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaults_V2", argTuple, callback, callbackArg )
	def SetFactoryDefaults_V2_Sync( self, ports ):
		""" Set the settings on the ports back to what was in factory defaults.
			ports: Set of Ports to set the factory defaults.
			Returns portsFailed: List of ports that failed to set to factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaults_V2", argTuple)
		return context.Sync()

	def SetModeDefaults( self, ports, callback = None, callbackArg = None ):
		""" Set the settings on the ports back to what was in mode defaults.
			ports: Set of Ports to set the factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetModeDefaults", argTuple, callback, callbackArg )
	def SetModeDefaults_Sync( self, ports ):
		""" Set the settings on the ports back to what was in mode defaults.
			ports: Set of Ports to set the factory defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetModeDefaults", argTuple)
		return context.Sync()

	def SetModeDefaults_V2( self, ports, callback = None, callbackArg = None ):
		""" Set the settings on the ports back to what was in mode defaults.
			ports: Set of Ports to set the mode defaults.
			Returns portsFailed: List of ports that failed to set to mode defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetModeDefaults_V2", argTuple, callback, callbackArg )
	def SetModeDefaults_V2_Sync( self, ports ):
		""" Set the settings on the ports back to what was in mode defaults.
			ports: Set of Ports to set the mode defaults.
			Returns portsFailed: List of ports that failed to set to mode defaults. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetModeDefaults_V2", argTuple)
		return context.Sync()

	def ConfigurePhysical( self, ports, xml, callback = None, callbackArg = None ):
		""" Configure layer1 information on the ports.
			ports: Ports to write the changes to.
			xml: The string containing the xml data. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysical", argTuple, callback, callbackArg )
	def ConfigurePhysical_Sync( self, ports, xml ):
		""" Configure layer1 information on the ports.
			ports: Ports to write the changes to.
			xml: The string containing the xml data. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysical", argTuple)
		return context.Sync()

	def SetBaseAddress( self, chassisHostName, baseIpAddress, callback = None, callbackArg = None ):
		""" Method to set the base management ip address used for the ports.
			chassisHostName: DNS name of the chassis.
			baseIpAddress: Base IP address to set to. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "baseIpAddress", baseIpAddress, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetBaseAddress", argTuple, callback, callbackArg )
	def SetBaseAddress_Sync( self, chassisHostName, baseIpAddress ):
		""" Method to set the base management ip address used for the ports.
			chassisHostName: DNS name of the chassis.
			baseIpAddress: Base IP address to set to. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "baseIpAddress", baseIpAddress, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetBaseAddress", argTuple)
		return context.Sync()

	def WriteChangesToPort( self, ports, callback = None, callbackArg = None ):
		""" Method to enforce changes on the IxServer after making changes to a port via the chPort structure.
			ports: Ports to write the changes to. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "WriteChangesToPort", argTuple, callback, callbackArg )
	def WriteChangesToPort_Sync( self, ports ):
		""" Method to enforce changes on the IxServer after making changes to a port via the chPort structure.
			ports: Ports to write the changes to. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "WriteChangesToPort", argTuple)
		return context.Sync()

	def ClearPcpuGrpTimeStamp( self, chassisHostName, callback = None, callbackArg = None ):
		""" Method to synchronize the time stamp on ports even within a chassis.
			chassisHostName: Dns name or IP address of the Chassis. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearPcpuGrpTimeStamp", argTuple, callback, callbackArg )
	def ClearPcpuGrpTimeStamp_Sync( self, chassisHostName ):
		""" Method to synchronize the time stamp on ports even within a chassis.
			chassisHostName: Dns name or IP address of the Chassis. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearPcpuGrpTimeStamp", argTuple)
		return context.Sync()

	def StartCapture( self, ports, callback = None, callbackArg = None ):
		""" Method to start capture on ports.
			ports: Set of ports to start capture """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartCapture", argTuple, callback, callbackArg )
	def StartCapture_Sync( self, ports ):
		""" Method to start capture on ports.
			ports: Set of ports to start capture """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartCapture", argTuple)
		return context.Sync()

	def StopCapture( self, ports, callback = None, callbackArg = None ):
		""" Method to stop capture on ports.
			ports: Set of ports to stop capture """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopCapture", argTuple, callback, callbackArg )
	def StopCapture_Sync( self, ports ):
		""" Method to stop capture on ports.
			ports: Set of ports to stop capture """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopCapture", argTuple)
		return context.Sync()

	def StartTransmit( self, ports, callback = None, callbackArg = None ):
		""" Method to start transmsit.
			ports: Set of ports to start transmit. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTransmit", argTuple, callback, callbackArg )
	def StartTransmit_Sync( self, ports ):
		""" Method to start transmsit.
			ports: Set of ports to start transmit. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTransmit", argTuple)
		return context.Sync()

	def StopTransmit( self, ports, callback = None, callbackArg = None ):
		""" Method to stop transmsit.
			ports: Set of ports to stop transmit. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopTransmit", argTuple, callback, callbackArg )
	def StopTransmit_Sync( self, ports ):
		""" Method to stop transmsit.
			ports: Set of ports to stop transmit. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopTransmit", argTuple)
		return context.Sync()

	def StartLatency( self, ports, callback = None, callbackArg = None ):
		""" Method to start latency on ports.
			ports: Set of ports to start latency """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartLatency", argTuple, callback, callbackArg )
	def StartLatency_Sync( self, ports ):
		""" Method to start latency on ports.
			ports: Set of ports to start latency """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartLatency", argTuple)
		return context.Sync()

	def StopLatency( self, ports, callback = None, callbackArg = None ):
		""" Method to stop latency on ports.
			ports: Set of ports to stop latency """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopLatency", argTuple, callback, callbackArg )
	def StopLatency_Sync( self, ports ):
		""" Method to stop latency on ports.
			ports: Set of ports to stop latency """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopLatency", argTuple)
		return context.Sync()

	def ClearTimeStamp( self, ports, callback = None, callbackArg = None ):
		""" Method to clear all time stamps in order to synchronize the time stamps throughout the chassis chain.
			ports: Set of ports to clear the timestamps. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearTimeStamp", argTuple, callback, callbackArg )
	def ClearTimeStamp_Sync( self, ports ):
		""" Method to clear all time stamps in order to synchronize the time stamps throughout the chassis chain.
			ports: Set of ports to clear the timestamps. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearTimeStamp", argTuple)
		return context.Sync()

	def SwitchToCapture( self, ports, callback = None, callbackArg = None ):
		""" Method to switch the ports to capture mode.
			ports: Set of ports to switch to capture mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToCapture", argTuple, callback, callbackArg )
	def SwitchToCapture_Sync( self, ports ):
		""" Method to switch the ports to capture mode.
			ports: Set of ports to switch to capture mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToCapture", argTuple)
		return context.Sync()

	def SwitchToPacketGroup( self, ports, callback = None, callbackArg = None ):
		""" Method to switch the ports to packet groups mode.
			ports: Set of ports to switch to packet groups mode.
			Returns portsFailed: List of ports that failed to switch to packets . """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToPacketGroup", argTuple, callback, callbackArg )
	def SwitchToPacketGroup_Sync( self, ports ):
		""" Method to switch the ports to packet groups mode.
			ports: Set of ports to switch to packet groups mode.
			Returns portsFailed: List of ports that failed to switch to packets . """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToPacketGroup", argTuple)
		return context.Sync()

	def SwitchToWidePacketGroup( self, ports, callback = None, callbackArg = None ):
		""" Method to switch the ports to wide packet groups mode.
			ports: Set of ports to switch to wide packet groups mode.
			Returns portsFailed: List of ports that failed to switch to wide packets. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToWidePacketGroup", argTuple, callback, callbackArg )
	def SwitchToWidePacketGroup_Sync( self, ports ):
		""" Method to switch the ports to wide packet groups mode.
			ports: Set of ports to switch to wide packet groups mode.
			Returns portsFailed: List of ports that failed to switch to wide packets. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToWidePacketGroup", argTuple)
		return context.Sync()

	def SwitchToPacketStreams( self, ports, callback = None, callbackArg = None ):
		""" Method to switch the ports to packet streams mode.
			ports: Set of ports to switch to packet streams mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToPacketStreams", argTuple, callback, callbackArg )
	def SwitchToPacketStreams_Sync( self, ports ):
		""" Method to switch the ports to packet streams mode.
			ports: Set of ports to switch to packet streams mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToPacketStreams", argTuple)
		return context.Sync()

	def SwitchToAdvancedScheduler( self, ports, callback = None, callbackArg = None ):
		""" Method to switch to advanced streams scheduler mode.
			ports: Set of ports to switch to advanced streams scheduler mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToAdvancedScheduler", argTuple, callback, callbackArg )
	def SwitchToAdvancedScheduler_Sync( self, ports ):
		""" Method to switch to advanced streams scheduler mode.
			ports: Set of ports to switch to advanced streams scheduler mode. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SwitchToAdvancedScheduler", argTuple)
		return context.Sync()

	def SimulateLinkState( self, ports, linkStateUp, callback = None, callbackArg = None ):
		""" Method to simulate the link (up and down).
			ports: Set of ports to simulate the link.
			linkStateUp: TRUE if you want to have the link up and FALSE if simulate cable disconnect """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "linkStateUp", linkStateUp, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SimulateLinkState", argTuple, callback, callbackArg )
	def SimulateLinkState_Sync( self, ports, linkStateUp ):
		""" Method to simulate the link (up and down).
			ports: Set of ports to simulate the link.
			linkStateUp: TRUE if you want to have the link up and FALSE if simulate cable disconnect """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "linkStateUp", linkStateUp, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SimulateLinkState", argTuple)
		return context.Sync()

	def SetCaptureFile( self, port, numPackets, exportFileName, callback = None, callbackArg = None ):
		""" Method to write the capture buffer to a file.
			port: the port.
			numPackets: Number of packets to retrieve.
			exportFileName: File name of the exported file capture buffer. """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "numPackets", numPackets, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "exportFileName", exportFileName, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCaptureFile", argTuple, callback, callbackArg )
	def SetCaptureFile_Sync( self, port, numPackets, exportFileName ):
		""" Method to write the capture buffer to a file.
			port: the port.
			numPackets: Number of packets to retrieve.
			exportFileName: File name of the exported file capture buffer. """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "numPackets", numPackets, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "exportFileName", exportFileName, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCaptureFile", argTuple)
		return context.Sync()

	def SetCaptureFile_V2( self, port, numPackets, fileFormat, callback = None, callbackArg = None ):
		""" Method to write the capture buffer to a file.
			port: the port.
			numPackets: Number of packets to retrieve.
			fileFormat: Format of the file.
			Returns outFile: file on the client with capture buffer """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "numPackets", numPackets, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "fileFormat", fileFormat, "in", "ChassisConfig.eFileFormat", ChassisConfig.eFileFormat)
		arg3 = Aptixia_prv.MethodArgument( "outFile", None, "out", "file", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCaptureFile_V2", argTuple, callback, callbackArg )
	def SetCaptureFile_V2_Sync( self, port, numPackets, fileFormat ):
		""" Method to write the capture buffer to a file.
			port: the port.
			numPackets: Number of packets to retrieve.
			fileFormat: Format of the file.
			Returns outFile: file on the client with capture buffer """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "numPackets", numPackets, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "fileFormat", fileFormat, "in", "ChassisConfig.eFileFormat", ChassisConfig.eFileFormat)
		arg3 = Aptixia_prv.MethodArgument( "outFile", None, "out", "file", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCaptureFile_V2", argTuple)
		return context.Sync()

	def ImportPrtFile_V2( self, ports, inFile, callback = None, callbackArg = None ):
		""" Method to import a port configuration to a list of ports.
			ports: Set of ports to import the file.
			inFile: file port configuration """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "inFile", inFile, "in", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportPrtFile_V2", argTuple, callback, callbackArg )
	def ImportPrtFile_V2_Sync( self, ports, inFile ):
		""" Method to import a port configuration to a list of ports.
			ports: Set of ports to import the file.
			inFile: file port configuration """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "inFile", inFile, "in", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportPrtFile_V2", argTuple)
		return context.Sync()

	def GetPortMemory( self, port, callback = None, callbackArg = None ):
		""" Method for getting the memory of a port.
			port: the port.
			Returns mbytes: number of Mbytes of the CPU port. """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "mbytes", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortMemory", argTuple, callback, callbackArg )
	def GetPortMemory_Sync( self, port ):
		""" Method for getting the memory of a port.
			port: the port.
			Returns mbytes: number of Mbytes of the CPU port. """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "mbytes", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortMemory", argTuple)
		return context.Sync()

	def GetMemory( self, ports, callback = None, callbackArg = None ):
		""" Method for getting the memory of a list of port.
			ports: Set of ports to switch to advanced streams scheduler mode.
			Returns mbytesVector: list of number of Mbytes of the CPU ports. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "mbytesVector", None, "out", "ChassisConfig.LongVector", ChassisConfig.LongVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetMemory", argTuple, callback, callbackArg )
	def GetMemory_Sync( self, ports ):
		""" Method for getting the memory of a list of port.
			ports: Set of ports to switch to advanced streams scheduler mode.
			Returns mbytesVector: list of number of Mbytes of the CPU ports. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "mbytesVector", None, "out", "ChassisConfig.LongVector", ChassisConfig.LongVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetMemory", argTuple)
		return context.Sync()

	def FileBeginDownLoad( self, filename, callback = None, callbackArg = None ):
		""" Method to signify beginning upload a File to the test server.This method must be used in conjunction withFileUploadSegment and FileEndDonwload.
			filename: Name of the file.
			Returns sessionId: Session ID for upload the fileto tgest server. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "sessionId", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileBeginDownLoad", argTuple, callback, callbackArg )
	def FileBeginDownLoad_Sync( self, filename ):
		""" Method to signify beginning upload a File to the test server.This method must be used in conjunction withFileUploadSegment and FileEndDonwload.
			filename: Name of the file.
			Returns sessionId: Session ID for upload the fileto tgest server. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "sessionId", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileBeginDownLoad", argTuple)
		return context.Sync()

	def FileUploadSegment( self, sessionID, segment, callback = None, callbackArg = None ):
		""" Method to upload a segment to testServer. This method must be called using the sessionID obtained by a call toFileBeginDownload methof.
			sessionID: The session ID for the upload.
			segment: The bytes containing the file segment. """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "segment", segment, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileUploadSegment", argTuple, callback, callbackArg )
	def FileUploadSegment_Sync( self, sessionID, segment ):
		""" Method to upload a segment to testServer. This method must be called using the sessionID obtained by a call toFileBeginDownload methof.
			sessionID: The session ID for the upload.
			segment: The bytes containing the file segment. """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "segment", segment, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileUploadSegment", argTuple)
		return context.Sync()

	def FileEndDownLoad( self, sessionID, callback = None, callbackArg = None ):
		""" Method to indicate that the file upload is complete.
			sessionID: The session ID for the upload. """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileEndDownLoad", argTuple, callback, callbackArg )
	def FileEndDownLoad_Sync( self, sessionID ):
		""" Method to indicate that the file upload is complete.
			sessionID: The session ID for the upload. """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileEndDownLoad", argTuple)
		return context.Sync()

	def ImportPrtFile( self, ports, sessionID, callback = None, callbackArg = None ):
		""" Method to import a prt file.
			ports: Set of ports to import the file
			sessionID: Session ID for importing the file.
			Returns retval: Return value of the method. If true, indicates success. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportPrtFile", argTuple, callback, callbackArg )
	def ImportPrtFile_Sync( self, ports, sessionID ):
		""" Method to import a prt file.
			ports: Set of ports to import the file
			sessionID: Session ID for importing the file.
			Returns retval: Return value of the method. If true, indicates success. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportPrtFile", argTuple)
		return context.Sync()

	def GetChassisTopology( self, chassisHostName, callback = None, callbackArg = None ):
		""" Get the complete information about the topology of the chassis, including card and port information.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns chassis: Reference to the structure containing the chassis topology information. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "chassis", None, "out", "ChassisConfig.XPChassis", ChassisConfig.XPChassis)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetChassisTopology", argTuple, callback, callbackArg )
	def GetChassisTopology_Sync( self, chassisHostName ):
		""" Get the complete information about the topology of the chassis, including card and port information.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns chassis: Reference to the structure containing the chassis topology information. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "chassis", None, "out", "ChassisConfig.XPChassis", ChassisConfig.XPChassis)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetChassisTopology", argTuple)
		return context.Sync()

	def GetDetailedChassisTopology( self, chassisHostName, callback = None, callbackArg = None ):
		""" Get the complete information about the topology of the chassis, including card and port information. This method alsoreturns the capabilities of each of the ports in the chassis.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns chassis: Reference to the structure containing the chassis topology information.
			Returns portVec: Reference to the structure containing the Port capabilities information. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "chassis", None, "out", "ChassisConfig.XPChassis2", ChassisConfig.XPChassis2)
		arg2 = Aptixia_prv.MethodArgument( "portVec", None, "out", "ChassisConfig.PortAddressWithPropertiesVector", ChassisConfig.PortAddressWithPropertiesVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetDetailedChassisTopology", argTuple, callback, callbackArg )
	def GetDetailedChassisTopology_Sync( self, chassisHostName ):
		""" Get the complete information about the topology of the chassis, including card and port information. This method alsoreturns the capabilities of each of the ports in the chassis.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns chassis: Reference to the structure containing the chassis topology information.
			Returns portVec: Reference to the structure containing the Port capabilities information. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "chassis", None, "out", "ChassisConfig.XPChassis2", ChassisConfig.XPChassis2)
		arg2 = Aptixia_prv.MethodArgument( "portVec", None, "out", "ChassisConfig.PortAddressWithPropertiesVector", ChassisConfig.PortAddressWithPropertiesVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetDetailedChassisTopology", argTuple)
		return context.Sync()

	def CreateChassisChain( self, callback = None, callbackArg = None ):
		""" Creates the chassis chain the chassis using the configured chassis chain information. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateChassisChain", argTuple, callback, callbackArg )
	def CreateChassisChain_Sync( self ):
		""" Creates the chassis chain the chassis using the configured chassis chain information. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateChassisChain", argTuple)
		return context.Sync()

	def EstablishChassisConnection( self, chassisHostName, callback = None, callbackArg = None ):
		""" EstablishConnection to the chassis
			chassisHostName: DNS name of the chassis.
			Returns retval: DNS name of ip address of the connected chassis. If already connected with a differentalias, returns that alias. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EstablishChassisConnection", argTuple, callback, callbackArg )
	def EstablishChassisConnection_Sync( self, chassisHostName ):
		""" EstablishConnection to the chassis
			chassisHostName: DNS name of the chassis.
			Returns retval: DNS name of ip address of the connected chassis. If already connected with a differentalias, returns that alias. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EstablishChassisConnection", argTuple)
		return context.Sync()

	def ClearStatistics( self, ports, callback = None, callbackArg = None ):
		""" Method to start transmsit.
			ports: Set of ports to clear statistics. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearStatistics", argTuple, callback, callbackArg )
	def ClearStatistics_Sync( self, ports ):
		""" Method to start transmsit.
			ports: Set of ports to clear statistics. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearStatistics", argTuple)
		return context.Sync()

	def ClearStatistics_V2( self, ports, callback = None, callbackArg = None ):
		""" Method to clear statistics. The method returns also the ports on which stats could not be cleared.
			ports: Set of ports to clear statistics.
			Returns portsFailed: List of ports that could not be cleared of statistics. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearStatistics_V2", argTuple, callback, callbackArg )
	def ClearStatistics_V2_Sync( self, ports ):
		""" Method to clear statistics. The method returns also the ports on which stats could not be cleared.
			ports: Set of ports to clear statistics.
			Returns portsFailed: List of ports that could not be cleared of statistics. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearStatistics_V2", argTuple)
		return context.Sync()

	def GetNicVector( self, uniquePortId, callback = None, callbackArg = None ):
		""" Returns the list of Nics for a particular port
			uniquePortId: Port id for which the Nics are required
			Returns nics: Vector representing Nics """
		arg0 = Aptixia_prv.MethodArgument( "uniquePortId", uniquePortId, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "nics", None, "out", "ChassisConfig.SeqNicVector", ChassisConfig.SeqNicVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetNicVector", argTuple, callback, callbackArg )
	def GetNicVector_Sync( self, uniquePortId ):
		""" Returns the list of Nics for a particular port
			uniquePortId: Port id for which the Nics are required
			Returns nics: Vector representing Nics """
		arg0 = Aptixia_prv.MethodArgument( "uniquePortId", uniquePortId, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "nics", None, "out", "ChassisConfig.SeqNicVector", ChassisConfig.SeqNicVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetNicVector", argTuple)
		return context.Sync()

	def SetFactoryDefaultsForNics( self, nics, callback = None, callbackArg = None ):
		""" Set the factory defaults
			nics: Nics for which the settings are to be made """
		arg0 = Aptixia_prv.MethodArgument( "nics", nics, "in", "ChassisConfig.SeqNicAddressVector", ChassisConfig.SeqNicAddressVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaultsForNics", argTuple, callback, callbackArg )
	def SetFactoryDefaultsForNics_Sync( self, nics ):
		""" Set the factory defaults
			nics: Nics for which the settings are to be made """
		arg0 = Aptixia_prv.MethodArgument( "nics", nics, "in", "ChassisConfig.SeqNicAddressVector", ChassisConfig.SeqNicAddressVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFactoryDefaultsForNics", argTuple)
		return context.Sync()

	def ConfigurePhysicalForNics( self, nics, xml, callback = None, callbackArg = None ):
		""" Configure physical properties for Nics
			nics: Vector of nics
			xml: xml file that contains the configuration information. """
		arg0 = Aptixia_prv.MethodArgument( "nics", nics, "in", "ChassisConfig.SeqNicAddressVector", ChassisConfig.SeqNicAddressVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysicalForNics", argTuple, callback, callbackArg )
	def ConfigurePhysicalForNics_Sync( self, nics, xml ):
		""" Configure physical properties for Nics
			nics: Vector of nics
			xml: xml file that contains the configuration information. """
		arg0 = Aptixia_prv.MethodArgument( "nics", nics, "in", "ChassisConfig.SeqNicAddressVector", ChassisConfig.SeqNicAddressVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysicalForNics", argTuple)
		return context.Sync()

	def StartTrafficGeneration( self, ports, callback = None, callbackArg = None ):
		""" Method to invoke a set of methods on a list of ports. This is a wrapper method that callsStopTransmit, StopLatency, ClearStatistics, ClearTimeStamp.
			ports: Set of  ports to call the wrapper API on. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTrafficGeneration", argTuple, callback, callbackArg )
	def StartTrafficGeneration_Sync( self, ports ):
		""" Method to invoke a set of methods on a list of ports. This is a wrapper method that callsStopTransmit, StopLatency, ClearStatistics, ClearTimeStamp.
			ports: Set of  ports to call the wrapper API on. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTrafficGeneration", argTuple)
		return context.Sync()

	def InvokeTranslatorModuleFunc( self, chassisHostName, xml_in, callback = None, callbackArg = None ):
		""" Method to invoke a translator module function in a chassis.
			chassisHostName: Hostname of the chassis to talk to.
			xml_in: xml file to be sent to the translator Module
			Returns xmlStream: xml file response from the translator Module """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml_in", xml_in, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "xmlStream", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InvokeTranslatorModuleFunc", argTuple, callback, callbackArg )
	def InvokeTranslatorModuleFunc_Sync( self, chassisHostName, xml_in ):
		""" Method to invoke a translator module function in a chassis.
			chassisHostName: Hostname of the chassis to talk to.
			xml_in: xml file to be sent to the translator Module
			Returns xmlStream: xml file response from the translator Module """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml_in", xml_in, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "xmlStream", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InvokeTranslatorModuleFunc", argTuple)
		return context.Sync()

	def DownloadPackagesToPorts( self, ports, File, fileName, callback = None, callbackArg = None ):
		""" Method to download one package to a set of ports.
			ports: List of ports to download to.
			File: Package to download.
			fileName: Package name to download. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "File", File, "in", "file", None)
		arg2 = Aptixia_prv.MethodArgument( "fileName", fileName, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DownloadPackagesToPorts", argTuple, callback, callbackArg )
	def DownloadPackagesToPorts_Sync( self, ports, File, fileName ):
		""" Method to download one package to a set of ports.
			ports: List of ports to download to.
			File: Package to download.
			fileName: Package name to download. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "File", File, "in", "file", None)
		arg2 = Aptixia_prv.MethodArgument( "fileName", fileName, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DownloadPackagesToPorts", argTuple)
		return context.Sync()

	def DeletePackagesFromPorts( self, ports, packages, callback = None, callbackArg = None ):
		""" Method to delete packages from a set of ports.
			ports: List of ports to delete packages from.
			packages: Package to delete. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "packages", packages, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeletePackagesFromPorts", argTuple, callback, callbackArg )
	def DeletePackagesFromPorts_Sync( self, ports, packages ):
		""" Method to delete packages from a set of ports.
			ports: List of ports to delete packages from.
			packages: Package to delete. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "packages", packages, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeletePackagesFromPorts", argTuple)
		return context.Sync()

	def InvokeTranslatorModuleFuncWithCompression( self, chassisHostName, xml_in, callback = None, callbackArg = None ):
		""" Method to call Translator module with compressed input and output streams.
			chassisHostName: Hostname of the chassis.
			xml_in: Compressed xml file stream  to be sent to the translator Module
			Returns xmlStream: Compressed xml file stream received from the translator Module. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml_in", xml_in, "in", "file", None)
		arg2 = Aptixia_prv.MethodArgument( "xmlStream", None, "out", "file", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InvokeTranslatorModuleFuncWithCompression", argTuple, callback, callbackArg )
	def InvokeTranslatorModuleFuncWithCompression_Sync( self, chassisHostName, xml_in ):
		""" Method to call Translator module with compressed input and output streams.
			chassisHostName: Hostname of the chassis.
			xml_in: Compressed xml file stream  to be sent to the translator Module
			Returns xmlStream: Compressed xml file stream received from the translator Module. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml_in", xml_in, "in", "file", None)
		arg2 = Aptixia_prv.MethodArgument( "xmlStream", None, "out", "file", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InvokeTranslatorModuleFuncWithCompression", argTuple)
		return context.Sync()

	def RebootPortCpuAndBlockUntilReady( self, portsIn, callback = None, callbackArg = None ):
		""" Method to reboot the ports and then check if the ports are all ready.Method returns when all ports are ready.
			portsIn: Set of ports to reboot and check for status.
			Returns portsFailed: List of ports that could not be rebooted. """
		arg0 = Aptixia_prv.MethodArgument( "portsIn", portsIn, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RebootPortCpuAndBlockUntilReady", argTuple, callback, callbackArg )
	def RebootPortCpuAndBlockUntilReady_Sync( self, portsIn ):
		""" Method to reboot the ports and then check if the ports are all ready.Method returns when all ports are ready.
			portsIn: Set of ports to reboot and check for status.
			Returns portsFailed: List of ports that could not be rebooted. """
		arg0 = Aptixia_prv.MethodArgument( "portsIn", portsIn, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RebootPortCpuAndBlockUntilReady", argTuple)
		return context.Sync()

	def ConfigurePhysical_V2( self, ports, xml, callback = None, callbackArg = None ):
		""" Configure layer1 information on the ports and return failed ports.
			ports: Ports to write the changes to.
			xml: The string containing the xml data.
			Returns portsFailed: List of ports that could not be set with Layer1 partamters. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysical_V2", argTuple, callback, callbackArg )
	def ConfigurePhysical_V2_Sync( self, ports, xml ):
		""" Configure layer1 information on the ports and return failed ports.
			ports: Ports to write the changes to.
			xml: The string containing the xml data.
			Returns portsFailed: List of ports that could not be set with Layer1 partamters. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigurePhysical_V2", argTuple)
		return context.Sync()

	def PingChassis( self, chassisHostName, callback = None, callbackArg = None ):
		""" Try connecting to chassis and see if it is up and Ixserver is also up
			chassisHostName: The string containing the chassisHostname.
			Returns retval: Return value of the method. If true, indicates success. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "PingChassis", argTuple, callback, callbackArg )
	def PingChassis_Sync( self, chassisHostName ):
		""" Try connecting to chassis and see if it is up and Ixserver is also up
			chassisHostName: The string containing the chassisHostname.
			Returns retval: Return value of the method. If true, indicates success. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retval", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "PingChassis", argTuple)
		return context.Sync()

	def GetPortInformation_V2( self, ports, callback = None, callbackArg = None ):
		""" Get the current port information such as speed, link state etc., for a set of ports.Return the failed ports.
			ports: Set of ports to get port information.
			Returns portInfo: Reference to the port info structure.
			Returns portsFailed: List of ports for which port information could not be obtained. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portInfo", None, "out", "ChassisConfig.PortVector", ChassisConfig.PortVector)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortInformation_V2", argTuple, callback, callbackArg )
	def GetPortInformation_V2_Sync( self, ports ):
		""" Get the current port information such as speed, link state etc., for a set of ports.Return the failed ports.
			ports: Set of ports to get port information.
			Returns portInfo: Reference to the port info structure.
			Returns portsFailed: List of ports for which port information could not be obtained. """
		arg0 = Aptixia_prv.MethodArgument( "ports", ports, "in", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		arg1 = Aptixia_prv.MethodArgument( "portInfo", None, "out", "ChassisConfig.PortVector", ChassisConfig.PortVector)
		arg2 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPortInformation_V2", argTuple)
		return context.Sync()

	def GetFailedPortsForLayer1( self, callback = None, callbackArg = None ):
		""" Method to obtain failed ports from ConfigLayer_V2 through TestConfigure method.
			Returns portsFailed: List of ports for Layer1 failed. """
		arg0 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetFailedPortsForLayer1", argTuple, callback, callbackArg )
	def GetFailedPortsForLayer1_Sync( self ):
		""" Method to obtain failed ports from ConfigLayer_V2 through TestConfigure method.
			Returns portsFailed: List of ports for Layer1 failed. """
		arg0 = Aptixia_prv.MethodArgument( "portsFailed", None, "out", "ChassisConfig.StringVector", ChassisConfig.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetFailedPortsForLayer1", argTuple)
		return context.Sync()

	def RemoveChassisConnectionCache( self, chassisHostName, callback = None, callbackArg = None ):
		""" Remove Chassis Connection Cache from testserver.
			chassisHostName: DNS name of the chassis. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RemoveChassisConnectionCache", argTuple, callback, callbackArg )
	def RemoveChassisConnectionCache_Sync( self, chassisHostName ):
		""" Remove Chassis Connection Cache from testserver.
			chassisHostName: DNS name of the chassis. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RemoveChassisConnectionCache", argTuple)
		return context.Sync()

	def GetVersion( self, machineIp, callback = None, callbackArg = None ):
		""" Returns the PCDAP version
			machineIp: Machine ip.
			Returns version: PCDAP version for the given machine ip """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetVersion", argTuple, callback, callbackArg )
	def GetVersion_Sync( self, machineIp ):
		""" Returns the PCDAP version
			machineIp: Machine ip.
			Returns version: PCDAP version for the given machine ip """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetVersion", argTuple)
		return context.Sync()

	def GetManagementNicVector( self, machineIp, callback = None, callbackArg = None ):
		""" Returns a vector of nic addresses
			machineIp: Machine ip
			Returns nicVector: Vector of nic addresses """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "nicVector", None, "out", "ChassisConfig.CPDNicAddressVector", ChassisConfig.CPDNicAddressVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetManagementNicVector", argTuple, callback, callbackArg )
	def GetManagementNicVector_Sync( self, machineIp ):
		""" Returns a vector of nic addresses
			machineIp: Machine ip
			Returns nicVector: Vector of nic addresses """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "nicVector", None, "out", "ChassisConfig.CPDNicAddressVector", ChassisConfig.CPDNicAddressVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetManagementNicVector", argTuple)
		return context.Sync()

	def SetHostname( self, machineIp, hostname, callback = None, callbackArg = None ):
		""" Sets the host name for the given pcdap machine
			machineIp: Machine ip
			hostname: Hostname to be set """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "hostname", hostname, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetHostname", argTuple, callback, callbackArg )
	def SetHostname_Sync( self, machineIp, hostname ):
		""" Sets the host name for the given pcdap machine
			machineIp: Machine ip
			hostname: Hostname to be set """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "hostname", hostname, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetHostname", argTuple)
		return context.Sync()

	def SetDnsServer( self, machineIp, dnsServer, callback = None, callbackArg = None ):
		""" Sets the dns server for the given pcdap machine
			machineIp: Machine ip
			dnsServer: Hostname to be set """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "dnsServer", dnsServer, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDnsServer", argTuple, callback, callbackArg )
	def SetDnsServer_Sync( self, machineIp, dnsServer ):
		""" Sets the dns server for the given pcdap machine
			machineIp: Machine ip
			dnsServer: Hostname to be set """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "dnsServer", dnsServer, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDnsServer", argTuple)
		return context.Sync()

	def GetHardwareManagerBuildVersion( self, machineIp, callback = None, callbackArg = None ):
		""" Gets the version
			machineIp: Machine ip
			Returns version: Version """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetHardwareManagerBuildVersion", argTuple, callback, callbackArg )
	def GetHardwareManagerBuildVersion_Sync( self, machineIp ):
		""" Gets the version
			machineIp: Machine ip
			Returns version: Version """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetHardwareManagerBuildVersion", argTuple)
		return context.Sync()

	def SetDhcp( self, nicAddress, callback = None, callbackArg = None ):
		""" Sets the nic to use DHCP
			nicAddress: Nic address """
		arg0 = Aptixia_prv.MethodArgument( "nicAddress", nicAddress, "in", "ChassisConfig.CPDNicAddress", ChassisConfig.CPDNicAddress)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDhcp", argTuple, callback, callbackArg )
	def SetDhcp_Sync( self, nicAddress ):
		""" Sets the nic to use DHCP
			nicAddress: Nic address """
		arg0 = Aptixia_prv.MethodArgument( "nicAddress", nicAddress, "in", "ChassisConfig.CPDNicAddress", ChassisConfig.CPDNicAddress)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDhcp", argTuple)
		return context.Sync()

	def SetStaticIp( self, nicAddress, ip, netmask, gateway, callback = None, callbackArg = None ):
		""" Sets the nic to use static ip
			nicAddress: Nic address
			ip: Ip
			netmask: Netmask
			gateway: Gateway """
		arg0 = Aptixia_prv.MethodArgument( "nicAddress", nicAddress, "in", "ChassisConfig.CPDNicAddress", ChassisConfig.CPDNicAddress)
		arg1 = Aptixia_prv.MethodArgument( "ip", ip, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "netmask", netmask, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "gateway", gateway, "in", "int32", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetStaticIp", argTuple, callback, callbackArg )
	def SetStaticIp_Sync( self, nicAddress, ip, netmask, gateway ):
		""" Sets the nic to use static ip
			nicAddress: Nic address
			ip: Ip
			netmask: Netmask
			gateway: Gateway """
		arg0 = Aptixia_prv.MethodArgument( "nicAddress", nicAddress, "in", "ChassisConfig.CPDNicAddress", ChassisConfig.CPDNicAddress)
		arg1 = Aptixia_prv.MethodArgument( "ip", ip, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "netmask", netmask, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "gateway", gateway, "in", "int32", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetStaticIp", argTuple)
		return context.Sync()

	def GetKernelCrashDump( self, machineIp, callback = None, callbackArg = None ):
		""" Returns the last kernel crash dump
			machineIp: Machine ip
			Returns crashDump: Kernel crash dump """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "crashDump", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetKernelCrashDump", argTuple, callback, callbackArg )
	def GetKernelCrashDump_Sync( self, machineIp ):
		""" Returns the last kernel crash dump
			machineIp: Machine ip
			Returns crashDump: Kernel crash dump """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "crashDump", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetKernelCrashDump", argTuple)
		return context.Sync()

	def CPDConfigurePhysical( self, nicAddressVector, configuration, callback = None, callbackArg = None ):
		""" Configures the physical properties
			nicAddressVector: Nic addresses
			configuration: Configuration to be set """
		arg0 = Aptixia_prv.MethodArgument( "nicAddressVector", nicAddressVector, "in", "ChassisConfig.CPDNicAddressVector", ChassisConfig.CPDNicAddressVector)
		arg1 = Aptixia_prv.MethodArgument( "configuration", configuration, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CPDConfigurePhysical", argTuple, callback, callbackArg )
	def CPDConfigurePhysical_Sync( self, nicAddressVector, configuration ):
		""" Configures the physical properties
			nicAddressVector: Nic addresses
			configuration: Configuration to be set """
		arg0 = Aptixia_prv.MethodArgument( "nicAddressVector", nicAddressVector, "in", "ChassisConfig.CPDNicAddressVector", ChassisConfig.CPDNicAddressVector)
		arg1 = Aptixia_prv.MethodArgument( "configuration", configuration, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CPDConfigurePhysical", argTuple)
		return context.Sync()

	def DoesChassisSupportMultiNic( self, chassisHostName, callback = None, callbackArg = None ):
		""" Returns true if the chassis is a PCDAP.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns retVal: Return value. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retVal", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DoesChassisSupportMultiNic", argTuple, callback, callbackArg )
	def DoesChassisSupportMultiNic_Sync( self, chassisHostName ):
		""" Returns true if the chassis is a PCDAP.
			chassisHostName: Dns name or IP address of the Chassis.
			Returns retVal: Return value. """
		arg0 = Aptixia_prv.MethodArgument( "chassisHostName", chassisHostName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "retVal", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DoesChassisSupportMultiNic", argTuple)
		return context.Sync()

	def GetIxOSVersion( self, machineIp, callback = None, callbackArg = None ):
		""" Returns the IxosVersion at the specified chassis address
			machineIp: Chassis Address.
			Returns version: IXOS version """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIxOSVersion", argTuple, callback, callbackArg )
	def GetIxOSVersion_Sync( self, machineIp ):
		""" Returns the IxosVersion at the specified chassis address
			machineIp: Chassis Address.
			Returns version: IXOS version """
		arg0 = Aptixia_prv.MethodArgument( "machineIp", machineIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIxOSVersion", argTuple)
		return context.Sync()

	def SetDelayStartTransmitTime( self, masterChassisIp, delay, callback = None, callbackArg = None ):
		""" Set the number of seconds to delay test application after a start. Applicable for chassis chain.
			masterChassisIp: The master of the chassis chain.
			delay: The delay value to be set. """
		arg0 = Aptixia_prv.MethodArgument( "masterChassisIp", masterChassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "delay", delay, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDelayStartTransmitTime", argTuple, callback, callbackArg )
	def SetDelayStartTransmitTime_Sync( self, masterChassisIp, delay ):
		""" Set the number of seconds to delay test application after a start. Applicable for chassis chain.
			masterChassisIp: The master of the chassis chain.
			delay: The delay value to be set. """
		arg0 = Aptixia_prv.MethodArgument( "masterChassisIp", masterChassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "delay", delay, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetDelayStartTransmitTime", argTuple)
		return context.Sync()

	def GetDelayStartTransmitTime( self, masterChassisIp, callback = None, callbackArg = None ):
		""" Get the number of seconds to delay test application after a start. Applicable for chassis chain.
			masterChassisIp: The master of the chassis chain.
			Returns delay: The return value. """
		arg0 = Aptixia_prv.MethodArgument( "masterChassisIp", masterChassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "delay", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetDelayStartTransmitTime", argTuple, callback, callbackArg )
	def GetDelayStartTransmitTime_Sync( self, masterChassisIp ):
		""" Get the number of seconds to delay test application after a start. Applicable for chassis chain.
			masterChassisIp: The master of the chassis chain.
			Returns delay: The return value. """
		arg0 = Aptixia_prv.MethodArgument( "masterChassisIp", masterChassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "delay", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetDelayStartTransmitTime", argTuple)
		return context.Sync()

	def GetChassisTimeSource( self, chassisIp, callback = None, callbackArg = None ):
		""" Get the source for the time server of the chassis.
			chassisIp: The chassis IP.
			Returns source: The return value. """
		arg0 = Aptixia_prv.MethodArgument( "chassisIp", chassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "source", None, "out", "ChassisConfig.eTimeSource", ChassisConfig.eTimeSource)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetChassisTimeSource", argTuple, callback, callbackArg )
	def GetChassisTimeSource_Sync( self, chassisIp ):
		""" Get the source for the time server of the chassis.
			chassisIp: The chassis IP.
			Returns source: The return value. """
		arg0 = Aptixia_prv.MethodArgument( "chassisIp", chassisIp, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "source", None, "out", "ChassisConfig.eTimeSource", ChassisConfig.eTimeSource)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetChassisTimeSource", argTuple)
		return context.Sync()


