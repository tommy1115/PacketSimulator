import string, threading
import Aptixia, Aptixia_prv
import SonetATMBasePlugin
import AtmRange, PvcRange


class ATMPlugin( SonetATMBasePlugin.SonetATMBasePlugin ):
	""" ATM Plugin configures ATM settings on ATM ports. """
	# Class Properties
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_atmInterfaceType (self):
		return self.getVar ("atmInterfaceType")
	def _set_atmInterfaceType (self, value):
		self.setVar ("atmInterfaceType", value)
	atmInterfaceType = property (_get_atmInterfaceType, _set_atmInterfaceType, None, "atmInterfaceType property")
	def _get_cosetEnable (self):
		return self.getVar ("cosetEnable")
	def _set_cosetEnable (self, value):
		self.setVar ("cosetEnable", value)
	cosetEnable = property (_get_cosetEnable, _set_cosetEnable, None, "cosetEnable property")
	def _get_fillerCell (self):
		return self.getVar ("fillerCell")
	def _set_fillerCell (self, value):
		self.setVar ("fillerCell", value)
	fillerCell = property (_get_fillerCell, _set_fillerCell, None, "fillerCell property")
	def _get_atmPatternMatching (self):
		return self.getVar ("atmPatternMatching")
	def _set_atmPatternMatching (self, value):
		self.setVar ("atmPatternMatching", value)
	atmPatternMatching = property (_get_atmPatternMatching, _set_atmPatternMatching, None, "atmPatternMatching property")
	def _get_reassemblyTimeout (self):
		return self.getVar ("reassemblyTimeout")
	def _set_reassemblyTimeout (self, value):
		self.setVar ("reassemblyTimeout", value)
	reassemblyTimeout = property (_get_reassemblyTimeout, _set_reassemblyTimeout, None, "reassemblyTimeout property")
	def _get_atmRangeList (self):
		return self.getListVar ("atmRangeList")
	atmRangeList = property (_get_atmRangeList, None, None, "atmRangeList property")
	def _get_pvcRangeList (self):
		return self.getListVar ("pvcRangeList")
	pvcRangeList = property (_get_pvcRangeList, None, None, "pvcRangeList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ATMPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["enabled"] = True
			self.managedProperties["atmInterfaceType"] = "kUNI"
			self.managedProperties["cosetEnable"] = False
			self.managedProperties["fillerCell"] = "kUnassigned"
			self.managedProperties["atmPatternMatching"] = True
			self.managedProperties["reassemblyTimeout"] = 10
			self.managedProperties["atmRangeList"] = Aptixia.IxObjectList (self.transactionContext, "AtmRange")
			self.managedProperties["pvcRangeList"] = Aptixia.IxObjectList (self.transactionContext, "PvcRange")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ATMPlugin"


