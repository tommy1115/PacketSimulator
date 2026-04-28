import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class Vlan( XProtocolObject.XProtocolObject ):
	""" Represents the Vlan properties for an IP range """
	# Class Properties
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_id (self):
		return self.getVar ("id")
	def _set_id (self, value):
		self.setVar ("id", value)
	id = property (_get_id, _set_id, None, "id property")
	def _get_priority (self):
		return self.getVar ("priority")
	def _set_priority (self, value):
		self.setVar ("priority", value)
	priority = property (_get_priority, _set_priority, None, "priority property")
	def _get_stepSize (self):
		return self.getVar ("stepSize")
	def _set_stepSize (self, value):
		self.setVar ("stepSize", value)
	stepSize = property (_get_stepSize, _set_stepSize, None, "stepSize property")
	def _get_incrementBy (self):
		return self.getVar ("incrementBy")
	def _set_incrementBy (self, value):
		self.setVar ("incrementBy", value)
	incrementBy = property (_get_incrementBy, _set_incrementBy, None, "incrementBy property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Vlan, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = False
			self.managedProperties["id"] = 0
			self.managedProperties["priority"] = 0
			self.managedProperties["stepSize"] = 10
			self.managedProperties["incrementBy"] = 1

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Vlan"


