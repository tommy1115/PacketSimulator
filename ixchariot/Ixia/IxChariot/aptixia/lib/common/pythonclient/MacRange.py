import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class MacRange( XProtocolObject.XProtocolObject ):
	""" Range of multiple MAC addresses for fine grained configuration """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_mac (self):
		return self.getVar ("mac")
	def _set_mac (self, value):
		self.setVar ("mac", value)
	mac = property (_get_mac, _set_mac, None, "mac property")
	def _get_incrementBy (self):
		return self.getVar ("incrementBy")
	def _set_incrementBy (self, value):
		self.setVar ("incrementBy", value)
	incrementBy = property (_get_incrementBy, _set_incrementBy, None, "incrementBy property")
	def _get_mtu (self):
		return self.getVar ("mtu")
	def _set_mtu (self, value):
		self.setVar ("mtu", value)
	mtu = property (_get_mtu, _set_mtu, None, "mtu property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( MacRange, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = "mac-"
			self.managedProperties["mac"] = "aa:bb:cc:00:00:00"
			self.managedProperties["incrementBy"] = "00:00:00:00:00:01"
			self.managedProperties["mtu"] = 1500

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "MacRange"


