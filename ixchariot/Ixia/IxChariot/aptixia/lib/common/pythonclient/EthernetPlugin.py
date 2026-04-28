import string, threading
import Aptixia, Aptixia_prv
import HardwarePlugin
import MacRange, VlanIdRange


class EthernetPlugin( HardwarePlugin.HardwarePlugin ):
	""" Configures Ethernet interfaces on Ethernet ports. """
	# Class Properties
	def _get_macRangeList (self):
		return self.getListVar ("macRangeList")
	macRangeList = property (_get_macRangeList, None, None, "macRangeList property")
	def _get_vlanRangeList (self):
		return self.getListVar ("vlanRangeList")
	vlanRangeList = property (_get_vlanRangeList, None, None, "vlanRangeList property")
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_autoNegotiate (self):
		return self.getVar ("autoNegotiate")
	def _set_autoNegotiate (self, value):
		self.setVar ("autoNegotiate", value)
	autoNegotiate = property (_get_autoNegotiate, _set_autoNegotiate, None, "autoNegotiate property")
	def _get_speed (self):
		return self.getVar ("speed")
	def _set_speed (self, value):
		self.setVar ("speed", value)
	speed = property (_get_speed, _set_speed, None, "speed property")
	def _get_advertise10Half (self):
		return self.getVar ("advertise10Half")
	def _set_advertise10Half (self, value):
		self.setVar ("advertise10Half", value)
	advertise10Half = property (_get_advertise10Half, _set_advertise10Half, None, "advertise10Half property")
	def _get_advertise10Full (self):
		return self.getVar ("advertise10Full")
	def _set_advertise10Full (self, value):
		self.setVar ("advertise10Full", value)
	advertise10Full = property (_get_advertise10Full, _set_advertise10Full, None, "advertise10Full property")
	def _get_advertise100Half (self):
		return self.getVar ("advertise100Half")
	def _set_advertise100Half (self, value):
		self.setVar ("advertise100Half", value)
	advertise100Half = property (_get_advertise100Half, _set_advertise100Half, None, "advertise100Half property")
	def _get_advertise100Full (self):
		return self.getVar ("advertise100Full")
	def _set_advertise100Full (self, value):
		self.setVar ("advertise100Full", value)
	advertise100Full = property (_get_advertise100Full, _set_advertise100Full, None, "advertise100Full property")
	def _get_advertise1000Full (self):
		return self.getVar ("advertise1000Full")
	def _set_advertise1000Full (self, value):
		self.setVar ("advertise1000Full", value)
	advertise1000Full = property (_get_advertise1000Full, _set_advertise1000Full, None, "advertise1000Full property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( EthernetPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["macRangeList"] = Aptixia.IxObjectList (self.transactionContext, "MacRange")
			self.managedProperties["vlanRangeList"] = Aptixia.IxObjectList (self.transactionContext, "VlanIdRange")
			self.managedProperties["enabled"] = True
			self.managedProperties["autoNegotiate"] = True
			self.managedProperties["speed"] = "k100FD"
			self.managedProperties["advertise10Half"] = True
			self.managedProperties["advertise10Full"] = True
			self.managedProperties["advertise100Half"] = True
			self.managedProperties["advertise100Full"] = True
			self.managedProperties["advertise1000Full"] = True

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "EthernetPlugin"


