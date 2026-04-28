import string, threading
import Aptixia, Aptixia_prv


class XProtocolObject( Aptixia.ClientObjectBase ):
	""" Implicit base class for all objects driven through the x-protocol infrastructure. """
	# Enums
	class eSerializationDepth (Aptixia.IxEnum):
		kShallow = 0
		kNode = 1
		kDeep = 2
		kPrefetch = 3
		kIdOnly = 4
		kInterfaceManager = 5
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "XProtocolObject.eSerializationDepth"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value
	class eValidateMode (Aptixia.IxEnum):
		kDefaultValidation = 100
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "XProtocolObject.eValidateMode"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class ObjectIdList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int64")
		if "XProtocolObject.ObjectIdList" not in Aptixia.lists:
			Aptixia.lists.append( "XProtocolObject.ObjectIdList" )
		def getType():
			return "XProtocolObject.ObjectIdList"
		getType = staticmethod(getType)
		def getElementType():
			return "int64"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class XmlList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "XProtocolObject.XmlList" not in Aptixia.lists:
			Aptixia.lists.append( "XProtocolObject.XmlList" )
		def getType():
			return "XProtocolObject.XmlList"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ClassVersionList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "XProtocolObject.ClassVersion")
		if "XProtocolObject.ClassVersionList" not in Aptixia.lists:
			Aptixia.lists.append( "XProtocolObject.ClassVersionList" )
		def getType():
			return "XProtocolObject.ClassVersionList"
		getType = staticmethod(getType)
		def getElementType():
			return "XProtocolObject.ClassVersion"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return XProtocolObject.ClassVersion
		getElementClass = staticmethod(getElementClass)

	# Structs
	class ClassVersion( Aptixia.IxStruct ):
		""" Structure representing a class (internal use only) """
		if "XProtocolObject.ClassVersion" not in Aptixia.structs:
			Aptixia.structs.append("XProtocolObject.ClassVersion")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.name = ""
			self.version = 1
			self.serverInstantiate = 1
			self._version = "1"
			self._types = { "name":"string",
				 "version":"int32",
				 "serverInstantiate":"bool" }
		def getType( self ):
			return "XProtocolObject.ClassVersion"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XProtocolObject, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XProtocolObject"

	# Class Methods
	def _GetXml( self, depth, forPersistentStorage, callback = None, callbackArg = None ):
		""" Get xml representation of the object
			depth: Flag indicating the serialization depth
			forPersistentStorage: Flag indicating if the xml is going to be used as persistent storage. If set, itremoves ephemeral information such as IORs.
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "depth", depth, "in", "XProtocolObject.eSerializationDepth", XProtocolObject.eSerializationDepth)
		arg1 = Aptixia_prv.MethodArgument( "forPersistentStorage", forPersistentStorage, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetXml", argTuple, callback, callbackArg )
	def _GetXml_Sync( self, depth, forPersistentStorage ):
		""" Get xml representation of the object
			depth: Flag indicating the serialization depth
			forPersistentStorage: Flag indicating if the xml is going to be used as persistent storage. If set, itremoves ephemeral information such as IORs.
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "depth", depth, "in", "XProtocolObject.eSerializationDepth", XProtocolObject.eSerializationDepth)
		arg1 = Aptixia_prv.MethodArgument( "forPersistentStorage", forPersistentStorage, "in", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetXml", argTuple)
		return context.Sync()

	def _SetXml( self, xml, merge, callback = None, callbackArg = None ):
		""" Deserialize xml representation of object into object
			xml: The xml representation of the object
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetXml", argTuple, callback, callbackArg )
	def _SetXml_Sync( self, xml, merge ):
		""" Deserialize xml representation of object into object
			xml: The xml representation of the object
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetXml", argTuple)
		return context.Sync()

	def _ImportXml( self, xml, merge, callback = None, callbackArg = None ):
		""" Deserialize xml representation of object into object and dealwith backward compatibility issues.
			xml: The xml representation of the object
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_ImportXml", argTuple, callback, callbackArg )
	def _ImportXml_Sync( self, xml, merge ):
		""" Deserialize xml representation of object into object and dealwith backward compatibility issues.
			xml: The xml representation of the object
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_ImportXml", argTuple)
		return context.Sync()

	def _Disposed( self, callback = None, callbackArg = None ):
		""" Client API must calls this method to indicate object is not used by client any more """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_Disposed", argTuple, callback, callbackArg )
	def _Disposed_Sync( self ):
		""" Client API must calls this method to indicate object is not used by client any more """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_Disposed", argTuple)
		return context.Sync()

	def _GetObjectListXml( self, listName, depth, forPersistentStorage, callback = None, callbackArg = None ):
		""" Get xml representation of a list of objects
			listName: The name of the list
			depth: The serialization depth
			forPersistentStorage: Flag indicating if the xml is going to be used as persistent storage. If set, itremoves ephemeral information such as IORs.
			Returns xml: The xml representation of the object list """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "depth", depth, "in", "XProtocolObject.eSerializationDepth", XProtocolObject.eSerializationDepth)
		arg2 = Aptixia_prv.MethodArgument( "forPersistentStorage", forPersistentStorage, "in", "bool", None)
		arg3 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetObjectListXml", argTuple, callback, callbackArg )
	def _GetObjectListXml_Sync( self, listName, depth, forPersistentStorage ):
		""" Get xml representation of a list of objects
			listName: The name of the list
			depth: The serialization depth
			forPersistentStorage: Flag indicating if the xml is going to be used as persistent storage. If set, itremoves ephemeral information such as IORs.
			Returns xml: The xml representation of the object list """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "depth", depth, "in", "XProtocolObject.eSerializationDepth", XProtocolObject.eSerializationDepth)
		arg2 = Aptixia_prv.MethodArgument( "forPersistentStorage", forPersistentStorage, "in", "bool", None)
		arg3 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetObjectListXml", argTuple)
		return context.Sync()

	def _SetObjectListXml( self, listName, xml, merge, callback = None, callbackArg = None ):
		""" Set a list of objects using its xml representation
			listName: The name of the list
			xml: The xml representation of the object list
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetObjectListXml", argTuple, callback, callbackArg )
	def _SetObjectListXml_Sync( self, listName, xml, merge ):
		""" Set a list of objects using its xml representation
			listName: The name of the list
			xml: The xml representation of the object list
			merge: Whether to clean the object prior to serialization or merge data """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "merge", merge, "in", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetObjectListXml", argTuple)
		return context.Sync()

	def _GetManagedDataXml( self, isDeep, callback = None, callbackArg = None ):
		""" Get xml representation of the object. Wrapper for _GetXml.
			isDeep: Whether the depth is kDeed or kPrefetch
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "isDeep", isDeep, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetManagedDataXml", argTuple, callback, callbackArg )
	def _GetManagedDataXml_Sync( self, isDeep ):
		""" Get xml representation of the object. Wrapper for _GetXml.
			isDeep: Whether the depth is kDeed or kPrefetch
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "isDeep", isDeep, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetManagedDataXml", argTuple)
		return context.Sync()

	def _SetManagedDataXml( self, xml, callback = None, callbackArg = None ):
		""" Set object data using xml representation of the object. Wrapper for _SetXml.
			xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetManagedDataXml", argTuple, callback, callbackArg )
	def _SetManagedDataXml_Sync( self, xml ):
		""" Set object data using xml representation of the object. Wrapper for _SetXml.
			xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_SetManagedDataXml", argTuple)
		return context.Sync()

	def _GetInstantiationXml( self, typeName, callback = None, callbackArg = None ):
		""" Get xml representation of a freshly created instance of a particular type (internal use only)
			typeName: The name of the class
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "typeName", typeName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetInstantiationXml", argTuple, callback, callbackArg )
	def _GetInstantiationXml_Sync( self, typeName ):
		""" Get xml representation of a freshly created instance of a particular type (internal use only)
			typeName: The name of the class
			Returns xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "typeName", typeName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetInstantiationXml", argTuple)
		return context.Sync()

	def _AppendListMember( self, listName, objecType, clientObjectId, xml, callback = None, callbackArg = None ):
		""" Append new object to object list (internal use only)
			listName: The name of the list
			objecType: The type of the object being added
			clientObjectId: The client side assigned object id of the new object
			xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "objecType", objecType, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "clientObjectId", clientObjectId, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_AppendListMember", argTuple, callback, callbackArg )
	def _AppendListMember_Sync( self, listName, objecType, clientObjectId, xml ):
		""" Append new object to object list (internal use only)
			listName: The name of the list
			objecType: The type of the object being added
			clientObjectId: The client side assigned object id of the new object
			xml: The xml representation of the object """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "objecType", objecType, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "clientObjectId", clientObjectId, "in", "int64", None)
		arg3 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_AppendListMember", argTuple)
		return context.Sync()

	def _DeleteListMember( self, listName, id, callback = None, callbackArg = None ):
		""" Delete object from object list (internal use only)
			listName: The name of the list
			id: The id of the object being deleted """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_DeleteListMember", argTuple, callback, callbackArg )
	def _DeleteListMember_Sync( self, listName, id ):
		""" Delete object from object list (internal use only)
			listName: The name of the list
			id: The id of the object being deleted """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_DeleteListMember", argTuple)
		return context.Sync()

	def _PrefetchListMembers( self, listName, idList, callback = None, callbackArg = None ):
		""" Get xml representation of list contents (internal use only)
			listName: The name of the list
			idList: List of ids of objects to be retrieved
			Returns xmlList: Xml representation of the objects being retrieved. """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "idList", idList, "in", "XProtocolObject.ObjectIdList", XProtocolObject.ObjectIdList)
		arg2 = Aptixia_prv.MethodArgument( "xmlList", None, "out", "XProtocolObject.XmlList", XProtocolObject.XmlList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PrefetchListMembers", argTuple, callback, callbackArg )
	def _PrefetchListMembers_Sync( self, listName, idList ):
		""" Get xml representation of list contents (internal use only)
			listName: The name of the list
			idList: List of ids of objects to be retrieved
			Returns xmlList: Xml representation of the objects being retrieved. """
		arg0 = Aptixia_prv.MethodArgument( "listName", listName, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "idList", idList, "in", "XProtocolObject.ObjectIdList", XProtocolObject.ObjectIdList)
		arg2 = Aptixia_prv.MethodArgument( "xmlList", None, "out", "XProtocolObject.XmlList", XProtocolObject.XmlList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PrefetchListMembers", argTuple)
		return context.Sync()

	def _GetClassVersionList( self, callback = None, callbackArg = None ):
		""" Get list of class information structures (internal use only)
			Returns versionList: The returned list """
		arg0 = Aptixia_prv.MethodArgument( "versionList", None, "out", "XProtocolObject.ClassVersionList", XProtocolObject.ClassVersionList)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetClassVersionList", argTuple, callback, callbackArg )
	def _GetClassVersionList_Sync( self ):
		""" Get list of class information structures (internal use only)
			Returns versionList: The returned list """
		arg0 = Aptixia_prv.MethodArgument( "versionList", None, "out", "XProtocolObject.ClassVersionList", XProtocolObject.ClassVersionList)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetClassVersionList", argTuple)
		return context.Sync()

	def _GetNewObjectIdRange( self, callback = None, callbackArg = None ):
		""" Reserve range of ids for client side instantiation (internal use only)
			Returns start: The beginning of the range
			Returns count: The number of ids in the range """
		arg0 = Aptixia_prv.MethodArgument( "start", None, "out", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "count", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetNewObjectIdRange", argTuple, callback, callbackArg )
	def _GetNewObjectIdRange_Sync( self ):
		""" Reserve range of ids for client side instantiation (internal use only)
			Returns start: The beginning of the range
			Returns count: The number of ids in the range """
		arg0 = Aptixia_prv.MethodArgument( "start", None, "out", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "count", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetNewObjectIdRange", argTuple)
		return context.Sync()

	def _GetCorbaIor( self, callback = None, callbackArg = None ):
		""" Get CORBA IOR for this object (internal use only)
			Returns ior: String form of the IOR for this object """
		arg0 = Aptixia_prv.MethodArgument( "ior", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetCorbaIor", argTuple, callback, callbackArg )
	def _GetCorbaIor_Sync( self ):
		""" Get CORBA IOR for this object (internal use only)
			Returns ior: String form of the IOR for this object """
		arg0 = Aptixia_prv.MethodArgument( "ior", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetCorbaIor", argTuple)
		return context.Sync()

	def _Validate( self, mode, callback = None, callbackArg = None ):
		""" Validate this object (internal use only)
			mode: Validation mode """
		arg0 = Aptixia_prv.MethodArgument( "mode", mode, "in", "XProtocolObject.eValidateMode", XProtocolObject.eValidateMode)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_Validate", argTuple, callback, callbackArg )
	def _Validate_Sync( self, mode ):
		""" Validate this object (internal use only)
			mode: Validation mode """
		arg0 = Aptixia_prv.MethodArgument( "mode", mode, "in", "XProtocolObject.eValidateMode", XProtocolObject.eValidateMode)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_Validate", argTuple)
		return context.Sync()

	def _CreateFileTransferContext( self, callback = None, callbackArg = None ):
		""" Create context for sending file to server (internal use only)
			Returns id: The ID of the transfer context """
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_CreateFileTransferContext", argTuple, callback, callbackArg )
	def _CreateFileTransferContext_Sync( self ):
		""" Create context for sending file to server (internal use only)
			Returns id: The ID of the transfer context """
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_CreateFileTransferContext", argTuple)
		return context.Sync()

	def _WriteFileBlock( self, id, data, callback = None, callbackArg = None ):
		""" Write to transfer file (internal use only)
			id: The ID of the transfer context
			data: Data to write """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "data", data, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_WriteFileBlock", argTuple, callback, callbackArg )
	def _WriteFileBlock_Sync( self, id, data ):
		""" Write to transfer file (internal use only)
			id: The ID of the transfer context
			data: Data to write """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "data", data, "in", "octets", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_WriteFileBlock", argTuple)
		return context.Sync()

	def _ReadFileBlock( self, id, maxBytes, callback = None, callbackArg = None ):
		""" Read from transfer file (internal use only)
			id: The ID of the transfer context
			maxBytes: Maximum number of bytes to read
			Returns data: Data read """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "maxBytes", maxBytes, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "data", None, "out", "octets", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_ReadFileBlock", argTuple, callback, callbackArg )
	def _ReadFileBlock_Sync( self, id, maxBytes ):
		""" Read from transfer file (internal use only)
			id: The ID of the transfer context
			maxBytes: Maximum number of bytes to read
			Returns data: Data read """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "maxBytes", maxBytes, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "data", None, "out", "octets", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_ReadFileBlock", argTuple)
		return context.Sync()

	def _CloseFileTransferContext( self, id, callback = None, callbackArg = None ):
		""" Close file transfer context (internal use only)
			id: The ID of the transfer context """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_CloseFileTransferContext", argTuple, callback, callbackArg )
	def _CloseFileTransferContext_Sync( self, id ):
		""" Close file transfer context (internal use only)
			id: The ID of the transfer context """
		arg0 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_CloseFileTransferContext", argTuple)
		return context.Sync()

	def _WriteLock( self, timeout, callback = None, callbackArg = None ):
		""" locks object for modification
			timeout: Timeout in milliseconds. """
		arg0 = Aptixia_prv.MethodArgument( "timeout", timeout, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_WriteLock", argTuple, callback, callbackArg )
	def _WriteLock_Sync( self, timeout ):
		""" locks object for modification
			timeout: Timeout in milliseconds. """
		arg0 = Aptixia_prv.MethodArgument( "timeout", timeout, "in", "int32", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_WriteLock", argTuple)
		return context.Sync()

	def _GetThisId( self, callback = None, callbackArg = None ):
		""" Get ID of this object (internal use only)
			Returns id: The ID of the object """
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetThisId", argTuple, callback, callbackArg )
	def _GetThisId_Sync( self ):
		""" Get ID of this object (internal use only)
			Returns id: The ID of the object """
		arg0 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetThisId", argTuple)
		return context.Sync()

	def _GetPropertyObjectId( self, name, callback = None, callbackArg = None ):
		""" Get ID of child object (internal use only)
			name: The name of the child object
			Returns id: The ID of the object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetPropertyObjectId", argTuple, callback, callbackArg )
	def _GetPropertyObjectId_Sync( self, name ):
		""" Get ID of child object (internal use only)
			name: The name of the child object
			Returns id: The ID of the object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetPropertyObjectId", argTuple)
		return context.Sync()

	def _GetPropertyObjectIdAndType( self, name, callback = None, callbackArg = None ):
		""" Get ID and type of child object (internal use only)
			name: The name of the child object
			Returns id: The ID of the object
			Returns type: The type of the object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetPropertyObjectIdAndType", argTuple, callback, callbackArg )
	def _GetPropertyObjectIdAndType_Sync( self, name ):
		""" Get ID and type of child object (internal use only)
			name: The name of the child object
			Returns id: The ID of the object
			Returns type: The type of the object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_GetPropertyObjectIdAndType", argTuple)
		return context.Sync()

	def _PropertyNodeInstantiate( self, name, type, callback = None, callbackArg = None ):
		""" Instantiate child object (internal use only)
			name: The name of the child object
			type: The type of the new object
			Returns id: The id of the child object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeInstantiate", argTuple, callback, callbackArg )
	def _PropertyNodeInstantiate_Sync( self, name, type ):
		""" Instantiate child object (internal use only)
			name: The name of the child object
			type: The type of the new object
			Returns id: The id of the child object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeInstantiate", argTuple)
		return context.Sync()

	def _PropertyNodeBind( self, name, id, callback = None, callbackArg = None ):
		""" Bind child object (internal use only)
			name: The name of the child object
			id: The id of the src object being bound to _name_
			Returns type: The type of the newly bound object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeBind", argTuple, callback, callbackArg )
	def _PropertyNodeBind_Sync( self, name, id ):
		""" Bind child object (internal use only)
			name: The name of the child object
			id: The id of the src object being bound to _name_
			Returns type: The type of the newly bound object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "id", id, "in", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeBind", argTuple)
		return context.Sync()

	def _PropertyNodeCharacterizationData( self, name, callback = None, callbackArg = None ):
		""" Get type and ID of a child object (internal use only)
			name: The name of the child object
			Returns type: The type of the new object
			Returns id: The id of the child object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeCharacterizationData", argTuple, callback, callbackArg )
	def _PropertyNodeCharacterizationData_Sync( self, name ):
		""" Get type and ID of a child object (internal use only)
			name: The name of the child object
			Returns type: The type of the new object
			Returns id: The id of the child object """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeCharacterizationData", argTuple)
		return context.Sync()

	def _PropertyNodeListEmpty( self, name, callback = None, callbackArg = None ):
		""" Clear node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListEmpty", argTuple, callback, callbackArg )
	def _PropertyNodeListEmpty_Sync( self, name ):
		""" Clear node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListEmpty", argTuple)
		return context.Sync()

	def _PropertyNodeListSize( self, name, callback = None, callbackArg = None ):
		""" Get size of node list (internal use only)
			name: The name of the node list
			Returns size: The size of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListSize", argTuple, callback, callbackArg )
	def _PropertyNodeListSize_Sync( self, name ):
		""" Get size of node list (internal use only)
			name: The name of the node list
			Returns size: The size of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListSize", argTuple)
		return context.Sync()

	def _PropertyNodeListDelete( self, name, index, callback = None, callbackArg = None ):
		""" Delete entry in node list (internal use only)
			name: The name of the node list
			index: Index of entry to be deleted """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListDelete", argTuple, callback, callbackArg )
	def _PropertyNodeListDelete_Sync( self, name, index ):
		""" Delete entry in node list (internal use only)
			name: The name of the node list
			index: Index of entry to be deleted """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListDelete", argTuple)
		return context.Sync()

	def _PropertyNodeListPopHead( self, name, callback = None, callbackArg = None ):
		""" Delete first entry in node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListPopHead", argTuple, callback, callbackArg )
	def _PropertyNodeListPopHead_Sync( self, name ):
		""" Delete first entry in node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListPopHead", argTuple)
		return context.Sync()

	def _PropertyNodeListPopTail( self, name, callback = None, callbackArg = None ):
		""" Delete last entry in node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListPopTail", argTuple, callback, callbackArg )
	def _PropertyNodeListPopTail_Sync( self, name ):
		""" Delete last entry in node list (internal use only)
			name: The name of the node list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListPopTail", argTuple)
		return context.Sync()

	def _PropertyNodeListAddHead( self, name, type, callback = None, callbackArg = None ):
		""" Add entry in node list in first position (internal use only)
			name: The name of the node list
			type: The type of object to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListAddHead", argTuple, callback, callbackArg )
	def _PropertyNodeListAddHead_Sync( self, name, type ):
		""" Add entry in node list in first position (internal use only)
			name: The name of the node list
			type: The type of object to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListAddHead", argTuple)
		return context.Sync()

	def _PropertyNodeListAddTail( self, name, type, callback = None, callbackArg = None ):
		""" Add entry in node list in last position (internal use only)
			name: The name of the node list
			type: The type of object to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListAddTail", argTuple, callback, callbackArg )
	def _PropertyNodeListAddTail_Sync( self, name, type ):
		""" Add entry in node list in last position (internal use only)
			name: The name of the node list
			type: The type of object to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "type", type, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListAddTail", argTuple)
		return context.Sync()

	def _PropertyNodeListGet( self, name, index, callback = None, callbackArg = None ):
		""" Get type and ID for node list entry (internal use only)
			name: The name of the node list
			index: The index of the entry
			Returns type: The type of the entry
			Returns id: The id of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		arg3 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListGet", argTuple, callback, callbackArg )
	def _PropertyNodeListGet_Sync( self, name, index ):
		""" Get type and ID for node list entry (internal use only)
			name: The name of the node list
			index: The index of the entry
			Returns type: The type of the entry
			Returns id: The id of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "type", None, "out", "string", None)
		arg3 = Aptixia_prv.MethodArgument( "id", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, arg3, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyNodeListGet", argTuple)
		return context.Sync()

	def _PropertyIntSet( self, name, value, callback = None, callbackArg = None ):
		""" Set value of int property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntSet", argTuple, callback, callbackArg )
	def _PropertyIntSet_Sync( self, name, value ):
		""" Set value of int property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntSet", argTuple)
		return context.Sync()

	def _PropertyIntGet( self, name, callback = None, callbackArg = None ):
		""" Get value of int property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntGet", argTuple, callback, callbackArg )
	def _PropertyIntGet_Sync( self, name ):
		""" Get value of int property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntGet", argTuple)
		return context.Sync()

	def _PropertyDoubleSet( self, name, value, callback = None, callbackArg = None ):
		""" Set value of int property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleSet", argTuple, callback, callbackArg )
	def _PropertyDoubleSet_Sync( self, name, value ):
		""" Set value of int property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleSet", argTuple)
		return context.Sync()

	def _PropertyDoubleGet( self, name, callback = None, callbackArg = None ):
		""" Get value of double property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleGet", argTuple, callback, callbackArg )
	def _PropertyDoubleGet_Sync( self, name ):
		""" Get value of double property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleGet", argTuple)
		return context.Sync()

	def _PropertyStringSet( self, name, value, callback = None, callbackArg = None ):
		""" Set value of string property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringSet", argTuple, callback, callbackArg )
	def _PropertyStringSet_Sync( self, name, value ):
		""" Set value of string property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringSet", argTuple)
		return context.Sync()

	def _PropertyStringGet( self, name, callback = None, callbackArg = None ):
		""" Get value of string property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringGet", argTuple, callback, callbackArg )
	def _PropertyStringGet_Sync( self, name ):
		""" Get value of string property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringGet", argTuple)
		return context.Sync()

	def _PropertyBooleanSet( self, name, value, callback = None, callbackArg = None ):
		""" Set value of bool property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyBooleanSet", argTuple, callback, callbackArg )
	def _PropertyBooleanSet_Sync( self, name, value ):
		""" Set value of bool property (internal use only)
			name: The name of the property
			value: The value to set the property to """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyBooleanSet", argTuple)
		return context.Sync()

	def _PropertyBooleanGet( self, name, callback = None, callbackArg = None ):
		""" Get value of bool property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyBooleanGet", argTuple, callback, callbackArg )
	def _PropertyBooleanGet_Sync( self, name ):
		""" Get value of bool property (internal use only)
			name: The name of the property
			Returns value: The value of the property """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", None, "out", "bool", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyBooleanGet", argTuple)
		return context.Sync()

	def _PropertyIntListEmpty( self, name, callback = None, callbackArg = None ):
		""" Clear int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListEmpty", argTuple, callback, callbackArg )
	def _PropertyIntListEmpty_Sync( self, name ):
		""" Clear int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListEmpty", argTuple)
		return context.Sync()

	def _PropertyIntListSize( self, name, callback = None, callbackArg = None ):
		""" Get size of int list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListSize", argTuple, callback, callbackArg )
	def _PropertyIntListSize_Sync( self, name ):
		""" Get size of int list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListSize", argTuple)
		return context.Sync()

	def _PropertyIntListGet( self, name, index, callback = None, callbackArg = None ):
		""" Get entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListGet", argTuple, callback, callbackArg )
	def _PropertyIntListGet_Sync( self, name, index ):
		""" Get entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListGet", argTuple)
		return context.Sync()

	def _PropertyIntListSet( self, name, index, value, callback = None, callbackArg = None ):
		""" Set entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListSet", argTuple, callback, callbackArg )
	def _PropertyIntListSet_Sync( self, name, index, value ):
		""" Set entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListSet", argTuple)
		return context.Sync()

	def _PropertyIntListDelete( self, name, index, callback = None, callbackArg = None ):
		""" Delete entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListDelete", argTuple, callback, callbackArg )
	def _PropertyIntListDelete_Sync( self, name, index ):
		""" Delete entry in int list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListDelete", argTuple)
		return context.Sync()

	def _PropertyIntListAddHead( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at head of int list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListAddHead", argTuple, callback, callbackArg )
	def _PropertyIntListAddHead_Sync( self, name, value ):
		""" Add entry at head of int list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListAddHead", argTuple)
		return context.Sync()

	def _PropertyIntListAddTail( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at tail of int list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListAddTail", argTuple, callback, callbackArg )
	def _PropertyIntListAddTail_Sync( self, name, value ):
		""" Add entry at tail of int list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "int64", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListAddTail", argTuple)
		return context.Sync()

	def _PropertyIntListPopHead( self, name, callback = None, callbackArg = None ):
		""" Remove entry from head of int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListPopHead", argTuple, callback, callbackArg )
	def _PropertyIntListPopHead_Sync( self, name ):
		""" Remove entry from head of int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListPopHead", argTuple)
		return context.Sync()

	def _PropertyIntListPopTail( self, name, callback = None, callbackArg = None ):
		""" Remove entry from tail of int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListPopTail", argTuple, callback, callbackArg )
	def _PropertyIntListPopTail_Sync( self, name ):
		""" Remove entry from tail of int list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyIntListPopTail", argTuple)
		return context.Sync()

	def _PropertyDoubleListEmpty( self, name, callback = None, callbackArg = None ):
		""" Clear double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListEmpty", argTuple, callback, callbackArg )
	def _PropertyDoubleListEmpty_Sync( self, name ):
		""" Clear double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListEmpty", argTuple)
		return context.Sync()

	def _PropertyDoubleListSize( self, name, callback = None, callbackArg = None ):
		""" Get size of double list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListSize", argTuple, callback, callbackArg )
	def _PropertyDoubleListSize_Sync( self, name ):
		""" Get size of double list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListSize", argTuple)
		return context.Sync()

	def _PropertyDoubleListGet( self, name, index, callback = None, callbackArg = None ):
		""" Get entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListGet", argTuple, callback, callbackArg )
	def _PropertyDoubleListGet_Sync( self, name, index ):
		""" Get entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListGet", argTuple)
		return context.Sync()

	def _PropertyDoubleListSet( self, name, index, value, callback = None, callbackArg = None ):
		""" Set entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListSet", argTuple, callback, callbackArg )
	def _PropertyDoubleListSet_Sync( self, name, index, value ):
		""" Set entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListSet", argTuple)
		return context.Sync()

	def _PropertyDoubleListDelete( self, name, index, callback = None, callbackArg = None ):
		""" Delete entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListDelete", argTuple, callback, callbackArg )
	def _PropertyDoubleListDelete_Sync( self, name, index ):
		""" Delete entry in double list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListDelete", argTuple)
		return context.Sync()

	def _PropertyDoubleListAddHead( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at head of double list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListAddHead", argTuple, callback, callbackArg )
	def _PropertyDoubleListAddHead_Sync( self, name, value ):
		""" Add entry at head of double list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListAddHead", argTuple)
		return context.Sync()

	def _PropertyDoubleListAddTail( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at head of double list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListAddTail", argTuple, callback, callbackArg )
	def _PropertyDoubleListAddTail_Sync( self, name, value ):
		""" Add entry at head of double list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "double", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListAddTail", argTuple)
		return context.Sync()

	def _PropertyDoubleListPopHead( self, name, callback = None, callbackArg = None ):
		""" Remove entry from head of double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListPopHead", argTuple, callback, callbackArg )
	def _PropertyDoubleListPopHead_Sync( self, name ):
		""" Remove entry from head of double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListPopHead", argTuple)
		return context.Sync()

	def _PropertyDoubleListPopTail( self, name, callback = None, callbackArg = None ):
		""" Remove entry from tail of double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListPopTail", argTuple, callback, callbackArg )
	def _PropertyDoubleListPopTail_Sync( self, name ):
		""" Remove entry from tail of double list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyDoubleListPopTail", argTuple)
		return context.Sync()

	def _PropertyStringListEmpty( self, name, callback = None, callbackArg = None ):
		""" Clear string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListEmpty", argTuple, callback, callbackArg )
	def _PropertyStringListEmpty_Sync( self, name ):
		""" Clear string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListEmpty", argTuple)
		return context.Sync()

	def _PropertyStringListSize( self, name, callback = None, callbackArg = None ):
		""" Get size of string list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListSize", argTuple, callback, callbackArg )
	def _PropertyStringListSize_Sync( self, name ):
		""" Get size of string list (internal use only)
			name: The name of the list
			Returns size: The size of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "size", None, "out", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListSize", argTuple)
		return context.Sync()

	def _PropertyStringListGet( self, name, index, callback = None, callbackArg = None ):
		""" Get entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListGet", argTuple, callback, callbackArg )
	def _PropertyStringListGet_Sync( self, name, index ):
		""" Get entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to get
			Returns value: The value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListGet", argTuple)
		return context.Sync()

	def _PropertyStringListSet( self, name, index, value, callback = None, callbackArg = None ):
		""" Set entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListSet", argTuple, callback, callbackArg )
	def _PropertyStringListSet_Sync( self, name, index, value ):
		""" Set entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to set
			value: The new value of the entry """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListSet", argTuple)
		return context.Sync()

	def _PropertyStringListDelete( self, name, index, callback = None, callbackArg = None ):
		""" Delete entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListDelete", argTuple, callback, callbackArg )
	def _PropertyStringListDelete_Sync( self, name, index ):
		""" Delete entry in string list (internal use only)
			name: The name of the list
			index: The index of the entry to delete """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "index", index, "in", "int32", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListDelete", argTuple)
		return context.Sync()

	def _PropertyStringListAddHead( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at head of string list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListAddHead", argTuple, callback, callbackArg )
	def _PropertyStringListAddHead_Sync( self, name, value ):
		""" Add entry at head of string list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListAddHead", argTuple)
		return context.Sync()

	def _PropertyStringListAddTail( self, name, value, callback = None, callbackArg = None ):
		""" Add entry at tail of string list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListAddTail", argTuple, callback, callbackArg )
	def _PropertyStringListAddTail_Sync( self, name, value ):
		""" Add entry at tail of string list (internal use only)
			name: The name of the list
			value: The value to add """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "value", value, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListAddTail", argTuple)
		return context.Sync()

	def _PropertyStringListPopHead( self, name, callback = None, callbackArg = None ):
		""" Remove entry from head of string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListPopHead", argTuple, callback, callbackArg )
	def _PropertyStringListPopHead_Sync( self, name ):
		""" Remove entry from head of string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListPopHead", argTuple)
		return context.Sync()

	def _PropertyStringListPopTail( self, name, callback = None, callbackArg = None ):
		""" Remove entry from tail of string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListPopTail", argTuple, callback, callbackArg )
	def _PropertyStringListPopTail_Sync( self, name ):
		""" Remove entry from tail of string list (internal use only)
			name: The name of the list """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "_PropertyStringListPopTail", argTuple)
		return context.Sync()


