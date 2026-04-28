import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class ChartAxis( XProtocolObject.XProtocolObject ):
	""" Base class for X and Y Axis Properties for StatViewer Charts """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ChartAxis, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ChartAxis"

		pass

