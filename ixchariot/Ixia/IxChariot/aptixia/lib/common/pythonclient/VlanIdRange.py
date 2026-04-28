import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class VlanIdRange( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_enable (self):
		return self.getVar ("enable")
	def _set_enable (self, value):
		self.setVar ("enable", value)
	enable = property (_get_enable, _set_enable, None, "enable property")
	def _get_firstId (self):
		return self.getVar ("firstId")
	def _set_firstId (self, value):
		self.setVar ("firstId", value)
	firstId = property (_get_firstId, _set_firstId, None, "firstId property")
	def _get_incrementStep (self):
		return self.getVar ("incrementStep")
	def _set_incrementStep (self, value):
		self.setVar ("incrementStep", value)
	incrementStep = property (_get_incrementStep, _set_incrementStep, None, "incrementStep property")
	def _get_increment (self):
		return self.getVar ("increment")
	def _set_increment (self, value):
		self.setVar ("increment", value)
	increment = property (_get_increment, _set_increment, None, "increment property")
	def _get_uniqueCount (self):
		return self.getVar ("uniqueCount")
	def _set_uniqueCount (self, value):
		self.setVar ("uniqueCount", value)
	uniqueCount = property (_get_uniqueCount, _set_uniqueCount, None, "uniqueCount property")
	def _get_priority (self):
		return self.getVar ("priority")
	def _set_priority (self, value):
		self.setVar ("priority", value)
	priority = property (_get_priority, _set_priority, None, "priority property")
	def _get_innerEnable (self):
		return self.getVar ("innerEnable")
	def _set_innerEnable (self, value):
		self.setVar ("innerEnable", value)
	innerEnable = property (_get_innerEnable, _set_innerEnable, None, "innerEnable property")
	def _get_innerFirstId (self):
		return self.getVar ("innerFirstId")
	def _set_innerFirstId (self, value):
		self.setVar ("innerFirstId", value)
	innerFirstId = property (_get_innerFirstId, _set_innerFirstId, None, "innerFirstId property")
	def _get_innerIncrementStep (self):
		return self.getVar ("innerIncrementStep")
	def _set_innerIncrementStep (self, value):
		self.setVar ("innerIncrementStep", value)
	innerIncrementStep = property (_get_innerIncrementStep, _set_innerIncrementStep, None, "innerIncrementStep property")
	def _get_innerIncrement (self):
		return self.getVar ("innerIncrement")
	def _set_innerIncrement (self, value):
		self.setVar ("innerIncrement", value)
	innerIncrement = property (_get_innerIncrement, _set_innerIncrement, None, "innerIncrement property")
	def _get_innerUniqueCount (self):
		return self.getVar ("innerUniqueCount")
	def _set_innerUniqueCount (self, value):
		self.setVar ("innerUniqueCount", value)
	innerUniqueCount = property (_get_innerUniqueCount, _set_innerUniqueCount, None, "innerUniqueCount property")
	def _get_innerPriority (self):
		return self.getVar ("innerPriority")
	def _set_innerPriority (self, value):
		self.setVar ("innerPriority", value)
	innerPriority = property (_get_innerPriority, _set_innerPriority, None, "innerPriority property")
	def _get_idIncrMode (self):
		return self.getVar ("idIncrMode")
	def _set_idIncrMode (self, value):
		self.setVar ("idIncrMode", value)
	idIncrMode = property (_get_idIncrMode, _set_idIncrMode, None, "idIncrMode property")
	def _get_etherType (self):
		return self.getVar ("etherType")
	def _set_etherType (self, value):
		self.setVar ("etherType", value)
	etherType = property (_get_etherType, _set_etherType, None, "etherType property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( VlanIdRange, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = "VLAN-"
			self.managedProperties["enable"] = False
			self.managedProperties["firstId"] = 1
			self.managedProperties["incrementStep"] = 1
			self.managedProperties["increment"] = 1
			self.managedProperties["uniqueCount"] = 4094
			self.managedProperties["priority"] = 1
			self.managedProperties["innerEnable"] = False
			self.managedProperties["innerFirstId"] = 1
			self.managedProperties["innerIncrementStep"] = 1
			self.managedProperties["innerIncrement"] = 1
			self.managedProperties["innerUniqueCount"] = 4094
			self.managedProperties["innerPriority"] = 1
			self.managedProperties["idIncrMode"] = 2
			self.managedProperties["etherType"] = "0x8100"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "VlanIdRange"


