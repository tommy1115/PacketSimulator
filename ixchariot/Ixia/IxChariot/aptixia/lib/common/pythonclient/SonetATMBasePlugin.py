import string, threading
import Aptixia, Aptixia_prv
import HardwarePlugin


class SonetATMBasePlugin( HardwarePlugin.HardwarePlugin ):
	# Class Properties
	def _get_interfaceType (self):
		return self.getVar ("interfaceType")
	def _set_interfaceType (self, value):
		self.setVar ("interfaceType", value)
	interfaceType = property (_get_interfaceType, _set_interfaceType, None, "interfaceType property")
	def _get_c2Transmit (self):
		return self.getVar ("c2Transmit")
	def _set_c2Transmit (self, value):
		self.setVar ("c2Transmit", value)
	c2Transmit = property (_get_c2Transmit, _set_c2Transmit, None, "c2Transmit property")
	def _get_c2Expected (self):
		return self.getVar ("c2Expected")
	def _set_c2Expected (self, value):
		self.setVar ("c2Expected", value)
	c2Expected = property (_get_c2Expected, _set_c2Expected, None, "c2Expected property")
	def _get_transmitClocking (self):
		return self.getVar ("transmitClocking")
	def _set_transmitClocking (self, value):
		self.setVar ("transmitClocking", value)
	transmitClocking = property (_get_transmitClocking, _set_transmitClocking, None, "transmitClocking property")
	def _get_crc (self):
		return self.getVar ("crc")
	def _set_crc (self, value):
		self.setVar ("crc", value)
	crc = property (_get_crc, _set_crc, None, "crc property")
	def _get_dataScrambling (self):
		return self.getVar ("dataScrambling")
	def _set_dataScrambling (self, value):
		self.setVar ("dataScrambling", value)
	dataScrambling = property (_get_dataScrambling, _set_dataScrambling, None, "dataScrambling property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( SonetATMBasePlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["interfaceType"] = "kOC12"
			self.managedProperties["c2Transmit"] = 19
			self.managedProperties["c2Expected"] = 19
			self.managedProperties["transmitClocking"] = "internal"
			self.managedProperties["crc"] = "crc16"
			self.managedProperties["dataScrambling"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "SonetATMBasePlugin"


