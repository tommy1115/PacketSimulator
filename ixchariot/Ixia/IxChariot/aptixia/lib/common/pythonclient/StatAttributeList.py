import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import StatAttribute


class StatAttributeList( XProtocolObject.XProtocolObject ):
	""" Contains the list of Statistic Attributes for a StatView """
	# Class Properties
	def _get_statAttributeList (self):
		return self.getListVar ("statAttributeList")
	statAttributeList = property (_get_statAttributeList, None, None, "statAttributeList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatAttributeList, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["statAttributeList"] = Aptixia.IxObjectList (self.transactionContext, "StatAttribute")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatAttributeList"


