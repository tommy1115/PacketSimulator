import string, threading
import Aptixia, Aptixia_prv
import Test
import PortGroup, ChassisConfig, GenericStatSource, ActivityModelInstance, PortWatch


class GenericTestModel( Test.Test ):
	""" Top level object which describes an aptixia test configuration.  Thisincludes elements such as such as portcpu network stack configurations,ixia chassis/port allocations, etc. """
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
		kFsmEnteredRunStateGratArp = 13
		kFsmEnteredRunStateWaitLinkUp = 14
		kFsmEnteredRunStateConfigured = 15
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "GenericTestModel.eEventType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eActionBehavior (Aptixia.IxEnum):
		kActionBehaviorSmart = 10
		kActionBehaviorAlways = 20
		kActionBehaviorNever = 30
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "GenericTestModel.eActionBehavior"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eAction (Aptixia.IxEnum):
		kActionTakeOwnership = 100
		kActionConfigurePhysical = 200
		kActionApplicationDOD = 300
		kActionApplicationDODUnload = 310
		kActionConfigureStack = 400
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "GenericTestModel.eAction"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class StringVector( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "GenericTestModel.StringVector" not in Aptixia.lists:
			Aptixia.lists.append( "GenericTestModel.StringVector" )
		def getType():
			return "GenericTestModel.StringVector"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)

	# Structs
	class EventData( Aptixia.IxStruct ):
		""" The event information that is delivered with test modelSystemEvents. """
		if "GenericTestModel.EventData" not in Aptixia.structs:
			Aptixia.structs.append("GenericTestModel.EventData")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.eventType = GenericTestModel.eEventType()
			self._version = "1"
			self._types = { "eventType":"GenericTestModel.eEventType" }
		def getType( self ):
			return "GenericTestModel.EventData"

	class TestInfo( Aptixia.IxStruct ):
		""" This structure holds information about a test. """
		if "GenericTestModel.TestInfo" not in Aptixia.structs:
			Aptixia.structs.append("GenericTestModel.TestInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.appName = ""
			self.userName = ""
			self.sessionName = ""
			self._version = "1"
			self._types = { "appName":"string",
				 "userName":"string",
				 "sessionName":"string" }
		def getType( self ):
			return "GenericTestModel.TestInfo"


	# Class Properties
	def _get_rebootPortsBeforeConfigure (self):
		return self.getVar ("rebootPortsBeforeConfigure")
	def _set_rebootPortsBeforeConfigure (self, value):
		self.setVar ("rebootPortsBeforeConfigure", value)
	rebootPortsBeforeConfigure = property (_get_rebootPortsBeforeConfigure, _set_rebootPortsBeforeConfigure, None, "rebootPortsBeforeConfigure property")
	def _get_testDuration (self):
		return self.getVar ("testDuration")
	def _set_testDuration (self, value):
		self.setVar ("testDuration", value)
	testDuration = property (_get_testDuration, _set_testDuration, None, "testDuration property")
	def _get_checkLinkState (self):
		return self.getVar ("checkLinkState")
	def _set_checkLinkState (self, value):
		self.setVar ("checkLinkState", value)
	checkLinkState = property (_get_checkLinkState, _set_checkLinkState, None, "checkLinkState property")
	def _get_portGroupList (self):
		return self.getListVar ("portGroupList")
	portGroupList = property (_get_portGroupList, None, None, "portGroupList property")
	def _get_chassisConfig (self):
		return self.getListVar ("chassisConfig")
	chassisConfig = property (_get_chassisConfig, None, None, "chassisConfig property")
	def _get_statSourcesList (self):
		return self.getListVar ("statSourcesList")
	statSourcesList = property (_get_statSourcesList, None, None, "statSourcesList property")
	def _get_activityModels (self):
		return self.getListVar ("activityModels")
	activityModels = property (_get_activityModels, None, None, "activityModels property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( GenericTestModel, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["rebootPortsBeforeConfigure"] = False
			self.managedProperties["testDuration"] = 10000
			self.managedProperties["checkLinkState"] = False
			self.managedProperties["portGroupList"] = Aptixia.IxObjectList (self.transactionContext, "PortGroup")
			self.managedProperties["chassisConfig"] = ChassisConfig.ChassisConfig (self)
			self.managedProperties["statSourcesList"] = Aptixia.IxObjectList (self.transactionContext, "GenericStatSource")
			self.managedProperties["activityModels"] = Aptixia.IxObjectList (self.transactionContext, "ActivityModelInstance")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "GenericTestModel"

	# Class Events
	def register_SystemEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "eventData", None, "out", "GenericTestModel.EventData", GenericTestModel.EventData)
		argTuple = ( arg0, )
		return self.registerEvent ("SystemEvent", argTuple, callback, callbackArg)

	# Class Methods
	def ImportItsConfig( self, itsLines, callback = None, callbackArg = None ):
		""" Import an .its configuration file generated by the ixia 'Applifier'application into this test configuration.
			itsLines: The .its file data to be imported
			Returns warningMessages: List of warnings that occured during the importing process. """
		arg0 = Aptixia_prv.MethodArgument( "itsLines", itsLines, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "warningMessages", None, "out", "GenericTestModel.StringVector", GenericTestModel.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportItsConfig", argTuple, callback, callbackArg )
	def ImportItsConfig_Sync( self, itsLines ):
		""" Import an .its configuration file generated by the ixia 'Applifier'application into this test configuration.
			itsLines: The .its file data to be imported
			Returns warningMessages: List of warnings that occured during the importing process. """
		arg0 = Aptixia_prv.MethodArgument( "itsLines", itsLines, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "warningMessages", None, "out", "GenericTestModel.StringVector", GenericTestModel.StringVector)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ImportItsConfig", argTuple)
		return context.Sync()

	def GetPluginList( self, callback = None, callbackArg = None ):
		""" Returns a list of plugin names depending on thedirectories in data/stackelementplugins.
			Returns pluginList: StringVector that has the names of the plugins """
		arg0 = Aptixia_prv.MethodArgument( "pluginList", None, "out", "GenericTestModel.StringVector", GenericTestModel.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPluginList", argTuple, callback, callbackArg )
	def GetPluginList_Sync( self ):
		""" Returns a list of plugin names depending on thedirectories in data/stackelementplugins.
			Returns pluginList: StringVector that has the names of the plugins """
		arg0 = Aptixia_prv.MethodArgument( "pluginList", None, "out", "GenericTestModel.StringVector", GenericTestModel.StringVector)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetPluginList", argTuple)
		return context.Sync()

	def TestConfigure( self, callback = None, callbackArg = None ):
		""" Take the test server through the configuration phase of a test. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestConfigure", argTuple, callback, callbackArg )
	def TestConfigure_Sync( self ):
		""" Take the test server through the configuration phase of a test. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestConfigure", argTuple)
		return context.Sync()

	def TestDeconfigure( self, callback = None, callbackArg = None ):
		""" Take the test server through the de-configuration phase of a test. """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestDeconfigure", argTuple, callback, callbackArg )
	def TestDeconfigure_Sync( self ):
		""" Take the test server through the de-configuration phase of a test. """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestDeconfigure", argTuple)
		return context.Sync()

	def TestStart( self, callback = None, callbackArg = None ):
		""" Starts a test, once it's been configured """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestStart", argTuple, callback, callbackArg )
	def TestStart_Sync( self ):
		""" Starts a test, once it's been configured """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestStart", argTuple)
		return context.Sync()

	def TestStop( self, callback = None, callbackArg = None ):
		""" Stops a test which has been started via the 'TestStart' method """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestStop", argTuple, callback, callbackArg )
	def TestStop_Sync( self ):
		""" Stops a test which has been started via the 'TestStart' method """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestStop", argTuple)
		return context.Sync()

	def GetTestInfo( self, callback = None, callbackArg = None ):
		""" Get general information Associated with the test.
			Returns testInfo: The return area for the information collected by this method.See TestInfo definition in this object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "testInfo", None, "out", "GenericTestModel.TestInfo", GenericTestModel.TestInfo)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestInfo", argTuple, callback, callbackArg )
	def GetTestInfo_Sync( self ):
		""" Get general information Associated with the test.
			Returns testInfo: The return area for the information collected by this method.See TestInfo definition in this object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "testInfo", None, "out", "GenericTestModel.TestInfo", GenericTestModel.TestInfo)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestInfo", argTuple)
		return context.Sync()

	def CreatePortWatch( self, callback = None, callbackArg = None ):
		""" Returns a new PortWatch instance
			Returns newPortWatch: Output parameter containing the requested 'PortWatch' object.See the 'PortWatch' object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "newPortWatch", None, "out", "PortWatch", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreatePortWatch", argTuple, callback, callbackArg )
	def CreatePortWatch_Sync( self ):
		""" Returns a new PortWatch instance
			Returns newPortWatch: Output parameter containing the requested 'PortWatch' object.See the 'PortWatch' object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "newPortWatch", None, "out", "PortWatch", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreatePortWatch", argTuple)
		return context.Sync()

	def CreateChassisWatch( self, callback = None, callbackArg = None ):
		""" Returns a new PortWatch instance that will watch for HwManager/IxServer down/up events.The PortWatch.EventList is ignored, on this watch only events of type kLink will be sent.The PortWatch.portList must contain port unique Ids as chassis;0;0 for HwManager state events,or chassis;-1;-1 for IxServer state events, or both.
			Returns newChassisWatch: Output parameter containing the requested 'PortWatch' object.See the 'PortWatch' object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "newChassisWatch", None, "out", "PortWatch", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateChassisWatch", argTuple, callback, callbackArg )
	def CreateChassisWatch_Sync( self ):
		""" Returns a new PortWatch instance that will watch for HwManager/IxServer down/up events.The PortWatch.EventList is ignored, on this watch only events of type kLink will be sent.The PortWatch.portList must contain port unique Ids as chassis;0;0 for HwManager state events,or chassis;-1;-1 for IxServer state events, or both.
			Returns newChassisWatch: Output parameter containing the requested 'PortWatch' object.See the 'PortWatch' object for more info. """
		arg0 = Aptixia_prv.MethodArgument( "newChassisWatch", None, "out", "PortWatch", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateChassisWatch", argTuple)
		return context.Sync()

	def GetActionBehavior( self, action, callback = None, callbackArg = None ):
		""" Get the behavior associated with the supplied (test) action
			action: Action to get the behavior for
			Returns behavior: The type of behavior associated with the action """
		arg0 = Aptixia_prv.MethodArgument( "action", action, "in", "GenericTestModel.eAction", GenericTestModel.eAction)
		arg1 = Aptixia_prv.MethodArgument( "behavior", None, "out", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetActionBehavior", argTuple, callback, callbackArg )
	def GetActionBehavior_Sync( self, action ):
		""" Get the behavior associated with the supplied (test) action
			action: Action to get the behavior for
			Returns behavior: The type of behavior associated with the action """
		arg0 = Aptixia_prv.MethodArgument( "action", action, "in", "GenericTestModel.eAction", GenericTestModel.eAction)
		arg1 = Aptixia_prv.MethodArgument( "behavior", None, "out", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetActionBehavior", argTuple)
		return context.Sync()

	def SetActionBehavior( self, action, behavior, callback = None, callbackArg = None ):
		""" Set the behavior associated with for a test action
			action: Action to apply behavior to
			behavior: Behavior to apply to action """
		arg0 = Aptixia_prv.MethodArgument( "action", action, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		arg1 = Aptixia_prv.MethodArgument( "behavior", behavior, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActionBehavior", argTuple, callback, callbackArg )
	def SetActionBehavior_Sync( self, action, behavior ):
		""" Set the behavior associated with for a test action
			action: Action to apply behavior to
			behavior: Behavior to apply to action """
		arg0 = Aptixia_prv.MethodArgument( "action", action, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		arg1 = Aptixia_prv.MethodArgument( "behavior", behavior, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActionBehavior", argTuple)
		return context.Sync()

	def SetActionBehaviorForAllActions( self, behavior, callback = None, callbackArg = None ):
		""" Set an action behavior type for all actions in the test
			behavior: Behavior to apply to all actions to """
		arg0 = Aptixia_prv.MethodArgument( "behavior", behavior, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActionBehaviorForAllActions", argTuple, callback, callbackArg )
	def SetActionBehaviorForAllActions_Sync( self, behavior ):
		""" Set an action behavior type for all actions in the test
			behavior: Behavior to apply to all actions to """
		arg0 = Aptixia_prv.MethodArgument( "behavior", behavior, "in", "GenericTestModel.eActionBehavior", GenericTestModel.eActionBehavior)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetActionBehaviorForAllActions", argTuple)
		return context.Sync()


