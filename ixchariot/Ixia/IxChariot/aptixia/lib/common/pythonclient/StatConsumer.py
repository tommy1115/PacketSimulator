import string, threading
import Aptixia, Aptixia_prv
import TreeNode


class StatConsumer( TreeNode.TreeNode ):
	""" Any consumer of stats, could be views or logs or other """
	# Enums
	class eStatValueType (Aptixia.IxEnum):
		kInt = 0
		kString = 1
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatConsumer.eStatValueType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class StatValueList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatConsumer.StatValue")
		if "StatConsumer.StatValueList" not in Aptixia.lists:
			Aptixia.lists.append( "StatConsumer.StatValueList" )
		def getType():
			return "StatConsumer.StatValueList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatConsumer.StatValue"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatConsumer.StatValue
		getElementClass = staticmethod(getElementClass)
	class StatChangeList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatConsumer.StatChange")
		if "StatConsumer.StatChangeList" not in Aptixia.lists:
			Aptixia.lists.append( "StatConsumer.StatChangeList" )
		def getType():
			return "StatConsumer.StatChangeList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatConsumer.StatChange"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatConsumer.StatChange
		getElementClass = staticmethod(getElementClass)
	class StatSetList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatConsumer.StatSet")
		if "StatConsumer.StatSetList" not in Aptixia.lists:
			Aptixia.lists.append( "StatConsumer.StatSetList" )
		def getType():
			return "StatConsumer.StatSetList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatConsumer.StatSet"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatConsumer.StatSet
		getElementClass = staticmethod(getElementClass)

	# Structs
	class StatValue( Aptixia.IxStruct ):
		""" The value a stat at a point in time """
		if "StatConsumer.StatValue" not in Aptixia.structs:
			Aptixia.structs.append("StatConsumer.StatValue")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.id = -1
			self.type = 0
			self.intValue = 0
			self.stringValue = ""
			self.timestamp = 0
			self._version = "1"
			self._types = { "id":"int32",
				 "type":"int32",
				 "intValue":"int64",
				 "stringValue":"string",
				 "timestamp":"int64" }
		def getType( self ):
			return "StatConsumer.StatValue"

	class StatChange( Aptixia.IxStruct ):
		""" A new change in a list of stats """
		if "StatConsumer.StatChange" not in Aptixia.structs:
			Aptixia.structs.append("StatConsumer.StatChange")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.newIndex = -1
			self.resultIndex = -1
			self.statSpecIndex = -1
			self.statSourceType = ""
			self.statName = ""
			self.statSpecCaption = ""
			self.csvStatLabel = ""
			self.csvFunctionLabel = ""
			self.filterGroupCaption = ""
			self.filterGroupToolTip = ""
			self._version = "1"
			self._types = { "newIndex":"int64",
				 "resultIndex":"int64",
				 "statSpecIndex":"int64",
				 "statSourceType":"string",
				 "statName":"string",
				 "statSpecCaption":"string",
				 "csvStatLabel":"string",
				 "csvFunctionLabel":"string",
				 "filterGroupCaption":"string",
				 "filterGroupToolTip":"string" }
		def getType( self ):
			return "StatConsumer.StatChange"

	class StatSet( Aptixia.IxStruct ):
		""" A timestamped delivery of a set of stats along and changes in the list from the last delivery """
		if "StatConsumer.StatSet" not in Aptixia.structs:
			Aptixia.structs.append("StatConsumer.StatSet")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.timestamp = 0
			self.stats = StatConsumer.StatValueList()
			self.changes = StatConsumer.StatChangeList()
			self._version = "1"
			self._types = { "timestamp":"int64",
				 "stats":"StatConsumer.StatValueList",
				 "changes":"StatConsumer.StatChangeList" }
		def getType( self ):
			return "StatConsumer.StatSet"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatConsumer, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatConsumer"

		pass

