import string, threading
import Aptixia, Aptixia_prv
import StackElementPlugin
import IPSecNetwork, IPSecPhase1, IPSecPhase2, IPSecTunnelSetup


class IPSecPlugin( StackElementPlugin.StackElementPlugin ):
	""" IPSec plugin configured IPSec tunnels between given end points and exposed the date end points for upper layer to runtraffic with negotiated IPSec policies. """
	# Class Properties
	def _get_ipsecNetwork (self):
		return self.getListVar ("ipsecNetwork")
	ipsecNetwork = property (_get_ipsecNetwork, None, None, "ipsecNetwork property")
	def _get_ipsecPhase1 (self):
		return self.getListVar ("ipsecPhase1")
	ipsecPhase1 = property (_get_ipsecPhase1, None, None, "ipsecPhase1 property")
	def _get_ipsecPhase2 (self):
		return self.getListVar ("ipsecPhase2")
	ipsecPhase2 = property (_get_ipsecPhase2, None, None, "ipsecPhase2 property")
	def _get_ipsecTunnelSetup (self):
		return self.getListVar ("ipsecTunnelSetup")
	ipsecTunnelSetup = property (_get_ipsecTunnelSetup, None, None, "ipsecTunnelSetup property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( IPSecPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["ipsecNetwork"] = Aptixia.IxObjectList (self.transactionContext, "IPSecNetwork")
			self.managedProperties["ipsecPhase1"] = IPSecPhase1.IPSecPhase1 (self)
			self.managedProperties["ipsecPhase2"] = IPSecPhase2.IPSecPhase2 (self)
			self.managedProperties["ipsecTunnelSetup"] = IPSecTunnelSetup.IPSecTunnelSetup (self)

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "IPSecPlugin"


