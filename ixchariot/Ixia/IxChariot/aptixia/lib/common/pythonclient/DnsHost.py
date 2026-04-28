import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class DnsHost( XProtocolObject.XProtocolObject ):
	""" Describes a host as to be defined in hosts file """
	# Class Properties
	def _get_hostIP (self):
		return self.getVar ("hostIP")
	def _set_hostIP (self, value):
		self.setVar ("hostIP", value)
	hostIP = property (_get_hostIP, _set_hostIP, None, "hostIP property")
	def _get_hostName (self):
		return self.getVar ("hostName")
	def _set_hostName (self, value):
		self.setVar ("hostName", value)
	hostName = property (_get_hostName, _set_hostName, None, "hostName property")
	def _get_alias1 (self):
		return self.getVar ("alias1")
	def _set_alias1 (self, value):
		self.setVar ("alias1", value)
	alias1 = property (_get_alias1, _set_alias1, None, "alias1 property")
	def _get_alias2 (self):
		return self.getVar ("alias2")
	def _set_alias2 (self, value):
		self.setVar ("alias2", value)
	alias2 = property (_get_alias2, _set_alias2, None, "alias2 property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DnsHost, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["hostIP"] = "127.0.0.1"
			self.managedProperties["hostName"] = "localhost"
			self.managedProperties["alias1"] = ""
			self.managedProperties["alias2"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DnsHost"


