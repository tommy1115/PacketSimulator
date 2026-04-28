import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class PppL2tp( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_lcpTimeout (self):
		return self.getVar ("lcpTimeout")
	def _set_lcpTimeout (self, value):
		self.setVar ("lcpTimeout", value)
	lcpTimeout = property (_get_lcpTimeout, _set_lcpTimeout, None, "lcpTimeout property")
	def _get_lcpRetries (self):
		return self.getVar ("lcpRetries")
	def _set_lcpRetries (self, value):
		self.setVar ("lcpRetries", value)
	lcpRetries = property (_get_lcpRetries, _set_lcpRetries, None, "lcpRetries property")
	def _get_mtu (self):
		return self.getVar ("mtu")
	def _set_mtu (self, value):
		self.setVar ("mtu", value)
	mtu = property (_get_mtu, _set_mtu, None, "mtu property")
	def _get_ncpType (self):
		return self.getVar ("ncpType")
	def _set_ncpType (self, value):
		self.setVar ("ncpType", value)
	ncpType = property (_get_ncpType, _set_ncpType, None, "ncpType property")
	def _get_clientBaseIp (self):
		return self.getVar ("clientBaseIp")
	def _set_clientBaseIp (self, value):
		self.setVar ("clientBaseIp", value)
	clientBaseIp = property (_get_clientBaseIp, _set_clientBaseIp, None, "clientBaseIp property")
	def _get_clientIpIncr (self):
		return self.getVar ("clientIpIncr")
	def _set_clientIpIncr (self, value):
		self.setVar ("clientIpIncr", value)
	clientIpIncr = property (_get_clientIpIncr, _set_clientIpIncr, None, "clientIpIncr property")
	def _get_serverBaseIp (self):
		return self.getVar ("serverBaseIp")
	def _set_serverBaseIp (self, value):
		self.setVar ("serverBaseIp", value)
	serverBaseIp = property (_get_serverBaseIp, _set_serverBaseIp, None, "serverBaseIp property")
	def _get_serverIpIncr (self):
		return self.getVar ("serverIpIncr")
	def _set_serverIpIncr (self, value):
		self.setVar ("serverIpIncr", value)
	serverIpIncr = property (_get_serverIpIncr, _set_serverIpIncr, None, "serverIpIncr property")
	def _get_clientBaseIID (self):
		return self.getVar ("clientBaseIID")
	def _set_clientBaseIID (self, value):
		self.setVar ("clientBaseIID", value)
	clientBaseIID = property (_get_clientBaseIID, _set_clientBaseIID, None, "clientBaseIID property")
	def _get_clientIIDIncr (self):
		return self.getVar ("clientIIDIncr")
	def _set_clientIIDIncr (self, value):
		self.setVar ("clientIIDIncr", value)
	clientIIDIncr = property (_get_clientIIDIncr, _set_clientIIDIncr, None, "clientIIDIncr property")
	def _get_serverBaseIID (self):
		return self.getVar ("serverBaseIID")
	def _set_serverBaseIID (self, value):
		self.setVar ("serverBaseIID", value)
	serverBaseIID = property (_get_serverBaseIID, _set_serverBaseIID, None, "serverBaseIID property")
	def _get_serverIIDIncr (self):
		return self.getVar ("serverIIDIncr")
	def _set_serverIIDIncr (self, value):
		self.setVar ("serverIIDIncr", value)
	serverIIDIncr = property (_get_serverIIDIncr, _set_serverIIDIncr, None, "serverIIDIncr property")
	def _get_ipv6PoolPrefix (self):
		return self.getVar ("ipv6PoolPrefix")
	def _set_ipv6PoolPrefix (self, value):
		self.setVar ("ipv6PoolPrefix", value)
	ipv6PoolPrefix = property (_get_ipv6PoolPrefix, _set_ipv6PoolPrefix, None, "ipv6PoolPrefix property")
	def _get_ipv6PoolPrefixLen (self):
		return self.getVar ("ipv6PoolPrefixLen")
	def _set_ipv6PoolPrefixLen (self, value):
		self.setVar ("ipv6PoolPrefixLen", value)
	ipv6PoolPrefixLen = property (_get_ipv6PoolPrefixLen, _set_ipv6PoolPrefixLen, None, "ipv6PoolPrefixLen property")
	def _get_ipv6AddrPrefixLen (self):
		return self.getVar ("ipv6AddrPrefixLen")
	def _set_ipv6AddrPrefixLen (self, value):
		self.setVar ("ipv6AddrPrefixLen", value)
	ipv6AddrPrefixLen = property (_get_ipv6AddrPrefixLen, _set_ipv6AddrPrefixLen, None, "ipv6AddrPrefixLen property")
	def _get_authType (self):
		return self.getVar ("authType")
	def _set_authType (self, value):
		self.setVar ("authType", value)
	authType = property (_get_authType, _set_authType, None, "authType property")
	def _get_papUser (self):
		return self.getVar ("papUser")
	def _set_papUser (self, value):
		self.setVar ("papUser", value)
	papUser = property (_get_papUser, _set_papUser, None, "papUser property")
	def _get_papPassword (self):
		return self.getVar ("papPassword")
	def _set_papPassword (self, value):
		self.setVar ("papPassword", value)
	papPassword = property (_get_papPassword, _set_papPassword, None, "papPassword property")
	def _get_chapName (self):
		return self.getVar ("chapName")
	def _set_chapName (self, value):
		self.setVar ("chapName", value)
	chapName = property (_get_chapName, _set_chapName, None, "chapName property")
	def _get_chapSecret (self):
		return self.getVar ("chapSecret")
	def _set_chapSecret (self, value):
		self.setVar ("chapSecret", value)
	chapSecret = property (_get_chapSecret, _set_chapSecret, None, "chapSecret property")
	def _get_lcpTermTimeout (self):
		return self.getVar ("lcpTermTimeout")
	def _set_lcpTermTimeout (self, value):
		self.setVar ("lcpTermTimeout", value)
	lcpTermTimeout = property (_get_lcpTermTimeout, _set_lcpTermTimeout, None, "lcpTermTimeout property")
	def _get_lcpTermRetries (self):
		return self.getVar ("lcpTermRetries")
	def _set_lcpTermRetries (self, value):
		self.setVar ("lcpTermRetries", value)
	lcpTermRetries = property (_get_lcpTermRetries, _set_lcpTermRetries, None, "lcpTermRetries property")
	def _get_useMagic (self):
		return self.getVar ("useMagic")
	def _set_useMagic (self, value):
		self.setVar ("useMagic", value)
	useMagic = property (_get_useMagic, _set_useMagic, None, "useMagic property")
	def _get_enableEchoRsp (self):
		return self.getVar ("enableEchoRsp")
	def _set_enableEchoRsp (self, value):
		self.setVar ("enableEchoRsp", value)
	enableEchoRsp = property (_get_enableEchoRsp, _set_enableEchoRsp, None, "enableEchoRsp property")
	def _get_enableEchoReq (self):
		return self.getVar ("enableEchoReq")
	def _set_enableEchoReq (self, value):
		self.setVar ("enableEchoReq", value)
	enableEchoReq = property (_get_enableEchoReq, _set_enableEchoReq, None, "enableEchoReq property")
	def _get_echoReqInterval (self):
		return self.getVar ("echoReqInterval")
	def _set_echoReqInterval (self, value):
		self.setVar ("echoReqInterval", value)
	echoReqInterval = property (_get_echoReqInterval, _set_echoReqInterval, None, "echoReqInterval property")
	def _get_ncpTimeout (self):
		return self.getVar ("ncpTimeout")
	def _set_ncpTimeout (self, value):
		self.setVar ("ncpTimeout", value)
	ncpTimeout = property (_get_ncpTimeout, _set_ncpTimeout, None, "ncpTimeout property")
	def _get_ncpRetries (self):
		return self.getVar ("ncpRetries")
	def _set_ncpRetries (self, value):
		self.setVar ("ncpRetries", value)
	ncpRetries = property (_get_ncpRetries, _set_ncpRetries, None, "ncpRetries property")
	def _get_authTimeout (self):
		return self.getVar ("authTimeout")
	def _set_authTimeout (self, value):
		self.setVar ("authTimeout", value)
	authTimeout = property (_get_authTimeout, _set_authTimeout, None, "authTimeout property")
	def _get_authRetries (self):
		return self.getVar ("authRetries")
	def _set_authRetries (self, value):
		self.setVar ("authRetries", value)
	authRetries = property (_get_authRetries, _set_authRetries, None, "authRetries property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PppL2tp, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["lcpTimeout"] = 15
			self.managedProperties["lcpRetries"] = 5
			self.managedProperties["mtu"] = 1492
			self.managedProperties["ncpType"] = "IPv4"
			self.managedProperties["clientBaseIp"] = "99.99.0.1"
			self.managedProperties["clientIpIncr"] = "0.0.0.1"
			self.managedProperties["serverBaseIp"] = "99.98.0.1"
			self.managedProperties["serverIpIncr"] = "0.0.0.0"
			self.managedProperties["clientBaseIID"] = "00:11:11:11:00:00:00:01"
			self.managedProperties["clientIIDIncr"] = 1
			self.managedProperties["serverBaseIID"] = "00:11:22:11:00:00:00:01"
			self.managedProperties["serverIIDIncr"] = 1
			self.managedProperties["ipv6PoolPrefix"] = "1:1:1::"
			self.managedProperties["ipv6PoolPrefixLen"] = 48
			self.managedProperties["ipv6AddrPrefixLen"] = 64
			self.managedProperties["authType"] = "none"
			self.managedProperties["papUser"] = "user"
			self.managedProperties["papPassword"] = "password"
			self.managedProperties["chapName"] = "user"
			self.managedProperties["chapSecret"] = "secret"
			self.managedProperties["lcpTermTimeout"] = 15
			self.managedProperties["lcpTermRetries"] = 5
			self.managedProperties["useMagic"] = True
			self.managedProperties["enableEchoRsp"] = True
			self.managedProperties["enableEchoReq"] = False
			self.managedProperties["echoReqInterval"] = 60
			self.managedProperties["ncpTimeout"] = 15
			self.managedProperties["ncpRetries"] = 5
			self.managedProperties["authTimeout"] = 15
			self.managedProperties["authRetries"] = 5

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PppL2tp"


