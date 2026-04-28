import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class DataDrivenFormBase( XProtocolObject.XProtocolObject ):
	""" This is the base class for configurable objects that are to be usedby Aptixia's data driven GUI system. It has no data members, butprovides methods for setting and getting the layout of the formused to render the form for this object. Note that the files needto be checked out from source control to set them. """
	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DataDrivenFormBase, self ).__init__(parent, objectId, transactionContext, preFetch)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DataDrivenFormBase"

	# Class Methods
	def GetFormLayout( self, filename, callback = None, callbackArg = None ):
		""" Returns XML layout from given XML file
			filename: File name
			Returns xml: XML layout from given XML file """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetFormLayout", argTuple, callback, callbackArg )
	def GetFormLayout_Sync( self, filename ):
		""" Returns XML layout from given XML file
			filename: File name
			Returns xml: XML layout from given XML file """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", None, "out", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetFormLayout", argTuple)
		return context.Sync()

	def SetFormLayout( self, filename, xml, callback = None, callbackArg = None ):
		""" Saves XML layout to the given XML file
			filename: File name
			xml: XML layout to save """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFormLayout", argTuple, callback, callbackArg )
	def SetFormLayout_Sync( self, filename, xml ):
		""" Saves XML layout to the given XML file
			filename: File name
			xml: XML layout to save """
		arg0 = Aptixia_prv.MethodArgument( "filename", filename, "in", "string", None)
		arg1 = Aptixia_prv.MethodArgument( "xml", xml, "in", "string", None)
		argTuple = ( arg0, arg1, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SetFormLayout", argTuple)
		return context.Sync()


