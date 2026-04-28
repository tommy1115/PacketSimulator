import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class IPSecPhase2( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_enablePFS (self):
		return self.getVar ("enablePFS")
	def _set_enablePFS (self, value):
		self.setVar ("enablePFS", value)
	enablePFS = property (_get_enablePFS, _set_enablePFS, None, "enablePFS property")
	def _get_lifeTime (self):
		return self.getVar ("lifeTime")
	def _set_lifeTime (self, value):
		self.setVar ("lifeTime", value)
	lifeTime = property (_get_lifeTime, _set_lifeTime, None, "lifeTime property")
	def _get_ahNespMode (self):
		return self.getVar ("ahNespMode")
	def _set_ahNespMode (self, value):
		self.setVar ("ahNespMode", value)
	ahNespMode = property (_get_ahNespMode, _set_ahNespMode, None, "ahNespMode property")
	def _get_encapMode (self):
		return self.getVar ("encapMode")
	def _set_encapMode (self, value):
		self.setVar ("encapMode", value)
	encapMode = property (_get_encapMode, _set_encapMode, None, "encapMode property")
	def _get_hashAlgo (self):
		return self.getVar ("hashAlgo")
	def _set_hashAlgo (self, value):
		self.setVar ("hashAlgo", value)
	hashAlgo = property (_get_hashAlgo, _set_hashAlgo, None, "hashAlgo property")
	def _get_pfsGroup (self):
		return self.getVar ("pfsGroup")
	def _set_pfsGroup (self, value):
		self.setVar ("pfsGroup", value)
	pfsGroup = property (_get_pfsGroup, _set_pfsGroup, None, "pfsGroup property")
	def _get_encAlgo (self):
		return self.getVar ("encAlgo")
	def _set_encAlgo (self, value):
		self.setVar ("encAlgo", value)
	encAlgo = property (_get_encAlgo, _set_encAlgo, None, "encAlgo property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IPSecPhase2, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enablePFS"] = False
			self.managedProperties["lifeTime"] = "28800"
			self.managedProperties["ahNespMode"] = "ESPOnly"
			self.managedProperties["encapMode"] = "tunnel"
			self.managedProperties["hashAlgo"] = "md5"
			self.managedProperties["pfsGroup"] = "dh2"
			self.managedProperties["encAlgo"] = "3des"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IPSecPhase2"


