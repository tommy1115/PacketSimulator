import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import TrafficShape


class ActivityInstance( XProtocolObject.XProtocolObject ):
	""" This contains information relating to a traffic generating activitythe traffic is typically generated at the layer 7 level. """
	# Class Properties
	def _get_activityId (self):
		return self.getVar ("activityId")
	def _set_activityId (self, value):
		self.setVar ("activityId", value)
	activityId = property (_get_activityId, _set_activityId, None, "activityId property")
	def _get_symbolicMapping (self):
		return self.getVar ("symbolicMapping")
	def _set_symbolicMapping (self, value):
		self.setVar ("symbolicMapping", value)
	symbolicMapping = property (_get_symbolicMapping, _set_symbolicMapping, None, "symbolicMapping property")
	def _get_objectiveType (self):
		return self.getVar ("objectiveType")
	def _set_objectiveType (self, value):
		self.setVar ("objectiveType", value)
	objectiveType = property (_get_objectiveType, _set_objectiveType, None, "objectiveType property")
	def _get_objectiveValue (self):
		return self.getVar ("objectiveValue")
	def _set_objectiveValue (self, value):
		self.setVar ("objectiveValue", value)
	objectiveValue = property (_get_objectiveValue, _set_objectiveValue, None, "objectiveValue property")
	def _get_trafficShape (self):
		return self.getListVar ("trafficShape")
	def _set_trafficShape (self, value):
		self.setVar ("trafficShape", value)
	trafficShape = property (_get_trafficShape, _set_trafficShape, None, "trafficShape property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ActivityInstance, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["activityId"] = ""
			self.managedProperties["symbolicMapping"] = 0
			self.managedProperties["objectiveType"] = "simulatedUsers"
			self.managedProperties["objectiveValue"] = float(100)
			self.managedProperties["trafficShape"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ActivityInstance"


