import string, threading
import Aptixia, Aptixia_prv
import GlobalPlugin


class FilterPlugin( GlobalPlugin.GlobalPlugin ):
	""" FilterPlugin configures filter settings on a port. """
	# Class Properties
	def _get_initialAction (self):
		return self.getVar ("initialAction")
	def _set_initialAction (self, value):
		self.setVar ("initialAction", value)
	initialAction = property (_get_initialAction, _set_initialAction, None, "initialAction property")
	def _get_all (self):
		return self.getVar ("all")
	def _set_all (self, value):
		self.setVar ("all", value)
	all = property (_get_all, _set_all, None, "all property")
	def _get_pppoecontrol (self):
		return self.getVar ("pppoecontrol")
	def _set_pppoecontrol (self, value):
		self.setVar ("pppoecontrol", value)
	pppoecontrol = property (_get_pppoecontrol, _set_pppoecontrol, None, "pppoecontrol property")
	def _get_pppoenetwork (self):
		return self.getVar ("pppoenetwork")
	def _set_pppoenetwork (self, value):
		self.setVar ("pppoenetwork", value)
	pppoenetwork = property (_get_pppoenetwork, _set_pppoenetwork, None, "pppoenetwork property")
	def _get_isis (self):
		return self.getVar ("isis")
	def _set_isis (self, value):
		self.setVar ("isis", value)
	isis = property (_get_isis, _set_isis, None, "isis property")
	def _get_ip (self):
		return self.getVar ("ip")
	def _set_ip (self, value):
		self.setVar ("ip", value)
	ip = property (_get_ip, _set_ip, None, "ip property")
	def _get_tcp (self):
		return self.getVar ("tcp")
	def _set_tcp (self, value):
		self.setVar ("tcp", value)
	tcp = property (_get_tcp, _set_tcp, None, "tcp property")
	def _get_udp (self):
		return self.getVar ("udp")
	def _set_udp (self, value):
		self.setVar ("udp", value)
	udp = property (_get_udp, _set_udp, None, "udp property")
	def _get_mac (self):
		return self.getVar ("mac")
	def _set_mac (self, value):
		self.setVar ("mac", value)
	mac = property (_get_mac, _set_mac, None, "mac property")
	def _get_icmp (self):
		return self.getVar ("icmp")
	def _set_icmp (self, value):
		self.setVar ("icmp", value)
	icmp = property (_get_icmp, _set_icmp, None, "icmp property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( FilterPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["initialAction"] = "reset"
			self.managedProperties["all"] = True
			self.managedProperties["pppoecontrol"] = False
			self.managedProperties["pppoenetwork"] = False
			self.managedProperties["isis"] = False
			self.managedProperties["ip"] = ""
			self.managedProperties["tcp"] = ""
			self.managedProperties["udp"] = ""
			self.managedProperties["mac"] = ""
			self.managedProperties["icmp"] = ""

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "FilterPlugin"


