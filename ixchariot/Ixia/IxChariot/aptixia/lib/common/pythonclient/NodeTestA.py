import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class NodeTestA( XProtocolObject.XProtocolObject ):
	""" NodeTestA is to test CORBA access to TestServer. """
	# Class Properties
	def _get_stringVarA (self):
		return self.getVar ("stringVarA")
	def _set_stringVarA (self, value):
		self.setVar ("stringVarA", value)
	stringVarA = property (_get_stringVarA, _set_stringVarA, None, "stringVarA property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( NodeTestA, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarA"] = "default string"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "NodeTestA"


