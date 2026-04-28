import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class StatAttribute( XProtocolObject.XProtocolObject ):
	""" Attributes of Statistics, such as Color """
	# Class Properties
	def _get_color (self):
		return self.getVar ("color")
	def _set_color (self, value):
		self.setVar ("color", value)
	color = property (_get_color, _set_color, None, "color property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatAttribute, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["color"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatAttribute"


