import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import Vlan, IpV4V6Range


class EmulatedRouterPlugin( StackElementPlugin.StackElementPlugin ):
	""" EmulatedRouterPlugin plugin configures a single connected interface on the Port CPUrouting traffic from all the unconnected interfaces available on the port CPU,emulating the function of a router. """
	# Class Properties
	def _get_rangeList (self):
		return self.getListVar ("rangeList")
	rangeList = property (_get_rangeList, None, None, "rangeList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( EmulatedRouterPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["rangeList"] = Aptixia.IxObjectList (self.transactionContext, "IpV4V6Range")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "EmulatedRouterPlugin"


