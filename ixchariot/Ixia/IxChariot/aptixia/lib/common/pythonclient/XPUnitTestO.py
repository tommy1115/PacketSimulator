import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class XPUnitTestO( XProtocolObject.XProtocolObject ):
	""" Used for internal unit testing """
	# Class Properties
	def _get_stringVarO (self):
		return self.getVar ("stringVarO")
	def _set_stringVarO (self, value):
		self.setVar ("stringVarO", value)
	stringVarO = property (_get_stringVarO, _set_stringVarO, None, "stringVarO property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTestO, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarO"] = "my most excellent string"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTestO"

	# Class Methods
	def GetTestStringO( self, callback = None, callbackArg = None ):
		""" Used for internal unit testing
			Returns v: Used for internal unit testing """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringO", argTuple, callback, callbackArg )
	def GetTestStringO_Sync( self ):
		""" Used for internal unit testing
			Returns v: Used for internal unit testing """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringO", argTuple)
		return context.Sync()


