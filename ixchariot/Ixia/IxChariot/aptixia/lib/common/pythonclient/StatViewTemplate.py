import string, threading
import Aptixia, Aptixia_prv
import ServiceExtension
import StatView


class StatViewTemplate( ServiceExtension.ServiceExtension ):
	""" API to the TestServer DataStore for ViewTemplates """
	# List properties
	class TemplateInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StatViewTemplate.TemplateInfo")
		if "StatViewTemplate.TemplateInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StatViewTemplate.TemplateInfoList" )
		def getType():
			return "StatViewTemplate.TemplateInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StatViewTemplate.TemplateInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StatViewTemplate.TemplateInfo
		getElementClass = staticmethod(getElementClass)

	# Structs
	class TemplateInfo( Aptixia.IxStruct ):
		""" Structure to describe a template in the TestServer DataStore """
		if "StatViewTemplate.TemplateInfo" not in Aptixia.structs:
			Aptixia.structs.append("StatViewTemplate.TemplateInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.statSourceTypes = ""
			self.userDefined = False
			self.enabled = False
			self._version = "1"
			self._types = { "name":"string",
				 "statSourceTypes":"string",
				 "userDefined":"bool",
				 "enabled":"bool" }
		def getType( self ):
			return "StatViewTemplate.TemplateInfo"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatViewTemplate, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatViewTemplate"

	# Class Methods
	def Create( self, callback = None, callbackArg = None ):
		""" Creates a new stat view without adding it to the DataStore
			Returns statView: Stat view returned """
		arg0 = Aptixia_prv.MethodArgument( "statView", None, "out", "StatView", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Create", argTuple, callback, callbackArg )
	def Create_Sync( self ):
		""" Creates a new stat view without adding it to the DataStore
			Returns statView: Stat view returned """
		arg0 = Aptixia_prv.MethodArgument( "statView", None, "out", "StatView", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Create", argTuple)
		return context.Sync()

	def Add( self, templateInfo, xml, callback = None, callbackArg = None ):
		""" Adds a new stat view to the DataStore
			templateInfo: Properties of the new template
			xml: Properties of the stat view for the new template """
		arg0 = Aptixia_prv.MethodArgument( "templateInfo", templateInfo, "inout", "StatViewTemplate.TemplateInfo", StatViewTemplate.TemplateInfo)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Add", argTuple, callback, callbackArg )
	def Add_Sync( self, templateInfo, xml ):
		""" Adds a new stat view to the DataStore
			templateInfo: Properties of the new template
			xml: Properties of the stat view for the new template """
		arg0 = Aptixia_prv.MethodArgument( "templateInfo", templateInfo, "inout", "StatViewTemplate.TemplateInfo", StatViewTemplate.TemplateInfo)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Add", argTuple)
		return context.Sync()

	def Delete( self, name, callback = None, callbackArg = None ):
		""" Deletes a template from the DataStore
			name: The name of the template to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Delete", argTuple, callback, callbackArg )
	def Delete_Sync( self, name ):
		""" Deletes a template from the DataStore
			name: The name of the template to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Delete", argTuple)
		return context.Sync()

	def Exists( self, name, callback = None, callbackArg = None ):
		""" Checks if a template already exists in the DataStore
			name: The name of the template to check for
			Returns exists: The return value """
		arg0 = Aptixia_prv.MethodArgument( "exists", None, "out", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Exists", argTuple, callback, callbackArg )
	def Exists_Sync( self, name ):
		""" Checks if a template already exists in the DataStore
			name: The name of the template to check for
			Returns exists: The return value """
		arg0 = Aptixia_prv.MethodArgument( "exists", None, "out", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Exists", argTuple)
		return context.Sync()

	def GetList( self, callback = None, callbackArg = None ):
		""" Get a list of all of the templates in the DataStore for a client application
			Returns list: The list returned """
		arg0 = Aptixia_prv.MethodArgument( "list", None, "out", "StatViewTemplate.TemplateInfoList", StatViewTemplate.TemplateInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetList", argTuple, callback, callbackArg )
	def GetList_Sync( self ):
		""" Get a list of all of the templates in the DataStore for a client application
			Returns list: The list returned """
		arg0 = Aptixia_prv.MethodArgument( "list", None, "out", "StatViewTemplate.TemplateInfoList", StatViewTemplate.TemplateInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetList", argTuple)
		return context.Sync()

	def GetViewXml( self, name, callback = None, callbackArg = None ):
		""" Get the stat view xml of a template in the DataStore
			name: The name of the template
			Returns xml: The xml returned """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetViewXml", argTuple, callback, callbackArg )
	def GetViewXml_Sync( self, name ):
		""" Get the stat view xml of a template in the DataStore
			name: The name of the template
			Returns xml: The xml returned """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetViewXml", argTuple)
		return context.Sync()

	def Rename( self, name, newName, callback = None, callbackArg = None ):
		""" Rename a template in the DataStore
			name: The name of the template to rename
			newName: The new name for the template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Rename", argTuple, callback, callbackArg )
	def Rename_Sync( self, name, newName ):
		""" Rename a template in the DataStore
			name: The name of the template to rename
			newName: The new name for the template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Rename", argTuple)
		return context.Sync()

	def Enable( self, name, enable, callback = None, callbackArg = None ):
		""" Enable or disable a template in the DataStore.  Enabled templates will be added to the stat view list when commitCatalog is called for matching statSourceTypes
			name: The name of a template to enable or disable
			enable: Enable or disable a template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Enable", argTuple, callback, callbackArg )
	def Enable_Sync( self, name, enable ):
		""" Enable or disable a template in the DataStore.  Enabled templates will be added to the stat view list when commitCatalog is called for matching statSourceTypes
			name: The name of a template to enable or disable
			enable: Enable or disable a template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "enable", enable, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Enable", argTuple)
		return context.Sync()

	def SaveAs( self, name, newName, callback = None, callbackArg = None ):
		""" Save a template in the DataStore with a new name
			name: The name of a template to save
			newName: The name of the new template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAs", argTuple, callback, callbackArg )
	def SaveAs_Sync( self, name, newName ):
		""" Save a template in the DataStore with a new name
			name: The name of a template to save
			newName: The name of the new template """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newName", newName, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAs", argTuple)
		return context.Sync()


