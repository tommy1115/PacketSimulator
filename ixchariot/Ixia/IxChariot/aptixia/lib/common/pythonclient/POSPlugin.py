import string, threading
import Aptixia, Aptixia_prv
import SonetATMBasePlugin
import POSPayLoad


class POSPlugin( SonetATMBasePlugin.SonetATMBasePlugin ):
	# Class Properties
	def _get_eui (self):
		return self.getVar ("eui")
	def _set_eui (self, value):
		self.setVar ("eui", value)
	eui = property (_get_eui, _set_eui, None, "eui property")
	def _get_incrementBy (self):
		return self.getVar ("incrementBy")
	def _set_incrementBy (self, value):
		self.setVar ("incrementBy", value)
	incrementBy = property (_get_incrementBy, _set_incrementBy, None, "incrementBy property")
	def _get_payLoadType (self):
		return self.getVar ("payLoadType")
	def _set_payLoadType (self, value):
		self.setVar ("payLoadType", value)
	payLoadType = property (_get_payLoadType, _set_payLoadType, None, "payLoadType property")
	def _get_address (self):
		return self.getVar ("address")
	def _set_address (self, value):
		self.setVar ("address", value)
	address = property (_get_address, _set_address, None, "address property")
	def _get_control (self):
		return self.getVar ("control")
	def _set_control (self, value):
		self.setVar ("control", value)
	control = property (_get_control, _set_control, None, "control property")
	def _get_payLoad (self):
		return self.getListVar ("payLoad")
	def _set_payLoad (self, value):
		self.setVar ("payLoad", value)
	payLoad = property (_get_payLoad, _set_payLoad, None, "payLoad property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( POSPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["eui"] = "00:01:02:03:00:00:00:00"
			self.managedProperties["incrementBy"] = "00:00:00:00:00:00:00:01"
			self.managedProperties["payLoadType"] = "kCISCOHDLC"
			self.managedProperties["address"] = "FF"
			self.managedProperties["control"] = "03"
			self.managedProperties["payLoad"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "POSPlugin"


