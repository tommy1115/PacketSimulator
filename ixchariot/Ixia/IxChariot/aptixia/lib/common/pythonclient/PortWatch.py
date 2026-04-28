import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import PortGroup


class PortWatch( XProtocolObject.XProtocolObject ):
	""" Used for Port State Watches """
	# Enums
	class eEventType (Aptixia.IxEnum):
		kLink = 1
		kTransmit = 2
		kCapture = 4
		kOwnership = 8
		kPortCpuStatus = 16
		kPortCpuDodStatus = 32
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "PortWatch.eEventType"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class EventList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "PortWatch.eEventType")
		if "PortWatch.EventList" not in Aptixia.lists:
			Aptixia.lists.append( "PortWatch.EventList" )
		def getType():
			return "PortWatch.EventList"
		getType = staticmethod(getType)
		def getElementType():
			return "PortWatch.eEventType"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return PortWatch.eEventType
		getElementClass = staticmethod(getElementClass)

	# Class Properties
	def _get_portList (self):
		return self.getListVar ("portList")
	portList = property (_get_portList, None, None, "portList property")
	def _get_needInitialValues (self):
		return self.getVar ("needInitialValues")
	def _set_needInitialValues (self, value):
		self.setVar ("needInitialValues", value)
	needInitialValues = property (_get_needInitialValues, _set_needInitialValues, None, "needInitialValues property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( PortWatch, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["portList"] = Aptixia.IxList ("string")
			self.managedProperties["needInitialValues"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "PortWatch"

	# Class Events
	def register_StateChanged_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "port", None, "out", "PortGroup.Port", PortGroup.PortGroup.Port)
		arg1 = Aptixia_prv.MethodArgument( "eventType", None, "out", "PortWatch.eEventType", PortWatch.eEventType)
		arg2 = Aptixia_prv.MethodArgument( "oldValue", None, "out", "string", None)
		arg3 = Aptixia_prv.MethodArgument( "currentValue", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		return self.registerEvent ("StateChanged", argTuple, callback, callbackArg)

	# Class Methods
	def SetEvents( self, eventList, callback = None, callbackArg = None ):
		""" Sets the port states to be watched
			eventList: Describes for what events the user needs notifications """
		arg0 = Aptixia_prv.MethodArgument( "eventList", eventList, "in", "PortWatch.EventList", PortWatch.EventList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetEvents", argTuple, callback, callbackArg )
	def SetEvents_Sync( self, eventList ):
		""" Sets the port states to be watched
			eventList: Describes for what events the user needs notifications """
		arg0 = Aptixia_prv.MethodArgument( "eventList", eventList, "in", "PortWatch.EventList", PortWatch.EventList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetEvents", argTuple)
		return context.Sync()

	def Apply( self, callback = None, callbackArg = None ):
		""" Sends the current configuration to the chassis """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Apply", argTuple, callback, callbackArg )
	def Apply_Sync( self ):
		""" Sends the current configuration to the chassis """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Apply", argTuple)
		return context.Sync()

	def Destroy( self, callback = None, callbackArg = None ):
		""" Unregisters from HwManager and destroys this object """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Destroy", argTuple, callback, callbackArg )
	def Destroy_Sync( self ):
		""" Unregisters from HwManager and destroys this object """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Destroy", argTuple)
		return context.Sync()


