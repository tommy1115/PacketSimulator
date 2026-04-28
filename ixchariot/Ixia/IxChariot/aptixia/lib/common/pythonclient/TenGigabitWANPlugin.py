import string, threading
import Aptixia, Aptixia_prv
import CardPlugin


class TenGigabitWANPlugin( CardPlugin.CardPlugin ):
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
	def _get_enableFlowControl (self):
		return self.getVar ("enableFlowControl")
	def _set_enableFlowControl (self, value):
		self.setVar ("enableFlowControl", value)
	enableFlowControl = property (_get_enableFlowControl, _set_enableFlowControl, None, "enableFlowControl property")
	def _get_directedAddress (self):
		return self.getVar ("directedAddress")
	def _set_directedAddress (self, value):
		self.setVar ("directedAddress", value)
	directedAddress = property (_get_directedAddress, _set_directedAddress, None, "directedAddress property")
	def _get_txIgnoresRxLinkFaults (self):
		return self.getVar ("txIgnoresRxLinkFaults")
	def _set_txIgnoresRxLinkFaults (self, value):
		self.setVar ("txIgnoresRxLinkFaults", value)
	txIgnoresRxLinkFaults = property (_get_txIgnoresRxLinkFaults, _set_txIgnoresRxLinkFaults, None, "txIgnoresRxLinkFaults property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TenGigabitWANPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["interfaceType"] = "kWANSonet"
			self.managedProperties["c2Transmit"] = 26
			self.managedProperties["c2Expected"] = 26
			self.managedProperties["transmitClocking"] = "internal"
			self.managedProperties["enableFlowControl"] = False
			self.managedProperties["directedAddress"] = "01 80 C2 00 00 01"
			self.managedProperties["txIgnoresRxLinkFaults"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TenGigabitWANPlugin"


