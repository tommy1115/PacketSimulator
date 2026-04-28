import string, threading
import Aptixia, Aptixia_prv
import TreeNode


class CsvHeaderField( TreeNode.TreeNode ):
	""" Generated csv file can have a list of name, value pair values written at the top. This object represents one such pair. """
	# Class Properties
	def _get_sequenceNumber (self):
		return self.getVar ("sequenceNumber")
	def _set_sequenceNumber (self, value):
		self.setVar ("sequenceNumber", value)
	sequenceNumber = property (_get_sequenceNumber, _set_sequenceNumber, None, "sequenceNumber property")
	def _get_fieldName (self):
		return self.getVar ("fieldName")
	def _set_fieldName (self, value):
		self.setVar ("fieldName", value)
	fieldName = property (_get_fieldName, _set_fieldName, None, "fieldName property")
	def _get_fieldValue (self):
		return self.getVar ("fieldValue")
	def _set_fieldValue (self, value):
		self.setVar ("fieldValue", value)
	fieldValue = property (_get_fieldValue, _set_fieldValue, None, "fieldValue property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( CsvHeaderField, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["sequenceNumber"] = 0
			self.managedProperties["fieldName"] = "0"
			self.managedProperties["fieldValue"] = "0"

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "CsvHeaderField"


