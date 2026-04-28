import string, threading
import Aptixia, Aptixia_prv
import GenericStatSource
import SnmpStatSource


class SnmpPlugin( GenericStatSource.GenericStatSource ):
	""" SNMP Stat Source TestServer plug in """
	# List properties
	class MibVars( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "SnmpPlugin.MibVars" not in Aptixia.lists:
			Aptixia.lists.append( "SnmpPlugin.MibVars" )
		def getType():
			return "SnmpPlugin.MibVars"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class SnmpTemplates( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "SnmpPlugin.SnmpTemplate")
		if "SnmpPlugin.SnmpTemplates" not in Aptixia.lists:
			Aptixia.lists.append( "SnmpPlugin.SnmpTemplates" )
		def getType():
			return "SnmpPlugin.SnmpTemplates"
		getType = staticmethod(getType)
		def getElementType():
			return "SnmpPlugin.SnmpTemplate"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return SnmpPlugin.SnmpTemplate
		getElementClass = staticmethod(getElementClass)

	# Structs
	class SnmpTemplate( Aptixia.IxStruct ):
		if "SnmpPlugin.SnmpTemplate" not in Aptixia.structs:
			Aptixia.structs.append("SnmpPlugin.SnmpTemplate")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.m_Name = ""
			self.m_Description = ""
			self._version = "1"
			self._types = { "m_Name":"string",
				 "m_Description":"string" }
		def getType( self ):
			return "SnmpPlugin.SnmpTemplate"


	# Class Properties
	def _get_snmpStatSources (self):
		return self.getListVar ("snmpStatSources")
	snmpStatSources = property (_get_snmpStatSources, None, None, "snmpStatSources property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( SnmpPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["snmpStatSources"] = Aptixia.IxObjectList (self.transactionContext, "SnmpStatSource")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "SnmpPlugin"

	# Class Methods
	def MibGetChildren( self, sPath, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "childNodes", None, "out", "SnmpPlugin.MibVars", SnmpPlugin.MibVars)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetChildren", argTuple, callback, callbackArg )
	def MibGetChildren_Sync( self, sPath ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "childNodes", None, "out", "SnmpPlugin.MibVars", SnmpPlugin.MibVars)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetChildren", argTuple)
		return context.Sync()

	def MibGetType( self, sPath, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetType", argTuple, callback, callbackArg )
	def MibGetType_Sync( self, sPath ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetType", argTuple)
		return context.Sync()

	def MibGetDescription( self, sPath, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "description", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetDescription", argTuple, callback, callbackArg )
	def MibGetDescription_Sync( self, sPath ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "description", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibGetDescription", argTuple)
		return context.Sync()

	def MibResolveToName( self, sPath, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibResolveToName", argTuple, callback, callbackArg )
	def MibResolveToName_Sync( self, sPath ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "name", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibResolveToName", argTuple)
		return context.Sync()

	def MibResolveToOID( self, sPath, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "oid", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibResolveToOID", argTuple, callback, callbackArg )
	def MibResolveToOID_Sync( self, sPath ):
		arg0 = Aptixia_prv.MethodArgument( "sPath", sPath, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "oid", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibResolveToOID", argTuple)
		return context.Sync()

	def MibAddNewMib( self, FileName, body, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "FileName", FileName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "body", body, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibAddNewMib", argTuple, callback, callbackArg )
	def MibAddNewMib_Sync( self, FileName, body ):
		arg0 = Aptixia_prv.MethodArgument( "FileName", FileName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "body", body, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MibAddNewMib", argTuple)
		return context.Sync()

	def Init( self, callback = None, callbackArg = None ):
		""" Initializes the SNMP CAL plugin """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Init", argTuple, callback, callbackArg )
	def Init_Sync( self ):
		""" Initializes the SNMP CAL plugin """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Init", argTuple)
		return context.Sync()

	def PopulateStatCatalog( self, callback = None, callbackArg = None ):
		""" Initializes the SNMP CAL plugin """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "PopulateStatCatalog", argTuple, callback, callbackArg )
	def PopulateStatCatalog_Sync( self ):
		""" Initializes the SNMP CAL plugin """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "PopulateStatCatalog", argTuple)
		return context.Sync()

	def TmplGetTemplates( self, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "templates", None, "out", "SnmpPlugin.SnmpTemplates", SnmpPlugin.SnmpTemplates)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplGetTemplates", argTuple, callback, callbackArg )
	def TmplGetTemplates_Sync( self ):
		arg0 = Aptixia_prv.MethodArgument( "templates", None, "out", "SnmpPlugin.SnmpTemplates", SnmpPlugin.SnmpTemplates)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplGetTemplates", argTuple)
		return context.Sync()

	def TmplRename( self, oldName, newName, description, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "oldName", oldName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "description", description, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplRename", argTuple, callback, callbackArg )
	def TmplRename_Sync( self, oldName, newName, description ):
		arg0 = Aptixia_prv.MethodArgument( "oldName", oldName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "description", description, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplRename", argTuple)
		return context.Sync()

	def TmplLoad( self, name, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "result", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplLoad", argTuple, callback, callbackArg )
	def TmplLoad_Sync( self, name ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "result", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplLoad", argTuple)
		return context.Sync()

	def TmplSave( self, name, body, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "body", body, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "result", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplSave", argTuple, callback, callbackArg )
	def TmplSave_Sync( self, name, body ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "body", body, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "result", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplSave", argTuple)
		return context.Sync()

	def TmplRemove( self, name, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplRemove", argTuple, callback, callbackArg )
	def TmplRemove_Sync( self, name ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TmplRemove", argTuple)
		return context.Sync()

	def IsStarted( self, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsStarted", argTuple, callback, callbackArg )
	def IsStarted_Sync( self ):
		arg0 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsStarted", argTuple)
		return context.Sync()

	def IsSourceInUse( self, name, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsSourceInUse", argTuple, callback, callbackArg )
	def IsSourceInUse_Sync( self, name ):
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsSourceInUse", argTuple)
		return context.Sync()

	def IsStatInUse( self, source, stat, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "source", source, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "stat", stat, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsStatInUse", argTuple, callback, callbackArg )
	def IsStatInUse_Sync( self, source, stat ):
		arg0 = Aptixia_prv.MethodArgument( "source", source, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "stat", stat, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "result", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "IsStatInUse", argTuple)
		return context.Sync()


