import string, threading
import Aptixia, Aptixia_prv
import ServiceExtension


class StackManagerApp( ServiceExtension.ServiceExtension ):
	# Class Properties
	def _get_defaultImportExportDirectory (self):
		return self.getVar ("defaultImportExportDirectory")
	def _set_defaultImportExportDirectory (self, value):
		self.setVar ("defaultImportExportDirectory", value)
	defaultImportExportDirectory = property (_get_defaultImportExportDirectory, _set_defaultImportExportDirectory, None, "defaultImportExportDirectory property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StackManagerApp, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["defaultImportExportDirectory"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StackManagerApp"


