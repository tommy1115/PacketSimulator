import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin


class ImpairmentPlugin( StackElementPlugin.StackElementPlugin ):
	""" Impairment plugin configures interfaces on the Port CPU to impair selected outgoing traffic.Impairment configuration specifies the type of impairment and the filter configuration specifies the selection criteria. """
	# Class Properties
	def _get_addDelay (self):
		return self.getVar ("addDelay")
	def _set_addDelay (self, value):
		self.setVar ("addDelay", value)
	addDelay = property (_get_addDelay, _set_addDelay, None, "addDelay property")
	def _get_addReorder (self):
		return self.getVar ("addReorder")
	def _set_addReorder (self, value):
		self.setVar ("addReorder", value)
	addReorder = property (_get_addReorder, _set_addReorder, None, "addReorder property")
	def _get_addDrop (self):
		return self.getVar ("addDrop")
	def _set_addDrop (self, value):
		self.setVar ("addDrop", value)
	addDrop = property (_get_addDrop, _set_addDrop, None, "addDrop property")
	def _get_addDuplicate (self):
		return self.getVar ("addDuplicate")
	def _set_addDuplicate (self, value):
		self.setVar ("addDuplicate", value)
	addDuplicate = property (_get_addDuplicate, _set_addDuplicate, None, "addDuplicate property")
	def _get_addBandwidth (self):
		return self.getVar ("addBandwidth")
	def _set_addBandwidth (self, value):
		self.setVar ("addBandwidth", value)
	addBandwidth = property (_get_addBandwidth, _set_addBandwidth, None, "addBandwidth property")
	def _get_randomizeSeed (self):
		return self.getVar ("randomizeSeed")
	def _set_randomizeSeed (self, value):
		self.setVar ("randomizeSeed", value)
	randomizeSeed = property (_get_randomizeSeed, _set_randomizeSeed, None, "randomizeSeed property")
	def _get_delay (self):
		return self.getVar ("delay")
	def _set_delay (self, value):
		self.setVar ("delay", value)
	delay = property (_get_delay, _set_delay, None, "delay property")
	def _get_reorder (self):
		return self.getVar ("reorder")
	def _set_reorder (self, value):
		self.setVar ("reorder", value)
	reorder = property (_get_reorder, _set_reorder, None, "reorder property")
	def _get_reorderLength (self):
		return self.getVar ("reorderLength")
	def _set_reorderLength (self, value):
		self.setVar ("reorderLength", value)
	reorderLength = property (_get_reorderLength, _set_reorderLength, None, "reorderLength property")
	def _get_destinationIp (self):
		return self.getVar ("destinationIp")
	def _set_destinationIp (self, value):
		self.setVar ("destinationIp", value)
	destinationIp = property (_get_destinationIp, _set_destinationIp, None, "destinationIp property")
	def _get_sourcePort (self):
		return self.getVar ("sourcePort")
	def _set_sourcePort (self, value):
		self.setVar ("sourcePort", value)
	sourcePort = property (_get_sourcePort, _set_sourcePort, None, "sourcePort property")
	def _get_destinationPort (self):
		return self.getVar ("destinationPort")
	def _set_destinationPort (self, value):
		self.setVar ("destinationPort", value)
	destinationPort = property (_get_destinationPort, _set_destinationPort, None, "destinationPort property")
	def _get_protocol (self):
		return self.getVar ("protocol")
	def _set_protocol (self, value):
		self.setVar ("protocol", value)
	protocol = property (_get_protocol, _set_protocol, None, "protocol property")
	def _get_typeOfService (self):
		return self.getVar ("typeOfService")
	def _set_typeOfService (self, value):
		self.setVar ("typeOfService", value)
	typeOfService = property (_get_typeOfService, _set_typeOfService, None, "typeOfService property")
	def _get_bandwidthUnits (self):
		return self.getVar ("bandwidthUnits")
	def _set_bandwidthUnits (self, value):
		self.setVar ("bandwidthUnits", value)
	bandwidthUnits = property (_get_bandwidthUnits, _set_bandwidthUnits, None, "bandwidthUnits property")
	def _get_drop (self):
		return self.getVar ("drop")
	def _set_drop (self, value):
		self.setVar ("drop", value)
	drop = property (_get_drop, _set_drop, None, "drop property")
	def _get_duplicate (self):
		return self.getVar ("duplicate")
	def _set_duplicate (self, value):
		self.setVar ("duplicate", value)
	duplicate = property (_get_duplicate, _set_duplicate, None, "duplicate property")
	def _get_jitter (self):
		return self.getVar ("jitter")
	def _set_jitter (self, value):
		self.setVar ("jitter", value)
	jitter = property (_get_jitter, _set_jitter, None, "jitter property")
	def _get_gap (self):
		return self.getVar ("gap")
	def _set_gap (self, value):
		self.setVar ("gap", value)
	gap = property (_get_gap, _set_gap, None, "gap property")
	def _get_bandwidth (self):
		return self.getVar ("bandwidth")
	def _set_bandwidth (self, value):
		self.setVar ("bandwidth", value)
	bandwidth = property (_get_bandwidth, _set_bandwidth, None, "bandwidth property")
	def _get_seed (self):
		return self.getVar ("seed")
	def _set_seed (self, value):
		self.setVar ("seed", value)
	seed = property (_get_seed, _set_seed, None, "seed property")
	def _get_impairGlobal (self):
		return self.getVar ("impairGlobal")
	def _set_impairGlobal (self, value):
		self.setVar ("impairGlobal", value)
	impairGlobal = property (_get_impairGlobal, _set_impairGlobal, None, "impairGlobal property")
	def _get_addDropSequence (self):
		return self.getVar ("addDropSequence")
	def _set_addDropSequence (self, value):
		self.setVar ("addDropSequence", value)
	addDropSequence = property (_get_addDropSequence, _set_addDropSequence, None, "addDropSequence property")
	def _get_dropSequenceSkip (self):
		return self.getVar ("dropSequenceSkip")
	def _set_dropSequenceSkip (self, value):
		self.setVar ("dropSequenceSkip", value)
	dropSequenceSkip = property (_get_dropSequenceSkip, _set_dropSequenceSkip, None, "dropSequenceSkip property")
	def _get_dropSequenceLength (self):
		return self.getVar ("dropSequenceLength")
	def _set_dropSequenceLength (self, value):
		self.setVar ("dropSequenceLength", value)
	dropSequenceLength = property (_get_dropSequenceLength, _set_dropSequenceLength, None, "dropSequenceLength property")
	def _get_addReorderPI (self):
		return self.getVar ("addReorderPI")
	def _set_addReorderPI (self, value):
		self.setVar ("addReorderPI", value)
	addReorderPI = property (_get_addReorderPI, _set_addReorderPI, None, "addReorderPI property")
	def _get_reorderPISkip (self):
		return self.getVar ("reorderPISkip")
	def _set_reorderPISkip (self, value):
		self.setVar ("reorderPISkip", value)
	reorderPISkip = property (_get_reorderPISkip, _set_reorderPISkip, None, "reorderPISkip property")
	def _get_reorderPILength (self):
		return self.getVar ("reorderPILength")
	def _set_reorderPILength (self, value):
		self.setVar ("reorderPILength", value)
	reorderPILength = property (_get_reorderPILength, _set_reorderPILength, None, "reorderPILength property")
	def _get_reorderPIInterval (self):
		return self.getVar ("reorderPIInterval")
	def _set_reorderPIInterval (self, value):
		self.setVar ("reorderPIInterval", value)
	reorderPIInterval = property (_get_reorderPIInterval, _set_reorderPIInterval, None, "reorderPIInterval property")
	def _get_reorderPITimeout (self):
		return self.getVar ("reorderPITimeout")
	def _set_reorderPITimeout (self, value):
		self.setVar ("reorderPITimeout", value)
	reorderPITimeout = property (_get_reorderPITimeout, _set_reorderPITimeout, None, "reorderPITimeout property")
	def _get_operationOrder (self):
		return self.getListVar ("operationOrder")
	operationOrder = property (_get_operationOrder, None, None, "operationOrder property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( ImpairmentPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["addDelay"] = True
			self.managedProperties["addReorder"] = False
			self.managedProperties["addDrop"] = False
			self.managedProperties["addDuplicate"] = False
			self.managedProperties["addBandwidth"] = False
			self.managedProperties["randomizeSeed"] = False
			self.managedProperties["delay"] = 1
			self.managedProperties["reorder"] = 1
			self.managedProperties["reorderLength"] = 1
			self.managedProperties["destinationIp"] = "any"
			self.managedProperties["sourcePort"] = 0
			self.managedProperties["destinationPort"] = 0
			self.managedProperties["protocol"] = "any"
			self.managedProperties["typeOfService"] = "any"
			self.managedProperties["bandwidthUnits"] = "kbps"
			self.managedProperties["drop"] = 1
			self.managedProperties["duplicate"] = 1
			self.managedProperties["jitter"] = 0
			self.managedProperties["gap"] = 1
			self.managedProperties["bandwidth"] = 1
			self.managedProperties["seed"] = 1
			self.managedProperties["impairGlobal"] = True
			self.managedProperties["addDropSequence"] = False
			self.managedProperties["dropSequenceSkip"] = 1
			self.managedProperties["dropSequenceLength"] = 1
			self.managedProperties["addReorderPI"] = False
			self.managedProperties["reorderPISkip"] = 1
			self.managedProperties["reorderPILength"] = 1
			self.managedProperties["reorderPIInterval"] = 1
			self.managedProperties["reorderPITimeout"] = 1000
			self.managedProperties["operationOrder"] = Aptixia.IxList ("string")

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "ImpairmentPlugin"


