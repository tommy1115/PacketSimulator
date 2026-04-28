import string, threading
import Aptixia, Aptixia_prv
import DataDrivenFormBase


class StackElementPlugin( DataDrivenFormBase.DataDrivenFormBase ):
	""" The base class that defines the common characteristics of all aptixianetwork stack element plugins. """
	# List properties
	class CardPluginInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StackElementPlugin.CardPluginInfo")
		if "StackElementPlugin.CardPluginInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StackElementPlugin.CardPluginInfoList" )
		def getType():
			return "StackElementPlugin.CardPluginInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StackElementPlugin.CardPluginInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StackElementPlugin.CardPluginInfo
		getElementClass = staticmethod(getElementClass)
	class BaseStyleList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "StackElementPlugin.BaseStyleList" not in Aptixia.lists:
			Aptixia.lists.append( "StackElementPlugin.BaseStyleList" )
		def getType():
			return "StackElementPlugin.BaseStyleList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class SupportedCardList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StackElementPlugin.SupportedCardInfo")
		if "StackElementPlugin.SupportedCardList" not in Aptixia.lists:
			Aptixia.lists.append( "StackElementPlugin.SupportedCardList" )
		def getType():
			return "StackElementPlugin.SupportedCardList"
		getType = staticmethod(getType)
		def getElementType():
			return "StackElementPlugin.SupportedCardInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StackElementPlugin.SupportedCardInfo
		getElementClass = staticmethod(getElementClass)
	class PluginInfoList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "StackElementPlugin.PluginInfo")
		if "StackElementPlugin.PluginInfoList" not in Aptixia.lists:
			Aptixia.lists.append( "StackElementPlugin.PluginInfoList" )
		def getType():
			return "StackElementPlugin.PluginInfoList"
		getType = staticmethod(getType)
		def getElementType():
			return "StackElementPlugin.PluginInfo"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return StackElementPlugin.PluginInfo
		getElementClass = staticmethod(getElementClass)

	# Structs
	class CardPluginInfo( Aptixia.IxStruct ):
		""" Information relating to the ixia card associated with this plugin(if any). """
		if "StackElementPlugin.CardPluginInfo" not in Aptixia.structs:
			Aptixia.structs.append("StackElementPlugin.CardPluginInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.type = ""
			self._version = "1"
			self._types = { "name":"string",
				 "type":"string" }
		def getType( self ):
			return "StackElementPlugin.CardPluginInfo"

	class SupportedCardInfo( Aptixia.IxStruct ):
		""" Information about cards that can be used with this plugin. """
		if "StackElementPlugin.SupportedCardInfo" not in Aptixia.structs:
			Aptixia.structs.append("StackElementPlugin.SupportedCardInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.type = ""
			self.maxInterfaces = 99999
			self._version = "1"
			self._types = { "type":"string",
				 "maxInterfaces":"int32" }
		def getType( self ):
			return "StackElementPlugin.SupportedCardInfo"

	class PluginInfo( Aptixia.IxStruct ):
		""" Contains high level information relating to plugin such as name,version, card compatibility, etc. """
		if "StackElementPlugin.PluginInfo" not in Aptixia.structs:
			Aptixia.structs.append("StackElementPlugin.PluginInfo")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.sourceLocation = ""
			self.version = ""
			self.type = ""
			self.name = ""
			self.pluginClass = ""
			self.compatibleCards = StackElementPlugin.CardPluginInfoList()
			self.canStackOnBaseStyles = StackElementPlugin.BaseStyleList()
			self.canProvideBaseStyles = StackElementPlugin.BaseStyleList()
			self.supportedCards = StackElementPlugin.SupportedCardList()
			self._version = "1"
			self._types = { "sourceLocation":"string",
				 "version":"string",
				 "type":"string",
				 "name":"string",
				 "pluginClass":"string",
				 "compatibleCards":"StackElementPlugin.CardPluginInfoList",
				 "canStackOnBaseStyles":"StackElementPlugin.BaseStyleList",
				 "canProvideBaseStyles":"StackElementPlugin.BaseStyleList",
				 "supportedCards":"StackElementPlugin.SupportedCardList" }
		def getType( self ):
			return "StackElementPlugin.PluginInfo"


	# Class Properties
	def _get_childrenList (self):
		return self.getListVar ("childrenList")
	childrenList = property (_get_childrenList, None, None, "childrenList property")
	def _get_internalStackElementId (self):
		return self.getVar ("internalStackElementId")
	def _set_internalStackElementId (self, value):
		self.setVar ("internalStackElementId", value)
	internalStackElementId = property (_get_internalStackElementId, _set_internalStackElementId, None, "internalStackElementId property")
	def _get_comment (self):
		return self.getVar ("comment")
	def _set_comment (self, value):
		self.setVar ("comment", value)
	comment = property (_get_comment, _set_comment, None, "comment property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StackElementPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["childrenList"] = Aptixia.IxObjectList (self.transactionContext, "StackElementPlugin")
			self.managedProperties["internalStackElementId"] = ""
			self.managedProperties["comment"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StackElementPlugin"

	# Class Methods
	def Echo( self, value, callback = None, callbackArg = None ):
		""" This diagnostic method is for internal use only
			value: This diagnostic method param is for internal use only
			Returns rval: This diagnostic method param is for internal use only """
		arg0 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "rval", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Echo", argTuple, callback, callbackArg )
	def Echo_Sync( self, value ):
		""" This diagnostic method is for internal use only
			value: This diagnostic method param is for internal use only
			Returns rval: This diagnostic method param is for internal use only """
		arg0 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "rval", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Echo", argTuple)
		return context.Sync()

	def DirectoryInfo( self, callback = None, callbackArg = None ):
		""" Retrieve general "directory" style information for this plugin
			Returns rval: The requested plugin information.  See'StackElementPlugin.PluginInfo' structure definition for moreinfo. """
		arg0 = Aptixia_prv.MethodArgument( "rval", None, "out", "StackElementPlugin.PluginInfo", StackElementPlugin.PluginInfo)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DirectoryInfo", argTuple, callback, callbackArg )
	def DirectoryInfo_Sync( self ):
		""" Retrieve general "directory" style information for this plugin
			Returns rval: The requested plugin information.  See'StackElementPlugin.PluginInfo' structure definition for moreinfo. """
		arg0 = Aptixia_prv.MethodArgument( "rval", None, "out", "StackElementPlugin.PluginInfo", StackElementPlugin.PluginInfo)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DirectoryInfo", argTuple)
		return context.Sync()

	def InsertPluginParent( self, pluginType, callback = None, callbackArg = None ):
		""" Insert a new plugin into the stack as the parent of thisplugin
			pluginType: The type of new plugin to create(as the parent of this plugin)
			Returns newPlugin: Output param containing the newly created parent plugin """
		arg0 = Aptixia_prv.MethodArgument( "pluginType", pluginType, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newPlugin", None, "out", "StackElementPlugin", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InsertPluginParent", argTuple, callback, callbackArg )
	def InsertPluginParent_Sync( self, pluginType ):
		""" Insert a new plugin into the stack as the parent of thisplugin
			pluginType: The type of new plugin to create(as the parent of this plugin)
			Returns newPlugin: Output param containing the newly created parent plugin """
		arg0 = Aptixia_prv.MethodArgument( "pluginType", pluginType, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "newPlugin", None, "out", "StackElementPlugin", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InsertPluginParent", argTuple)
		return context.Sync()

	def InsertBeforeCandidates( self, callback = None, callbackArg = None ):
		""" Return a list of PluginInfo's that describewhich plugin's are insertable before this plugin.
			Returns candidates: The list of PluginInfo's that describe plugins that are insertablebefore this plugin. """
		arg0 = Aptixia_prv.MethodArgument( "candidates", None, "out", "StackElementPlugin.PluginInfoList", StackElementPlugin.PluginInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InsertBeforeCandidates", argTuple, callback, callbackArg )
	def InsertBeforeCandidates_Sync( self ):
		""" Return a list of PluginInfo's that describewhich plugin's are insertable before this plugin.
			Returns candidates: The list of PluginInfo's that describe plugins that are insertablebefore this plugin. """
		arg0 = Aptixia_prv.MethodArgument( "candidates", None, "out", "StackElementPlugin.PluginInfoList", StackElementPlugin.PluginInfoList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "InsertBeforeCandidates", argTuple)
		return context.Sync()

	def RemovePluginChild( self, index, callback = None, callbackArg = None ):
		""" Remove the n-th child plugin of 'this' plugin.Descendants of the removed plugin are re-attached at thelocation of the plugin being removed.
			index: The index of the plugin to remove from the stack """
		arg0 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RemovePluginChild", argTuple, callback, callbackArg )
	def RemovePluginChild_Sync( self, index ):
		""" Remove the n-th child plugin of 'this' plugin.Descendants of the removed plugin are re-attached at thelocation of the plugin being removed.
			index: The index of the plugin to remove from the stack """
		arg0 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "RemovePluginChild", argTuple)
		return context.Sync()


