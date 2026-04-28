import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class L2tp( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_sessionsPerTunnel (self):
		return self.getVar ("sessionsPerTunnel")
	def _set_sessionsPerTunnel (self, value):
		self.setVar ("sessionsPerTunnel", value)
	sessionsPerTunnel = property (_get_sessionsPerTunnel, _set_sessionsPerTunnel, None, "sessionsPerTunnel property")
	def _get_sessionAllocMethod (self):
		return self.getVar ("sessionAllocMethod")
	def _set_sessionAllocMethod (self, value):
		self.setVar ("sessionAllocMethod", value)
	sessionAllocMethod = property (_get_sessionAllocMethod, _set_sessionAllocMethod, None, "sessionAllocMethod property")
	def _get_rws (self):
		return self.getVar ("rws")
	def _set_rws (self, value):
		self.setVar ("rws", value)
	rws = property (_get_rws, _set_rws, None, "rws property")
	def _get_sourceUdpPort (self):
		return self.getVar ("sourceUdpPort")
	def _set_sourceUdpPort (self, value):
		self.setVar ("sourceUdpPort", value)
	sourceUdpPort = property (_get_sourceUdpPort, _set_sourceUdpPort, None, "sourceUdpPort property")
	def _get_destinationUdpPort (self):
		return self.getVar ("destinationUdpPort")
	def _set_destinationUdpPort (self, value):
		self.setVar ("destinationUdpPort", value)
	destinationUdpPort = property (_get_destinationUdpPort, _set_destinationUdpPort, None, "destinationUdpPort property")
	def _get_enableDataChecksum (self):
		return self.getVar ("enableDataChecksum")
	def _set_enableDataChecksum (self, value):
		self.setVar ("enableDataChecksum", value)
	enableDataChecksum = property (_get_enableDataChecksum, _set_enableDataChecksum, None, "enableDataChecksum property")
	def _get_enableControlChecksum (self):
		return self.getVar ("enableControlChecksum")
	def _set_enableControlChecksum (self, value):
		self.setVar ("enableControlChecksum", value)
	enableControlChecksum = property (_get_enableControlChecksum, _set_enableControlChecksum, None, "enableControlChecksum property")
	def _get_enableAvpHiding (self):
		return self.getVar ("enableAvpHiding")
	def _set_enableAvpHiding (self, value):
		self.setVar ("enableAvpHiding", value)
	enableAvpHiding = property (_get_enableAvpHiding, _set_enableAvpHiding, None, "enableAvpHiding property")
	def _get_tunnelAuthMode (self):
		return self.getVar ("tunnelAuthMode")
	def _set_tunnelAuthMode (self, value):
		self.setVar ("tunnelAuthMode", value)
	tunnelAuthMode = property (_get_tunnelAuthMode, _set_tunnelAuthMode, None, "tunnelAuthMode property")
	def _get_localHostName (self):
		return self.getVar ("localHostName")
	def _set_localHostName (self, value):
		self.setVar ("localHostName", value)
	localHostName = property (_get_localHostName, _set_localHostName, None, "localHostName property")
	def _get_secret (self):
		return self.getVar ("secret")
	def _set_secret (self, value):
		self.setVar ("secret", value)
	secret = property (_get_secret, _set_secret, None, "secret property")
	def _get_peerHostName (self):
		return self.getVar ("peerHostName")
	def _set_peerHostName (self, value):
		self.setVar ("peerHostName", value)
	peerHostName = property (_get_peerHostName, _set_peerHostName, None, "peerHostName property")
	def _get_tunnelStartId (self):
		return self.getVar ("tunnelStartId")
	def _set_tunnelStartId (self, value):
		self.setVar ("tunnelStartId", value)
	tunnelStartId = property (_get_tunnelStartId, _set_tunnelStartId, None, "tunnelStartId property")
	def _get_noCallTimeout (self):
		return self.getVar ("noCallTimeout")
	def _set_noCallTimeout (self, value):
		self.setVar ("noCallTimeout", value)
	noCallTimeout = property (_get_noCallTimeout, _set_noCallTimeout, None, "noCallTimeout property")
	def _get_framingCapability (self):
		return self.getVar ("framingCapability")
	def _set_framingCapability (self, value):
		self.setVar ("framingCapability", value)
	framingCapability = property (_get_framingCapability, _set_framingCapability, None, "framingCapability property")
	def _get_bearerCapability (self):
		return self.getVar ("bearerCapability")
	def _set_bearerCapability (self, value):
		self.setVar ("bearerCapability", value)
	bearerCapability = property (_get_bearerCapability, _set_bearerCapability, None, "bearerCapability property")
	def _get_sessionStartId (self):
		return self.getVar ("sessionStartId")
	def _set_sessionStartId (self, value):
		self.setVar ("sessionStartId", value)
	sessionStartId = property (_get_sessionStartId, _set_sessionStartId, None, "sessionStartId property")
	def _get_bearerType (self):
		return self.getVar ("bearerType")
	def _set_bearerType (self, value):
		self.setVar ("bearerType", value)
	bearerType = property (_get_bearerType, _set_bearerType, None, "bearerType property")
	def _get_txConnectSpeed (self):
		return self.getVar ("txConnectSpeed")
	def _set_txConnectSpeed (self, value):
		self.setVar ("txConnectSpeed", value)
	txConnectSpeed = property (_get_txConnectSpeed, _set_txConnectSpeed, None, "txConnectSpeed property")
	def _get_rxConnectSpeed (self):
		return self.getVar ("rxConnectSpeed")
	def _set_rxConnectSpeed (self, value):
		self.setVar ("rxConnectSpeed", value)
	rxConnectSpeed = property (_get_rxConnectSpeed, _set_rxConnectSpeed, None, "rxConnectSpeed property")
	def _get_enableOffsetBit (self):
		return self.getVar ("enableOffsetBit")
	def _set_enableOffsetBit (self, value):
		self.setVar ("enableOffsetBit", value)
	enableOffsetBit = property (_get_enableOffsetBit, _set_enableOffsetBit, None, "enableOffsetBit property")
	def _get_offsetLen (self):
		return self.getVar ("offsetLen")
	def _set_offsetLen (self, value):
		self.setVar ("offsetLen", value)
	offsetLen = property (_get_offsetLen, _set_offsetLen, None, "offsetLen property")
	def _get_offsetByte (self):
		return self.getVar ("offsetByte")
	def _set_offsetByte (self, value):
		self.setVar ("offsetByte", value)
	offsetByte = property (_get_offsetByte, _set_offsetByte, None, "offsetByte property")
	def _get_enableLengthBit (self):
		return self.getVar ("enableLengthBit")
	def _set_enableLengthBit (self, value):
		self.setVar ("enableLengthBit", value)
	enableLengthBit = property (_get_enableLengthBit, _set_enableLengthBit, None, "enableLengthBit property")
	def _get_enableProxy (self):
		return self.getVar ("enableProxy")
	def _set_enableProxy (self, value):
		self.setVar ("enableProxy", value)
	enableProxy = property (_get_enableProxy, _set_enableProxy, None, "enableProxy property")
	def _get_enableSequenceBit (self):
		return self.getVar ("enableSequenceBit")
	def _set_enableSequenceBit (self, value):
		self.setVar ("enableSequenceBit", value)
	enableSequenceBit = property (_get_enableSequenceBit, _set_enableSequenceBit, None, "enableSequenceBit property")
	def _get_enableRedial (self):
		return self.getVar ("enableRedial")
	def _set_enableRedial (self, value):
		self.setVar ("enableRedial", value)
	enableRedial = property (_get_enableRedial, _set_enableRedial, None, "enableRedial property")
	def _get_redialTimeout (self):
		return self.getVar ("redialTimeout")
	def _set_redialTimeout (self, value):
		self.setVar ("redialTimeout", value)
	redialTimeout = property (_get_redialTimeout, _set_redialTimeout, None, "redialTimeout property")
	def _get_redialMax (self):
		return self.getVar ("redialMax")
	def _set_redialMax (self, value):
		self.setVar ("redialMax", value)
	redialMax = property (_get_redialMax, _set_redialMax, None, "redialMax property")
	def _get_initTimeout (self):
		return self.getVar ("initTimeout")
	def _set_initTimeout (self, value):
		self.setVar ("initTimeout", value)
	initTimeout = property (_get_initTimeout, _set_initTimeout, None, "initTimeout property")
	def _get_maxTimeout (self):
		return self.getVar ("maxTimeout")
	def _set_maxTimeout (self, value):
		self.setVar ("maxTimeout", value)
	maxTimeout = property (_get_maxTimeout, _set_maxTimeout, None, "maxTimeout property")
	def _get_l2tpRetries (self):
		return self.getVar ("l2tpRetries")
	def _set_l2tpRetries (self, value):
		self.setVar ("l2tpRetries", value)
	l2tpRetries = property (_get_l2tpRetries, _set_l2tpRetries, None, "l2tpRetries property")
	def _get_enableHello (self):
		return self.getVar ("enableHello")
	def _set_enableHello (self, value):
		self.setVar ("enableHello", value)
	enableHello = property (_get_enableHello, _set_enableHello, None, "enableHello property")
	def _get_helloTimeout (self):
		return self.getVar ("helloTimeout")
	def _set_helloTimeout (self, value):
		self.setVar ("helloTimeout", value)
	helloTimeout = property (_get_helloTimeout, _set_helloTimeout, None, "helloTimeout property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( L2tp, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["sessionsPerTunnel"] = 1
			self.managedProperties["sessionAllocMethod"] = "nextTunnel"
			self.managedProperties["rws"] = 10
			self.managedProperties["sourceUdpPort"] = 1701
			self.managedProperties["destinationUdpPort"] = 1701
			self.managedProperties["enableDataChecksum"] = False
			self.managedProperties["enableControlChecksum"] = False
			self.managedProperties["enableAvpHiding"] = False
			self.managedProperties["tunnelAuthMode"] = "none"
			self.managedProperties["localHostName"] = "ixia"
			self.managedProperties["secret"] = "ixia"
			self.managedProperties["peerHostName"] = "ixia"
			self.managedProperties["tunnelStartId"] = 1
			self.managedProperties["noCallTimeout"] = 5
			self.managedProperties["framingCapability"] = "sync"
			self.managedProperties["bearerCapability"] = "digital"
			self.managedProperties["sessionStartId"] = 1
			self.managedProperties["bearerType"] = "digital"
			self.managedProperties["txConnectSpeed"] = 268435456
			self.managedProperties["rxConnectSpeed"] = 268435456
			self.managedProperties["enableOffsetBit"] = True
			self.managedProperties["offsetLen"] = 0
			self.managedProperties["offsetByte"] = 0
			self.managedProperties["enableLengthBit"] = False
			self.managedProperties["enableProxy"] = True
			self.managedProperties["enableSequenceBit"] = False
			self.managedProperties["enableRedial"] = False
			self.managedProperties["redialTimeout"] = 10
			self.managedProperties["redialMax"] = 20
			self.managedProperties["initTimeout"] = 2
			self.managedProperties["maxTimeout"] = 8
			self.managedProperties["l2tpRetries"] = 30
			self.managedProperties["enableHello"] = False
			self.managedProperties["helloTimeout"] = 60

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "L2tp"


