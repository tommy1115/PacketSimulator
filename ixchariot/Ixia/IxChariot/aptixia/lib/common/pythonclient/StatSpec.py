import string, threading
import Aptixia, Aptixia_prv
import TreeNode


class StatSpec( TreeNode.TreeNode ):
	""" Description of stat for a stat consumer """
	# Enums
	class eAggregationTypeEnum (Aptixia.IxEnum):
		kSum = 0
		kMax = 1
		kMin = 2
		kAverage = 3
		kWeightedAverage = 4
		kRate = 5
		kMaxRate = 6
		kMinRate = 7
		kAverageRate = 8
		kNone = 9
		kRunStateAgg = 10
		kRunStateAggIgnoreRamp = 11
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatSpec.eAggregationTypeEnum"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eStatTypeEnum (Aptixia.IxEnum):
		kDefault = 0
		kArray = 1
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatSpec.eStatTypeEnum"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# Class Properties
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_removed (self):
		return self.getVar ("removed")
	def _set_removed (self, value):
		self.setVar ("removed", value)
	removed = property (_get_removed, _set_removed, None, "removed property")
	def _get_caption (self):
		return self.getVar ("caption")
	def _set_caption (self, value):
		self.setVar ("caption", value)
	caption = property (_get_caption, _set_caption, None, "caption property")
	def _get_statSourceType (self):
		return self.getVar ("statSourceType")
	def _set_statSourceType (self, value):
		self.setVar ("statSourceType", value)
	statSourceType = property (_get_statSourceType, _set_statSourceType, None, "statSourceType property")
	def _get_statName (self):
		return self.getVar ("statName")
	def _set_statName (self, value):
		self.setVar ("statName", value)
	statName = property (_get_statName, _set_statName, None, "statName property")
	def _get_aggregationType (self):
		return self.getVar ("aggregationType")
	def _set_aggregationType (self, value):
		self.setVar ("aggregationType", value)
	aggregationType = property (_get_aggregationType, _set_aggregationType, None, "aggregationType property")
	def _get_enumerated (self):
		return self.getVar ("enumerated")
	def _set_enumerated (self, value):
		self.setVar ("enumerated", value)
	enumerated = property (_get_enumerated, _set_enumerated, None, "enumerated property")
	def _get_interpolated (self):
		return self.getVar ("interpolated")
	def _set_interpolated (self, value):
		self.setVar ("interpolated", value)
	interpolated = property (_get_interpolated, _set_interpolated, None, "interpolated property")
	def _get_index (self):
		return self.getVar ("index")
	def _set_index (self, value):
		self.setVar ("index", value)
	index = property (_get_index, _set_index, None, "index property")
	def _get_indexLast (self):
		return self.getVar ("indexLast")
	def _set_indexLast (self, value):
		self.setVar ("indexLast", value)
	indexLast = property (_get_indexLast, _set_indexLast, None, "indexLast property")
	def _get_statType (self):
		return self.getVar ("statType")
	def _set_statType (self, value):
		self.setVar ("statType", value)
	statType = property (_get_statType, _set_statType, None, "statType property")
	def _get_yAxisRange (self):
		return self.getVar ("yAxisRange")
	def _set_yAxisRange (self, value):
		self.setVar ("yAxisRange", value)
	yAxisRange = property (_get_yAxisRange, _set_yAxisRange, None, "yAxisRange property")
	def _get_csvStatLabel (self):
		return self.getVar ("csvStatLabel")
	def _set_csvStatLabel (self, value):
		self.setVar ("csvStatLabel", value)
	csvStatLabel = property (_get_csvStatLabel, _set_csvStatLabel, None, "csvStatLabel property")
	def _get_csvFunctionLabel (self):
		return self.getVar ("csvFunctionLabel")
	def _set_csvFunctionLabel (self, value):
		self.setVar ("csvFunctionLabel", value)
	csvFunctionLabel = property (_get_csvFunctionLabel, _set_csvFunctionLabel, None, "csvFunctionLabel property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatSpec, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = True
			self.managedProperties["removed"] = False
			self.managedProperties["caption"] = "Stat1"
			self.managedProperties["statSourceType"] = "(Select)"
			self.managedProperties["statName"] = "(Select)"
			self.managedProperties["aggregationType"] = 0
			self.managedProperties["enumerated"] = False
			self.managedProperties["interpolated"] = True
			self.managedProperties["index"] = 0
			self.managedProperties["indexLast"] = 0
			self.managedProperties["statType"] = 0
			self.managedProperties["yAxisRange"] = "Main"
			self.managedProperties["csvStatLabel"] = ""
			self.managedProperties["csvFunctionLabel"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatSpec"


