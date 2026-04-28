import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin


class GlobalPlugin( StackElementPlugin.StackElementPlugin ):
	""" This is a abstract object that serves a base for globalstack element plugins. The FilterPlugin is one example of a pluginbased on GlobalPlugin. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( GlobalPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "GlobalPlugin"

		pass

