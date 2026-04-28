import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import SnmpStatVariable


class SnmpStatSource( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_description (self):
		return self.getVar ("description")
	def _set_description (self, value):
		self.setVar ("description", value)
	description = property (_get_description, _set_description, None, "description property")
	def _get_snmpHost (self):
		return self.getVar ("snmpHost")
	def _set_snmpHost (self, value):
		self.setVar ("snmpHost", value)
	snmpHost = property (_get_snmpHost, _set_snmpHost, None, "snmpHost property")
	def _get_snmpPort (self):
		return self.getVar ("snmpPort")
	def _set_snmpPort (self, value):
		self.setVar ("snmpPort", value)
	snmpPort = property (_get_snmpPort, _set_snmpPort, None, "snmpPort property")
	def _get_snmpVersion (self):
		return self.getVar ("snmpVersion")
	def _set_snmpVersion (self, value):
		self.setVar ("snmpVersion", value)
	snmpVersion = property (_get_snmpVersion, _set_snmpVersion, None, "snmpVersion property")
	def _get_community (self):
		return self.getVar ("community")
	def _set_community (self, value):
		self.setVar ("community", value)
	community = property (_get_community, _set_community, None, "community property")
	def _get_ysePort (self):
		return self.getVar ("ysePort")
	def _set_ysePort (self, value):
		self.setVar ("ysePort", value)
	ysePort = property (_get_ysePort, _set_ysePort, None, "ysePort property")
	def _get_destination (self):
		return self.getVar ("destination")
	def _set_destination (self, value):
		self.setVar ("destination", value)
	destination = property (_get_destination, _set_destination, None, "destination property")
	def _get_snmpVariables (self):
		return self.getListVar ("snmpVariables")
	snmpVariables = property (_get_snmpVariables, None, None, "snmpVariables property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( SnmpStatSource, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["description"] = ""
			self.managedProperties["snmpHost"] = ""
			self.managedProperties["snmpPort"] = 161
			self.managedProperties["snmpVersion"] = -1
			self.managedProperties["community"] = "public"
			self.managedProperties["ysePort"] = ""
			self.managedProperties["destination"] = ""
			self.managedProperties["snmpVariables"] = Aptixia.IxObjectList (self.transactionContext, "SnmpStatVariable")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "SnmpStatSource"


