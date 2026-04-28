import string, threading
import Aptixia, Aptixia_prv
import TreeNode


class DataStore( TreeNode.TreeNode ):
	""" This object exposes global configuration properties and methods for Datastore operations. """
	# List properties
	class TestResultIdList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int32")
		if "DataStore.TestResultIdList" not in Aptixia.lists:
			Aptixia.lists.append( "DataStore.TestResultIdList" )
		def getType():
			return "DataStore.TestResultIdList"
		getType = staticmethod(getType)
		def getElementType():
			return "int32"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)

	# Structs
	class ArchiveTimeOfDay( Aptixia.IxStruct ):
		""" Time of the day when automated archiving is attempted. """
		if "DataStore.ArchiveTimeOfDay" not in Aptixia.structs:
			Aptixia.structs.append("DataStore.ArchiveTimeOfDay")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.hour = -1
			self.minute = -1
			self._version = "1"
			self._types = { "hour":"int16",
				 "minute":"int16" }
		def getType( self ):
			return "DataStore.ArchiveTimeOfDay"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DataStore, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DataStore"

	# Class Methods
	def ArchiveTestResults( self, idList, callback = None, callbackArg = None ):
		""" This command archives data for the specified TestResults.
			idList: List of Ids of TestResult to archive. """
		arg0 = Aptixia_prv.MethodArgument( "idList", idList, "in", "DataStore.TestResultIdList", DataStore.TestResultIdList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ArchiveTestResults", argTuple, callback, callbackArg )
	def ArchiveTestResults_Sync( self, idList ):
		""" This command archives data for the specified TestResults.
			idList: List of Ids of TestResult to archive. """
		arg0 = Aptixia_prv.MethodArgument( "idList", idList, "in", "DataStore.TestResultIdList", DataStore.TestResultIdList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ArchiveTestResults", argTuple)
		return context.Sync()

	def ArchiveTestResult( self, testResultId, callback = None, callbackArg = None ):
		""" This command archives data for the specified TestResult.
			testResultId: Id of the TestResult to archive. """
		arg0 = Aptixia_prv.MethodArgument( "testResultId", testResultId, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ArchiveTestResult", argTuple, callback, callbackArg )
	def ArchiveTestResult_Sync( self, testResultId ):
		""" This command archives data for the specified TestResult.
			testResultId: Id of the TestResult to archive. """
		arg0 = Aptixia_prv.MethodArgument( "testResultId", testResultId, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ArchiveTestResult", argTuple)
		return context.Sync()

	def GetArchiveTimeOfDay( self, callback = None, callbackArg = None ):
		""" Gets the configured time of the day for automated archiving.
			Returns timeOfDay: Configured time of the day for automated archiving. """
		arg0 = Aptixia_prv.MethodArgument( "timeOfDay", None, "out", "DataStore.ArchiveTimeOfDay", DataStore.ArchiveTimeOfDay)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetArchiveTimeOfDay", argTuple, callback, callbackArg )
	def GetArchiveTimeOfDay_Sync( self ):
		""" Gets the configured time of the day for automated archiving.
			Returns timeOfDay: Configured time of the day for automated archiving. """
		arg0 = Aptixia_prv.MethodArgument( "timeOfDay", None, "out", "DataStore.ArchiveTimeOfDay", DataStore.ArchiveTimeOfDay)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetArchiveTimeOfDay", argTuple)
		return context.Sync()

	def SetArchiveTimeOfDay( self, timeOfDay, callback = None, callbackArg = None ):
		""" Configures time of the day for automated archiving.
			timeOfDay: Time of the day for automated archiving, using ArchiveTimeOfDay struct. """
		arg0 = Aptixia_prv.MethodArgument( "timeOfDay", timeOfDay, "in", "DataStore.ArchiveTimeOfDay", DataStore.ArchiveTimeOfDay)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetArchiveTimeOfDay", argTuple, callback, callbackArg )
	def SetArchiveTimeOfDay_Sync( self, timeOfDay ):
		""" Configures time of the day for automated archiving.
			timeOfDay: Time of the day for automated archiving, using ArchiveTimeOfDay struct. """
		arg0 = Aptixia_prv.MethodArgument( "timeOfDay", timeOfDay, "in", "DataStore.ArchiveTimeOfDay", DataStore.ArchiveTimeOfDay)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetArchiveTimeOfDay", argTuple)
		return context.Sync()

	def GetMaxSize( self, callback = None, callbackArg = None ):
		""" Gets configured maximum database size. When database size goes over this limit automated archiving kicks in.
			Returns maxSize: Maximum database size in MB. """
		arg0 = Aptixia_prv.MethodArgument( "maxSize", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetMaxSize", argTuple, callback, callbackArg )
	def GetMaxSize_Sync( self ):
		""" Gets configured maximum database size. When database size goes over this limit automated archiving kicks in.
			Returns maxSize: Maximum database size in MB. """
		arg0 = Aptixia_prv.MethodArgument( "maxSize", None, "out", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetMaxSize", argTuple)
		return context.Sync()

	def SetMaxSize( self, maxSize, callback = None, callbackArg = None ):
		""" Configures maximum database size. When database size goes over this limit automated archiving kicks in.
			maxSize: Maximum database size in MB. """
		arg0 = Aptixia_prv.MethodArgument( "maxSize", maxSize, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetMaxSize", argTuple, callback, callbackArg )
	def SetMaxSize_Sync( self, maxSize ):
		""" Configures maximum database size. When database size goes over this limit automated archiving kicks in.
			maxSize: Maximum database size in MB. """
		arg0 = Aptixia_prv.MethodArgument( "maxSize", maxSize, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetMaxSize", argTuple)
		return context.Sync()

	def GetReporterDSN( self, callback = None, callbackArg = None ):
		""" Returns a connection string for the reporter to be used when requesting data from this Datastore.
			Returns reporterDsn: Pass this string to the reporter command line argument named -udl. """
		arg0 = Aptixia_prv.MethodArgument( "reporterDsn", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetReporterDSN", argTuple, callback, callbackArg )
	def GetReporterDSN_Sync( self ):
		""" Returns a connection string for the reporter to be used when requesting data from this Datastore.
			Returns reporterDsn: Pass this string to the reporter command line argument named -udl. """
		arg0 = Aptixia_prv.MethodArgument( "reporterDsn", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetReporterDSN", argTuple)
		return context.Sync()


