import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class PortController( XProtocolObject.XProtocolObject ):
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PortController, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PortController"

		pass

