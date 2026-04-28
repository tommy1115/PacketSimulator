import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import Session


class TestServer( XProtocolObject.XProtocolObject ):
	""" This singleton represents the TestServer process. It is used tomanage sessions and help in regression testing. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TestServer, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TestServer"

	# Class Events
	def register_InvalidateObjectEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "objectId", None, "out", "int64", None)
		argTuple = ( arg0, )
		return self.registerEvent ("InvalidateObjectEvent", argTuple, callback, callbackArg)

	# Class Methods
	def GetClassMetaSchema( self, type, callback = None, callbackArg = None ):
		""" Return the metaschema definition for the requested object class.
			type: The object class type to return the metaschema definition for.
			Returns metaschema: The requested metaschema (xml) definition """
		arg0 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "metaschema", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetClassMetaSchema", argTuple, callback, callbackArg )
	def GetClassMetaSchema_Sync( self, type ):
		""" Return the metaschema definition for the requested object class.
			type: The object class type to return the metaschema definition for.
			Returns metaschema: The requested metaschema (xml) definition """
		arg0 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "metaschema", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetClassMetaSchema", argTuple)
		return context.Sync()

	def GetVersion( self, callback = None, callbackArg = None ):
		""" Returns the version of Aptixia
			Returns version: Aptixia version """
		arg0 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetVersion", argTuple, callback, callbackArg )
	def GetVersion_Sync( self ):
		""" Returns the version of Aptixia
			Returns version: Aptixia version """
		arg0 = Aptixia_prv.MethodArgument( "version", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetVersion", argTuple)
		return context.Sync()

	def Ping( self, callback = None, callbackArg = None ):
		""" An empty method used for basic communications testing """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple, callback, callbackArg )
	def Ping_Sync( self ):
		""" An empty method used for basic communications testing """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple)
		return context.Sync()

	def OpenSession( self, userName, sessionName, inactivityTimeout, callback = None, callbackArg = None ):
		""" Create a session. Sessions contain, configure and run a test. Sessionscan be viewed by more than one client, but edited only by one client.
			userName: The user name
			sessionName: The name of the session to remind the user what the session is for.
			inactivityTimeout: Zero for no timeout, otherwise a value in ms. [Not implemented]
			Returns session: A reference to the created session. """
		arg0 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "sessionName", sessionName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "inactivityTimeout", inactivityTimeout, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "session", None, "out", "Session", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenSession", argTuple, callback, callbackArg )
	def OpenSession_Sync( self, userName, sessionName, inactivityTimeout ):
		""" Create a session. Sessions contain, configure and run a test. Sessionscan be viewed by more than one client, but edited only by one client.
			userName: The user name
			sessionName: The name of the session to remind the user what the session is for.
			inactivityTimeout: Zero for no timeout, otherwise a value in ms. [Not implemented]
			Returns session: A reference to the created session. """
		arg0 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "sessionName", sessionName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "inactivityTimeout", inactivityTimeout, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "session", None, "out", "Session", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenSession", argTuple)
		return context.Sync()

	def OpenSessionEx( self, appName, userName, sessionName, inactivityTimeout, callback = None, callbackArg = None ):
		""" Create a session. Sessions contain, configure and run a test. Sessionscan be viewed by more than one client, but edited only by one client.
			appName: The name of the application. This argument is used to keepsave files of different applications in different places.
			userName: The user name
			sessionName: The name of the session to remind the user what the session is for.
			inactivityTimeout: Zero for no timeout, otherwise a value in ms. [Not implemented]
			Returns session: A reference to the created session. """
		arg0 = Aptixia_prv.MethodArgument( "appName", appName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "sessionName", sessionName, "in", "string", None)
		arg3 = Aptixia_prv.MethodArgument( "inactivityTimeout", inactivityTimeout, "in", "int32", None)
		arg4 = Aptixia_prv.MethodArgument( "session", None, "out", "Session", None)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenSession", argTuple, callback, callbackArg )
	def OpenSessionEx_Sync( self, appName, userName, sessionName, inactivityTimeout ):
		""" Create a session. Sessions contain, configure and run a test. Sessionscan be viewed by more than one client, but edited only by one client.
			appName: The name of the application. This argument is used to keepsave files of different applications in different places.
			userName: The user name
			sessionName: The name of the session to remind the user what the session is for.
			inactivityTimeout: Zero for no timeout, otherwise a value in ms. [Not implemented]
			Returns session: A reference to the created session. """
		arg0 = Aptixia_prv.MethodArgument( "appName", appName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "userName", userName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "sessionName", sessionName, "in", "string", None)
		arg3 = Aptixia_prv.MethodArgument( "inactivityTimeout", inactivityTimeout, "in", "int32", None)
		arg4 = Aptixia_prv.MethodArgument( "session", None, "out", "Session", None)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OpenSession", argTuple)
		return context.Sync()

	def Shutdown( self, callback = None, callbackArg = None ):
		""" Shuts down the TestServer process """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Shutdown", argTuple, callback, callbackArg )
	def Shutdown_Sync( self ):
		""" Shuts down the TestServer process """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Shutdown", argTuple)
		return context.Sync()


