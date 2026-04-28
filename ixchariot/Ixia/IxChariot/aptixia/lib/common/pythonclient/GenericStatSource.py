import string, threading
import Aptixia, Aptixia_prv
import DataDrivenFormBase


class GenericStatSource( DataDrivenFormBase.DataDrivenFormBase ):
	""" Base interface for all additional Stat Sources used by GenericTestModel """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( GenericStatSource, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "GenericStatSource"

	# Class Methods
	def Configure( self, callback = None, callbackArg = None ):
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Configure", argTuple, callback, callbackArg )
	def Configure_Sync( self ):
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Configure", argTuple)
		return context.Sync()

	def Start( self, callback = None, callbackArg = None ):
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Start", argTuple, callback, callbackArg )
	def Start_Sync( self ):
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Start", argTuple)
		return context.Sync()

	def Stop( self, callback = None, callbackArg = None ):
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Stop", argTuple, callback, callbackArg )
	def Stop_Sync( self ):
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Stop", argTuple)
		return context.Sync()

	def Deconfigure( self, callback = None, callbackArg = None ):
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Deconfigure", argTuple, callback, callbackArg )
	def Deconfigure_Sync( self ):
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Deconfigure", argTuple)
		return context.Sync()


