import string, threading
import Aptixia, Aptixia_prv
import StatSpec
import StatFilter


class AggregatedStat( StatSpec.StatSpec ):
	""" A unique specification for a stat in StatView includes StatSpec plus a filter list """
	# Class Properties
	def _get_statFilterList (self):
		return self.getListVar ("statFilterList")
	statFilterList = property (_get_statFilterList, None, None, "statFilterList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( AggregatedStat, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["statFilterList"] = Aptixia.IxObjectList (self.transactionContext, "StatFilter")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "AggregatedStat"


