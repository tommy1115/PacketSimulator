import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject
import NodeTestB, NodeTestA


class NodeTest( XProtocolObject.XProtocolObject ):
	""" NodeTest is one of the unit test classes. It is used for testingCORBA access to TestServer. """
	# Class Properties
	def _get_intVar (self):
		return self.getVar ("intVar")
	def _set_intVar (self, value):
		self.setVar ("intVar", value)
	intVar = property (_get_intVar, _set_intVar, None, "intVar property")
	def _get_intVarNoLimits (self):
		return self.getVar ("intVarNoLimits")
	def _set_intVarNoLimits (self, value):
		self.setVar ("intVarNoLimits", value)
	intVarNoLimits = property (_get_intVarNoLimits, _set_intVarNoLimits, None, "intVarNoLimits property")
	def _get_booleanVar (self):
		return self.getVar ("booleanVar")
	def _set_booleanVar (self, value):
		self.setVar ("booleanVar", value)
	booleanVar = property (_get_booleanVar, _set_booleanVar, None, "booleanVar property")
	def _get_doubleVar (self):
		return self.getVar ("doubleVar")
	def _set_doubleVar (self, value):
		self.setVar ("doubleVar", value)
	doubleVar = property (_get_doubleVar, _set_doubleVar, None, "doubleVar property")
	def _get_doubleVarNoLimits (self):
		return self.getVar ("doubleVarNoLimits")
	def _set_doubleVarNoLimits (self, value):
		self.setVar ("doubleVarNoLimits", value)
	doubleVarNoLimits = property (_get_doubleVarNoLimits, _set_doubleVarNoLimits, None, "doubleVarNoLimits property")
	def _get_stringVar (self):
		return self.getVar ("stringVar")
	def _set_stringVar (self, value):
		self.setVar ("stringVar", value)
	stringVar = property (_get_stringVar, _set_stringVar, None, "stringVar property")
	def _get_intListVar (self):
		return self.getListVar ("intListVar")
	intListVar = property (_get_intListVar, None, None, "intListVar property")
	def _get_doubleListVar (self):
		return self.getListVar ("doubleListVar")
	doubleListVar = property (_get_doubleListVar, None, None, "doubleListVar property")
	def _get_stringListVar (self):
		return self.getListVar ("stringListVar")
	stringListVar = property (_get_stringListVar, None, None, "stringListVar property")
	def _get_subNode (self):
		return self.getListVar ("subNode")
	subNode = property (_get_subNode, None, None, "subNode property")
	def _get_subNodeList (self):
		return self.getListVar ("subNodeList")
	subNodeList = property (_get_subNodeList, None, None, "subNodeList property")
	def _get_subNodePolymorphic (self):
		return self.getListVar ("subNodePolymorphic")
	def _set_subNodePolymorphic (self, value):
		self.setVar ("subNodePolymorphic", value)
	subNodePolymorphic = property (_get_subNodePolymorphic, _set_subNodePolymorphic, None, "subNodePolymorphic property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( NodeTest, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["intVar"] = 5
			self.managedProperties["intVarNoLimits"] = 5
			self.managedProperties["booleanVar"] = False
			self.managedProperties["doubleVar"] = float(300.5)
			self.managedProperties["doubleVarNoLimits"] = float(300.5)
			self.managedProperties["stringVar"] = "default string"
			self.managedProperties["intListVar"] = Aptixia.IxList ("int")
			self.managedProperties["doubleListVar"] = Aptixia.IxList ("double")
			self.managedProperties["stringListVar"] = Aptixia.IxList ("string")
			self.managedProperties["subNode"] = NodeTestB.NodeTestB (self)
			self.managedProperties["subNodeList"] = Aptixia.IxObjectList (self.transactionContext, "NodeTestB")
			self.managedProperties["subNodePolymorphic"] = None

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "NodeTest"


