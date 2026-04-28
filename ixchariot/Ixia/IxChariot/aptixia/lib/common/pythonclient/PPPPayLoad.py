import string, threading
import Aptixia, Aptixia_prv
import POSPayLoad


class PPPPayLoad( POSPayLoad.POSPayLoad ):
	# Class Properties
	def _get_enablePPP (self):
		return self.getVar ("enablePPP")
	def _set_enablePPP (self, value):
		self.setVar ("enablePPP", value)
	enablePPP = property (_get_enablePPP, _set_enablePPP, None, "enablePPP property")
	def _get_transmitUnit (self):
		return self.getVar ("transmitUnit")
	def _set_transmitUnit (self, value):
		self.setVar ("transmitUnit", value)
	transmitUnit = property (_get_transmitUnit, _set_transmitUnit, None, "transmitUnit property")
	def _get_receiveUnit (self):
		return self.getVar ("receiveUnit")
	def _set_receiveUnit (self, value):
		self.setVar ("receiveUnit", value)
	receiveUnit = property (_get_receiveUnit, _set_receiveUnit, None, "receiveUnit property")
	def _get_configurationRetries (self):
		return self.getVar ("configurationRetries")
	def _set_configurationRetries (self, value):
		self.setVar ("configurationRetries", value)
	configurationRetries = property (_get_configurationRetries, _set_configurationRetries, None, "configurationRetries property")
	def _get_terminationRetries (self):
		return self.getVar ("terminationRetries")
	def _set_terminationRetries (self, value):
		self.setVar ("terminationRetries", value)
	terminationRetries = property (_get_terminationRetries, _set_terminationRetries, None, "terminationRetries property")
	def _get_retryTimeout (self):
		return self.getVar ("retryTimeout")
	def _set_retryTimeout (self, value):
		self.setVar ("retryTimeout", value)
	retryTimeout = property (_get_retryTimeout, _set_retryTimeout, None, "retryTimeout property")
	def _get_useMagicNumber (self):
		return self.getVar ("useMagicNumber")
	def _set_useMagicNumber (self, value):
		self.setVar ("useMagicNumber", value)
	useMagicNumber = property (_get_useMagicNumber, _set_useMagicNumber, None, "useMagicNumber property")
	def _get_enableACCM (self):
		return self.getVar ("enableACCM")
	def _set_enableACCM (self, value):
		self.setVar ("enableACCM", value)
	enableACCM = property (_get_enableACCM, _set_enableACCM, None, "enableACCM property")
	def _get_linkQualityMonitoring (self):
		return self.getVar ("linkQualityMonitoring")
	def _set_linkQualityMonitoring (self, value):
		self.setVar ("linkQualityMonitoring", value)
	linkQualityMonitoring = property (_get_linkQualityMonitoring, _set_linkQualityMonitoring, None, "linkQualityMonitoring property")
	def _get_lqmReceiveInterval (self):
		return self.getVar ("lqmReceiveInterval")
	def _set_lqmReceiveInterval (self, value):
		self.setVar ("lqmReceiveInterval", value)
	lqmReceiveInterval = property (_get_lqmReceiveInterval, _set_lqmReceiveInterval, None, "lqmReceiveInterval property")
	def _get_ip (self):
		return self.getVar ("ip")
	def _set_ip (self, value):
		self.setVar ("ip", value)
	ip = property (_get_ip, _set_ip, None, "ip property")
	def _get_localIPAddress (self):
		return self.getVar ("localIPAddress")
	def _set_localIPAddress (self, value):
		self.setVar ("localIPAddress", value)
	localIPAddress = property (_get_localIPAddress, _set_localIPAddress, None, "localIPAddress property")
	def _get_ipv6 (self):
		return self.getVar ("ipv6")
	def _set_ipv6 (self, value):
		self.setVar ("ipv6", value)
	ipv6 = property (_get_ipv6, _set_ipv6, None, "ipv6 property")
	def _get_localNegotiationMode (self):
		return self.getVar ("localNegotiationMode")
	def _set_localNegotiationMode (self, value):
		self.setVar ("localNegotiationMode", value)
	localNegotiationMode = property (_get_localNegotiationMode, _set_localNegotiationMode, None, "localNegotiationMode property")
	def _get_localIdType (self):
		return self.getVar ("localIdType")
	def _set_localIdType (self, value):
		self.setVar ("localIdType", value)
	localIdType = property (_get_localIdType, _set_localIdType, None, "localIdType property")
	def _get_localMACInterfaceId (self):
		return self.getVar ("localMACInterfaceId")
	def _set_localMACInterfaceId (self, value):
		self.setVar ("localMACInterfaceId", value)
	localMACInterfaceId = property (_get_localMACInterfaceId, _set_localMACInterfaceId, None, "localMACInterfaceId property")
	def _get_localIPv6InterfaceId (self):
		return self.getVar ("localIPv6InterfaceId")
	def _set_localIPv6InterfaceId (self, value):
		self.setVar ("localIPv6InterfaceId", value)
	localIPv6InterfaceId = property (_get_localIPv6InterfaceId, _set_localIPv6InterfaceId, None, "localIPv6InterfaceId property")
	def _get_peerNegotiationMode (self):
		return self.getVar ("peerNegotiationMode")
	def _set_peerNegotiationMode (self, value):
		self.setVar ("peerNegotiationMode", value)
	peerNegotiationMode = property (_get_peerNegotiationMode, _set_peerNegotiationMode, None, "peerNegotiationMode property")
	def _get_peerIdType (self):
		return self.getVar ("peerIdType")
	def _set_peerIdType (self, value):
		self.setVar ("peerIdType", value)
	peerIdType = property (_get_peerIdType, _set_peerIdType, None, "peerIdType property")
	def _get_peerMACInterfaceId (self):
		return self.getVar ("peerMACInterfaceId")
	def _set_peerMACInterfaceId (self, value):
		self.setVar ("peerMACInterfaceId", value)
	peerMACInterfaceId = property (_get_peerMACInterfaceId, _set_peerMACInterfaceId, None, "peerMACInterfaceId property")
	def _get_peerIPv6InterfaceId (self):
		return self.getVar ("peerIPv6InterfaceId")
	def _set_peerIPv6InterfaceId (self, value):
		self.setVar ("peerIPv6InterfaceId", value)
	peerIPv6InterfaceId = property (_get_peerIPv6InterfaceId, _set_peerIPv6InterfaceId, None, "peerIPv6InterfaceId property")
	def _get_osi (self):
		return self.getVar ("osi")
	def _set_osi (self, value):
		self.setVar ("osi", value)
	osi = property (_get_osi, _set_osi, None, "osi property")
	def _get_transmitAlignment (self):
		return self.getVar ("transmitAlignment")
	def _set_transmitAlignment (self, value):
		self.setVar ("transmitAlignment", value)
	transmitAlignment = property (_get_transmitAlignment, _set_transmitAlignment, None, "transmitAlignment property")
	def _get_receiveAlignment (self):
		return self.getVar ("receiveAlignment")
	def _set_receiveAlignment (self, value):
		self.setVar ("receiveAlignment", value)
	receiveAlignment = property (_get_receiveAlignment, _set_receiveAlignment, None, "receiveAlignment property")
	def _get_mpls (self):
		return self.getVar ("mpls")
	def _set_mpls (self, value):
		self.setVar ("mpls", value)
	mpls = property (_get_mpls, _set_mpls, None, "mpls property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PPPPayLoad, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enablePPP"] = False
			self.managedProperties["transmitUnit"] = 65535
			self.managedProperties["receiveUnit"] = 65535
			self.managedProperties["configurationRetries"] = 9
			self.managedProperties["terminationRetries"] = 8
			self.managedProperties["retryTimeout"] = 8
			self.managedProperties["useMagicNumber"] = False
			self.managedProperties["enableACCM"] = False
			self.managedProperties["linkQualityMonitoring"] = False
			self.managedProperties["lqmReceiveInterval"] = 10
			self.managedProperties["ip"] = False
			self.managedProperties["localIPAddress"] = "0.0.0.1"
			self.managedProperties["ipv6"] = False
			self.managedProperties["localNegotiationMode"] = "kLocalMay"
			self.managedProperties["localIdType"] = "kRandom"
			self.managedProperties["localMACInterfaceId"] = "00 00 00 00 00 00"
			self.managedProperties["localIPv6InterfaceId"] = "00 00 00 00 00 00 00 00"
			self.managedProperties["peerNegotiationMode"] = "kPeerMay"
			self.managedProperties["peerIdType"] = "kRandom"
			self.managedProperties["peerMACInterfaceId"] = "00 00 00 00 00 00"
			self.managedProperties["peerIPv6InterfaceId"] = "00 00 00 00 00 00 00 00"
			self.managedProperties["osi"] = False
			self.managedProperties["transmitAlignment"] = 0
			self.managedProperties["receiveAlignment"] = 0
			self.managedProperties["mpls"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PPPPayLoad"


