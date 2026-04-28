import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class XPUnitTestD( XProtocolObject.XProtocolObject ):
	""" Provides Unit Test facility for object hierarchy """
	# Class Properties
	def _get_stringVarD (self):
		return self.getVar ("stringVarD")
	def _set_stringVarD (self, value):
		self.setVar ("stringVarD", value)
	stringVarD = property (_get_stringVarD, _set_stringVarD, None, "stringVarD property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTestD, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarD"] = "dzz"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTestD"


