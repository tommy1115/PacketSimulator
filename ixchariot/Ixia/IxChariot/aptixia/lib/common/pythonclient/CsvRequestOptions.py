import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class CsvRequestOptions( XProtocolObject.XProtocolObject ):
	""" Any statview can be output to a csv file during test run. These options allows api users to specify, among other things, wether the csv file is to be generated. """
	# Class Properties
	def _get_outputCsv (self):
		return self.getVar ("outputCsv")
	def _set_outputCsv (self, value):
		self.setVar ("outputCsv", value)
	outputCsv = property (_get_outputCsv, _set_outputCsv, None, "outputCsv property")
	def _get_outputFileHeader (self):
		return self.getVar ("outputFileHeader")
	def _set_outputFileHeader (self, value):
		self.setVar ("outputFileHeader", value)
	outputFileHeader = property (_get_outputFileHeader, _set_outputFileHeader, None, "outputFileHeader property")
	def _get_outputColumnHeader (self):
		return self.getVar ("outputColumnHeader")
	def _set_outputColumnHeader (self, value):
		self.setVar ("outputColumnHeader", value)
	outputColumnHeader = property (_get_outputColumnHeader, _set_outputColumnHeader, None, "outputColumnHeader property")
	def _get_outputFunctionHeader (self):
		return self.getVar ("outputFunctionHeader")
	def _set_outputFunctionHeader (self, value):
		self.setVar ("outputFunctionHeader", value)
	outputFunctionHeader = property (_get_outputFunctionHeader, _set_outputFunctionHeader, None, "outputFunctionHeader property")
	def _get_outputLabelHeader (self):
		return self.getVar ("outputLabelHeader")
	def _set_outputLabelHeader (self, value):
		self.setVar ("outputLabelHeader", value)
	outputLabelHeader = property (_get_outputLabelHeader, _set_outputLabelHeader, None, "outputLabelHeader property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( CsvRequestOptions, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["outputCsv"] = False
			self.managedProperties["outputFileHeader"] = False
			self.managedProperties["outputColumnHeader"] = False
			self.managedProperties["outputFunctionHeader"] = False
			self.managedProperties["outputLabelHeader"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "CsvRequestOptions"


