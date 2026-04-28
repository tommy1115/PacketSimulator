import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import ServiceExtension


class ServiceExtensionsWrapper( XProtocolObject.XProtocolObject ):
	""" Access to the service extensions list """
	# Class Properties
	def _get_serviceExtensions (self):
		return self.getListVar ("serviceExtensions")
	serviceExtensions = property (_get_serviceExtensions, None, None, "serviceExtensions property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ServiceExtensionsWrapper, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["serviceExtensions"] = Aptixia.IxObjectList (self.transactionContext, "ServiceExtension")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ServiceExtensionsWrapper"


