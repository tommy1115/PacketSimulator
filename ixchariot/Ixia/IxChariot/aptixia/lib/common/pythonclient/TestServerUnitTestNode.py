import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import StackElementPlugin


class TestServerUnitTestNode( XProtocolObject.XProtocolObject ):
	""" This class is used for regression only """
	# Class Properties
	def _get_stackElementPlugin (self):
		return self.getListVar ("stackElementPlugin")
	def _set_stackElementPlugin (self, value):
		self.setVar ("stackElementPlugin", value)
	stackElementPlugin = property (_get_stackElementPlugin, _set_stackElementPlugin, None, "stackElementPlugin property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TestServerUnitTestNode, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stackElementPlugin"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TestServerUnitTestNode"


