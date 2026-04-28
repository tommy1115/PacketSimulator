import string, threading
import Aptixia, Aptixia_prv
import TreeNode
import StatCatalogItem, StatViewer, StatWatch, StatConsumer


class StatManager( TreeNode.TreeNode ):
	""" Manages the stat catalog and stat views """
	# Enums
	class eViewChangeActionEnum (Aptixia.IxEnum):
		kAdd = 0
		kRemove = 1
		kEnable = 2
		kDisable = 3
		kUpdate = 4
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatManager.eViewChangeActionEnum"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class StatPathList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "StatManager.StatPathList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.StatPathList" )
		def getType():
			return "StatManager.StatPathList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ResolvedStatList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.ResolvedStat")
		if "StatManager.ResolvedStatList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.ResolvedStatList" )
		def getType():
			return "StatManager.ResolvedStatList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.ResolvedStat"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.ResolvedStat
		getElementClass = staticmethod(getElementClass)
	class ValueList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "StatManager.ValueList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.ValueList" )
		def getType():
			return "StatManager.ValueList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class StatFilterList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.StatFilter")
		if "StatManager.StatFilterList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.StatFilterList" )
		def getType():
			return "StatManager.StatFilterList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.StatFilter"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.StatFilter
		getElementClass = staticmethod(getElementClass)
	class AggregatedStatList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.AggregatedStat")
		if "StatManager.AggregatedStatList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.AggregatedStatList" )
		def getType():
			return "StatManager.AggregatedStatList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.AggregatedStat"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.AggregatedStat
		getElementClass = staticmethod(getElementClass)
	class AggregatedStatInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.AggregatedStatInfo")
		if "StatManager.AggregatedStatInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.AggregatedStatInfoList" )
		def getType():
			return "StatManager.AggregatedStatInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.AggregatedStatInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.AggregatedStatInfo
		getElementClass = staticmethod(getElementClass)
	class PgidRangeList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.PgidRange")
		if "StatManager.PgidRangeList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.PgidRangeList" )
		def getType():
			return "StatManager.PgidRangeList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.PgidRange"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.PgidRange
		getElementClass = staticmethod(getElementClass)
	class PortList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "StatManager.PortList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.PortList" )
		def getType():
			return "StatManager.PortList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class StreamInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.StreamInfo")
		if "StatManager.StreamInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.StreamInfoList" )
		def getType():
			return "StatManager.StreamInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.StreamInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.StreamInfo
		getElementClass = staticmethod(getElementClass)
	class FlowInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.FlowInfo")
		if "StatManager.FlowInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.FlowInfoList" )
		def getType():
			return "StatManager.FlowInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.FlowInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.FlowInfo
		getElementClass = staticmethod(getElementClass)
	class ViewChangeList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatManager.ViewChange")
		if "StatManager.ViewChangeList" not in Aptixia.lists:
			Aptixia.lists.append( "StatManager.ViewChangeList" )
		def getType():
			return "StatManager.ViewChangeList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatManager.ViewChange"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatManager.ViewChange
		getElementClass = staticmethod(getElementClass)

	# Structs
	class ResolvedStat( Aptixia.IxStruct ):
		""" Stat with the stat engine path resolved """
		if "StatManager.ResolvedStat" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.ResolvedStat")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.tag = ""
			self.statPathList = StatManager.StatPathList()
			self._version = "1"
			self._types = { "tag":"string",
				 "statPathList":"StatManager.StatPathList" }
		def getType( self ):
			return "StatManager.ResolvedStat"

	class StatFilter( Aptixia.IxStruct ):
		""" A filter applied to the statistic.  The source application may define oneor more filters you can select from. If you select a filter, only the values forthe statistic that pass through that filter are displayed. For example, if you areconfiguring a statistic for packets transmitted and the source application allowsyou to filter for a particular port, such as port 1.1.1, the graph will only displaythe packets transmitted from port 1.1.1. """
		if "StatManager.StatFilter" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.StatFilter")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.valueList = StatManager.ValueList()
			self._version = "1"
			self._types = { "name":"string",
				 "valueList":"StatManager.ValueList" }
		def getType( self ):
			return "StatManager.StatFilter"

	class AggregatedStat( Aptixia.IxStruct ):
		""" A specific stat being aggregated with StatSpec and StatFilter selection """
		if "StatManager.AggregatedStat" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.AggregatedStat")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.tag = ""
			self.statSourceType = ""
			self.statName = ""
			self.filters = StatManager.StatFilterList()
			self._version = "1"
			self._types = { "tag":"string",
				 "statSourceType":"string",
				 "statName":"string",
				 "filters":"StatManager.StatFilterList" }
		def getType( self ):
			return "StatManager.AggregatedStat"

	class AggregatedStatInfo( Aptixia.IxStruct ):
		""" A specific stat being aggregated with StatSpec and StatFilter selection with array stat """
		if "StatManager.AggregatedStatInfo" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.AggregatedStatInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.tag = ""
			self.statSourceType = ""
			self.statName = ""
			self.statType = 0
			self.index = 0
			self.indexLast = 0
			self.filters = StatManager.StatFilterList()
			self._version = "1"
			self._types = { "tag":"string",
				 "statSourceType":"string",
				 "statName":"string",
				 "statType":"int64",
				 "index":"int64",
				 "indexLast":"int64",
				 "filters":"StatManager.StatFilterList" }
		def getType( self ):
			return "StatManager.AggregatedStatInfo"

	class PgidRange( Aptixia.IxStruct ):
		""" Range of Packet Group IDs from IxOS hardware """
		if "StatManager.PgidRange" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.PgidRange")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.firstIndex = -1
			self.lastIndex = -1
			self._version = "1"
			self._types = { "firstIndex":"int32",
				 "lastIndex":"int32" }
		def getType( self ):
			return "StatManager.PgidRange"

	class StreamInfo( Aptixia.IxStruct ):
		""" Describe a stream with PGID and tx/Rx ports """
		if "StatManager.StreamInfo" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.StreamInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.id = -1
			self.lineRate = 0
			self.txPort = ""
			self.rxPortList = StatManager.PortList()
			self.pgidRangeList = StatManager.PgidRangeList()
			self._version = "1"
			self._types = { "id":"int32",
				 "lineRate":"double",
				 "txPort":"string",
				 "rxPortList":"StatManager.PortList",
				 "pgidRangeList":"StatManager.PgidRangeList" }
		def getType( self ):
			return "StatManager.StreamInfo"

	class FlowInfo( Aptixia.IxStruct ):
		""" Flow name and PGID mapping """
		if "StatManager.FlowInfo" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.FlowInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.pgid = -1
			self.name = ""
			self._version = "1"
			self._types = { "pgid":"int32",
				 "name":"string" }
		def getType( self ):
			return "StatManager.FlowInfo"

	class ViewChange( Aptixia.IxStruct ):
		""" Change to a StatView """
		if "StatManager.ViewChange" not in Aptixia.structs:
			Aptixia.structs.append("StatManager.ViewChange")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.caption = ""
			self.action = 0
			self._version = "1"
			self._types = { "caption":"string",
				 "action":"int32" }
		def getType( self ):
			return "StatManager.ViewChange"


	# Class Properties
	def _get_statCatalog (self):
		return self.getListVar ("statCatalog")
	statCatalog = property (_get_statCatalog, None, None, "statCatalog property")
	def _get_statViewer (self):
		return self.getListVar ("statViewer")
	statViewer = property (_get_statViewer, None, None, "statViewer property")
	def _get_dbLogging (self):
		return self.getVar ("dbLogging")
	def _set_dbLogging (self, value):
		self.setVar ("dbLogging", value)
	dbLogging = property (_get_dbLogging, _set_dbLogging, None, "dbLogging property")
	def _get_statWatchList (self):
		return self.getListVar ("statWatchList")
	statWatchList = property (_get_statWatchList, None, None, "statWatchList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatManager, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["statCatalog"] = Aptixia.IxObjectList (self.transactionContext, "StatCatalogItem")
			self.managedProperties["statViewer"] = StatViewer.StatViewer (self)
			self.managedProperties["dbLogging"] = False
			self.managedProperties["statWatchList"] = Aptixia.IxObjectList (self.transactionContext, "StatWatch")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatManager"

	# Class Events
	def register_CatalogUpdateEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		return self.registerEvent ("CatalogUpdateEvent", argTuple, callback, callbackArg)

	def register_PathResolutionEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", None, "out", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "aggregatedStat", None, "out", "StatManager.AggregatedStatInfo", StatManager.AggregatedStatInfo)
		argTuple = ( arg0, arg1, arg2, )
		return self.registerEvent ("PathResolutionEvent", argTuple, callback, callbackArg)

	def register_LogStatsEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "statSetList", None, "out", "StatConsumer.StatSetList", StatConsumer.StatConsumer.StatSetList)
		argTuple = ( arg0, arg1, )
		return self.registerEvent ("LogStatsEvent", argTuple, callback, callbackArg)

	def register_ClearStatsEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		argTuple = ( arg0, )
		return self.registerEvent ("ClearStatsEvent", argTuple, callback, callbackArg)

	def register_CatalogChangeEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		argTuple = ( arg0, )
		return self.registerEvent ("CatalogChangeEvent", argTuple, callback, callbackArg)

	def register_ViewChangeEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "changeList", None, "out", "StatManager.ViewChangeList", StatManager.ViewChangeList)
		argTuple = ( arg0, arg1, )
		return self.registerEvent ("ViewChangeEvent", argTuple, callback, callbackArg)

	# Class Methods
	def ElapsedTime( self, callback = None, callbackArg = None ):
		""" Returns the elapsed time since start of Test.
			Returns elapsedTime: The elapsed time since start of Test. """
		arg0 = Aptixia_prv.MethodArgument( "elapsedTime", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ElapsedTime", argTuple, callback, callbackArg )
	def ElapsedTime_Sync( self ):
		""" Returns the elapsed time since start of Test.
			Returns elapsedTime: The elapsed time since start of Test. """
		arg0 = Aptixia_prv.MethodArgument( "elapsedTime", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ElapsedTime", argTuple)
		return context.Sync()

	def CommitCatalog( self, callback = None, callbackArg = None ):
		""" Select view templates to match statistic sources in the catalog. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CommitCatalog", argTuple, callback, callbackArg )
	def CommitCatalog_Sync( self ):
		""" Select view templates to match statistic sources in the catalog. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CommitCatalog", argTuple)
		return context.Sync()

	def RegisterStatEnginePaths( self, resolvedStatList, callback = None, callbackArg = None ):
		""" Register stat engine paths resolved by a client application from the aggregated stat list
			resolvedStatList: The resolved stat engine paths to register """
		arg0 = Aptixia_prv.MethodArgument( "resolvedStatList", resolvedStatList, "in", "StatManager.ResolvedStatList", StatManager.ResolvedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RegisterStatEnginePaths", argTuple, callback, callbackArg )
	def RegisterStatEnginePaths_Sync( self, resolvedStatList ):
		""" Register stat engine paths resolved by a client application from the aggregated stat list
			resolvedStatList: The resolved stat engine paths to register """
		arg0 = Aptixia_prv.MethodArgument( "resolvedStatList", resolvedStatList, "in", "StatManager.ResolvedStatList", StatManager.ResolvedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RegisterStatEnginePaths", argTuple)
		return context.Sync()

	def GetRegisteredStatEnginePaths( self, callback = None, callbackArg = None ):
		""" Get the registered stat engine paths that were resolved by a client application
			Returns resolvedStatList: The list of resolved stat engine paths """
		arg0 = Aptixia_prv.MethodArgument( "resolvedStatList", None, "out", "StatManager.ResolvedStatList", StatManager.ResolvedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetRegisteredStatEnginePaths", argTuple, callback, callbackArg )
	def GetRegisteredStatEnginePaths_Sync( self ):
		""" Get the registered stat engine paths that were resolved by a client application
			Returns resolvedStatList: The list of resolved stat engine paths """
		arg0 = Aptixia_prv.MethodArgument( "resolvedStatList", None, "out", "StatManager.ResolvedStatList", StatManager.ResolvedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetRegisteredStatEnginePaths", argTuple)
		return context.Sync()

	def GetAggregatedStatList( self, callback = None, callbackArg = None ):
		""" Get the aggregated stat descriptions for stat engine path resolution by a client application
			Returns aggregatedStatList: The list of aggregated stat descriptions for stat engine path resolution by a client application """
		arg0 = Aptixia_prv.MethodArgument( "aggregatedStatList", None, "out", "StatManager.AggregatedStatList", StatManager.AggregatedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAggregatedStatList", argTuple, callback, callbackArg )
	def GetAggregatedStatList_Sync( self ):
		""" Get the aggregated stat descriptions for stat engine path resolution by a client application
			Returns aggregatedStatList: The list of aggregated stat descriptions for stat engine path resolution by a client application """
		arg0 = Aptixia_prv.MethodArgument( "aggregatedStatList", None, "out", "StatManager.AggregatedStatList", StatManager.AggregatedStatList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAggregatedStatList", argTuple)
		return context.Sync()

	def GetAggregatedStatInfoList( self, callback = None, callbackArg = None ):
		""" Get the aggregated stat descriptions with array support for stat engine path resolution by a client application
			Returns aggregatedStatInfoList: The list of aggregated stat with array support descriptions for stat engine path resolution by a client application """
		arg0 = Aptixia_prv.MethodArgument( "aggregatedStatInfoList", None, "out", "StatManager.AggregatedStatInfoList", StatManager.AggregatedStatInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAggregatedStatInfoList", argTuple, callback, callbackArg )
	def GetAggregatedStatInfoList_Sync( self ):
		""" Get the aggregated stat descriptions with array support for stat engine path resolution by a client application
			Returns aggregatedStatInfoList: The list of aggregated stat with array support descriptions for stat engine path resolution by a client application """
		arg0 = Aptixia_prv.MethodArgument( "aggregatedStatInfoList", None, "out", "StatManager.AggregatedStatInfoList", StatManager.AggregatedStatInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAggregatedStatInfoList", argTuple)
		return context.Sync()

	def SetStreamFlowInfo( self, publisher, streamTable, flowTable, callback = None, callbackArg = None ):
		""" Set stream table and PGID label map for a publisher
			publisher: Name of the application that is setting the stream info
			streamTable: List of streams
			flowTable: List of flows """
		arg0 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "streamTable", streamTable, "in", "StatManager.StreamInfoList", StatManager.StreamInfoList)
		arg2 = Aptixia_prv.MethodArgument( "flowTable", flowTable, "in", "StatManager.FlowInfoList", StatManager.FlowInfoList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetStreamFlowInfo", argTuple, callback, callbackArg )
	def SetStreamFlowInfo_Sync( self, publisher, streamTable, flowTable ):
		""" Set stream table and PGID label map for a publisher
			publisher: Name of the application that is setting the stream info
			streamTable: List of streams
			flowTable: List of flows """
		arg0 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "streamTable", streamTable, "in", "StatManager.StreamInfoList", StatManager.StreamInfoList)
		arg2 = Aptixia_prv.MethodArgument( "flowTable", flowTable, "in", "StatManager.FlowInfoList", StatManager.FlowInfoList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetStreamFlowInfo", argTuple)
		return context.Sync()

	def RegisterStatPublisher( self, name, callback = None, callbackArg = None ):
		""" Add a remote StatPublisher
			name: The name of a remote StatPublisher to register """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RegisterStatPublisher", argTuple, callback, callbackArg )
	def RegisterStatPublisher_Sync( self, name ):
		""" Add a remote StatPublisher
			name: The name of a remote StatPublisher to register """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RegisterStatPublisher", argTuple)
		return context.Sync()

	def DeregisterStatPublisher( self, name, callback = None, callbackArg = None ):
		""" Remove a remote StatPublisher
			name: The name of a remote StatPublisher to deregister """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeregisterStatPublisher", argTuple, callback, callbackArg )
	def DeregisterStatPublisher_Sync( self, name ):
		""" Remove a remote StatPublisher
			name: The name of a remote StatPublisher to deregister """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeregisterStatPublisher", argTuple)
		return context.Sync()

	def UpdateStatCatalog( self, eventId, publisher, success, callback = None, callbackArg = None ):
		""" Notify StatManager that particular StatPublisher has finished the catalog updating
			eventId: Event ID that has been sent out by StatManager to request the StatCatalog updating or a negative vlaue indicates the application ahs updated the StatCatalog spontaniously
			publisher: name of the paplication that has updated the StatCatalog
			success: Whether the updating is successful """
		arg0 = Aptixia_prv.MethodArgument( "eventId", eventId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "success", success, "in", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "UpdateStatCatalog", argTuple, callback, callbackArg )
	def UpdateStatCatalog_Sync( self, eventId, publisher, success ):
		""" Notify StatManager that particular StatPublisher has finished the catalog updating
			eventId: Event ID that has been sent out by StatManager to request the StatCatalog updating or a negative vlaue indicates the application ahs updated the StatCatalog spontaniously
			publisher: name of the paplication that has updated the StatCatalog
			success: Whether the updating is successful """
		arg0 = Aptixia_prv.MethodArgument( "eventId", eventId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "success", success, "in", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "UpdateStatCatalog", argTuple)
		return context.Sync()

	def ResolveAggregatedStat( self, eventId, publisher, resolvedStat, callback = None, callbackArg = None ):
		""" Resolve StatEngine paths for a aggregated stat
			eventId: The event ID originally sent by Statmanager to resolve this StatEngine path
			publisher: The name of the StatPublisher that has resolved this stat
			resolvedStat: The resolved StatEngine paths """
		arg0 = Aptixia_prv.MethodArgument( "eventId", eventId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "resolvedStat", resolvedStat, "in", "StatManager.ResolvedStat", StatManager.ResolvedStat)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResolveAggregatedStat", argTuple, callback, callbackArg )
	def ResolveAggregatedStat_Sync( self, eventId, publisher, resolvedStat ):
		""" Resolve StatEngine paths for a aggregated stat
			eventId: The event ID originally sent by Statmanager to resolve this StatEngine path
			publisher: The name of the StatPublisher that has resolved this stat
			resolvedStat: The resolved StatEngine paths """
		arg0 = Aptixia_prv.MethodArgument( "eventId", eventId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "publisher", publisher, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "resolvedStat", resolvedStat, "in", "StatManager.ResolvedStat", StatManager.ResolvedStat)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ResolveAggregatedStat", argTuple)
		return context.Sync()

	def ConfigBuildInPublisher( self, name, enable, callback = None, callbackArg = None ):
		""" Configure build in StatPublisher
			name: The name of the buildin StatPublisher
			enable: Enable or Disable request """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigBuildInPublisher", argTuple, callback, callbackArg )
	def ConfigBuildInPublisher_Sync( self, name, enable ):
		""" Configure build in StatPublisher
			name: The name of the buildin StatPublisher
			enable: Enable or Disable request """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigBuildInPublisher", argTuple)
		return context.Sync()

	def CommitViewChange( self, changeList, callback = None, callbackArg = None ):
		""" Notify StatManager that particular StatPublisher has modified StatView list
			changeList: A list of StatView change actions """
		arg0 = Aptixia_prv.MethodArgument( "changeList", changeList, "in", "StatManager.ViewChangeList", StatManager.ViewChangeList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CommitViewChange", argTuple, callback, callbackArg )
	def CommitViewChange_Sync( self, changeList ):
		""" Notify StatManager that particular StatPublisher has modified StatView list
			changeList: A list of StatView change actions """
		arg0 = Aptixia_prv.MethodArgument( "changeList", changeList, "in", "StatManager.ViewChangeList", StatManager.ViewChangeList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CommitViewChange", argTuple)
		return context.Sync()


