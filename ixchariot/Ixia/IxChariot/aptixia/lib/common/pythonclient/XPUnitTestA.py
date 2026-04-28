import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import XPUnitTestD


class XPUnitTestA( XProtocolObject.XProtocolObject ):
	""" Provides Unit Test facility for object hierarchy """
	# Class Properties
	def _get_stringVar (self):
		return self.getVar ("stringVar")
	def _set_stringVar (self, value):
		self.setVar ("stringVar", value)
	stringVar = property (_get_stringVar, _set_stringVar, None, "stringVar property")
	def _get_subNode (self):
		return self.getListVar ("subNode")
	subNode = property (_get_subNode, None, None, "subNode property")
	def _get_secondReference (self):
		return self.getListVar ("secondReference")
	def _set_secondReference (self, value):
		self.setVar ("secondReference", value)
	secondReference = property (_get_secondReference, _set_secondReference, None, "secondReference property")
	def _get_subNodeList (self):
		return self.getListVar ("subNodeList")
	subNodeList = property (_get_subNodeList, None, None, "subNodeList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTestA, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVar"] = "xyz"
			self.managedProperties["subNode"] = XPUnitTestD.XPUnitTestD (self)
			self.managedProperties["secondReference"] = None
			self.managedProperties["subNodeList"] = Aptixia.IxObjectList (self.transactionContext, "XPUnitTestD")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTestA"

	# Class Methods
	def GetTestStringA( self, callback = None, callbackArg = None ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringA", argTuple, callback, callbackArg )
	def GetTestStringA_Sync( self ):
		""" Test method
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestStringA", argTuple)
		return context.Sync()


