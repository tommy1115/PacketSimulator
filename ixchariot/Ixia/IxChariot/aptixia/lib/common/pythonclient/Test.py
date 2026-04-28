import string, threading
import Aptixia, Aptixia_prv
import TreeNode
import StatManager


class Test( TreeNode.TreeNode ):
	""" The base class for test configurations """
	# Enums
	class eMode (Aptixia.IxEnum):
		kMonitor = 0
		kTest = 1
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "Test.eMode"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# Class Properties
	def _get_mode (self):
		return self.getVar ("mode")
	def _set_mode (self, value):
		self.setVar ("mode", value)
	mode = property (_get_mode, _set_mode, None, "mode property")
	def _get_statManager (self):
		return self.getListVar ("statManager")
	statManager = property (_get_statManager, None, None, "statManager property")
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_userName (self):
		return self.getVar ("userName")
	def _set_userName (self, value):
		self.setVar ("userName", value)
	userName = property (_get_userName, _set_userName, None, "userName property")
	def _get_resultsFolderPath (self):
		return self.getVar ("resultsFolderPath")
	def _set_resultsFolderPath (self, value):
		self.setVar ("resultsFolderPath", value)
	resultsFolderPath = property (_get_resultsFolderPath, _set_resultsFolderPath, None, "resultsFolderPath property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Test, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["mode"] = 0
			self.managedProperties["statManager"] = StatManager.StatManager (self)
			self.managedProperties["name"] = "Test1"
			self.managedProperties["userName"] = "User"
			self.managedProperties["resultsFolderPath"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Test"

	# Class Methods
	def Ping( self, callback = None, callbackArg = None ):
		""" Empty method used to test basic connectivity """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple, callback, callbackArg )
	def Ping_Sync( self ):
		""" Empty method used to test basic connectivity """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple)
		return context.Sync()

	def Start( self, callback = None, callbackArg = None ):
		""" Start a test run """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Start", argTuple, callback, callbackArg )
	def Start_Sync( self ):
		""" Start a test run """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Start", argTuple)
		return context.Sync()

	def Stop( self, callback = None, callbackArg = None ):
		""" Stop a test run """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Stop", argTuple, callback, callbackArg )
	def Stop_Sync( self ):
		""" Stop a test run """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Stop", argTuple)
		return context.Sync()

	def Save( self, appXml, callback = None, callbackArg = None ):
		""" Save this test configuration along with application data
			appXml: The application data to save with the test """
		arg0 = Aptixia_prv.MethodArgument( "appXml", appXml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Save", argTuple, callback, callbackArg )
	def Save_Sync( self, appXml ):
		""" Save this test configuration along with application data
			appXml: The application data to save with the test """
		arg0 = Aptixia_prv.MethodArgument( "appXml", appXml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Save", argTuple)
		return context.Sync()

	def SaveAs( self, name, appXml, callback = None, callbackArg = None ):
		""" Save this test configuration under a different name
			name: The name to save this test under
			appXml: The application data to save with the test
			Returns id: The id the test was saved under """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "appXml", appXml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAs", argTuple, callback, callbackArg )
	def SaveAs_Sync( self, name, appXml ):
		""" Save this test configuration under a different name
			name: The name to save this test under
			appXml: The application data to save with the test
			Returns id: The id the test was saved under """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "appXml", appXml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAs", argTuple)
		return context.Sync()

	def Close( self, callback = None, callbackArg = None ):
		""" Close this test and release all resources associated with it """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Close", argTuple, callback, callbackArg )
	def Close_Sync( self ):
		""" Close this test and release all resources associated with it """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Close", argTuple)
		return context.Sync()

	def GetAppXml( self, id, callback = None, callbackArg = None ):
		""" Get the application data associated with a particular test
			id: The id of the test to retrieve the associated data for
			Returns appXml: The associated data """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "appXml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAppXml", argTuple, callback, callbackArg )
	def GetAppXml_Sync( self, id ):
		""" Get the application data associated with a particular test
			id: The id of the test to retrieve the associated data for
			Returns appXml: The associated data """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "appXml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetAppXml", argTuple)
		return context.Sync()

	def GetReporterXmd( self, callback = None, callbackArg = None ):
		""" Get the reporter xmd xml associated with a particular test result
			Returns reporterXmd: associated xml string """
		arg0 = Aptixia_prv.MethodArgument( "reporterXmd", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetReporterXmd", argTuple, callback, callbackArg )
	def GetReporterXmd_Sync( self ):
		""" Get the reporter xmd xml associated with a particular test result
			Returns reporterXmd: associated xml string """
		arg0 = Aptixia_prv.MethodArgument( "reporterXmd", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetReporterXmd", argTuple)
		return context.Sync()

	def SetReporterXmd( self, reporterXmd, callback = None, callbackArg = None ):
		""" Set the reporter xmd xml associated with a particular test result
			reporterXmd: associated xml string """
		arg0 = Aptixia_prv.MethodArgument( "reporterXmd", reporterXmd, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetReporterXmd", argTuple, callback, callbackArg )
	def SetReporterXmd_Sync( self, reporterXmd ):
		""" Set the reporter xmd xml associated with a particular test result
			reporterXmd: associated xml string """
		arg0 = Aptixia_prv.MethodArgument( "reporterXmd", reporterXmd, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetReporterXmd", argTuple)
		return context.Sync()


