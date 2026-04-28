import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import ChassisCard


class Chassis( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_dns (self):
		return self.getVar ("dns")
	def _set_dns (self, value):
		self.setVar ("dns", value)
	dns = property (_get_dns, _set_dns, None, "dns property")
	def _get_cableLength (self):
		return self.getVar ("cableLength")
	def _set_cableLength (self, value):
		self.setVar ("cableLength", value)
	cableLength = property (_get_cableLength, _set_cableLength, None, "cableLength property")
	def _get_physicalChain (self):
		return self.getVar ("physicalChain")
	def _set_physicalChain (self, value):
		self.setVar ("physicalChain", value)
	physicalChain = property (_get_physicalChain, _set_physicalChain, None, "physicalChain property")
	def _get_masterChassis (self):
		return self.getVar ("masterChassis")
	def _set_masterChassis (self, value):
		self.setVar ("masterChassis", value)
	masterChassis = property (_get_masterChassis, _set_masterChassis, None, "masterChassis property")
	def _get_managementIP (self):
		return self.getVar ("managementIP")
	def _set_managementIP (self, value):
		self.setVar ("managementIP", value)
	managementIP = property (_get_managementIP, _set_managementIP, None, "managementIP property")
	def _get_chassisType (self):
		return self.getVar ("chassisType")
	def _set_chassisType (self, value):
		self.setVar ("chassisType", value)
	chassisType = property (_get_chassisType, _set_chassisType, None, "chassisType property")
	def _get_cardList (self):
		return self.getListVar ("cardList")
	cardList = property (_get_cardList, None, None, "cardList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Chassis, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["dns"] = "UNDEFINED-CHASSIS-NAME"
			self.managedProperties["cableLength"] = float(0.0)
			self.managedProperties["physicalChain"] = False
			self.managedProperties["masterChassis"] = "UNDEFINED-CHASSIS-NAME"
			self.managedProperties["managementIP"] = "0.0.0.0"
			self.managedProperties["chassisType"] = ""
			self.managedProperties["cardList"] = Aptixia.IxObjectList (self.transactionContext, "ChassisCard")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Chassis"


