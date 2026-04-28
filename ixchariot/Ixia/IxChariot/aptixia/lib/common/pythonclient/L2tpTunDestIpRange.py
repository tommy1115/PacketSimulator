import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import IpV4V6Range


class L2tpTunDestIpRange( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_sourceIpRange (self):
		return self.getListVar ("sourceIpRange")
	def _set_sourceIpRange (self, value):
		self.setVar ("sourceIpRange", value)
	sourceIpRange = property (_get_sourceIpRange, _set_sourceIpRange, None, "sourceIpRange property")
	def _get_baseTunDestIp (self):
		return self.getVar ("baseTunDestIp")
	def _set_baseTunDestIp (self, value):
		self.setVar ("baseTunDestIp", value)
	baseTunDestIp = property (_get_baseTunDestIp, _set_baseTunDestIp, None, "baseTunDestIp property")
	def _get_incrementBy (self):
		return self.getVar ("incrementBy")
	def _set_incrementBy (self, value):
		self.setVar ("incrementBy", value)
	incrementBy = property (_get_incrementBy, _set_incrementBy, None, "incrementBy property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( L2tpTunDestIpRange, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = True
			self.managedProperties["sourceIpRange"] = None
			self.managedProperties["baseTunDestIp"] = "10.10.10.2"
			self.managedProperties["incrementBy"] = "0.0.0.1"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "L2tpTunDestIpRange"


