import string, threading
import Aptixia, Aptixia_prv
import TestServer
import XPBootstrap


class TestServerPrivate( TestServer.TestServer ):
	""" This is the actual class being used to instantiate TestServer. Itcontains administrative and regression functions not availableto the "normal" user. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TestServerPrivate, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TestServerPrivate"

	# Class Methods
	def CreateTestObject( self, callback = None, callbackArg = None ):
		""" Create an XPBootstrap regression object
			Returns bootstrap: The returned regression object """
		arg0 = Aptixia_prv.MethodArgument( "bootstrap", None, "out", "XPBootstrap", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestObject", argTuple, callback, callbackArg )
	def CreateTestObject_Sync( self ):
		""" Create an XPBootstrap regression object
			Returns bootstrap: The returned regression object """
		arg0 = Aptixia_prv.MethodArgument( "bootstrap", None, "out", "XPBootstrap", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestObject", argTuple)
		return context.Sync()


