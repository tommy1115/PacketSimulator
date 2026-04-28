import string, threading
import Aptixia, Aptixia_prv
import CardPlugin


class EthernetCardPlugin( CardPlugin.CardPlugin ):
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( EthernetCardPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "EthernetCardPlugin"

		pass

