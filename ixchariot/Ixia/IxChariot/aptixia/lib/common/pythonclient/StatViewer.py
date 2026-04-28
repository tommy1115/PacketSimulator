import string, threading
import Aptixia, Aptixia_prv
import StatConsumer
import StatView


class StatViewer( StatConsumer.StatConsumer ):
	""" List of stat views for a test """
	# Enums
	class eMode (Aptixia.IxEnum):
		kModeDesign = 0
		kModeRun = 1
		kModeResult = 2
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatViewer.eMode"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eNotify (Aptixia.IxEnum):
		kViewDataChanged = 0
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatViewer.eNotify"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eWindowState (Aptixia.IxEnum):
		kNormal = 0
		kMaximized = 1
		kMinimized = 2
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "StatViewer.eWindowState"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# Class Properties
	def _get_statViewList (self):
		return self.getListVar ("statViewList")
	statViewList = property (_get_statViewList, None, None, "statViewList property")
	def _get_windowPositions (self):
		return self.getVar ("windowPositions")
	def _set_windowPositions (self, value):
		self.setVar ("windowPositions", value)
	windowPositions = property (_get_windowPositions, _set_windowPositions, None, "windowPositions property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatViewer, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["statViewList"] = Aptixia.IxObjectList (self.transactionContext, "StatView")
			self.managedProperties["windowPositions"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatViewer"

	# Class Methods
	def ViewExists( self, name, callback = None, callbackArg = None ):
		""" Check if a view exists in the list for this test
			name: Name of the view to check for
			Returns exists: Result of the check """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "exists", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ViewExists", argTuple, callback, callbackArg )
	def ViewExists_Sync( self, name ):
		""" Check if a view exists in the list for this test
			name: Name of the view to check for
			Returns exists: Result of the check """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "exists", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ViewExists", argTuple)
		return context.Sync()


