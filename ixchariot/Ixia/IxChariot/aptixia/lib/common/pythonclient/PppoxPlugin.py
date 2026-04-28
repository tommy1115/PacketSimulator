import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import AtmRange, MacRange, VlanIdRange, PvcRange, Pppoe, Ppp


class PppoxPlugin( StackElementPlugin.StackElementPlugin ):
	# Class Properties
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_role (self):
		return self.getVar ("role")
	def _set_role (self, value):
		self.setVar ("role", value)
	role = property (_get_role, _set_role, None, "role property")
	def _get_numSessions (self):
		return self.getVar ("numSessions")
	def _set_numSessions (self, value):
		self.setVar ("numSessions", value)
	numSessions = property (_get_numSessions, _set_numSessions, None, "numSessions property")
	def _get_setupRate (self):
		return self.getVar ("setupRate")
	def _set_setupRate (self, value):
		self.setVar ("setupRate", value)
	setupRate = property (_get_setupRate, _set_setupRate, None, "setupRate property")
	def _get_enableThrottling (self):
		return self.getVar ("enableThrottling")
	def _set_enableThrottling (self, value):
		self.setVar ("enableThrottling", value)
	enableThrottling = property (_get_enableThrottling, _set_enableThrottling, None, "enableThrottling property")
	def _get_maxOutstandingSessions (self):
		return self.getVar ("maxOutstandingSessions")
	def _set_maxOutstandingSessions (self, value):
		self.setVar ("maxOutstandingSessions", value)
	maxOutstandingSessions = property (_get_maxOutstandingSessions, _set_maxOutstandingSessions, None, "maxOutstandingSessions property")
	def _get_teardownRate (self):
		return self.getVar ("teardownRate")
	def _set_teardownRate (self, value):
		self.setVar ("teardownRate", value)
	teardownRate = property (_get_teardownRate, _set_teardownRate, None, "teardownRate property")
	def _get_atmRange (self):
		return self.getListVar ("atmRange")
	def _set_atmRange (self, value):
		self.setVar ("atmRange", value)
	atmRange = property (_get_atmRange, _set_atmRange, None, "atmRange property")
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
	def _get_pvcRange (self):
		return self.getListVar ("pvcRange")
	def _set_pvcRange (self, value):
		self.setVar ("pvcRange", value)
	pvcRange = property (_get_pvcRange, _set_pvcRange, None, "pvcRange property")
	def _get_pppoe (self):
		return self.getListVar ("pppoe")
	pppoe = property (_get_pppoe, None, None, "pppoe property")
	def _get_ppp (self):
		return self.getListVar ("ppp")
	ppp = property (_get_ppp, None, None, "ppp property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PppoxPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = True
			self.managedProperties["role"] = "client"
			self.managedProperties["numSessions"] = 1
			self.managedProperties["setupRate"] = 100
			self.managedProperties["enableThrottling"] = True
			self.managedProperties["maxOutstandingSessions"] = 1000
			self.managedProperties["teardownRate"] = 100
			self.managedProperties["atmRange"] = None
			self.managedProperties["macRange"] = None
			self.managedProperties["vlanRange"] = None
			self.managedProperties["pvcRange"] = None
			self.managedProperties["pppoe"] = Pppoe.Pppoe (self)
			self.managedProperties["ppp"] = Ppp.Ppp (self)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PppoxPlugin"

	# Class Methods
	def GetTestMode( self, callback = None, callbackArg = None ):
		""" Return basic mode of test, e.g. pppoe, pppoa, etc..(NOTE: for internal use only)
			Returns testMode: Basic mode of test, e.g. pppoe, pppoa, etc..(NOTE: for internal use only) """
		arg0 = Aptixia_prv.MethodArgument( "testMode", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestMode", argTuple, callback, callbackArg )
	def GetTestMode_Sync( self ):
		""" Return basic mode of test, e.g. pppoe, pppoa, etc..(NOTE: for internal use only)
			Returns testMode: Basic mode of test, e.g. pppoe, pppoa, etc..(NOTE: for internal use only) """
		arg0 = Aptixia_prv.MethodArgument( "testMode", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestMode", argTuple)
		return context.Sync()


