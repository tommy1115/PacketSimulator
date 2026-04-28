import string, threading
import Aptixia, Aptixia_prv
import CardPlugin


class DualPhyPlugin( CardPlugin.CardPlugin ):
	# Class Properties
	def _get_medium (self):
		return self.getVar ("medium")
	def _set_medium (self, value):
		self.setVar ("medium", value)
	medium = property (_get_medium, _set_medium, None, "medium property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DualPhyPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["medium"] = "copper"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DualPhyPlugin"


