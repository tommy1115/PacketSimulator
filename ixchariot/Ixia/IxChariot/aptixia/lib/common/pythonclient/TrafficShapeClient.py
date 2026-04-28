import string, threading
import Aptixia, Aptixia_prv
import TrafficShape


class TrafficShapeClient( TrafficShape.TrafficShape ):
	# Class Properties
	def _get_rampUpType (self):
		return self.getVar ("rampUpType")
	def _set_rampUpType (self, value):
		self.setVar ("rampUpType", value)
	rampUpType = property (_get_rampUpType, _set_rampUpType, None, "rampUpType property")
	def _get_rampUpValue (self):
		return self.getVar ("rampUpValue")
	def _set_rampUpValue (self, value):
		self.setVar ("rampUpValue", value)
	rampUpValue = property (_get_rampUpValue, _set_rampUpValue, None, "rampUpValue property")
	def _get_rampDownDuration (self):
		return self.getVar ("rampDownDuration")
	def _set_rampDownDuration (self, value):
		self.setVar ("rampDownDuration", value)
	rampDownDuration = property (_get_rampDownDuration, _set_rampDownDuration, None, "rampDownDuration property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TrafficShapeClient, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["rampUpType"] = 0
			self.managedProperties["rampUpValue"] = 100
			self.managedProperties["rampDownDuration"] = 20

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TrafficShapeClient"


