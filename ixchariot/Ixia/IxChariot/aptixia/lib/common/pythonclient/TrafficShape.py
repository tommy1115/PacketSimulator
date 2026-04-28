import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class TrafficShape( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_standbyDuration (self):
		return self.getVar ("standbyDuration")
	def _set_standbyDuration (self, value):
		self.setVar ("standbyDuration", value)
	standbyDuration = property (_get_standbyDuration, _set_standbyDuration, None, "standbyDuration property")
	def _get_sustainDuration (self):
		return self.getVar ("sustainDuration")
	def _set_sustainDuration (self, value):
		self.setVar ("sustainDuration", value)
	sustainDuration = property (_get_sustainDuration, _set_sustainDuration, None, "sustainDuration property")
	def _get_offlineDuration (self):
		return self.getVar ("offlineDuration")
	def _set_offlineDuration (self, value):
		self.setVar ("offlineDuration", value)
	offlineDuration = property (_get_offlineDuration, _set_offlineDuration, None, "offlineDuration property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TrafficShape, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["standbyDuration"] = 0
			self.managedProperties["sustainDuration"] = 20
			self.managedProperties["offlineDuration"] = 0

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TrafficShape"


