import string, threading
import Aptixia, Aptixia_prv
import NodeTestA


class NodeTestB( NodeTestA.NodeTestA ):
	""" NodeTestB is used to test CORBA access to TestServer. """
	# Class Properties
	def _get_stringVarB (self):
		return self.getVar ("stringVarB")
	def _set_stringVarB (self, value):
		self.setVar ("stringVarB", value)
	stringVarB = property (_get_stringVarB, _set_stringVarB, None, "stringVarB property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( NodeTestB, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarB"] = "default string"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "NodeTestB"


