import string, threading
import Aptixia, Aptixia_prv
import ChartAxis


class ChartYAxis( ChartAxis.ChartAxis ):
	""" X Axis Properties for StatViewer Charts """
	# Class Properties
	def _get_yAxisExtent (self):
		return self.getVar ("yAxisExtent")
	def _set_yAxisExtent (self, value):
		self.setVar ("yAxisExtent", value)
	yAxisExtent = property (_get_yAxisExtent, _set_yAxisExtent, None, "yAxisExtent property")
	def _get_yAxisRange (self):
		return self.getVar ("yAxisRange")
	def _set_yAxisRange (self, value):
		self.setVar ("yAxisRange", value)
	yAxisRange = property (_get_yAxisRange, _set_yAxisRange, None, "yAxisRange property")
	def _get_yAxisRangeMax (self):
		return self.getVar ("yAxisRangeMax")
	def _set_yAxisRangeMax (self, value):
		self.setVar ("yAxisRangeMax", value)
	yAxisRangeMax = property (_get_yAxisRangeMax, _set_yAxisRangeMax, None, "yAxisRangeMax property")
	def _get_yAxisRangeMin (self):
		return self.getVar ("yAxisRangeMin")
	def _set_yAxisRangeMin (self, value):
		self.setVar ("yAxisRangeMin", value)
	yAxisRangeMin = property (_get_yAxisRangeMin, _set_yAxisRangeMin, None, "yAxisRangeMin property")
	def _get_autoScale (self):
		return self.getVar ("autoScale")
	def _set_autoScale (self, value):
		self.setVar ("autoScale", value)
	autoScale = property (_get_autoScale, _set_autoScale, None, "autoScale property")
	def _get_logScale (self):
		return self.getVar ("logScale")
	def _set_logScale (self, value):
		self.setVar ("logScale", value)
	logScale = property (_get_logScale, _set_logScale, None, "logScale property")
	def _get_yAxisScrollScale (self):
		return self.getVar ("yAxisScrollScale")
	def _set_yAxisScrollScale (self, value):
		self.setVar ("yAxisScrollScale", value)
	yAxisScrollScale = property (_get_yAxisScrollScale, _set_yAxisScrollScale, None, "yAxisScrollScale property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ChartYAxis, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["yAxisExtent"] = 85
			self.managedProperties["yAxisRange"] = "Auto"
			self.managedProperties["yAxisRangeMax"] = 100
			self.managedProperties["yAxisRangeMin"] = 0
			self.managedProperties["autoScale"] = False
			self.managedProperties["logScale"] = False
			self.managedProperties["yAxisScrollScale"] = True

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ChartYAxis"


