import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class DhcpSettings( XProtocolObject.XProtocolObject ):
	""" Node to represent dhcp settings """
	# Class Properties
	def _get_dhcpServerIp (self):
		return self.getVar ("dhcpServerIp")
	def _set_dhcpServerIp (self, value):
		self.setVar ("dhcpServerIp", value)
	dhcpServerIp = property (_get_dhcpServerIp, _set_dhcpServerIp, None, "dhcpServerIp property")
	def _get_timeOut (self):
		return self.getVar ("timeOut")
	def _set_timeOut (self, value):
		self.setVar ("timeOut", value)
	timeOut = property (_get_timeOut, _set_timeOut, None, "timeOut property")
	def _get_iaType (self):
		return self.getVar ("iaType")
	def _set_iaType (self, value):
		self.setVar ("iaType", value)
	iaType = property (_get_iaType, _set_iaType, None, "iaType property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DhcpSettings, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["dhcpServerIp"] = "0.0.0.0"
			self.managedProperties["timeOut"] = 10
			self.managedProperties["iaType"] = "IANA"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DhcpSettings"


