import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class IPSecTunnelSetup( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_tunnelSweepSize (self):
		return self.getVar ("tunnelSweepSize")
	def _set_tunnelSweepSize (self, value):
		self.setVar ("tunnelSweepSize", value)
	tunnelSweepSize = property (_get_tunnelSweepSize, _set_tunnelSweepSize, None, "tunnelSweepSize property")
	def _get_tunnelSetupTimeout (self):
		return self.getVar ("tunnelSetupTimeout")
	def _set_tunnelSetupTimeout (self, value):
		self.setVar ("tunnelSetupTimeout", value)
	tunnelSetupTimeout = property (_get_tunnelSetupTimeout, _set_tunnelSetupTimeout, None, "tunnelSetupTimeout property")
	def _get_numRetries (self):
		return self.getVar ("numRetries")
	def _set_numRetries (self, value):
		self.setVar ("numRetries", value)
	numRetries = property (_get_numRetries, _set_numRetries, None, "numRetries property")
	def _get_retryInterval (self):
		return self.getVar ("retryInterval")
	def _set_retryInterval (self, value):
		self.setVar ("retryInterval", value)
	retryInterval = property (_get_retryInterval, _set_retryInterval, None, "retryInterval property")
	def _get_retryDelay (self):
		return self.getVar ("retryDelay")
	def _set_retryDelay (self, value):
		self.setVar ("retryDelay", value)
	retryDelay = property (_get_retryDelay, _set_retryDelay, None, "retryDelay property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IPSecTunnelSetup, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["tunnelSweepSize"] = 10
			self.managedProperties["tunnelSetupTimeout"] = 30
			self.managedProperties["numRetries"] = 0
			self.managedProperties["retryInterval"] = 10
			self.managedProperties["retryDelay"] = 10

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IPSecTunnelSetup"


