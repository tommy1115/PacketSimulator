import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import IpV4V6Range


class IPSecNetwork( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_testType (self):
		return self.getVar ("testType")
	def _set_testType (self, value):
		self.setVar ("testType", value)
	testType = property (_get_testType, _set_testType, None, "testType property")
	def _get_role (self):
		return self.getVar ("role")
	def _set_role (self, value):
		self.setVar ("role", value)
	role = property (_get_role, _set_role, None, "role property")
	def _get_emulatedSubnetIpType (self):
		return self.getVar ("emulatedSubnetIpType")
	def _set_emulatedSubnetIpType (self, value):
		self.setVar ("emulatedSubnetIpType", value)
	emulatedSubnetIpType = property (_get_emulatedSubnetIpType, _set_emulatedSubnetIpType, None, "emulatedSubnetIpType property")
	def _get_numEHCount (self):
		return self.getVar ("numEHCount")
	def _set_numEHCount (self, value):
		self.setVar ("numEHCount", value)
	numEHCount = property (_get_numEHCount, _set_numEHCount, None, "numEHCount property")
	def _get_emulatedSubnet (self):
		return self.getVar ("emulatedSubnet")
	def _set_emulatedSubnet (self, value):
		self.setVar ("emulatedSubnet", value)
	emulatedSubnet = property (_get_emulatedSubnet, _set_emulatedSubnet, None, "emulatedSubnet property")
	def _get_protectedSubnet (self):
		return self.getVar ("protectedSubnet")
	def _set_protectedSubnet (self, value):
		self.setVar ("protectedSubnet", value)
	protectedSubnet = property (_get_protectedSubnet, _set_protectedSubnet, None, "protectedSubnet property")
	def _get_emulatedSubnetSuffix (self):
		return self.getVar ("emulatedSubnetSuffix")
	def _set_emulatedSubnetSuffix (self, value):
		self.setVar ("emulatedSubnetSuffix", value)
	emulatedSubnetSuffix = property (_get_emulatedSubnetSuffix, _set_emulatedSubnetSuffix, None, "emulatedSubnetSuffix property")
	def _get_protectedSubnetSuffix (self):
		return self.getVar ("protectedSubnetSuffix")
	def _set_protectedSubnetSuffix (self, value):
		self.setVar ("protectedSubnetSuffix", value)
	protectedSubnetSuffix = property (_get_protectedSubnetSuffix, _set_protectedSubnetSuffix, None, "protectedSubnetSuffix property")
	def _get_esnIncrementBy (self):
		return self.getVar ("esnIncrementBy")
	def _set_esnIncrementBy (self, value):
		self.setVar ("esnIncrementBy", value)
	esnIncrementBy = property (_get_esnIncrementBy, _set_esnIncrementBy, None, "esnIncrementBy property")
	def _get_psnIncrementBy (self):
		return self.getVar ("psnIncrementBy")
	def _set_psnIncrementBy (self, value):
		self.setVar ("psnIncrementBy", value)
	psnIncrementBy = property (_get_psnIncrementBy, _set_psnIncrementBy, None, "psnIncrementBy property")
	def _get_peerName (self):
		return self.getVar ("peerName")
	def _set_peerName (self, value):
		self.setVar ("peerName", value)
	peerName = property (_get_peerName, _set_peerName, None, "peerName property")
	def _get_peerPublicIPType (self):
		return self.getVar ("peerPublicIPType")
	def _set_peerPublicIPType (self, value):
		self.setVar ("peerPublicIPType", value)
	peerPublicIPType = property (_get_peerPublicIPType, _set_peerPublicIPType, None, "peerPublicIPType property")
	def _get_peerPublicIP (self):
		return self.getVar ("peerPublicIP")
	def _set_peerPublicIP (self, value):
		self.setVar ("peerPublicIP", value)
	peerPublicIP = property (_get_peerPublicIP, _set_peerPublicIP, None, "peerPublicIP property")
	def _get_singlePH (self):
		return self.getVar ("singlePH")
	def _set_singlePH (self, value):
		self.setVar ("singlePH", value)
	singlePH = property (_get_singlePH, _set_singlePH, None, "singlePH property")
	def _get_egRange (self):
		return self.getListVar ("egRange")
	def _set_egRange (self, value):
		self.setVar ("egRange", value)
	egRange = property (_get_egRange, _set_egRange, None, "egRange property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IPSecNetwork, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["testType"] = "p2d"
			self.managedProperties["role"] = "Initiator"
			self.managedProperties["emulatedSubnetIpType"] = "IPv4"
			self.managedProperties["numEHCount"] = 1
			self.managedProperties["emulatedSubnet"] = "40.0.0.0"
			self.managedProperties["protectedSubnet"] = "70.0.0.0"
			self.managedProperties["emulatedSubnetSuffix"] = 24
			self.managedProperties["protectedSubnetSuffix"] = 24
			self.managedProperties["esnIncrementBy"] = "0.0.1.0"
			self.managedProperties["psnIncrementBy"] = "0.0.1.0"
			self.managedProperties["peerName"] = ""
			self.managedProperties["peerPublicIPType"] = "IPv4"
			self.managedProperties["peerPublicIP"] = ""
			self.managedProperties["singlePH"] = False
			self.managedProperties["egRange"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IPSecNetwork"


