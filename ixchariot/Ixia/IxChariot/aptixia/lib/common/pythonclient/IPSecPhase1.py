import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class IPSecPhase1( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_psk (self):
		return self.getVar ("psk")
	def _set_psk (self, value):
		self.setVar ("psk", value)
	psk = property (_get_psk, _set_psk, None, "psk property")
	def _get_lifeTime (self):
		return self.getVar ("lifeTime")
	def _set_lifeTime (self, value):
		self.setVar ("lifeTime", value)
	lifeTime = property (_get_lifeTime, _set_lifeTime, None, "lifeTime property")
	def _get_ikeMode (self):
		return self.getVar ("ikeMode")
	def _set_ikeMode (self, value):
		self.setVar ("ikeMode", value)
	ikeMode = property (_get_ikeMode, _set_ikeMode, None, "ikeMode property")
	def _get_hashAlgo (self):
		return self.getVar ("hashAlgo")
	def _set_hashAlgo (self, value):
		self.setVar ("hashAlgo", value)
	hashAlgo = property (_get_hashAlgo, _set_hashAlgo, None, "hashAlgo property")
	def _get_dhGroup (self):
		return self.getVar ("dhGroup")
	def _set_dhGroup (self, value):
		self.setVar ("dhGroup", value)
	dhGroup = property (_get_dhGroup, _set_dhGroup, None, "dhGroup property")
	def _get_encAlgo (self):
		return self.getVar ("encAlgo")
	def _set_encAlgo (self, value):
		self.setVar ("encAlgo", value)
	encAlgo = property (_get_encAlgo, _set_encAlgo, None, "encAlgo property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IPSecPhase1, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["psk"] = "ixvpn"
			self.managedProperties["lifeTime"] = "3600"
			self.managedProperties["ikeMode"] = "main"
			self.managedProperties["hashAlgo"] = "md5"
			self.managedProperties["dhGroup"] = "dh2"
			self.managedProperties["encAlgo"] = "3des"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IPSecPhase1"


