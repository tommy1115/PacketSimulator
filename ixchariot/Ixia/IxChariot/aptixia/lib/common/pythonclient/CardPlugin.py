import string, threading
import Aptixia, Aptixia_prv
import DataDrivenFormBase


class CardPlugin( DataDrivenFormBase.DataDrivenFormBase ):
	""" This plugin exists as a polymorphic node in hardware plugin.Hardware plugins like Ethernetplugin have subclass types like DualPhy.These are added as subclass of this plugin. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( CardPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "CardPlugin"

		pass

