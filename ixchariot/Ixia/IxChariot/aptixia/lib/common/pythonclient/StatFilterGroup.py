import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import StatFilter


class StatFilterGroup( XProtocolObject.XProtocolObject ):
	""" A list of stat fitlers available for a stat source type """
	# Class Properties
	def _get_caption (self):
		return self.getVar ("caption")
	def _set_caption (self, value):
		self.setVar ("caption", value)
	caption = property (_get_caption, _set_caption, None, "caption property")
	def _get_statFilterList (self):
		return self.getListVar ("statFilterList")
	statFilterList = property (_get_statFilterList, None, None, "statFilterList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatFilterGroup, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["caption"] = ""
			self.managedProperties["statFilterList"] = Aptixia.IxObjectList (self.transactionContext, "StatFilter")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatFilterGroup"


