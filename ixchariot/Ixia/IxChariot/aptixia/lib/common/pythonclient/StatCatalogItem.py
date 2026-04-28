import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import StatCatalogStat, StatFilter


class StatCatalogItem( XProtocolObject.XProtocolObject ):
	""" Item in the StatCatalog """
	# Class Properties
	def _get_statSourceType (self):
		return self.getVar ("statSourceType")
	def _set_statSourceType (self, value):
		self.setVar ("statSourceType", value)
	statSourceType = property (_get_statSourceType, _set_statSourceType, None, "statSourceType property")
	def _get_id (self):
		return self.getVar ("id")
	def _set_id (self, value):
		self.setVar ("id", value)
	id = property (_get_id, _set_id, None, "id property")
	def _get_statPublisher (self):
		return self.getVar ("statPublisher")
	def _set_statPublisher (self, value):
		self.setVar ("statPublisher", value)
	statPublisher = property (_get_statPublisher, _set_statPublisher, None, "statPublisher property")
	def _get_statList (self):
		return self.getListVar ("statList")
	statList = property (_get_statList, None, None, "statList property")
	def _get_statFilterList (self):
		return self.getListVar ("statFilterList")
	statFilterList = property (_get_statFilterList, None, None, "statFilterList property")
	def _get_description (self):
		return self.getVar ("description")
	def _set_description (self, value):
		self.setVar ("description", value)
	description = property (_get_description, _set_description, None, "description property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatCatalogItem, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["statSourceType"] = ""
			self.managedProperties["id"] = 0
			self.managedProperties["statPublisher"] = ""
			self.managedProperties["statList"] = Aptixia.IxObjectList (self.transactionContext, "StatCatalogStat")
			self.managedProperties["statFilterList"] = Aptixia.IxObjectList (self.transactionContext, "StatFilter")
			self.managedProperties["description"] = "SourceType"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatCatalogItem"


