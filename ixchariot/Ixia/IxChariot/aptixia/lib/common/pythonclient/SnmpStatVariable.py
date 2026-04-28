import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class SnmpStatVariable( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_oidText (self):
		return self.getVar ("oidText")
	def _set_oidText (self, value):
		self.setVar ("oidText", value)
	oidText = property (_get_oidText, _set_oidText, None, "oidText property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( SnmpStatVariable, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["oidText"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "SnmpStatVariable"


