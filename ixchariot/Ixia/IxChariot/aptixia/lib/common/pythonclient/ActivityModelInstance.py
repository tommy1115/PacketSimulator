import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import ActivityInstance


class ActivityModelInstance( XProtocolObject.XProtocolObject ):
	""" Container that associates a list of traffic generatingActivities with a PortGroup network configuration. """
	# Class Properties
	def _get_portGroupId (self):
		return self.getVar ("portGroupId")
	def _set_portGroupId (self, value):
		self.setVar ("portGroupId", value)
	portGroupId = property (_get_portGroupId, _set_portGroupId, None, "portGroupId property")
	def _get_activityModelId (self):
		return self.getVar ("activityModelId")
	def _set_activityModelId (self, value):
		self.setVar ("activityModelId", value)
	activityModelId = property (_get_activityModelId, _set_activityModelId, None, "activityModelId property")
	def _get_activities (self):
		return self.getListVar ("activities")
	activities = property (_get_activities, None, None, "activities property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ActivityModelInstance, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["portGroupId"] = ""
			self.managedProperties["activityModelId"] = ""
			self.managedProperties["activities"] = Aptixia.IxObjectList (self.transactionContext, "ActivityInstance")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ActivityModelInstance"


