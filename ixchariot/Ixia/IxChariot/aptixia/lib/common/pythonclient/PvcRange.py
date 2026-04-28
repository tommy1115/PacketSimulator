import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class PvcRange( XProtocolObject.XProtocolObject ):
	""" Range of multiple PVCs for fine grained configuration """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_vpiFirstId (self):
		return self.getVar ("vpiFirstId")
	def _set_vpiFirstId (self, value):
		self.setVar ("vpiFirstId", value)
	vpiFirstId = property (_get_vpiFirstId, _set_vpiFirstId, None, "vpiFirstId property")
	def _get_vpiIncrementStep (self):
		return self.getVar ("vpiIncrementStep")
	def _set_vpiIncrementStep (self, value):
		self.setVar ("vpiIncrementStep", value)
	vpiIncrementStep = property (_get_vpiIncrementStep, _set_vpiIncrementStep, None, "vpiIncrementStep property")
	def _get_vpiIncrement (self):
		return self.getVar ("vpiIncrement")
	def _set_vpiIncrement (self, value):
		self.setVar ("vpiIncrement", value)
	vpiIncrement = property (_get_vpiIncrement, _set_vpiIncrement, None, "vpiIncrement property")
	def _get_vpiUniqueCount (self):
		return self.getVar ("vpiUniqueCount")
	def _set_vpiUniqueCount (self, value):
		self.setVar ("vpiUniqueCount", value)
	vpiUniqueCount = property (_get_vpiUniqueCount, _set_vpiUniqueCount, None, "vpiUniqueCount property")
	def _get_vciFirstId (self):
		return self.getVar ("vciFirstId")
	def _set_vciFirstId (self, value):
		self.setVar ("vciFirstId", value)
	vciFirstId = property (_get_vciFirstId, _set_vciFirstId, None, "vciFirstId property")
	def _get_vciIncrementStep (self):
		return self.getVar ("vciIncrementStep")
	def _set_vciIncrementStep (self, value):
		self.setVar ("vciIncrementStep", value)
	vciIncrementStep = property (_get_vciIncrementStep, _set_vciIncrementStep, None, "vciIncrementStep property")
	def _get_vciIncrement (self):
		return self.getVar ("vciIncrement")
	def _set_vciIncrement (self, value):
		self.setVar ("vciIncrement", value)
	vciIncrement = property (_get_vciIncrement, _set_vciIncrement, None, "vciIncrement property")
	def _get_vciUniqueCount (self):
		return self.getVar ("vciUniqueCount")
	def _set_vciUniqueCount (self, value):
		self.setVar ("vciUniqueCount", value)
	vciUniqueCount = property (_get_vciUniqueCount, _set_vciUniqueCount, None, "vciUniqueCount property")
	def _get_incrementMode (self):
		return self.getVar ("incrementMode")
	def _set_incrementMode (self, value):
		self.setVar ("incrementMode", value)
	incrementMode = property (_get_incrementMode, _set_incrementMode, None, "incrementMode property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PvcRange, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = "pvc-"
			self.managedProperties["vpiFirstId"] = 0
			self.managedProperties["vpiIncrementStep"] = 1
			self.managedProperties["vpiIncrement"] = 1
			self.managedProperties["vpiUniqueCount"] = 1
			self.managedProperties["vciFirstId"] = 32
			self.managedProperties["vciIncrementStep"] = 1
			self.managedProperties["vciIncrement"] = 1
			self.managedProperties["vciUniqueCount"] = 4063
			self.managedProperties["incrementMode"] = 2

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PvcRange"


