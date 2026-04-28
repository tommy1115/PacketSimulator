import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import XPUnitTest


class XPBootstrap( XProtocolObject.XProtocolObject ):
	""" Main x-protocol infrastructure regression testing object """
	# Enums
	class eMyEnum (Aptixia.IxEnum):
		kSymbol1 = 5
		kSymbol2 = 6
		kSymbol3 = 9
		__value = 0
		def __init__( self, value = 0, ignored = None ):
			self.__value = int(value)
		def __str__( self ):
			return str( self.__value )
		def getType():
			return "XPBootstrap.eMyEnum"
		getType = staticmethod(getType)
		def getValue( self ):
			return self.__value

	# List properties
	class ListInt8( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int8")
		if "XPBootstrap.ListInt8" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListInt8" )
		def getType():
			return "XPBootstrap.ListInt8"
		getType = staticmethod(getType)
		def getElementType():
			return "int8"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListInt16( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int16")
		if "XPBootstrap.ListInt16" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListInt16" )
		def getType():
			return "XPBootstrap.ListInt16"
		getType = staticmethod(getType)
		def getElementType():
			return "int16"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListInt32( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int32")
		if "XPBootstrap.ListInt32" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListInt32" )
		def getType():
			return "XPBootstrap.ListInt32"
		getType = staticmethod(getType)
		def getElementType():
			return "int32"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListInt64( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "int64")
		if "XPBootstrap.ListInt64" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListInt64" )
		def getType():
			return "XPBootstrap.ListInt64"
		getType = staticmethod(getType)
		def getElementType():
			return "int64"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListBool( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "bool")
		if "XPBootstrap.ListBool" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListBool" )
		def getType():
			return "XPBootstrap.ListBool"
		getType = staticmethod(getType)
		def getElementType():
			return "bool"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListDouble( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "double")
		if "XPBootstrap.ListDouble" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListDouble" )
		def getType():
			return "XPBootstrap.ListDouble"
		getType = staticmethod(getType)
		def getElementType():
			return "double"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListString( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "string")
		if "XPBootstrap.ListString" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListString" )
		def getType():
			return "XPBootstrap.ListString"
		getType = staticmethod(getType)
		def getElementType():
			return "string"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListOctets( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "octets")
		if "XPBootstrap.ListOctets" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListOctets" )
		def getType():
			return "XPBootstrap.ListOctets"
		getType = staticmethod(getType)
		def getElementType():
			return "octets"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return None
		getElementClass = staticmethod(getElementClass)
	class ListEnum( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "XPBootstrap.eMyEnum")
		if "XPBootstrap.ListEnum" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListEnum" )
		def getType():
			return "XPBootstrap.ListEnum"
		getType = staticmethod(getType)
		def getElementType():
			return "XPBootstrap.eMyEnum"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return XPBootstrap.eMyEnum
		getElementClass = staticmethod(getElementClass)
	class ListStruct( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "XPBootstrap.MyStruct")
		if "XPBootstrap.ListStruct" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListStruct" )
		def getType():
			return "XPBootstrap.ListStruct"
		getType = staticmethod(getType)
		def getElementType():
			return "XPBootstrap.MyStruct"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return XPBootstrap.MyStruct
		getElementClass = staticmethod(getElementClass)
	class ListList( Aptixia.IxList ):
		def __init__( self ):
			Aptixia.IxList.__init__(self, "XPBootstrap.ListInt8")
		if "XPBootstrap.ListList" not in Aptixia.lists:
			Aptixia.lists.append( "XPBootstrap.ListList" )
		def getType():
			return "XPBootstrap.ListList"
		getType = staticmethod(getType)
		def getElementType():
			return "XPBootstrap.ListInt8"
		getElementType = staticmethod(getElementType)
		def getElementClass():
			return XPBootstrap.ListInt8
		getElementClass = staticmethod(getElementClass)

	# Structs
	class InnerStruct( Aptixia.IxStruct ):
		""" A simple test struct (user defined type) """
		if "XPBootstrap.InnerStruct" not in Aptixia.structs:
			Aptixia.structs.append("XPBootstrap.InnerStruct")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.anInt32 = 931
			self._version = "2"
			self._types = { "anInt32":"int32" }
		def getType( self ):
			return "XPBootstrap.InnerStruct"

	class MyStruct( Aptixia.IxStruct ):
		""" A complex structure (user defined type) """
		if "XPBootstrap.MyStruct" not in Aptixia.structs:
			Aptixia.structs.append("XPBootstrap.MyStruct")
		def __init__( self ):
			Aptixia.IxStruct.__init__( self )
			self.anInt8 = 3
			self.anInt16 = 8
			self.anInt32 = 1
			self.anInt64 = 999
			self.aBool = 1
			self.aDouble = 3.5
			self.aString = "abcdef"
			self.anOctets = buffer( "" )
			self.anEnum = XPBootstrap.eMyEnum()
			self.aStruct = XPBootstrap.InnerStruct()
			self.aList = XPBootstrap.ListInt8()
			self._version = "2"
			self._types = { "anInt8":"int8",
				 "anInt16":"int16",
				 "anInt32":"int32",
				 "anInt64":"int64",
				 "aBool":"bool",
				 "aDouble":"double",
				 "aString":"string",
				 "anOctets":"octets",
				 "anEnum":"XPBootstrap.eMyEnum",
				 "aStruct":"XPBootstrap.InnerStruct",
				 "aList":"XPBootstrap.ListInt8" }
		def getType( self ):
			return "XPBootstrap.MyStruct"


	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( XPBootstrap, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "XPBootstrap"

	# Class Methods
	def Ping( self, callback = None, callbackArg = None ):
		""" Empty function to check basic connecticity """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple, callback, callbackArg )
	def Ping_Sync( self ):
		""" Empty function to check basic connecticity """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Ping", argTuple)
		return context.Sync()

	def Int8Test( self, inInt8, inoutInt8, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt8: Argument 1
			inoutInt8: Argument 2
			Returns outInt8: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt8", inInt8, "in", "int8", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt8", inoutInt8, "inout", "int8", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt8", None, "out", "int8", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int8Test", argTuple, callback, callbackArg )
	def Int8Test_Sync( self, inInt8, inoutInt8 ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt8: Argument 1
			inoutInt8: Argument 2
			Returns outInt8: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt8", inInt8, "in", "int8", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt8", inoutInt8, "inout", "int8", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt8", None, "out", "int8", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int8Test", argTuple)
		return context.Sync()

	def Int16Test( self, inInt16, inoutInt16, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt16: Argument 1
			inoutInt16: Argument 2
			Returns outInt16: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt16", inInt16, "in", "int16", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt16", inoutInt16, "inout", "int16", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt16", None, "out", "int16", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int16Test", argTuple, callback, callbackArg )
	def Int16Test_Sync( self, inInt16, inoutInt16 ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt16: Argument 1
			inoutInt16: Argument 2
			Returns outInt16: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt16", inInt16, "in", "int16", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt16", inoutInt16, "inout", "int16", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt16", None, "out", "int16", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int16Test", argTuple)
		return context.Sync()

	def Int32Test( self, inInt32, inoutInt32, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt32: Argument 1
			inoutInt32: Argument 2
			Returns outInt32: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt32", inInt32, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt32", inoutInt32, "inout", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt32", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int32Test", argTuple, callback, callbackArg )
	def Int32Test_Sync( self, inInt32, inoutInt32 ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt32: Argument 1
			inoutInt32: Argument 2
			Returns outInt32: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt32", inInt32, "in", "int32", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt32", inoutInt32, "inout", "int32", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt32", None, "out", "int32", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int32Test", argTuple)
		return context.Sync()

	def Int64Test( self, inInt64, inoutInt64, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt64: Argument 1
			inoutInt64: Argument 2
			Returns outInt64: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt64", inInt64, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt64", inoutInt64, "inout", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt64", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int64Test", argTuple, callback, callbackArg )
	def Int64Test_Sync( self, inInt64, inoutInt64 ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inInt64: Argument 1
			inoutInt64: Argument 2
			Returns outInt64: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inInt64", inInt64, "in", "int64", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutInt64", inoutInt64, "inout", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "outInt64", None, "out", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Int64Test", argTuple)
		return context.Sync()

	def BoolTest( self, inBool, inoutBool, callback = None, callbackArg = None ):
		""" Basic types test. Returns NOT argument 2 in argument 3and NOT argument 1 in argument 2.
			inBool: Argument 1
			inoutBool: Argument 2
			Returns outBool: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inBool", inBool, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutBool", inoutBool, "inout", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "outBool", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "BoolTest", argTuple, callback, callbackArg )
	def BoolTest_Sync( self, inBool, inoutBool ):
		""" Basic types test. Returns NOT argument 2 in argument 3and NOT argument 1 in argument 2.
			inBool: Argument 1
			inoutBool: Argument 2
			Returns outBool: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inBool", inBool, "in", "bool", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutBool", inoutBool, "inout", "bool", None)
		arg2 = Aptixia_prv.MethodArgument( "outBool", None, "out", "bool", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "BoolTest", argTuple)
		return context.Sync()

	def DoubleTest( self, inDouble, inoutDouble, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inDouble: Argument 1
			inoutDouble: Argument 2
			Returns outDouble: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inDouble", inDouble, "in", "double", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutDouble", inoutDouble, "inout", "double", None)
		arg2 = Aptixia_prv.MethodArgument( "outDouble", None, "out", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DoubleTest", argTuple, callback, callbackArg )
	def DoubleTest_Sync( self, inDouble, inoutDouble ):
		""" Basic types test. Returns argument 2 incremented by 1 in argument 3and argument 1 incremented by 1 in argument 2.
			inDouble: Argument 1
			inoutDouble: Argument 2
			Returns outDouble: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inDouble", inDouble, "in", "double", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutDouble", inoutDouble, "inout", "double", None)
		arg2 = Aptixia_prv.MethodArgument( "outDouble", None, "out", "double", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "DoubleTest", argTuple)
		return context.Sync()

	def StringTest( self, inString, inoutString, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 appended to itself in argument 3and argument 1 appended to itself in argument 2.
			inString: Argument 1
			inoutString: Argument 2
			Returns outString: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inString", inString, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutString", inoutString, "inout", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "outString", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StringTest", argTuple, callback, callbackArg )
	def StringTest_Sync( self, inString, inoutString ):
		""" Basic types test. Returns argument 2 appended to itself in argument 3and argument 1 appended to itself in argument 2.
			inString: Argument 1
			inoutString: Argument 2
			Returns outString: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inString", inString, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutString", inoutString, "inout", "string", None)
		arg2 = Aptixia_prv.MethodArgument( "outString", None, "out", "string", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StringTest", argTuple)
		return context.Sync()

	def OctetsTest( self, inOctets, inoutOctets, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inOctets: Argument 1
			inoutOctets: Argument 2
			Returns outOctets: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inOctets", inOctets, "in", "octets", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutOctets", inoutOctets, "inout", "octets", None)
		arg2 = Aptixia_prv.MethodArgument( "outOctets", None, "out", "octets", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OctetsTest", argTuple, callback, callbackArg )
	def OctetsTest_Sync( self, inOctets, inoutOctets ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inOctets: Argument 1
			inoutOctets: Argument 2
			Returns outOctets: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inOctets", inOctets, "in", "octets", None)
		arg1 = Aptixia_prv.MethodArgument( "inoutOctets", inoutOctets, "inout", "octets", None)
		arg2 = Aptixia_prv.MethodArgument( "outOctets", None, "out", "octets", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "OctetsTest", argTuple)
		return context.Sync()

	def FileTest( self, inFile, callback = None, callbackArg = None ):
		""" File argument test. Returns the file passed in argument 1 as argument 2.
			inFile: Argument 1
			Returns outFile: Argument 2 """
		arg0 = Aptixia_prv.MethodArgument( "inFile", inFile, "in", "file", None)
		arg1 = Aptixia_prv.MethodArgument( "outFile", None, "out", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileTest", argTuple, callback, callbackArg )
	def FileTest_Sync( self, inFile ):
		""" File argument test. Returns the file passed in argument 1 as argument 2.
			inFile: Argument 1
			Returns outFile: Argument 2 """
		arg0 = Aptixia_prv.MethodArgument( "inFile", inFile, "in", "file", None)
		arg1 = Aptixia_prv.MethodArgument( "outFile", None, "out", "file", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "FileTest", argTuple)
		return context.Sync()

	def EnumTest( self, inEnum, inoutEnum, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inEnum: Argument 1
			inoutEnum: Argument 2
			Returns outEnum: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inEnum", inEnum, "in", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		arg1 = Aptixia_prv.MethodArgument( "inoutEnum", inoutEnum, "inout", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		arg2 = Aptixia_prv.MethodArgument( "outEnum", None, "out", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EnumTest", argTuple, callback, callbackArg )
	def EnumTest_Sync( self, inEnum, inoutEnum ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inEnum: Argument 1
			inoutEnum: Argument 2
			Returns outEnum: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inEnum", inEnum, "in", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		arg1 = Aptixia_prv.MethodArgument( "inoutEnum", inoutEnum, "inout", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		arg2 = Aptixia_prv.MethodArgument( "outEnum", None, "out", "XPBootstrap.eMyEnum", XPBootstrap.eMyEnum)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "EnumTest", argTuple)
		return context.Sync()

	def StructTest( self, inStruct, inoutStruct, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inStruct: Argument 1
			inoutStruct: Argument 2
			Returns outStruct: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inStruct", inStruct, "in", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		arg1 = Aptixia_prv.MethodArgument( "inoutStruct", inoutStruct, "inout", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		arg2 = Aptixia_prv.MethodArgument( "outStruct", None, "out", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StructTest", argTuple, callback, callbackArg )
	def StructTest_Sync( self, inStruct, inoutStruct ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inStruct: Argument 1
			inoutStruct: Argument 2
			Returns outStruct: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inStruct", inStruct, "in", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		arg1 = Aptixia_prv.MethodArgument( "inoutStruct", inoutStruct, "inout", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		arg2 = Aptixia_prv.MethodArgument( "outStruct", None, "out", "XPBootstrap.MyStruct", XPBootstrap.MyStruct)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "StructTest", argTuple)
		return context.Sync()

	def ListTestInt8( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt8", argTuple, callback, callbackArg )
	def ListTestInt8_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt8", XPBootstrap.ListInt8)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt8", argTuple)
		return context.Sync()

	def ListTestInt16( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt16", argTuple, callback, callbackArg )
	def ListTestInt16_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt16", XPBootstrap.ListInt16)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt16", argTuple)
		return context.Sync()

	def ListTestInt32( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 1
			Returns outList: Argument 1 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt32", argTuple, callback, callbackArg )
	def ListTestInt32_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 1
			Returns outList: Argument 1 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt32", XPBootstrap.ListInt32)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt32", argTuple)
		return context.Sync()

	def ListTestInt64( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt64", argTuple, callback, callbackArg )
	def ListTestInt64_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListInt64", XPBootstrap.ListInt64)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestInt64", argTuple)
		return context.Sync()

	def ListTestBool( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestBool", argTuple, callback, callbackArg )
	def ListTestBool_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListBool", XPBootstrap.ListBool)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestBool", argTuple)
		return context.Sync()

	def ListTestDouble( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestDouble", argTuple, callback, callbackArg )
	def ListTestDouble_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListDouble", XPBootstrap.ListDouble)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestDouble", argTuple)
		return context.Sync()

	def ListTestString( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListString", XPBootstrap.ListString)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListString", XPBootstrap.ListString)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListString", XPBootstrap.ListString)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestString", argTuple, callback, callbackArg )
	def ListTestString_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListString", XPBootstrap.ListString)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListString", XPBootstrap.ListString)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListString", XPBootstrap.ListString)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestString", argTuple)
		return context.Sync()

	def ListTestOctets( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestOctets", argTuple, callback, callbackArg )
	def ListTestOctets_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListOctets", XPBootstrap.ListOctets)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestOctets", argTuple)
		return context.Sync()

	def ListTestEnum( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestEnum", argTuple, callback, callbackArg )
	def ListTestEnum_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListEnum", XPBootstrap.ListEnum)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestEnum", argTuple)
		return context.Sync()

	def ListTestStruct( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestStruct", argTuple, callback, callbackArg )
	def ListTestStruct_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListStruct", XPBootstrap.ListStruct)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestStruct", argTuple)
		return context.Sync()

	def ListTestList( self, inList, inoutList, callback = None, callbackArg = None ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListList", XPBootstrap.ListList)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListList", XPBootstrap.ListList)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListList", XPBootstrap.ListList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestList", argTuple, callback, callbackArg )
	def ListTestList_Sync( self, inList, inoutList ):
		""" Basic types test. Returns argument 2 in argument 3and argument 1 in argument 2.
			inList: Argument 1
			inoutList: Argument 2
			Returns outList: Argument 3 """
		arg0 = Aptixia_prv.MethodArgument( "inList", inList, "in", "XPBootstrap.ListList", XPBootstrap.ListList)
		arg1 = Aptixia_prv.MethodArgument( "inoutList", inoutList, "inout", "XPBootstrap.ListList", XPBootstrap.ListList)
		arg2 = Aptixia_prv.MethodArgument( "outList", None, "out", "XPBootstrap.ListList", XPBootstrap.ListList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ListTestList", argTuple)
		return context.Sync()

	def ObjectTest( self, callback = None, callbackArg = None ):
		""" Returns a reference to self/this.
			Returns outObject: Reference to self/this """
		arg0 = Aptixia_prv.MethodArgument( "outObject", None, "out", "XPBootstrap", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ObjectTest", argTuple, callback, callbackArg )
	def ObjectTest_Sync( self ):
		""" Returns a reference to self/this.
			Returns outObject: Reference to self/this """
		arg0 = Aptixia_prv.MethodArgument( "outObject", None, "out", "XPBootstrap", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ObjectTest", argTuple)
		return context.Sync()

	def CreateTestObject( self, callback = None, callbackArg = None ):
		""" Creates an XPUnitTest regression object
			Returns unitTest: Reference to the created regression object """
		arg0 = Aptixia_prv.MethodArgument( "unitTest", None, "out", "XPUnitTest", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestObject", argTuple, callback, callbackArg )
	def CreateTestObject_Sync( self ):
		""" Creates an XPUnitTest regression object
			Returns unitTest: Reference to the created regression object """
		arg0 = Aptixia_prv.MethodArgument( "unitTest", None, "out", "XPUnitTest", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "CreateTestObject", argTuple)
		return context.Sync()

	def TestUserDefinedTypeScope( self, anEnum, aStruct, aList, callback = None, callbackArg = None ):
		""" Dummy call to test foreign scopes
			anEnum: An enum in a different scope
			aStruct: A structure in a different scope
			aList: A list in a different scope """
		arg0 = Aptixia_prv.MethodArgument( "anEnum", anEnum, "inout", "XPUnitTest.eUnitTestEnum", XPUnitTest.XPUnitTest.eUnitTestEnum)
		arg1 = Aptixia_prv.MethodArgument( "aStruct", aStruct, "inout", "XPUnitTest.UnitTestStruct", XPUnitTest.XPUnitTest.UnitTestStruct)
		arg2 = Aptixia_prv.MethodArgument( "aList", aList, "inout", "XPUnitTest.UnitTestList", XPUnitTest.XPUnitTest.UnitTestList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestUserDefinedTypeScope", argTuple, callback, callbackArg )
	def TestUserDefinedTypeScope_Sync( self, anEnum, aStruct, aList ):
		""" Dummy call to test foreign scopes
			anEnum: An enum in a different scope
			aStruct: A structure in a different scope
			aList: A list in a different scope """
		arg0 = Aptixia_prv.MethodArgument( "anEnum", anEnum, "inout", "XPUnitTest.eUnitTestEnum", XPUnitTest.XPUnitTest.eUnitTestEnum)
		arg1 = Aptixia_prv.MethodArgument( "aStruct", aStruct, "inout", "XPUnitTest.UnitTestStruct", XPUnitTest.XPUnitTest.UnitTestStruct)
		arg2 = Aptixia_prv.MethodArgument( "aList", aList, "inout", "XPUnitTest.UnitTestList", XPUnitTest.XPUnitTest.UnitTestList)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "TestUserDefinedTypeScope", argTuple)
		return context.Sync()


