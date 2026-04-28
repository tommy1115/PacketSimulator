import string, threading
import Aptixia, Aptixia_prv
import CardPlugin


class TenGigabitLANPlugin( CardPlugin.CardPlugin ):
	# Class Properties
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
	def _get_transmitClocking (self):
		return self.getVar ("transmitClocking")
	def _set_transmitClocking (self, value):
		self.setVar ("transmitClocking", value)
	transmitClocking = property (_get_transmitClocking, _set_transmitClocking, None, "transmitClocking property")
	def _get_recoveredClock (self):
		return self.getVar ("recoveredClock")
	def _set_recoveredClock (self, value):
		self.setVar ("recoveredClock", value)
	recoveredClock = property (_get_recoveredClock, _set_recoveredClock, None, "recoveredClock property")
	def _get_laserOn (self):
		return self.getVar ("laserOn")
	def _set_laserOn (self, value):
		self.setVar ("laserOn", value)
	laserOn = property (_get_laserOn, _set_laserOn, None, "laserOn property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TenGigabitLANPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enableFlowControl"] = False
			self.managedProperties["directedAddress"] = "01 80 C2 00 00 01"
			self.managedProperties["txIgnoresRxLinkFaults"] = False
			self.managedProperties["transmitClocking"] = "internal"
			self.managedProperties["recoveredClock"] = False
			self.managedProperties["laserOn"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TenGigabitLANPlugin"


