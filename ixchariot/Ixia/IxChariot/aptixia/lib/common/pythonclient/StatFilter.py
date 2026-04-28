import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class StatFilter( XProtocolObject.XProtocolObject ):
	""" A filter applied to the statistic.  The source application may define oneor more filters you can select from. If you select a filter, only the values forthe statistic that pass through that filter are displayed. For example, if you areconfiguring a statistic for packets transmitted and the source application allowsyou to filter for a particular port, such as port 1.1.1, the graph will only displaythe packets transmitted from port 1.1.1. """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_valueList (self):
		return self.getListVar ("valueList")
	valueList = property (_get_valueList, None, None, "valueList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatFilter, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["valueList"] = Aptixia.IxList ("string")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatFilter"


