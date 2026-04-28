import string, threading
import Aptixia, Aptixia_prv
import CardPlugin


class EthernetELMPlugin( CardPlugin.CardPlugin ):
	""" Plugin to set Ethernet ELM specific settings in Ethernet ELM type ports. """
	# Class Properties
	def _get_negotiateMasterSlave (self):
		return self.getVar ("negotiateMasterSlave")
	def _set_negotiateMasterSlave (self, value):
		self.setVar ("negotiateMasterSlave", value)
	negotiateMasterSlave = property (_get_negotiateMasterSlave, _set_negotiateMasterSlave, None, "negotiateMasterSlave property")
	def _get_negotiationType (self):
		return self.getVar ("negotiationType")
	def _set_negotiationType (self, value):
		self.setVar ("negotiationType", value)
	negotiationType = property (_get_negotiationType, _set_negotiationType, None, "negotiationType property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( EthernetELMPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["negotiateMasterSlave"] = False
			self.managedProperties["negotiationType"] = "master"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "EthernetELMPlugin"


