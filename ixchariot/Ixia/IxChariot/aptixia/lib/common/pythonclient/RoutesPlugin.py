import string, threading
import Aptixia, Aptixia_prv
import GlobalPlugin
import Route


class RoutesPlugin( GlobalPlugin.GlobalPlugin ):
	""" Stackelement plugin through which users can configure routes on ports """
	# Class Properties
	def _get_routes (self):
		return self.getListVar ("routes")
	routes = property (_get_routes, None, None, "routes property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( RoutesPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["routes"] = Aptixia.IxObjectList (self.transactionContext, "Route")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "RoutesPlugin"


