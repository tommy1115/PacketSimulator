import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class DnsNameServer( XProtocolObject.XProtocolObject ):
	""" Describes a nameserver item as to be defined in resolv.conf """
	# Class Properties
	def _get_nameServer (self):
		return self.getVar ("nameServer")
	def _set_nameServer (self, value):
		self.setVar ("nameServer", value)
	nameServer = property (_get_nameServer, _set_nameServer, None, "nameServer property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DnsNameServer, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["nameServer"] = "127.0.0.1"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DnsNameServer"


