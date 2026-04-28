import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class StatCatalogStat( XProtocolObject.XProtocolObject ):
	""" A stat in the StatCatalog """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_id (self):
		return self.getVar ("id")
	def _set_id (self, value):
		self.setVar ("id", value)
	id = property (_get_id, _set_id, None, "id property")
	def _get_valueType (self):
		return self.getVar ("valueType")
	def _set_valueType (self, value):
		self.setVar ("valueType", value)
	valueType = property (_get_valueType, _set_valueType, None, "valueType property")
	def _get_statType (self):
		return self.getVar ("statType")
	def _set_statType (self, value):
		self.setVar ("statType", value)
	statType = property (_get_statType, _set_statType, None, "statType property")
	def _get_indexMin (self):
		return self.getVar ("indexMin")
	def _set_indexMin (self, value):
		self.setVar ("indexMin", value)
	indexMin = property (_get_indexMin, _set_indexMin, None, "indexMin property")
	def _get_indexMax (self):
		return self.getVar ("indexMax")
	def _set_indexMax (self, value):
		self.setVar ("indexMax", value)
	indexMax = property (_get_indexMax, _set_indexMax, None, "indexMax property")
	def _get_availableAggregationTypeList (self):
		return self.getListVar ("availableAggregationTypeList")
	availableAggregationTypeList = property (_get_availableAggregationTypeList, None, None, "availableAggregationTypeList property")
	def _get_statEnginePath (self):
		return self.getVar ("statEnginePath")
	def _set_statEnginePath (self, value):
		self.setVar ("statEnginePath", value)
	statEnginePath = property (_get_statEnginePath, _set_statEnginePath, None, "statEnginePath property")
	def _get_description (self):
		return self.getVar ("description")
	def _set_description (self, value):
		self.setVar ("description", value)
	description = property (_get_description, _set_description, None, "description property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatCatalogStat, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["id"] = 0
			self.managedProperties["valueType"] = 0
			self.managedProperties["statType"] = 0
			self.managedProperties["indexMin"] = 0
			self.managedProperties["indexMax"] = 0
			self.managedProperties["availableAggregationTypeList"] = Aptixia.IxList ("int")
			self.managedProperties["statEnginePath"] = ""
			self.managedProperties["description"] = "Stat"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatCatalogStat"


