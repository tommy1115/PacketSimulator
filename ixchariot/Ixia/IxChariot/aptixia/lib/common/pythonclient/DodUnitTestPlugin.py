import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin


class DodUnitTestPlugin( StackElementPlugin.StackElementPlugin ):
	""" Class to help unit test the DOD functionality """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DodUnitTestPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DodUnitTestPlugin"

		pass

