import string, threading
import Aptixia, Aptixia_prv
import ChartAxis


class ChartXAxis( ChartAxis.ChartAxis ):
	""" X Axis Properties for StatViewer Charts """
	# Class Properties
	def _get_scrollScale (self):
		return self.getVar ("scrollScale")
	def _set_scrollScale (self, value):
		self.setVar ("scrollScale", value)
	scrollScale = property (_get_scrollScale, _set_scrollScale, None, "scrollScale property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ChartXAxis, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["scrollScale"] = True

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ChartXAxis"


