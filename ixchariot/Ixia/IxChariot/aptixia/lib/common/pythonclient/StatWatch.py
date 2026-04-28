import string, threading
import Aptixia, Aptixia_prv
import StatConsumer
import AggregatedStat


class StatWatch( StatConsumer.StatConsumer ):
	""" Deprecated """
	# Class Properties
	def _get_name (self):
		return self.getVar ("name")
	def _set_name (self, value):
		self.setVar ("name", value)
	name = property (_get_name, _set_name, None, "name property")
	def _get_frequency (self):
		return self.getVar ("frequency")
	def _set_frequency (self, value):
		self.setVar ("frequency", value)
	frequency = property (_get_frequency, _set_frequency, None, "frequency property")
	def _get_aggregatedStatList (self):
		return self.getListVar ("aggregatedStatList")
	aggregatedStatList = property (_get_aggregatedStatList, None, None, "aggregatedStatList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatWatch, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["name"] = ""
			self.managedProperties["frequency"] = float(1)
			self.managedProperties["aggregatedStatList"] = Aptixia.IxObjectList (self.transactionContext, "AggregatedStat")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatWatch"


