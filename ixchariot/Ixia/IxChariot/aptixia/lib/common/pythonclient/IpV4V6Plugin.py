import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import IpV4V6Range, Dhcp


class IpV4V6Plugin( StackElementPlugin.StackElementPlugin ):
	""" Network stack element plugin that manages IP v4 and v6 addressesas a list of address blocks or 'ranges'. """
	# Class Properties
	def _get_rangeList (self):
		return self.getListVar ("rangeList")
	rangeList = property (_get_rangeList, None, None, "rangeList property")
	def _get_dhcp (self):
		return self.getListVar ("dhcp")
	dhcp = property (_get_dhcp, None, None, "dhcp property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IpV4V6Plugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["rangeList"] = Aptixia.IxObjectList (self.transactionContext, "IpV4V6Range")
			self.managedProperties["dhcp"] = Dhcp.Dhcp (self)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IpV4V6Plugin"


