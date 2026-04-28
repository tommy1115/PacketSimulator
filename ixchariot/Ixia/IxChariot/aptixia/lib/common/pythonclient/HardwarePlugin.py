import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import CardPlugin


class HardwarePlugin( StackElementPlugin.StackElementPlugin ):
	# Class Properties
	def _get_card (self):
		return self.getListVar ("card")
	def _set_card (self, value):
		self.setVar ("card", value)
	card = property (_get_card, _set_card, None, "card property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( HardwarePlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["card"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "HardwarePlugin"

	# Class Methods
	def GetCardClassification( self, callback = None, callbackArg = None ):
		""" Method to get the card type or classification.
			Returns classification: The classification for the card. """
		arg0 = Aptixia_prv.MethodArgument( "classification", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetCardClassification", argTuple, callback, callbackArg )
	def GetCardClassification_Sync( self ):
		""" Method to get the card type or classification.
			Returns classification: The classification for the card. """
		arg0 = Aptixia_prv.MethodArgument( "classification", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetCardClassification", argTuple)
		return context.Sync()


