import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import L2tp, PppL2tp, L2tpTunDestIpRange


class L2tpPlugin( StackElementPlugin.StackElementPlugin ):
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
	def _get_numSessions (self):
		return self.getVar ("numSessions")
	def _set_numSessions (self, value):
		self.setVar ("numSessions", value)
	numSessions = property (_get_numSessions, _set_numSessions, None, "numSessions property")
	def _get_l2tp (self):
		return self.getListVar ("l2tp")
	l2tp = property (_get_l2tp, None, None, "l2tp property")
	def _get_pppL2tp (self):
		return self.getListVar ("pppL2tp")
	pppL2tp = property (_get_pppL2tp, None, None, "pppL2tp property")
	def _get_tunDestIpRanges (self):
		return self.getListVar ("tunDestIpRanges")
	tunDestIpRanges = property (_get_tunDestIpRanges, None, None, "tunDestIpRanges property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( L2tpPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = True
			self.managedProperties["role"] = "lac"
			self.managedProperties["setupRate"] = 100
			self.managedProperties["enableThrottling"] = True
			self.managedProperties["maxOutstandingSessions"] = 1000
			self.managedProperties["teardownRate"] = 100
			self.managedProperties["numSessions"] = 1
			self.managedProperties["l2tp"] = L2tp.L2tp (self)
			self.managedProperties["pppL2tp"] = PppL2tp.PppL2tp (self)
			self.managedProperties["tunDestIpRanges"] = Aptixia.IxObjectList (self.transactionContext, "L2tpTunDestIpRange")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "L2tpPlugin"


