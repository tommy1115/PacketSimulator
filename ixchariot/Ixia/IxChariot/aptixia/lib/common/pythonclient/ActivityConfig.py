import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class ActivityConfig( XProtocolObject.XProtocolObject ):
	# Enums
	class eActivityType (Aptixia.IxEnum):
		kTypeClient = 0
		kTypeServer = 1
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "ActivityConfig.eActivityType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class ActivityObjectiveVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ActivityConfig.ActivityObjective")
		if "ActivityConfig.ActivityObjectiveVector" not in Aptixia.lists:
			Aptixia.lists.append( "ActivityConfig.ActivityObjectiveVector" )
		def getType():
			return "ActivityConfig.ActivityObjectiveVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ActivityConfig.ActivityObjective"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ActivityConfig.ActivityObjective
		getElementClass = staticmethod(getElementClass)
	class ActivityVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ActivityConfig.Activity")
		if "ActivityConfig.ActivityVector" not in Aptixia.lists:
			Aptixia.lists.append( "ActivityConfig.ActivityVector" )
		def getType():
			return "ActivityConfig.ActivityVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ActivityConfig.Activity"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ActivityConfig.Activity
		getElementClass = staticmethod(getElementClass)
	class ActivityModelVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "ActivityConfig.ActivityModel")
		if "ActivityConfig.ActivityModelVector" not in Aptixia.lists:
			Aptixia.lists.append( "ActivityConfig.ActivityModelVector" )
		def getType():
			return "ActivityConfig.ActivityModelVector"
		getType = staticmethod(getType)
		def getElementType():
			return "ActivityConfig.ActivityModel"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return ActivityConfig.ActivityModel
		getElementClass = staticmethod(getElementClass)

	# Structs
	class ActivityObjective( Aptixia.IxStruct ):
		if "ActivityConfig.ActivityObjective" not in Aptixia.structs:
			Aptixia.structs.append("ActivityConfig.ActivityObjective")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.type = ""
			self.units = ""
			self.minLoad = 0.0
			self.maxLoad = 0.0
			self._version = "1"
			self._types = { "type":"string",
				 "units":"string",
				 "minLoad":"double",
				 "maxLoad":"double" }
		def getType( self ):
			return "ActivityConfig.ActivityObjective"

	class Activity( Aptixia.IxStruct ):
		if "ActivityConfig.Activity" not in Aptixia.structs:
			Aptixia.structs.append("ActivityConfig.Activity")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.type = ActivityConfig.eActivityType()
			self.protocol = ""
			self.adapterId = ""
			self.supportsIterations = False
			self.supportsRandom = False
			self.supportsPendingUsers = False
			self.minInterval = 0
			self.objectives = ActivityConfig.ActivityObjectiveVector()
			self._version = "1"
			self._types = { "name":"string",
				 "type":"ActivityConfig.eActivityType",
				 "protocol":"string",
				 "adapterId":"string",
				 "supportsIterations":"bool",
				 "supportsRandom":"bool",
				 "supportsPendingUsers":"bool",
				 "minInterval":"int32",
				 "objectives":"ActivityConfig.ActivityObjectiveVector" }
		def getType( self ):
			return "ActivityConfig.Activity"

	class ActivityModel( Aptixia.IxStruct ):
		if "ActivityConfig.ActivityModel" not in Aptixia.structs:
			Aptixia.structs.append("ActivityConfig.ActivityModel")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.type = ActivityConfig.eActivityType()
			self.activities = ActivityConfig.ActivityVector()
			self._version = "1"
			self._types = { "name":"string",
				 "type":"ActivityConfig.eActivityType",
				 "activities":"ActivityConfig.ActivityVector" }
		def getType( self ):
			return "ActivityConfig.ActivityModel"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ActivityConfig, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ActivityConfig"

		pass

