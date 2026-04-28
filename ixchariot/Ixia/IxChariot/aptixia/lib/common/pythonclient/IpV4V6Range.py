import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import Vlan, MacRange, VlanIdRange, AtmRange, PvcRange, DhcpSettings


class IpV4V6Range( XProtocolObject.XProtocolObject ):
	""" Manages a range of IP addresses within a IpV4V6 stack element plugin. """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_macRange (self):
		return self.getListVar ("macRange")
	def _set_macRange (self, value):
		self.setVar ("macRange", value)
	macRange = property (_get_macRange, _set_macRange, None, "macRange property")
	def _get_vlanRange (self):
		return self.getListVar ("vlanRange")
	def _set_vlanRange (self, value):
		self.setVar ("vlanRange", value)
	vlanRange = property (_get_vlanRange, _set_vlanRange, None, "vlanRange property")
	def _get_atmRange (self):
		return self.getListVar ("atmRange")
	def _set_atmRange (self, value):
		self.setVar ("atmRange", value)
	atmRange = property (_get_atmRange, _set_atmRange, None, "atmRange property")
	def _get_pvcRange (self):
		return self.getListVar ("pvcRange")
	def _set_pvcRange (self, value):
		self.setVar ("pvcRange", value)
	pvcRange = property (_get_pvcRange, _set_pvcRange, None, "pvcRange property")
	def _get_generateStatistics (self):
		return self.getVar ("generateStatistics")
	def _set_generateStatistics (self, value):
		self.setVar ("generateStatistics", value)
	generateStatistics = property (_get_generateStatistics, _set_generateStatistics, None, "generateStatistics property")
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_ipType (self):
		return self.getVar ("ipType")
	def _set_ipType (self, value):
		self.setVar ("ipType", value)
	ipType = property (_get_ipType, _set_ipType, None, "ipType property")
	def _get_ipAddress (self):
		return self.getVar ("ipAddress")
	def _set_ipAddress (self, value):
		self.setVar ("ipAddress", value)
	ipAddress = property (_get_ipAddress, _set_ipAddress, None, "ipAddress property")
	def _get_incrementBy (self):
		return self.getVar ("incrementBy")
	def _set_incrementBy (self, value):
		self.setVar ("incrementBy", value)
	incrementBy = property (_get_incrementBy, _set_incrementBy, None, "incrementBy property")
	def _get_gatewayAddress (self):
		return self.getVar ("gatewayAddress")
	def _set_gatewayAddress (self, value):
		self.setVar ("gatewayAddress", value)
	gatewayAddress = property (_get_gatewayAddress, _set_gatewayAddress, None, "gatewayAddress property")
	def _get_prefix (self):
		return self.getVar ("prefix")
	def _set_prefix (self, value):
		self.setVar ("prefix", value)
	prefix = property (_get_prefix, _set_prefix, None, "prefix property")
	def _get_count (self):
		return self.getVar ("count")
	def _set_count (self, value):
		self.setVar ("count", value)
	count = property (_get_count, _set_count, None, "count property")
	def _get_mss (self):
		return self.getVar ("mss")
	def _set_mss (self, value):
		self.setVar ("mss", value)
	mss = property (_get_mss, _set_mss, None, "mss property")
	def _get_dhcpSettings (self):
		return self.getListVar ("dhcpSettings")
	def _set_dhcpSettings (self, value):
		self.setVar ("dhcpSettings", value)
	dhcpSettings = property (_get_dhcpSettings, _set_dhcpSettings, None, "dhcpSettings property")
	def _get_addressAllocationMechanism (self):
		return self.getVar ("addressAllocationMechanism")
	def _set_addressAllocationMechanism (self, value):
		self.setVar ("addressAllocationMechanism", value)
	addressAllocationMechanism = property (_get_addressAllocationMechanism, _set_addressAllocationMechanism, None, "addressAllocationMechanism property")
	def _get_autoMacGeneration (self):
		return self.getVar ("autoMacGeneration")
	def _set_autoMacGeneration (self, value):
		self.setVar ("autoMacGeneration", value)
	autoMacGeneration = property (_get_autoMacGeneration, _set_autoMacGeneration, None, "autoMacGeneration property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IpV4V6Range, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = "ip-"
			self.managedProperties["macRange"] = None
			self.managedProperties["vlanRange"] = None
			self.managedProperties["atmRange"] = None
			self.managedProperties["pvcRange"] = None
			self.managedProperties["generateStatistics"] = False
			self.managedProperties["enabled"] = True
			self.managedProperties["ipType"] = "IPv4"
			self.managedProperties["ipAddress"] = "10.10.10.2"
			self.managedProperties["incrementBy"] = "0.0.0.1"
			self.managedProperties["gatewayAddress"] = "10.10.10.1"
			self.managedProperties["prefix"] = 24
			self.managedProperties["count"] = 1
			self.managedProperties["mss"] = 1460
			self.managedProperties["dhcpSettings"] = None
			self.managedProperties["addressAllocationMechanism"] = "static"
			self.managedProperties["autoMacGeneration"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IpV4V6Range"

	# Class Methods
	def AutoGenerateMacRange( self, generate, callback = None, callbackArg = None ):
		""" Generate or remove a MAC range on demand.
			generate: If this field is true generate a new mac range. If the value is set to falsethe mac range associated is deleted.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "generate", generate, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGenerateMacRange", argTuple, callback, callbackArg )
	def AutoGenerateMacRange_Sync( self, generate ):
		""" Generate or remove a MAC range on demand.
			generate: If this field is true generate a new mac range. If the value is set to falsethe mac range associated is deleted.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "generate", generate, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGenerateMacRange", argTuple)
		return context.Sync()

	def AutoGenerateAtmRange( self, callback = None, callbackArg = None ):
		""" Generate or remove an ATM range on demand.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGenerateAtmRange", argTuple, callback, callbackArg )
	def AutoGenerateAtmRange_Sync( self ):
		""" Generate or remove an ATM range on demand.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGenerateAtmRange", argTuple)
		return context.Sync()

	def AutoGeneratePvcRange( self, callback = None, callbackArg = None ):
		""" Generate or remove a PVC range on demand.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGeneratePvcRange", argTuple, callback, callbackArg )
	def AutoGeneratePvcRange_Sync( self ):
		""" Generate or remove a PVC range on demand.
			Returns success: Return value is true if the range was generated. """
		arg0 = Aptixia_prv.MethodArgument( "success", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AutoGeneratePvcRange", argTuple)
		return context.Sync()


