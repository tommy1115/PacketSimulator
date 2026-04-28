import string, threading
import Aptixia, Aptixia_prv
import DataDrivenFormBase


class POSPayLoad( DataDrivenFormBase.DataDrivenFormBase ):
	""" This plugin exists as a polymorphic node in POS plugin. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( POSPayLoad, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "POSPayLoad"

		pass

