import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class TrafficShapeServer( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_matchMode (self):
		return self.getVar ("matchMode")
	def _set_matchMode (self, value):
		self.setVar ("matchMode", value)
	matchMode = property (_get_matchMode, _set_matchMode, None, "matchMode property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TrafficShapeServer, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["matchMode"] = 1

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TrafficShapeServer"


