import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class BranchToNic( XProtocolObject.XProtocolObject ):
	""" Stores the mapping between brach and nic addresses """
	# Class Properties
	def _get_firstPluginId (self):
		return self.getVar ("firstPluginId")
	def _set_firstPluginId (self, value):
		self.setVar ("firstPluginId", value)
	firstPluginId = property (_get_firstPluginId, _set_firstPluginId, None, "firstPluginId property")
	def _get_nicId (self):
		return self.getVar ("nicId")
	def _set_nicId (self, value):
		self.setVar ("nicId", value)
	nicId = property (_get_nicId, _set_nicId, None, "nicId property")
	def _get_uniquePortId (self):
		return self.getVar ("uniquePortId")
	def _set_uniquePortId (self, value):
		self.setVar ("uniquePortId", value)
	uniquePortId = property (_get_uniquePortId, _set_uniquePortId, None, "uniquePortId property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( BranchToNic, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["firstPluginId"] = ""
			self.managedProperties["nicId"] = ""
			self.managedProperties["uniquePortId"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "BranchToNic"


