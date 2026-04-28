import string, threading
import Aptixia, Aptixia_prv
import XPUnitTestA


class XPUnitTestB( XPUnitTestA.XPUnitTestA ):
	""" Provides Unit Test facility for object hierarchy """
	# Class Properties
	def _get_stringVarB (self):
		return self.getVar ("stringVarB")
	def _set_stringVarB (self, value):
		self.setVar ("stringVarB", value)
	stringVarB = property (_get_stringVarB, _set_stringVarB, None, "stringVarB property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTestB, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarB"] = "qrt"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTestB"

	# Class Methods
	def GetTestStringB( self, callback = None, callbackArg = None ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringB", argTuple, callback, callbackArg )
	def GetTestStringB_Sync( self ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringB", argTuple)
		return context.Sync()


