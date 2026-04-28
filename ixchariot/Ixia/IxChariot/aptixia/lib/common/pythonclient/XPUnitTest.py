import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import XPUnitTestA, XPUnitTestC, XPUnitTestD, XPUnitTestO


class XPUnitTest( XProtocolObject.XProtocolObject ):
	""" Provides Unit Test facility for the all types of data used in the meta-schemas """
	# Enums
	class eUnitTestEnum (Aptixia.IxEnum):
		kSymbol1 = 5
		kSymbol2 = 6
		kSymbol3 = 9
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "XPUnitTest.eUnitTestEnum"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class UnitTestList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int8")
		if "XPUnitTest.UnitTestList" not in Aptixia.lists:
			Aptixia.lists.append( "XPUnitTest.UnitTestList" )
		def getType():
			return "XPUnitTest.UnitTestList"
		getType = staticmethod(getType)
		def getElementType():
			return "int8"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)

	# Structs
	class UnitTestStruct( Aptixia.IxStruct ):
		""" Simplest user defined structure """
		if "XPUnitTest.UnitTestStruct" not in Aptixia.structs:
			Aptixia.structs.append("XPUnitTest.UnitTestStruct")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.anInt8 = 3
			self._version = "2"
			self._types = { "anInt8":"int8" }
		def getType( self ):
			return "XPUnitTest.UnitTestStruct"


	# Class Properties
	def _get_stringVar (self):
		return self.getVar ("stringVar")
	def _set_stringVar (self, value):
		self.setVar ("stringVar", value)
	stringVar = property (_get_stringVar, _set_stringVar, None, "stringVar property")
	def _get_intVar (self):
		return self.getVar ("intVar")
	def _set_intVar (self, value):
		self.setVar ("intVar", value)
	intVar = property (_get_intVar, _set_intVar, None, "intVar property")
	def _get_boolVar (self):
		return self.getVar ("boolVar")
	def _set_boolVar (self, value):
		self.setVar ("boolVar", value)
	boolVar = property (_get_boolVar, _set_boolVar, None, "boolVar property")
	def _get_doubleVar (self):
		return self.getVar ("doubleVar")
	def _set_doubleVar (self, value):
		self.setVar ("doubleVar", value)
	doubleVar = property (_get_doubleVar, _set_doubleVar, None, "doubleVar property")
	def _get_intList (self):
		return self.getListVar ("intList")
	intList = property (_get_intList, None, None, "intList property")
	def _get_stringList (self):
		return self.getListVar ("stringList")
	stringList = property (_get_stringList, None, None, "stringList property")
	def _get_doubleList (self):
		return self.getListVar ("doubleList")
	doubleList = property (_get_doubleList, None, None, "doubleList property")
	def _get_subNode (self):
		return self.getListVar ("subNode")
	subNode = property (_get_subNode, None, None, "subNode property")
	def _get_polymorphicSubNode (self):
		return self.getListVar ("polymorphicSubNode")
	def _set_polymorphicSubNode (self, value):
		self.setVar ("polymorphicSubNode", value)
	polymorphicSubNode = property (_get_polymorphicSubNode, _set_polymorphicSubNode, None, "polymorphicSubNode property")
	def _get_polymorphicSubNodeList (self):
		return self.getListVar ("polymorphicSubNodeList")
	polymorphicSubNodeList = property (_get_polymorphicSubNodeList, None, None, "polymorphicSubNodeList property")
	def _get_subNodeList (self):
		return self.getListVar ("subNodeList")
	subNodeList = property (_get_subNodeList, None, None, "subNodeList property")
	def _get_subNodeListD (self):
		return self.getListVar ("subNodeListD")
	subNodeListD = property (_get_subNodeListD, None, None, "subNodeListD property")
	def _get_stringListBehindObsoleteStringList (self):
		return self.getListVar ("stringListBehindObsoleteStringList")
	stringListBehindObsoleteStringList = property (_get_stringListBehindObsoleteStringList, None, None, "stringListBehindObsoleteStringList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPUnitTest, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["stringVar"] = "default string"
			self.managedProperties["intVar"] = 0
			self.managedProperties["boolVar"] = False
			self.managedProperties["doubleVar"] = 0.0
			self.managedProperties["intList"] = Aptixia.IxList ("int")
			self.managedProperties["stringList"] = Aptixia.IxList ("string")
			self.managedProperties["doubleList"] = Aptixia.IxList ("double")
			self.managedProperties["subNode"] = XPUnitTestA.XPUnitTestA (self)
			self.managedProperties["polymorphicSubNode"] = None
			self.managedProperties["polymorphicSubNodeList"] = Aptixia.IxObjectList (self.transactionContext, "XPUnitTestA")
			self.managedProperties["subNodeList"] = Aptixia.IxObjectList (self.transactionContext, "XPUnitTestC")
			self.managedProperties["subNodeListD"] = Aptixia.IxObjectList (self.transactionContext, "XPUnitTestD")
			self.managedProperties["stringListBehindObsoleteStringList"] = Aptixia.IxList ("string")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPUnitTest"

	# Class Events
	def register_MySimpleEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "aString", None, "out", "string", None)
		argTuple = ( arg0, )
		return self.registerEvent ("MySimpleEvent", argTuple, callback, callbackArg)

	def register_MyEvent_event (self, callback, callbackArg):
		arg0 = Aptixia_prv.MethodArgument( "anInt8", None, "out", "int8", None)
		arg1 = Aptixia_prv.MethodArgument( "anInt16", None, "out", "int16", None)
		arg2 = Aptixia_prv.MethodArgument( "anInt32", None, "out", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "anInt64", None, "out", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "aBool", None, "out", "bool", None)
		arg5 = Aptixia_prv.MethodArgument( "aDouble", None, "out", "double", None)
		arg6 = Aptixia_prv.MethodArgument( "aString", None, "out", "string", None)
		arg7 = Aptixia_prv.MethodArgument( "anOctets", None, "out", "octets", None)
		arg8 = Aptixia_prv.MethodArgument( "anEnum", None, "out", "XPUnitTest.eUnitTestEnum", XPUnitTest.eUnitTestEnum)
		arg9 = Aptixia_prv.MethodArgument( "aStruct", None, "out", "XPUnitTest.UnitTestStruct", XPUnitTest.UnitTestStruct)
		arg10 = Aptixia_prv.MethodArgument( "aList", None, "out", "XPUnitTest.UnitTestList", XPUnitTest.UnitTestList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, )
		return self.registerEvent ("MyEvent", argTuple, callback, callbackArg)

	# Class Methods
	def GetTestString( self, callback = None, callbackArg = None ):
		""" Tests out string method call
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestString", argTuple, callback, callbackArg )
	def GetTestString_Sync( self ):
		""" Tests out string method call
			Returns v: Returns a string """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestString", argTuple)
		return context.Sync()

	def SetTestString( self, v, callback = None, callbackArg = None ):
		""" Tests in string method call
			v: Sets a string """
		arg0 = Aptixia_prv.MethodArgument( "v", v, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetTestString", argTuple, callback, callbackArg )
	def SetTestString_Sync( self, v ):
		""" Tests in string method call
			v: Sets a string """
		arg0 = Aptixia_prv.MethodArgument( "v", v, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetTestString", argTuple)
		return context.Sync()

	def GetTestInt( self, callback = None, callbackArg = None ):
		""" Tests out integer method call
			Returns v: Returns a integer """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestInt", argTuple, callback, callbackArg )
	def GetTestInt_Sync( self ):
		""" Tests out integer method call
			Returns v: Returns a integer """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestInt", argTuple)
		return context.Sync()

	def GetTestBool( self, callback = None, callbackArg = None ):
		""" Tests out boolean method call
			Returns v: Returns a boolean """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestBool", argTuple, callback, callbackArg )
	def GetTestBool_Sync( self ):
		""" Tests out boolean method call
			Returns v: Returns a boolean """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "bool", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestBool", argTuple)
		return context.Sync()

	def GetTestDouble( self, callback = None, callbackArg = None ):
		""" Tests out double method call
			Returns v: Returns a double value """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "double", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestDouble", argTuple, callback, callbackArg )
	def GetTestDouble_Sync( self ):
		""" Tests out double method call
			Returns v: Returns a double value """
		arg0 = Aptixia_prv.MethodArgument( "v", None, "out", "double", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetTestDouble", argTuple)
		return context.Sync()

	def TestSimpleEvent( self, aString, callback = None, callbackArg = None ):
		arg0 = Aptixia_prv.MethodArgument( "aString", aString, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestSimpleEvent", argTuple, callback, callbackArg )
	def TestSimpleEvent_Sync( self, aString ):
		arg0 = Aptixia_prv.MethodArgument( "aString", aString, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestSimpleEvent", argTuple)
		return context.Sync()

	def TestEventNoArgs( self, callback = None, callbackArg = None ):
		""" Triggers MyEvent - event """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestEventNoArgs", argTuple, callback, callbackArg )
	def TestEventNoArgs_Sync( self ):
		""" Triggers MyEvent - event """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestEventNoArgs", argTuple)
		return context.Sync()

	def TestEvent( self, anInt8, anInt16, anInt32, anInt64, aBool, aDouble, aString, anOctets, anEnum, aStruct, aList, callback = None, callbackArg = None ):
		""" Triggers MyEvent - event
			anInt8: int8 argument to send into event
			anInt16: int16 argument to send into event
			anInt32: int32 argument to send into event
			anInt64: int64 argument to send into event
			aBool: bool argument to send into event
			aDouble: double argument to send into event
			aString: string argument to send into event
			anOctets: octets argument to send into event
			anEnum: XPUnitTest.eUnitTestEnum argument to send into event
			aStruct: XPUnitTest.UnitTestStruct argument to send into event
			aList: XPUnitTest.UnitTestList argument to send into event """
		arg0 = Aptixia_prv.MethodArgument( "anInt8", anInt8, "in", "int8", None)
		arg1 = Aptixia_prv.MethodArgument( "anInt16", anInt16, "in", "int16", None)
		arg2 = Aptixia_prv.MethodArgument( "anInt32", anInt32, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "anInt64", anInt64, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "aBool", aBool, "in", "bool", None)
		arg5 = Aptixia_prv.MethodArgument( "aDouble", aDouble, "in", "double", None)
		arg6 = Aptixia_prv.MethodArgument( "aString", aString, "in", "string", None)
		arg7 = Aptixia_prv.MethodArgument( "anOctets", anOctets, "in", "octets", None)
		arg8 = Aptixia_prv.MethodArgument( "anEnum", anEnum, "in", "XPUnitTest.eUnitTestEnum", XPUnitTest.eUnitTestEnum)
		arg9 = Aptixia_prv.MethodArgument( "aStruct", aStruct, "in", "XPUnitTest.UnitTestStruct", XPUnitTest.UnitTestStruct)
		arg10 = Aptixia_prv.MethodArgument( "aList", aList, "in", "XPUnitTest.UnitTestList", XPUnitTest.UnitTestList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestEvent", argTuple, callback, callbackArg )
	def TestEvent_Sync( self, anInt8, anInt16, anInt32, anInt64, aBool, aDouble, aString, anOctets, anEnum, aStruct, aList ):
		""" Triggers MyEvent - event
			anInt8: int8 argument to send into event
			anInt16: int16 argument to send into event
			anInt32: int32 argument to send into event
			anInt64: int64 argument to send into event
			aBool: bool argument to send into event
			aDouble: double argument to send into event
			aString: string argument to send into event
			anOctets: octets argument to send into event
			anEnum: XPUnitTest.eUnitTestEnum argument to send into event
			aStruct: XPUnitTest.UnitTestStruct argument to send into event
			aList: XPUnitTest.UnitTestList argument to send into event """
		arg0 = Aptixia_prv.MethodArgument( "anInt8", anInt8, "in", "int8", None)
		arg1 = Aptixia_prv.MethodArgument( "anInt16", anInt16, "in", "int16", None)
		arg2 = Aptixia_prv.MethodArgument( "anInt32", anInt32, "in", "int32", None)
		arg3 = Aptixia_prv.MethodArgument( "anInt64", anInt64, "in", "int64", None)
		arg4 = Aptixia_prv.MethodArgument( "aBool", aBool, "in", "bool", None)
		arg5 = Aptixia_prv.MethodArgument( "aDouble", aDouble, "in", "double", None)
		arg6 = Aptixia_prv.MethodArgument( "aString", aString, "in", "string", None)
		arg7 = Aptixia_prv.MethodArgument( "anOctets", anOctets, "in", "octets", None)
		arg8 = Aptixia_prv.MethodArgument( "anEnum", anEnum, "in", "XPUnitTest.eUnitTestEnum", XPUnitTest.eUnitTestEnum)
		arg9 = Aptixia_prv.MethodArgument( "aStruct", aStruct, "in", "XPUnitTest.UnitTestStruct", XPUnitTest.UnitTestStruct)
		arg10 = Aptixia_prv.MethodArgument( "aList", aList, "in", "XPUnitTest.UnitTestList", XPUnitTest.UnitTestList)
		argTuple = ( arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestEvent", argTuple)
		return context.Sync()


