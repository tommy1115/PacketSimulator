import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class ChassisCard( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_cardId (self):
		return self.getVar ("cardId")
	def _set_cardId (self, value):
		self.setVar ("cardId", value)
	cardId = property (_get_cardId, _set_cardId, None, "cardId property")
	def _get_cardType (self):
		return self.getVar ("cardType")
	def _set_cardType (self, value):
		self.setVar ("cardType", value)
	cardType = property (_get_cardType, _set_cardType, None, "cardType property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ChassisCard, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["cardId"] = 0
			self.managedProperties["cardType"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ChassisCard"


