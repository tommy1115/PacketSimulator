import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class DnsSearch( XProtocolObject.XProtocolObject ):
	""" Describes a search item as to be defined in resolv.conf """
	# Class Properties
	def _get_search (self):
		return self.getVar ("search")
	def _set_search (self, value):
		self.setVar ("search", value)
	search = property (_get_search, _set_search, None, "search property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DnsSearch, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["search"] = "Untitled"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DnsSearch"


