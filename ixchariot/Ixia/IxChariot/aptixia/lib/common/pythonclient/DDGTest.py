import string, threading
import Aptixia, Aptixia_prv
import DataDrivenFormBase
import NodeTestB


class DDGTest( DataDrivenFormBase.DataDrivenFormBase ):
	""" Provides Unit Test facility for Data Driven Form """
	# Class Properties
	def _get_intVar1 (self):
		return self.getVar ("intVar1")
	def _set_intVar1 (self, value):
		self.setVar ("intVar1", value)
	intVar1 = property (_get_intVar1, _set_intVar1, None, "intVar1 property")
	def _get_intVar2 (self):
		return self.getVar ("intVar2")
	def _set_intVar2 (self, value):
		self.setVar ("intVar2", value)
	intVar2 = property (_get_intVar2, _set_intVar2, None, "intVar2 property")
	def _get_booleanVar1 (self):
		return self.getVar ("booleanVar1")
	def _set_booleanVar1 (self, value):
		self.setVar ("booleanVar1", value)
	booleanVar1 = property (_get_booleanVar1, _set_booleanVar1, None, "booleanVar1 property")
	def _get_booleanVar2 (self):
		return self.getVar ("booleanVar2")
	def _set_booleanVar2 (self, value):
		self.setVar ("booleanVar2", value)
	booleanVar2 = property (_get_booleanVar2, _set_booleanVar2, None, "booleanVar2 property")
	def _get_doubleVar1 (self):
		return self.getVar ("doubleVar1")
	def _set_doubleVar1 (self, value):
		self.setVar ("doubleVar1", value)
	doubleVar1 = property (_get_doubleVar1, _set_doubleVar1, None, "doubleVar1 property")
	def _get_doubleVar2 (self):
		return self.getVar ("doubleVar2")
	def _set_doubleVar2 (self, value):
		self.setVar ("doubleVar2", value)
	doubleVar2 = property (_get_doubleVar2, _set_doubleVar2, None, "doubleVar2 property")
	def _get_stringVar1 (self):
		return self.getVar ("stringVar1")
	def _set_stringVar1 (self, value):
		self.setVar ("stringVar1", value)
	stringVar1 = property (_get_stringVar1, _set_stringVar1, None, "stringVar1 property")
	def _get_stringVar2 (self):
		return self.getVar ("stringVar2")
	def _set_stringVar2 (self, value):
		self.setVar ("stringVar2", value)
	stringVar2 = property (_get_stringVar2, _set_stringVar2, None, "stringVar2 property")
	def _get_stringVar3 (self):
		return self.getVar ("stringVar3")
	def _set_stringVar3 (self, value):
		self.setVar ("stringVar3", value)
	stringVar3 = property (_get_stringVar3, _set_stringVar3, None, "stringVar3 property")
	def _get_list (self):
		return self.getListVar ("list")
	list = property (_get_list, None, None, "list property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DDGTest, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["intVar1"] = 2
			self.managedProperties["intVar2"] = 0
			self.managedProperties["booleanVar1"] = False
			self.managedProperties["booleanVar2"] = False
			self.managedProperties["doubleVar1"] = float(300.5)
			self.managedProperties["doubleVar2"] = float(300.5)
			self.managedProperties["stringVar1"] = "2"
			self.managedProperties["stringVar2"] = "0"
			self.managedProperties["stringVar3"] = ""
			self.managedProperties["list"] = Aptixia.IxObjectList (self.transactionContext, "NodeTestB")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DDGTest"


