import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class Route( XProtocolObject.XProtocolObject ):
	""" Route class represents a route """
	# Class Properties
	def _get_protocol (self):
		return self.getVar ("protocol")
	def _set_protocol (self, value):
		self.setVar ("protocol", value)
	protocol = property (_get_protocol, _set_protocol, None, "protocol property")
	def _get_targetType (self):
		return self.getVar ("targetType")
	def _set_targetType (self, value):
		self.setVar ("targetType", value)
	targetType = property (_get_targetType, _set_targetType, None, "targetType property")
	def _get_destinationIp (self):
		return self.getVar ("destinationIp")
	def _set_destinationIp (self, value):
		self.setVar ("destinationIp", value)
	destinationIp = property (_get_destinationIp, _set_destinationIp, None, "destinationIp property")
	def _get_gateway (self):
		return self.getVar ("gateway")
	def _set_gateway (self, value):
		self.setVar ("gateway", value)
	gateway = property (_get_gateway, _set_gateway, None, "gateway property")
	def _get_prefixLength (self):
		return self.getVar ("prefixLength")
	def _set_prefixLength (self, value):
		self.setVar ("prefixLength", value)
	prefixLength = property (_get_prefixLength, _set_prefixLength, None, "prefixLength property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Route, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["protocol"] = "IPv4"
			self.managedProperties["targetType"] = "net"
			self.managedProperties["destinationIp"] = "10.10.0.0"
			self.managedProperties["gateway"] = "10.10.10.1"
			self.managedProperties["prefixLength"] = 24

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Route"


