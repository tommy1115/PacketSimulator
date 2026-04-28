import string, threading
import Aptixia, Aptixia_prv
import XPUnitTestA


class XPUnitTestC( XPUnitTestA.XPUnitTestA ):
	""" Provides Unit Test facility for object hierarchy """
	# Class Properties
	def _get_stringVarC (self):
		return self.getVar ("stringVarC")
	def _set_stringVarC (self, value):
		self.setVar ("stringVarC", value)
	stringVarC = property (_get_stringVarC, _set_stringVarC, None, "stringVarC property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTestC, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVarC"] = "qrt"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTestC"

	# Class Methods
	def GetTestStringC( self, callback = None, callbackArg = None ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringC", argTuple, callback, callbackArg )
	def GetTestStringC_Sync( self ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringC", argTuple)
		return context.Sync()


