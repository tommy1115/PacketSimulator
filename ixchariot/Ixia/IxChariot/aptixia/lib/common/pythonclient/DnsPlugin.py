import string, threading
import Aptixia, Aptixia_prv
import GlobalPlugin
import DnsNameServer, DnsSearch, DnsHost


class DnsPlugin( GlobalPlugin.GlobalPlugin ):
	""" Contains the settings from resolv.conf and hosts """
	# Class Properties
	def _get_domain (self):
		return self.getVar ("domain")
	def _set_domain (self, value):
		self.setVar ("domain", value)
	domain = property (_get_domain, _set_domain, None, "domain property")
	def _get_timeout (self):
		return self.getVar ("timeout")
	def _set_timeout (self, value):
		self.setVar ("timeout", value)
	timeout = property (_get_timeout, _set_timeout, None, "timeout property")
	def _get_nameServerList (self):
		return self.getListVar ("nameServerList")
	nameServerList = property (_get_nameServerList, None, None, "nameServerList property")
	def _get_searchList (self):
		return self.getListVar ("searchList")
	searchList = property (_get_searchList, None, None, "searchList property")
	def _get_hostList (self):
		return self.getListVar ("hostList")
	hostList = property (_get_hostList, None, None, "hostList property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( DnsPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["domain"] = ""
			self.managedProperties["timeout"] = 5
			self.managedProperties["nameServerList"] = Aptixia.IxObjectList (self.transactionContext, "DnsNameServer")
			self.managedProperties["searchList"] = Aptixia.IxObjectList (self.transactionContext, "DnsSearch")
			self.managedProperties["hostList"] = Aptixia.IxObjectList (self.transactionContext, "DnsHost")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "DnsPlugin"


