import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class Dhcp( XProtocolObject.XProtocolObject ):
	""" DHCP object which handles configure, deconfigure and IP address retrieval """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Dhcp, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Dhcp"

		pass

