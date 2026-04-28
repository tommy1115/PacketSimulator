import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class TreeNode( XProtocolObject.XProtocolObject ):
	""" Base class for managed objects used in tree controls """
	# Class Properties
	def _get_expanded (self):
		return self.getVar ("expanded")
	def _set_expanded (self, value):
		self.setVar ("expanded", value)
	expanded = property (_get_expanded, _set_expanded, None, "expanded property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TreeNode, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["expanded"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TreeNode"


