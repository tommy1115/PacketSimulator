import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import StackElementPlugin, PortController, BranchToNic


class PortGroup( XProtocolObject.XProtocolObject ):
	""" PortGroup represents the concept of a stack of layers which are to be configured on a group of ports. """
	# Enums
	class ePluginType (Aptixia.IxEnum):
		kIpSec = 0
		kIp = 1
		kEmulatedRouter = 1
		kPpp = 1
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "PortGroup.ePluginType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eIpAllocationMechanism (Aptixia.IxEnum):
		kStatic = 0
		kDynamic = 1
		kAll = 2
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "PortGroup.eIpAllocationMechanism"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eProtocol (Aptixia.IxEnum):
		kIpv4 = 0
		kIpv6 = 1
		kAll = 2
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "PortGroup.eProtocol"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class StringVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "PortGroup.StringVector" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.StringVector" )
		def getType():
			return "PortGroup.StringVector"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class VlanInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.VlanInfo")
		if "PortGroup.VlanInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.VlanInfoList" )
		def getType():
			return "PortGroup.VlanInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.VlanInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.VlanInfo
		getElementClass = staticmethod(getElementClass)
	class RangeInformationList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.RangeInformation")
		if "PortGroup.RangeInformationList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.RangeInformationList" )
		def getType():
			return "PortGroup.RangeInformationList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.RangeInformation"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.RangeInformation
		getElementClass = staticmethod(getElementClass)
	class PortList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.Port")
		if "PortGroup.PortList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.PortList" )
		def getType():
			return "PortGroup.PortList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.Port"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.Port
		getElementClass = staticmethod(getElementClass)
	class InterfaceInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.InterfaceInfo")
		if "PortGroup.InterfaceInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.InterfaceInfoList" )
		def getType():
			return "PortGroup.InterfaceInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.InterfaceInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.InterfaceInfo
		getElementClass = staticmethod(getElementClass)
	class IpPairInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.IpPairInfo")
		if "PortGroup.IpPairInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.IpPairInfoList" )
		def getType():
			return "PortGroup.IpPairInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.IpPairInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.IpPairInfo
		getElementClass = staticmethod(getElementClass)
	class IpAddressList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "PortGroup.IpAddressList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.IpAddressList" )
		def getType():
			return "PortGroup.IpAddressList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class StackElementPluginList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StackElementPlugin")
		if "PortGroup.StackElementPluginList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.StackElementPluginList" )
		def getType():
			return "PortGroup.StackElementPluginList"
		getType = staticmethod(getType)
		def getElementType():
			return "StackElementPlugin"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class IpV4V6RangeInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortGroup.IpV4V6RangeInfo")
		if "PortGroup.IpV4V6RangeInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "PortGroup.IpV4V6RangeInfoList" )
		def getType():
			return "PortGroup.IpV4V6RangeInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortGroup.IpV4V6RangeInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortGroup.IpV4V6RangeInfo
		getElementClass = staticmethod(getElementClass)

	# Structs
	class Port( Aptixia.IxStruct ):
		""" Structure representing a port """
		if "PortGroup.Port" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.Port")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassis = ""
			self.card = 0
			self.port = 0
			self.managementIp = ""
			self._version = "1"
			self._types = { "chassis":"string",
				 "card":"int32",
				 "port":"int32",
				 "managementIp":"string" }
		def getType( self ):
			return "PortGroup.Port"

	class VlanInfo( Aptixia.IxStruct ):
		""" Structure representing an VLAN tag. """
		if "PortGroup.VlanInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.VlanInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.vlanId = 1
			self.vlanPriority = 1
			self._version = "1"
			self._types = { "vlanId":"int64",
				 "vlanPriority":"int64" }
		def getType( self ):
			return "PortGroup.VlanInfo"

	class InterfaceInfo( Aptixia.IxStruct ):
		""" Structure representing an interface """
		if "PortGroup.InterfaceInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.InterfaceInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.ipAddress = ""
			self.prefix = ""
			self.macAddress = ""
			self.isConnectedInterface = 1
			self.vlanList = PortGroup.VlanInfoList()
			self._version = "1"
			self._types = { "ipAddress":"string",
				 "prefix":"string",
				 "macAddress":"string",
				 "isConnectedInterface":"bool",
				 "vlanList":"PortGroup.VlanInfoList" }
		def getType( self ):
			return "PortGroup.InterfaceInfo"

	class IpRangeInfo( Aptixia.IxStruct ):
		""" Structure to represent ip range information """
		if "PortGroup.IpRangeInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.IpRangeInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.startingIp = ""
			self.incrementIpBy = ""
			self.count = 0
			self.ipType = ""
			self._version = "1"
			self._types = { "startingIp":"string",
				 "incrementIpBy":"string",
				 "count":"int32",
				 "ipType":"string" }
		def getType( self ):
			return "PortGroup.IpRangeInfo"

	class MacRangeInfo( Aptixia.IxStruct ):
		""" Structure to represent mac range information """
		if "PortGroup.MacRangeInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.MacRangeInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.startingMac = ""
			self.incrementMacBy = ""
			self.startingInterfaceId = 0
			self.incrementInterfaceIdBy = 0
			self.isConnected = False
			self._version = "1"
			self._types = { "startingMac":"string",
				 "incrementMacBy":"string",
				 "startingInterfaceId":"int32",
				 "incrementInterfaceIdBy":"int32",
				 "isConnected":"bool" }
		def getType( self ):
			return "PortGroup.MacRangeInfo"

	class VlanRangeInfo( Aptixia.IxStruct ):
		""" Structure to represent vlan range information """
		if "PortGroup.VlanRangeInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.VlanRangeInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.enable = False
			self.firstId = 0
			self.incrementStep = 0
			self.increment = 0
			self.uniqueCount = 0
			self.priority = 0
			self.innerEnable = False
			self.innerFirstId = 0
			self.innerIncrementStep = 0
			self.innerIncrement = 0
			self.innerUniqueCount = 0
			self.innerPriority = 0
			self.idIncrMode = 0
			self.etherType = "0x8100"
			self._version = "1"
			self._types = { "enable":"bool",
				 "firstId":"int32",
				 "incrementStep":"int32",
				 "increment":"int32",
				 "uniqueCount":"int32",
				 "priority":"int32",
				 "innerEnable":"bool",
				 "innerFirstId":"int32",
				 "innerIncrementStep":"int32",
				 "innerIncrement":"int32",
				 "innerUniqueCount":"int32",
				 "innerPriority":"int32",
				 "idIncrMode":"int32",
				 "etherType":"string" }
		def getType( self ):
			return "PortGroup.VlanRangeInfo"

	class RangeInformation( Aptixia.IxStruct ):
		""" Structure to represent the range information for Ip, Vlan and Mac """
		if "PortGroup.RangeInformation" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.RangeInformation")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.ipRangeInfo = PortGroup.IpRangeInfo()
			self.macRangeInfo = PortGroup.MacRangeInfo()
			self.vlanRangeInfo = PortGroup.VlanRangeInfo()
			self.port = PortGroup.Port()
			self._version = "1"
			self._types = { "ipRangeInfo":"PortGroup.IpRangeInfo",
				 "macRangeInfo":"PortGroup.MacRangeInfo",
				 "vlanRangeInfo":"PortGroup.VlanRangeInfo",
				 "port":"PortGroup.Port" }
		def getType( self ):
			return "PortGroup.RangeInformation"

	class IPort( Aptixia.IxStruct ):
		""" Represents a port """
		if "PortGroup.IPort" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.IPort")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.chassis = ""
			self.card = 0
			self.port = 0
			self.managementIp = ""
			self._version = "1"
			self._types = { "chassis":"string",
				 "card":"int32",
				 "port":"int32",
				 "managementIp":"string" }
		def getType( self ):
			return "PortGroup.IPort"

	class IpPairInfo( Aptixia.IxStruct ):
		""" Represents an IP pair with information about the plugin """
		if "PortGroup.IpPairInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.IpPairInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.ip1 = ""
			self.ip2 = ""
			self.pluginType = PortGroup.ePluginType()
			self._version = "1"
			self._types = { "ip1":"string",
				 "ip2":"string",
				 "pluginType":"PortGroup.ePluginType" }
		def getType( self ):
			return "PortGroup.IpPairInfo"

	class IpV4V6RangeInfo( Aptixia.IxStruct ):
		""" Represents an IP range information """
		if "PortGroup.IpV4V6RangeInfo" not in Aptixia.structs:
			Aptixia.structs.append("PortGroup.IpV4V6RangeInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.ipType = ""
			self.startingIp = ""
			self.incrementBy = ""
			self.count = 0
			self._version = "1"
			self._types = { "ipType":"string",
				 "startingIp":"string",
				 "incrementBy":"string",
				 "count":"int32" }
		def getType( self ):
			return "PortGroup.IpV4V6RangeInfo"


	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_category (self):
		return self.getVar ("category")
	def _set_category (self, value):
		self.setVar ("category", value)
	category = property (_get_category, _set_category, None, "category property")
	def _get_stack (self):
		return self.getListVar ("stack")
	def _set_stack (self, value):
		self.setVar ("stack", value)
	stack = property (_get_stack, _set_stack, None, "stack property")
	def _get_globalPluginList (self):
		return self.getListVar ("globalPluginList")
	globalPluginList = property (_get_globalPluginList, None, None, "globalPluginList property")
	def _get_portList (self):
		return self.getListVar ("portList")
	portList = property (_get_portList, None, None, "portList property")
	def _get_portController (self):
		return self.getListVar ("portController")
	portController = property (_get_portController, None, None, "portController property")
	def _get_doAutoGratArpForIPv4 (self):
		return self.getVar ("doAutoGratArpForIPv4")
	def _set_doAutoGratArpForIPv4 (self, value):
		self.setVar ("doAutoGratArpForIPv4", value)
	doAutoGratArpForIPv4 = property (_get_doAutoGratArpForIPv4, _set_doAutoGratArpForIPv4, None, "doAutoGratArpForIPv4 property")
	def _get_doAutoGratArpForIPv6 (self):
		return self.getVar ("doAutoGratArpForIPv6")
	def _set_doAutoGratArpForIPv6 (self, value):
		self.setVar ("doAutoGratArpForIPv6", value)
	doAutoGratArpForIPv6 = property (_get_doAutoGratArpForIPv6, _set_doAutoGratArpForIPv6, None, "doAutoGratArpForIPv6 property")
	def _get_neighborTargetList (self):
		return self.getListVar ("neighborTargetList")
	neighborTargetList = property (_get_neighborTargetList, None, None, "neighborTargetList property")
	def _get_branchToNicMap (self):
		return self.getListVar ("branchToNicMap")
	branchToNicMap = property (_get_branchToNicMap, None, None, "branchToNicMap property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PortGroup, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["category"] = ""
			self.managedProperties["stack"] = None
			self.managedProperties["globalPluginList"] = Aptixia.IxObjectList (self.transactionContext, "StackElementPlugin")
			self.managedProperties["portList"] = Aptixia.IxList ("string")
			self.managedProperties["portController"] = PortController.PortController (self)
			self.managedProperties["doAutoGratArpForIPv4"] = True
			self.managedProperties["doAutoGratArpForIPv6"] = True
			self.managedProperties["neighborTargetList"] = Aptixia.IxList ("string")
			self.managedProperties["branchToNicMap"] = Aptixia.IxObjectList (self.transactionContext, "BranchToNic")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PortGroup"

	# Class Methods
	def DodBeginDownLoad( self, name, timeOut, callback = None, callbackArg = None ):
		""" DOD start download
			name: Name of the file to download
			timeOut: Time out limit
			Returns sessionId: Session id """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "timeOut", timeOut, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "sessionId", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodBeginDownLoad", argTuple, callback, callbackArg )
	def DodBeginDownLoad_Sync( self, name, timeOut ):
		""" DOD start download
			name: Name of the file to download
			timeOut: Time out limit
			Returns sessionId: Session id """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "timeOut", timeOut, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "sessionId", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodBeginDownLoad", argTuple)
		return context.Sync()

	def DodUpLoadFileSegment( self, sessionID, segment, callback = None, callbackArg = None ):
		""" Uploads a file
			sessionID: Session id
			segment: Segment name to upload """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "segment", segment, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodUpLoadFileSegment", argTuple, callback, callbackArg )
	def DodUpLoadFileSegment_Sync( self, sessionID, segment ):
		""" Uploads a file
			sessionID: Session id
			segment: Segment name to upload """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "segment", segment, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodUpLoadFileSegment", argTuple)
		return context.Sync()

	def DodEndDownLoad( self, sessionID, callback = None, callbackArg = None ):
		""" End download
			sessionID: Session id """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodEndDownLoad", argTuple, callback, callbackArg )
	def DodEndDownLoad_Sync( self, sessionID ):
		""" End download
			sessionID: Session id """
		arg0 = Aptixia_prv.MethodArgument( "sessionID", sessionID, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodEndDownLoad", argTuple)
		return context.Sync()

	def GetIps( self, allocationMechanism, protocol, count, callback = None, callbackArg = None ):
		""" Returns the IpPairInfo list.
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			count: The number if ips that should be returned in the list
			Returns pairInfoList: List of IpPairInfo """
		arg0 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg1 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg2 = Aptixia_prv.MethodArgument( "count", count, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "pairInfoList", None, "out", "PortGroup.IpPairInfoList", PortGroup.IpPairInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIps", argTuple, callback, callbackArg )
	def GetIps_Sync( self, allocationMechanism, protocol, count ):
		""" Returns the IpPairInfo list.
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			count: The number if ips that should be returned in the list
			Returns pairInfoList: List of IpPairInfo """
		arg0 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg1 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg2 = Aptixia_prv.MethodArgument( "count", count, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "pairInfoList", None, "out", "PortGroup.IpPairInfoList", PortGroup.IpPairInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIps", argTuple)
		return context.Sync()

	def HasDynamicIps( self, callback = None, callbackArg = None ):
		""" Returns true if dynamic ips are to be created, false otherwise
			Returns hasDynamicIps: true if dynamic ips are present, false otherwise """
		arg0 = Aptixia_prv.MethodArgument( "hasDynamicIps", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "HasDynamicIps", argTuple, callback, callbackArg )
	def HasDynamicIps_Sync( self ):
		""" Returns true if dynamic ips are to be created, false otherwise
			Returns hasDynamicIps: true if dynamic ips are present, false otherwise """
		arg0 = Aptixia_prv.MethodArgument( "hasDynamicIps", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "HasDynamicIps", argTuple)
		return context.Sync()

	def GetIpCount( self, callback = None, callbackArg = None ):
		""" Returns the number if ips in the PortGroup
			Returns ipCount: IP count """
		arg0 = Aptixia_prv.MethodArgument( "ipCount", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpCount", argTuple, callback, callbackArg )
	def GetIpCount_Sync( self ):
		""" Returns the number if ips in the PortGroup
			Returns ipCount: IP count """
		arg0 = Aptixia_prv.MethodArgument( "ipCount", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpCount", argTuple)
		return context.Sync()

	def GetIpCountEx( self, allocationMechanism, protocol, callback = None, callbackArg = None ):
		""" Returns the number of ips satisfying the filter parameters
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			Returns ipCount: IP count """
		arg0 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg1 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg2 = Aptixia_prv.MethodArgument( "ipCount", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpCount", argTuple, callback, callbackArg )
	def GetIpCountEx_Sync( self, allocationMechanism, protocol ):
		""" Returns the number of ips satisfying the filter parameters
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			Returns ipCount: IP count """
		arg0 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg1 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg2 = Aptixia_prv.MethodArgument( "ipCount", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpCount", argTuple)
		return context.Sync()

	def GetRangeInformationList( self, callback = None, callbackArg = None ):
		""" Returns the range information list
			Returns rangeInformationList: List of range information structures """
		arg0 = Aptixia_prv.MethodArgument( "rangeInformationList", None, "out", "PortGroup.RangeInformationList", PortGroup.RangeInformationList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetRangeInformationList", argTuple, callback, callbackArg )
	def GetRangeInformationList_Sync( self ):
		""" Returns the range information list
			Returns rangeInformationList: List of range information structures """
		arg0 = Aptixia_prv.MethodArgument( "rangeInformationList", None, "out", "PortGroup.RangeInformationList", PortGroup.RangeInformationList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetRangeInformationList", argTuple)
		return context.Sync()

	def GetPorts( self, callback = None, callbackArg = None ):
		""" Returns an array of IPort objects containing description of every port in the port group. All exceptions are passed to the caller
			Returns portList: List of ports """
		arg0 = Aptixia_prv.MethodArgument( "portList", None, "out", "PortGroup.PortList", PortGroup.PortList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPorts", argTuple, callback, callbackArg )
	def GetPorts_Sync( self ):
		""" Returns an array of IPort objects containing description of every port in the port group. All exceptions are passed to the caller
			Returns portList: List of ports """
		arg0 = Aptixia_prv.MethodArgument( "portList", None, "out", "PortGroup.PortList", PortGroup.PortList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPorts", argTuple)
		return context.Sync()

	def GetTestIpAddresses( self, portList, callback = None, callbackArg = None ):
		""" Returns an IpAddressList(an array of strings) containg ips mapped to ports in the portList. All exceptions are passed to the caller
			portList: A list of port description objects (IPort)
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple, callback, callbackArg )
	def GetTestIpAddresses_Sync( self, portList ):
		""" Returns an IpAddressList(an array of strings) containg ips mapped to ports in the portList. All exceptions are passed to the caller
			portList: A list of port description objects (IPort)
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple)
		return context.Sync()

	def GetTestIpAddressesEx( self, portList, callback = None, callbackArg = None ):
		""" Returns an IpAddressList(a list of InterfaceInfo) containg ips and Vlan informations mapped to ports in the portList. All exceptions are passed to the caller
			portList: A list of port description objects (IPort)
			Returns ipAddressList: List of informations """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.InterfaceInfoList", PortGroup.InterfaceInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple, callback, callbackArg )
	def GetTestIpAddressesEx_Sync( self, portList ):
		""" Returns an IpAddressList(a list of InterfaceInfo) containg ips and Vlan informations mapped to ports in the portList. All exceptions are passed to the caller
			portList: A list of port description objects (IPort)
			Returns ipAddressList: List of informations """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.InterfaceInfoList", PortGroup.InterfaceInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple)
		return context.Sync()

	def GetTestIpAddressesExEx( self, portList, allocationMechanism, protocol, callback = None, callbackArg = None ):
		""" Returns the IpAddressList.
			portList: A list of port description objects (IPort)
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg2 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg3 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple, callback, callbackArg )
	def GetTestIpAddressesExEx_Sync( self, portList, allocationMechanism, protocol ):
		""" Returns the IpAddressList.
			portList: A list of port description objects (IPort)
			allocationMechanism: IP address allocation mechanism
			protocol: Protocol type
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "portList", portList, "in", "PortGroup.PortList", PortGroup.PortList)
		arg1 = Aptixia_prv.MethodArgument( "allocationMechanism", allocationMechanism, "in", "PortGroup.eIpAllocationMechanism", PortGroup.eIpAllocationMechanism)
		arg2 = Aptixia_prv.MethodArgument( "protocol", protocol, "in", "PortGroup.eProtocol", PortGroup.eProtocol)
		arg3 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestIpAddresses", argTuple)
		return context.Sync()

	def GetShortForm( self, ipAddresses, callback = None, callbackArg = None ):
		""" Returns an IpAddressList(an array of strings) containg ips in the short form
			ipAddresses: A list of ip addresses
			Returns shortIpAddresses: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "ipAddresses", ipAddresses, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "shortIpAddresses", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetShortForm", argTuple, callback, callbackArg )
	def GetShortForm_Sync( self, ipAddresses ):
		""" Returns an IpAddressList(an array of strings) containg ips in the short form
			ipAddresses: A list of ip addresses
			Returns shortIpAddresses: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "ipAddresses", ipAddresses, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "shortIpAddresses", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetShortForm", argTuple)
		return context.Sync()

	def GetAllIpAddresses( self, callback = None, callbackArg = None ):
		""" Returns an IpAddressList(an array of strings) containg all the ips. All exceptions are passed to the caller
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAllIpAddresses", argTuple, callback, callbackArg )
	def GetAllIpAddresses_Sync( self ):
		""" Returns an IpAddressList(an array of strings) containg all the ips. All exceptions are passed to the caller
			Returns ipAddressList: List of ip addresses """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", None, "out", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAllIpAddresses", argTuple)
		return context.Sync()

	def GetIpAddressInfo( self, ipAddressList, callback = None, callbackArg = None ):
		""" Returns a list of port description objects for the corresponding Ip addresses in the ipAddressList. If an ip address does not exists then the corresponding port description object contains empty strings. All exceptions are passed to the caller
			ipAddressList: List of IP addresses
			Returns portList: List of ports """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", ipAddressList, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "portList", None, "out", "PortGroup.PortList", PortGroup.PortList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpAddressInfo", argTuple, callback, callbackArg )
	def GetIpAddressInfo_Sync( self, ipAddressList ):
		""" Returns a list of port description objects for the corresponding Ip addresses in the ipAddressList. If an ip address does not exists then the corresponding port description object contains empty strings. All exceptions are passed to the caller
			ipAddressList: List of IP addresses
			Returns portList: List of ports """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", ipAddressList, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "portList", None, "out", "PortGroup.PortList", PortGroup.PortList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpAddressInfo", argTuple)
		return context.Sync()

	def GetInterfaceInfoForIps( self, ipAddressList, callback = None, callbackArg = None ):
		""" Returns a list of Interface Info structs for the corresponding ips given. All exceptions are passed to the caller
			ipAddressList: List of ip addresses
			Returns interfaceInfoList: List of interfaces """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", ipAddressList, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "interfaceInfoList", None, "out", "PortGroup.InterfaceInfoList", PortGroup.InterfaceInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetInterfaceInfoForIps", argTuple, callback, callbackArg )
	def GetInterfaceInfoForIps_Sync( self, ipAddressList ):
		""" Returns a list of Interface Info structs for the corresponding ips given. All exceptions are passed to the caller
			ipAddressList: List of ip addresses
			Returns interfaceInfoList: List of interfaces """
		arg0 = Aptixia_prv.MethodArgument( "ipAddressList", ipAddressList, "in", "PortGroup.IpAddressList", PortGroup.IpAddressList)
		arg1 = Aptixia_prv.MethodArgument( "interfaceInfoList", None, "out", "PortGroup.InterfaceInfoList", PortGroup.InterfaceInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetInterfaceInfoForIps", argTuple)
		return context.Sync()

	def StackElementPluginInfo( self, callback = None, callbackArg = None ):
		""" Returns the information for a plugin
			Returns retval: Plugin information list """
		arg0 = Aptixia_prv.MethodArgument( "retval", None, "out", "StackElementPlugin.PluginInfoList", StackElementPlugin.StackElementPlugin.PluginInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StackElementPluginInfo", argTuple, callback, callbackArg )
	def StackElementPluginInfo_Sync( self ):
		""" Returns the information for a plugin
			Returns retval: Plugin information list """
		arg0 = Aptixia_prv.MethodArgument( "retval", None, "out", "StackElementPlugin.PluginInfoList", StackElementPlugin.StackElementPlugin.PluginInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StackElementPluginInfo", argTuple)
		return context.Sync()

	def CandidateStackPointRefs( self, pluginType, callback = None, callbackArg = None ):
		""" Returns a list of candidates
			pluginType: Type of plugin
			Returns candidateList: List of candidates """
		arg0 = Aptixia_prv.MethodArgument( "pluginType", pluginType, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "candidateList", None, "out", "PortGroup.StackElementPluginList", PortGroup.StackElementPluginList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CandidateStackPointRefs", argTuple, callback, callbackArg )
	def CandidateStackPointRefs_Sync( self, pluginType ):
		""" Returns a list of candidates
			pluginType: Type of plugin
			Returns candidateList: List of candidates """
		arg0 = Aptixia_prv.MethodArgument( "pluginType", pluginType, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "candidateList", None, "out", "PortGroup.StackElementPluginList", PortGroup.StackElementPluginList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CandidateStackPointRefs", argTuple)
		return context.Sync()

	def DodPackageToPortGroup( self, packageName, callback = None, callbackArg = None ):
		""" Downloads the specified package to the ports in the port group
			packageName: Name of the package """
		arg0 = Aptixia_prv.MethodArgument( "packageName", packageName, "in", "PortGroup.StringVector", PortGroup.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodPackageToPortGroup", argTuple, callback, callbackArg )
	def DodPackageToPortGroup_Sync( self, packageName ):
		""" Downloads the specified package to the ports in the port group
			packageName: Name of the package """
		arg0 = Aptixia_prv.MethodArgument( "packageName", packageName, "in", "PortGroup.StringVector", PortGroup.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DodPackageToPortGroup", argTuple)
		return context.Sync()

	def SetArpForGateway( self, ipAddress, val, callback = None, callbackArg = None ):
		""" Sets arp for gateway
			ipAddress: IP address
			val: If true arp is set """
		arg0 = Aptixia_prv.MethodArgument( "ipAddress", ipAddress, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "val", val, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetArpForGateway", argTuple, callback, callbackArg )
	def SetArpForGateway_Sync( self, ipAddress, val ):
		""" Sets arp for gateway
			ipAddress: IP address
			val: If true arp is set """
		arg0 = Aptixia_prv.MethodArgument( "ipAddress", ipAddress, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "val", val, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetArpForGateway", argTuple)
		return context.Sync()

	def GetGatewayMacForIp( self, ipAddress, callback = None, callbackArg = None ):
		""" Retrieves the gateway's MAC address for a given IP address
			ipAddress: IP address
			Returns gatewayMac: MAC address for the gateway """
		arg0 = Aptixia_prv.MethodArgument( "ipAddress", ipAddress, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "gatewayMac", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetGatewayMacForIp", argTuple, callback, callbackArg )
	def GetGatewayMacForIp_Sync( self, ipAddress ):
		""" Retrieves the gateway's MAC address for a given IP address
			ipAddress: IP address
			Returns gatewayMac: MAC address for the gateway """
		arg0 = Aptixia_prv.MethodArgument( "ipAddress", ipAddress, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "gatewayMac", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetGatewayMacForIp", argTuple)
		return context.Sync()

	def ForceARPCacheRefresh( self, callback = None, callbackArg = None ):
		""" Refresh the ARP cache so that every new test run starts with clean ARP information """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ForceARPCacheRefresh", argTuple, callback, callbackArg )
	def ForceARPCacheRefresh_Sync( self ):
		""" Refresh the ARP cache so that every new test run starts with clean ARP information """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ForceARPCacheRefresh", argTuple)
		return context.Sync()

	def GetIpV4V6RangeList( self, port, callback = None, callbackArg = None ):
		""" returns the ip ranges for the specified port
			port: Port descriptor in [chassis];[card];[port] format
			Returns ipRangeList: A list of ip range info structures for the specified port """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "ipRangeList", None, "out", "PortGroup.IpV4V6RangeInfoList", PortGroup.IpV4V6RangeInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpV4V6RangeList", argTuple, callback, callbackArg )
	def GetIpV4V6RangeList_Sync( self, port ):
		""" returns the ip ranges for the specified port
			port: Port descriptor in [chassis];[card];[port] format
			Returns ipRangeList: A list of ip range info structures for the specified port """
		arg0 = Aptixia_prv.MethodArgument( "port", port, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "ipRangeList", None, "out", "PortGroup.IpV4V6RangeInfoList", PortGroup.IpV4V6RangeInfoList)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetIpV4V6RangeList", argTuple)
		return context.Sync()

	def GetStackConfigurationsPerformed( self, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "count", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStackConfigurationsPerformed", argTuple, callback, callbackArg )
	def GetStackConfigurationsPerformed_Sync( self ):
		arg0 = Aptixia_prv.MethodArgument( "count", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStackConfigurationsPerformed", argTuple)
		return context.Sync()

	def RunScript( self, scriptFile, callback = None, callbackArg = None ):
		""" Runs the specified script on all ports in the port group
			scriptFile: The name of the script file to run on the ports """
		arg0 = Aptixia_prv.MethodArgument( "scriptFile", scriptFile, "in", "file", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RunScript", argTuple, callback, callbackArg )
	def RunScript_Sync( self, scriptFile ):
		""" Runs the specified script on all ports in the port group
			scriptFile: The name of the script file to run on the ports """
		arg0 = Aptixia_prv.MethodArgument( "scriptFile", scriptFile, "in", "file", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RunScript", argTuple)
		return context.Sync()

	def RunScriptOnPort( self, uniquePortId, scriptFile, callback = None, callbackArg = None ):
		""" Runs the specified script on the specified port
			uniquePortId: Unique id of the port
			scriptFile: The name of the script file to run on the port """
		arg0 = Aptixia_prv.MethodArgument( "uniquePortId", uniquePortId, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "scriptFile", scriptFile, "in", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RunScriptOnPort", argTuple, callback, callbackArg )
	def RunScriptOnPort_Sync( self, uniquePortId, scriptFile ):
		""" Runs the specified script on the specified port
			uniquePortId: Unique id of the port
			scriptFile: The name of the script file to run on the port """
		arg0 = Aptixia_prv.MethodArgument( "uniquePortId", uniquePortId, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "scriptFile", scriptFile, "in", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RunScriptOnPort", argTuple)
		return context.Sync()


