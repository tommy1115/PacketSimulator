import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import Test, ServiceExtension, ActivityConfig, TestServerUnitTestNode, GenericTestModel


class Session( XProtocolObject.XProtocolObject ):
	""" Session is a platform for manipulating tests. Multiple users can connectto the same session. Tests are created, loaded and saved from here. """
	# Enums
	class eEventType (Aptixia.IxEnum):
		kFsmEnteredStateUnconfigured = 0
		kFsmEnteredStateRebootPorts = 1
		kFsmEnteredStateTakeOwnership = 2
		kFsmEnteredStateReset = 3
		kFsmEnteredStateDodPackagesLoadStack = 4
		kFsmEnteredStateDodPackagesUnloadStack = 5
		kFsmEnteredStateConfigured = 6
		kFsmEnteredStateConfigStack = 7
		kFsmEnteredStatePostConfigStack = 8
		kFsmEnteredStateDeconfigStack = 9
		kFsmEnteredStateReleaseOwnership = 10
		kFsmEnteredStateOther = 11
		kFsmEnteredStateResetStack = 12
		kFsmEnteredRunStateGratArp = 13
		kFsmEnteredRunStateWaitLinkUp = 14
		kFsmEnteredRunStateConfigured = 15
		kUnconfigured = 16
		kConfigured = 17
		kTakeOwnership = 18
		kReleaseOwnership = 19
		kReset = 20
		kDodPackagesLoad = 21
		kDodPackagesUnload = 22
		kConfiguredPhysical = 23
		kRunning = 24
		kReady = 25
		kValidate = 26
		kRemovedConfig = 27
		kPluginInfo = 28
		kPluginError = 29
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "Session.eEventType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class SupportedCardList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "Session.SupportedCardList" not in Aptixia.lists:
			Aptixia.lists.append( "Session.SupportedCardList" )
		def getType():
			return "Session.SupportedCardList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class SupportedPluginList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "Session.SupportedPluginList" not in Aptixia.lists:
			Aptixia.lists.append( "Session.SupportedPluginList" )
		def getType():
			return "Session.SupportedPluginList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class TestInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "Session.TestInfo")
		if "Session.TestInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "Session.TestInfoList" )
		def getType():
			return "Session.TestInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "Session.TestInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return Session.TestInfo
		getElementClass = staticmethod(getElementClass)

	# Structs
	class TestInfo( Aptixia.IxStruct ):
		""" This structure holds information about a test. """
		if "Session.TestInfo" not in Aptixia.structs:
			Aptixia.structs.append("Session.TestInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.id = 0
			self.testName = ""
			self.userName = ""
			self.dateTime = 0
			self._version = "1"
			self._types = { "id":"int32",
				 "testName":"string",
				 "userName":"string",
				 "dateTime":"int64" }
		def getType( self ):
			return "Session.TestInfo"

	class EventData( Aptixia.IxStruct ):
		""" Structure containing argument data for SystemEvents """
		if "Session.EventData" not in Aptixia.structs:
			Aptixia.structs.append("Session.EventData")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.eventType = Session.eEventType()
			self.eventMessage = ""
			self._version = "1"
			self._types = { "eventType":"Session.eEventType",
				 "eventMessage":"string" }
		def getType( self ):
			return "Session.EventData"


	# Class Properties
	def _get_runningTest (self):
		return self.getListVar ("runningTest")
	def _set_runningTest (self, value):
		self.setVar ("runningTest", value)
	runningTest = property (_get_runningTest, _set_runningTest, None, "runningTest property")
	def _get_editableTest (self):
		return self.getListVar ("editableTest")
	def _set_editableTest (self, value):
		self.setVar ("editableTest", value)
	editableTest = property (_get_editableTest, _set_editableTest, None, "editableTest property")
	def _get_doWaitLinkUp (self):
		return self.getVar ("doWaitLinkUp")
	def _set_doWaitLinkUp (self, value):
		self.setVar ("doWaitLinkUp", value)
	doWaitLinkUp = property (_get_doWaitLinkUp, _set_doWaitLinkUp, None, "doWaitLinkUp property")
	def _get_doGratArp (self):
		return self.getVar ("doGratArp")
	def _set_doGratArp (self, value):
		self.setVar ("doGratArp", value)
	doGratArp = property (_get_doGratArp, _set_doGratArp, None, "doGratArp property")
	def _get_doInterfaceCheck (self):
		return self.getVar ("doInterfaceCheck")
	def _set_doInterfaceCheck (self, value):
		self.setVar ("doInterfaceCheck", value)
	doInterfaceCheck = property (_get_doInterfaceCheck, _set_doInterfaceCheck, None, "doInterfaceCheck property")
	def _get_serviceExtensionList (self):
		return self.getListVar ("serviceExtensionList")
	serviceExtensionList = property (_get_serviceExtensionList, None, None, "serviceExtensionList property")
	def _get_waitForLinkUp (self):
		return self.getVar ("waitForLinkUp")
	def _set_waitForLinkUp (self, value):
		self.setVar ("waitForLinkUp", value)
	waitForLinkUp = property (_get_waitForLinkUp, _set_waitForLinkUp, None, "waitForLinkUp property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Session, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["runningTest"] = None
			self.managedProperties["editableTest"] = None
			self.managedProperties["doWaitLinkUp"] = False
			self.managedProperties["doGratArp"] = False
			self.managedProperties["doInterfaceCheck"] = False
			self.managedProperties["serviceExtensionList"] = Aptixia.IxObjectList (self.transactionContext, "ServiceExtension")
			self.managedProperties["waitForLinkUp"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Session"

	# Class Events
	def register_PostConfigError_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "errorMessage", None, "out", "string", None)
		argTuple = ( arg0, )
		return self.registerEvent ("PostConfigError", argTuple, callback, callbackArg)

	def register_SystemEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "eventData", None, "out", "Session.EventData", Session.EventData)
		argTuple = ( arg0, )
		return self.registerEvent ("SystemEvent", argTuple, callback, callbackArg)

	# Class Methods
	def SetErrorInjectionTags( self, i_errorTags, callback = None, callbackArg = None ):
		""" Hook for enabling various error injection modes. Used for internalunit testing of various failure conditions
			i_errorTags: list of error tags to be injected """
		arg0 = Aptixia_prv.MethodArgument( "i_errorTags", i_errorTags, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetErrorInjectionTags", argTuple, callback, callbackArg )
	def SetErrorInjectionTags_Sync( self, i_errorTags ):
		""" Hook for enabling various error injection modes. Used for internalunit testing of various failure conditions
			i_errorTags: list of error tags to be injected """
		arg0 = Aptixia_prv.MethodArgument( "i_errorTags", i_errorTags, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetErrorInjectionTags", argTuple)
		return context.Sync()

	def SetCardsSupportedByApplication( self, supportedCardList, callback = None, callbackArg = None ):
		""" The application can constrain the available card typesby calling this function after creating a TestServer Session object.If the card is not in the supplied list, the card it is not made availablefor use.
			supportedCardList: A list of card description strings E.g. '10/100/1000 ALM T8' """
		arg0 = Aptixia_prv.MethodArgument( "supportedCardList", supportedCardList, "in", "Session.SupportedCardList", Session.SupportedCardList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCardsSupportedByApplication", argTuple, callback, callbackArg )
	def SetCardsSupportedByApplication_Sync( self, supportedCardList ):
		""" The application can constrain the available card typesby calling this function after creating a TestServer Session object.If the card is not in the supplied list, the card it is not made availablefor use.
			supportedCardList: A list of card description strings E.g. '10/100/1000 ALM T8' """
		arg0 = Aptixia_prv.MethodArgument( "supportedCardList", supportedCardList, "in", "Session.SupportedCardList", Session.SupportedCardList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetCardsSupportedByApplication", argTuple)
		return context.Sync()

	def SetPluginsSupportedByApplication( self, supportedPluginList, callback = None, callbackArg = None ):
		""" The application can constrain the plugin types by calling thisfunction after creating a TestServer Session object.If the plugin is not in the supplied the list, it is not made availablefor use.
			supportedPluginList: A list of plugin description strings E.g. 'EthernetPlugin' """
		arg0 = Aptixia_prv.MethodArgument( "supportedPluginList", supportedPluginList, "in", "Session.SupportedPluginList", Session.SupportedPluginList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetPluginsSupportedByApplication", argTuple, callback, callbackArg )
	def SetPluginsSupportedByApplication_Sync( self, supportedPluginList ):
		""" The application can constrain the plugin types by calling thisfunction after creating a TestServer Session object.If the plugin is not in the supplied the list, it is not made availablefor use.
			supportedPluginList: A list of plugin description strings E.g. 'EthernetPlugin' """
		arg0 = Aptixia_prv.MethodArgument( "supportedPluginList", supportedPluginList, "in", "Session.SupportedPluginList", Session.SupportedPluginList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetPluginsSupportedByApplication", argTuple)
		return context.Sync()

	def ClearHardwareTimeStamp( self, callback = None, callbackArg = None ):
		""" Clears the hardware timestamp """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearHardwareTimeStamp", argTuple, callback, callbackArg )
	def ClearHardwareTimeStamp_Sync( self ):
		""" Clears the hardware timestamp """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ClearHardwareTimeStamp", argTuple)
		return context.Sync()

	def ConfigureTest( self, callback = None, callbackArg = None ):
		""" Applies the configuration to the ports. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigureTest", argTuple, callback, callbackArg )
	def ConfigureTest_Sync( self ):
		""" Applies the configuration to the ports. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ConfigureTest", argTuple)
		return context.Sync()

	def DeconfigureTest( self, callback = None, callbackArg = None ):
		""" Removes the previously applied configuration. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeconfigureTest", argTuple, callback, callbackArg )
	def DeconfigureTest_Sync( self ):
		""" Removes the previously applied configuration. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeconfigureTest", argTuple)
		return context.Sync()

	def StartTest( self, callback = None, callbackArg = None ):
		""" Starts the configuration. Should be called before the application starts using the configuration. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTest", argTuple, callback, callbackArg )
	def StartTest_Sync( self ):
		""" Starts the configuration. Should be called before the application starts using the configuration. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StartTest", argTuple)
		return context.Sync()

	def StopTest( self, callback = None, callbackArg = None ):
		""" Stops the configuration. Is called by the application to stop the configuration. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopTest", argTuple, callback, callbackArg )
	def StopTest_Sync( self ):
		""" Stops the configuration. Is called by the application to stop the configuration. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StopTest", argTuple)
		return context.Sync()

	def CancelTest( self, callback = None, callbackArg = None ):
		""" Cancels the state machine action and empties the event queue. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CancelTest", argTuple, callback, callbackArg )
	def CancelTest_Sync( self ):
		""" Cancels the state machine action and empties the event queue. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CancelTest", argTuple)
		return context.Sync()

	def CloseTest( self, callback = None, callbackArg = None ):
		""" Closes the test object. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CloseTest", argTuple, callback, callbackArg )
	def CloseTest_Sync( self ):
		""" Closes the test object. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CloseTest", argTuple)
		return context.Sync()

	def Ping( self, callback = None, callbackArg = None ):
		""" Trivial method for checking connectivity. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple, callback, callbackArg )
	def Ping_Sync( self ):
		""" Trivial method for checking connectivity. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple)
		return context.Sync()

	def Close( self, callback = None, callbackArg = None ):
		""" Close this session. Discards all associated data. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Close", argTuple, callback, callbackArg )
	def Close_Sync( self ):
		""" Close this session. Discards all associated data. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Close", argTuple)
		return context.Sync()

	def CreateTest( self, callback = None, callbackArg = None ):
		""" Create a new test under this session. Displaces any test already in the session.
			Returns test: Reference to the new test. """
		arg0 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTest", argTuple, callback, callbackArg )
	def CreateTest_Sync( self ):
		""" Create a new test under this session. Displaces any test already in the session.
			Returns test: Reference to the new test. """
		arg0 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTest", argTuple)
		return context.Sync()

	def DeleteTest( self, testId, callback = None, callbackArg = None ):
		""" Delete a test in the database.
			testId: Unique id of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeleteTest", argTuple, callback, callbackArg )
	def DeleteTest_Sync( self, testId ):
		""" Delete a test in the database.
			testId: Unique id of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DeleteTest", argTuple)
		return context.Sync()

	def RenameTest( self, testId, name, callback = None, callbackArg = None ):
		""" Rename a test in the database.
			testId: Unique id of the test.
			name: New name of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RenameTest", argTuple, callback, callbackArg )
	def RenameTest_Sync( self, testId, name ):
		""" Rename a test in the database.
			testId: Unique id of the test.
			name: New name of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RenameTest", argTuple)
		return context.Sync()

	def OpenTest( self, testId, callback = None, callbackArg = None ):
		""" Open a test from the database. This will displace a pre-existing test in the session.
			testId: Unique id of the test.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTest", argTuple, callback, callbackArg )
	def OpenTest_Sync( self, testId ):
		""" Open a test from the database. This will displace a pre-existing test in the session.
			testId: Unique id of the test.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "testId", testId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTest", argTuple)
		return context.Sync()

	def OpenTestByName( self, filename, callback = None, callbackArg = None ):
		""" Open a test from the database. This will displace a pre-existing test in the session.
			filename: File name of the test.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestByName", argTuple, callback, callbackArg )
	def OpenTestByName_Sync( self, filename ):
		""" Open a test from the database. This will displace a pre-existing test in the session.
			filename: File name of the test.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestByName", argTuple)
		return context.Sync()

	def OpenTestResult( self, testResultId, callback = None, callbackArg = None ):
		""" Open a test result from the database. This will displace a pre-existing test in the session.
			testResultId: Unique id of the test result.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "testResultId", testResultId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestResult", argTuple, callback, callbackArg )
	def OpenTestResult_Sync( self, testResultId ):
		""" Open a test result from the database. This will displace a pre-existing test in the session.
			testResultId: Unique id of the test result.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "testResultId", testResultId, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestResult", argTuple)
		return context.Sync()

	def OpenTestResultByName( self, filename, callback = None, callbackArg = None ):
		""" Open a test result from the database by file name. This will displace a pre-existing test in the session.
			filename: File name of the test result.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestResultByName", argTuple, callback, callbackArg )
	def OpenTestResultByName_Sync( self, filename ):
		""" Open a test result from the database by file name. This will displace a pre-existing test in the session.
			filename: File name of the test result.
			Returns test: Reference to the opened test. """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "test", None, "out", "Test", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenTestResultByName", argTuple)
		return context.Sync()

	def GetTestList( self, testName, userName, dateTimeBegin, dateTimeEnd, callback = None, callbackArg = None ):
		""" Retrieve a list of tests from the database.
			testName: Name of the test or empty string. [?]
			userName: User name or empty string. [?]
			dateTimeBegin: Beginning of search period. [Units???]
			dateTimeEnd: End of search period. [Units???]
			Returns testInfoList: Returned list of test information structures. """
		arg0 = Aptixia_prv.MethodArgument( "testName", testName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "dateTimeBegin", dateTimeBegin, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "dateTimeEnd", dateTimeEnd, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "testInfoList", None, "out", "Session.TestInfoList", Session.TestInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestList", argTuple, callback, callbackArg )
	def GetTestList_Sync( self, testName, userName, dateTimeBegin, dateTimeEnd ):
		""" Retrieve a list of tests from the database.
			testName: Name of the test or empty string. [?]
			userName: User name or empty string. [?]
			dateTimeBegin: Beginning of search period. [Units???]
			dateTimeEnd: End of search period. [Units???]
			Returns testInfoList: Returned list of test information structures. """
		arg0 = Aptixia_prv.MethodArgument( "testName", testName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "dateTimeBegin", dateTimeBegin, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "dateTimeEnd", dateTimeEnd, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "testInfoList", None, "out", "Session.TestInfoList", Session.TestInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestList", argTuple)
		return context.Sync()

	def GetTestResultList( self, testName, userName, dateTimeBegin, dateTimeEnd, callback = None, callbackArg = None ):
		""" Retrieve a list of test results from the database.
			testName: Name of the test or empty string. [?]
			userName: User name or empty string. [?]
			dateTimeBegin: Beginning of search period. [Units???]
			dateTimeEnd: Beginning of search period. [Units???]
			Returns testInfoList: Returned list of test information structures. """
		arg0 = Aptixia_prv.MethodArgument( "testName", testName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "dateTimeBegin", dateTimeBegin, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "dateTimeEnd", dateTimeEnd, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "testInfoList", None, "out", "Session.TestInfoList", Session.TestInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestResultList", argTuple, callback, callbackArg )
	def GetTestResultList_Sync( self, testName, userName, dateTimeBegin, dateTimeEnd ):
		""" Retrieve a list of test results from the database.
			testName: Name of the test or empty string. [?]
			userName: User name or empty string. [?]
			dateTimeBegin: Beginning of search period. [Units???]
			dateTimeEnd: Beginning of search period. [Units???]
			Returns testInfoList: Returned list of test information structures. """
		arg0 = Aptixia_prv.MethodArgument( "testName", testName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "dateTimeBegin", dateTimeBegin, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "dateTimeEnd", dateTimeEnd, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "testInfoList", None, "out", "Session.TestInfoList", Session.TestInfoList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestResultList", argTuple)
		return context.Sync()

	def GetAppName( self, callback = None, callbackArg = None ):
		""" Retrieve the name of the application the session was created for.
			Returns name: Name of the application. """
		arg0 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAppName", argTuple, callback, callbackArg )
	def GetAppName_Sync( self ):
		""" Retrieve the name of the application the session was created for.
			Returns name: Name of the application. """
		arg0 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAppName", argTuple)
		return context.Sync()

	def GetTestXml( self, testId , callback = None, callbackArg = None ):
		""" Retrieve XML representation of a test in the database.
			testId : Unique ID of the test.
			Returns xml: XML representation of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId ", testId , "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestXml", argTuple, callback, callbackArg )
	def GetTestXml_Sync( self, testId  ):
		""" Retrieve XML representation of a test in the database.
			testId : Unique ID of the test.
			Returns xml: XML representation of the test. """
		arg0 = Aptixia_prv.MethodArgument( "testId ", testId , "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestXml", argTuple)
		return context.Sync()

	def GetTestResultXml( self, testId , callback = None, callbackArg = None ):
		""" Retrieve XML representation of a test result in the database.
			testId : Unique ID of the test.
			Returns xml: XML representation of the test result. """
		arg0 = Aptixia_prv.MethodArgument( "testId ", testId , "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestResultXml", argTuple, callback, callbackArg )
	def GetTestResultXml_Sync( self, testId  ):
		""" Retrieve XML representation of a test result in the database.
			testId : Unique ID of the test.
			Returns xml: XML representation of the test result. """
		arg0 = Aptixia_prv.MethodArgument( "testId ", testId , "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestResultXml", argTuple)
		return context.Sync()

	def SetPortGroupDefault( self, xml, callback = None, callbackArg = None ):
		""" Set the xml used to initialize new port groups
			xml: The xml used to initialize new port groups """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetPortGroupDefault", argTuple, callback, callbackArg )
	def SetPortGroupDefault_Sync( self, xml ):
		""" Set the xml used to initialize new port groups
			xml: The xml used to initialize new port groups """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetPortGroupDefault", argTuple)
		return context.Sync()

	def SetUserName( self, userName, callback = None, callbackArg = None ):
		""" (Re)set the user name for apply this session object
			userName: New User name to apply to this session object """
		arg0 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetUserName", argTuple, callback, callbackArg )
	def SetUserName_Sync( self, userName ):
		""" (Re)set the user name for apply this session object
			userName: New User name to apply to this session object """
		arg0 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetUserName", argTuple)
		return context.Sync()

	def SetActivityModels( self, activityModels, callback = None, callbackArg = None ):
		""" Method to set the activity model
			activityModels: List of avtivity models to set """
		arg0 = Aptixia_prv.MethodArgument( "activityModels", activityModels, "in", "ActivityConfig.ActivityModelVector", ActivityConfig.ActivityConfig.ActivityModelVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActivityModels", argTuple, callback, callbackArg )
	def SetActivityModels_Sync( self, activityModels ):
		""" Method to set the activity model
			activityModels: List of avtivity models to set """
		arg0 = Aptixia_prv.MethodArgument( "activityModels", activityModels, "in", "ActivityConfig.ActivityModelVector", ActivityConfig.ActivityConfig.ActivityModelVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActivityModels", argTuple)
		return context.Sync()

	def GetActivityModels( self, callback = None, callbackArg = None ):
		""" Method to get the list of activity models
			Returns activityModels: List of activity models """
		arg0 = Aptixia_prv.MethodArgument( "activityModels", None, "out", "ActivityConfig.ActivityModelVector", ActivityConfig.ActivityConfig.ActivityModelVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetActivityModels", argTuple, callback, callbackArg )
	def GetActivityModels_Sync( self ):
		""" Method to get the list of activity models
			Returns activityModels: List of activity models """
		arg0 = Aptixia_prv.MethodArgument( "activityModels", None, "out", "ActivityConfig.ActivityModelVector", ActivityConfig.ActivityConfig.ActivityModelVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetActivityModels", argTuple)
		return context.Sync()

	def CreateTestServerUnitTestNode( self, callback = None, callbackArg = None ):
		""" For internal unit test only
			Returns unitTestNode: returns unit test object """
		arg0 = Aptixia_prv.MethodArgument( "unitTestNode", None, "out", "TestServerUnitTestNode", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestServerUnitTestNode", argTuple, callback, callbackArg )
	def CreateTestServerUnitTestNode_Sync( self ):
		""" For internal unit test only
			Returns unitTestNode: returns unit test object """
		arg0 = Aptixia_prv.MethodArgument( "unitTestNode", None, "out", "TestServerUnitTestNode", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestServerUnitTestNode", argTuple)
		return context.Sync()

	def AddLicense( self, featureId, callback = None, callbackArg = None ):
		""" Activates licensed plug-in. For Ixia applications use only.
			featureId: License Id of plug-in to enable. """
		arg0 = Aptixia_prv.MethodArgument( "featureId", featureId, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AddLicense", argTuple, callback, callbackArg )
	def AddLicense_Sync( self, featureId ):
		""" Activates licensed plug-in. For Ixia applications use only.
			featureId: License Id of plug-in to enable. """
		arg0 = Aptixia_prv.MethodArgument( "featureId", featureId, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "AddLicense", argTuple)
		return context.Sync()

	def Internal_EnableActionBehaviorMessages( self, enable, callback = None, callbackArg = None ):
		""" Note: This is an internal Unit test method.Turn on or off ActionBehaviorMessage collection
			enable: The enabler parameter for the call """
		arg0 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Internal_EnableActionBehaviorMessages", argTuple, callback, callbackArg )
	def Internal_EnableActionBehaviorMessages_Sync( self, enable ):
		""" Note: This is an internal Unit test method.Turn on or off ActionBehaviorMessage collection
			enable: The enabler parameter for the call """
		arg0 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Internal_EnableActionBehaviorMessages", argTuple)
		return context.Sync()

	def Internal_GetActionBehaviorMessages( self, clear, callback = None, callbackArg = None ):
		""" Note: This is an internal Unit test method.Get all action behavior internal log messages.
			clear: clear messages after getting them
			Returns messagelist: Requested message (string) list """
		arg0 = Aptixia_prv.MethodArgument( "clear", clear, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "messagelist", None, "out", "GenericTestModel.StringVector", GenericTestModel.GenericTestModel.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Internal_GetActionBehaviorMessages", argTuple, callback, callbackArg )
	def Internal_GetActionBehaviorMessages_Sync( self, clear ):
		""" Note: This is an internal Unit test method.Get all action behavior internal log messages.
			clear: clear messages after getting them
			Returns messagelist: Requested message (string) list """
		arg0 = Aptixia_prv.MethodArgument( "clear", clear, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "messagelist", None, "out", "GenericTestModel.StringVector", GenericTestModel.GenericTestModel.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Internal_GetActionBehaviorMessages", argTuple)
		return context.Sync()


