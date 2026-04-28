import string, threading
import Aptixia, Aptixia_prv
import XProtocolObject


class Pppoe( XProtocolObject.XProtocolObject ):
	# Class Properties
	def _get_padiTimeout (self):
		return self.getVar ("padiTimeout")
	def _set_padiTimeout (self, value):
		self.setVar ("padiTimeout", value)
	padiTimeout = property (_get_padiTimeout, _set_padiTimeout, None, "padiTimeout property")
	def _get_padiRetries (self):
		return self.getVar ("padiRetries")
	def _set_padiRetries (self, value):
		self.setVar ("padiRetries", value)
	padiRetries = property (_get_padiRetries, _set_padiRetries, None, "padiRetries property")
	def _get_padrTimeout (self):
		return self.getVar ("padrTimeout")
	def _set_padrTimeout (self, value):
		self.setVar ("padrTimeout", value)
	padrTimeout = property (_get_padrTimeout, _set_padrTimeout, None, "padrTimeout property")
	def _get_padrRetries (self):
		return self.getVar ("padrRetries")
	def _set_padrRetries (self, value):
		self.setVar ("padrRetries", value)
	padrRetries = property (_get_padrRetries, _set_padrRetries, None, "padrRetries property")
	def _get_serviceName (self):
		return self.getVar ("serviceName")
	def _set_serviceName (self, value):
		self.setVar ("serviceName", value)
	serviceName = property (_get_serviceName, _set_serviceName, None, "serviceName property")
	def _get_acName (self):
		return self.getVar ("acName")
	def _set_acName (self, value):
		self.setVar ("acName", value)
	acName = property (_get_acName, _set_acName, None, "acName property")
	def _get_enableRedial (self):
		return self.getVar ("enableRedial")
	def _set_enableRedial (self, value):
		self.setVar ("enableRedial", value)
	enableRedial = property (_get_enableRedial, _set_enableRedial, None, "enableRedial property")
	def _get_redialTimeout (self):
		return self.getVar ("redialTimeout")
	def _set_redialTimeout (self, value):
		self.setVar ("redialTimeout", value)
	redialTimeout = property (_get_redialTimeout, _set_redialTimeout, None, "redialTimeout property")
	def _get_redialMax (self):
		return self.getVar ("redialMax")
	def _set_redialMax (self, value):
		self.setVar ("redialMax", value)
	redialMax = property (_get_redialMax, _set_redialMax, None, "redialMax property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( Pppoe, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["padiTimeout"] = 10
			self.managedProperties["padiRetries"] = 3
			self.managedProperties["padrTimeout"] = 10
			self.managedProperties["padrRetries"] = 3
			self.managedProperties["serviceName"] = ""
			self.managedProperties["acName"] = ""
			self.managedProperties["enableRedial"] = False
			self.managedProperties["redialTimeout"] = 10
			self.managedProperties["redialMax"] = 20

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "Pppoe"


