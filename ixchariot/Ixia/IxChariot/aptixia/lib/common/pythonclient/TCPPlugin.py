import string, threading
import Aptixia, Aptixia_prv
import GlobalPlugin


class TCPPlugin( GlobalPlugin.GlobalPlugin ):
	""" For setting all the TCP options on the port """
	# Class Properties
	def _get_tcp_abort_on_overflow (self):
		return self.getVar ("tcp_abort_on_overflow")
	def _set_tcp_abort_on_overflow (self, value):
		self.setVar ("tcp_abort_on_overflow", value)
	tcp_abort_on_overflow = property (_get_tcp_abort_on_overflow, _set_tcp_abort_on_overflow, None, "tcp_abort_on_overflow property")
	def _get_tcp_adv_win_scale (self):
		return self.getVar ("tcp_adv_win_scale")
	def _set_tcp_adv_win_scale (self, value):
		self.setVar ("tcp_adv_win_scale", value)
	tcp_adv_win_scale = property (_get_tcp_adv_win_scale, _set_tcp_adv_win_scale, None, "tcp_adv_win_scale property")
	def _get_tcp_app_win (self):
		return self.getVar ("tcp_app_win")
	def _set_tcp_app_win (self, value):
		self.setVar ("tcp_app_win", value)
	tcp_app_win = property (_get_tcp_app_win, _set_tcp_app_win, None, "tcp_app_win property")
	def _get_tcp_bic (self):
		return self.getVar ("tcp_bic")
	def _set_tcp_bic (self, value):
		self.setVar ("tcp_bic", value)
	tcp_bic = property (_get_tcp_bic, _set_tcp_bic, None, "tcp_bic property")
	def _get_tcp_bic_fast_convergence (self):
		return self.getVar ("tcp_bic_fast_convergence")
	def _set_tcp_bic_fast_convergence (self, value):
		self.setVar ("tcp_bic_fast_convergence", value)
	tcp_bic_fast_convergence = property (_get_tcp_bic_fast_convergence, _set_tcp_bic_fast_convergence, None, "tcp_bic_fast_convergence property")
	def _get_tcp_bic_low_window (self):
		return self.getVar ("tcp_bic_low_window")
	def _set_tcp_bic_low_window (self, value):
		self.setVar ("tcp_bic_low_window", value)
	tcp_bic_low_window = property (_get_tcp_bic_low_window, _set_tcp_bic_low_window, None, "tcp_bic_low_window property")
	def _get_tcp_dsack (self):
		return self.getVar ("tcp_dsack")
	def _set_tcp_dsack (self, value):
		self.setVar ("tcp_dsack", value)
	tcp_dsack = property (_get_tcp_dsack, _set_tcp_dsack, None, "tcp_dsack property")
	def _get_tcp_ecn (self):
		return self.getVar ("tcp_ecn")
	def _set_tcp_ecn (self, value):
		self.setVar ("tcp_ecn", value)
	tcp_ecn = property (_get_tcp_ecn, _set_tcp_ecn, None, "tcp_ecn property")
	def _get_tcp_fack (self):
		return self.getVar ("tcp_fack")
	def _set_tcp_fack (self, value):
		self.setVar ("tcp_fack", value)
	tcp_fack = property (_get_tcp_fack, _set_tcp_fack, None, "tcp_fack property")
	def _get_tcp_fin_timeout (self):
		return self.getVar ("tcp_fin_timeout")
	def _set_tcp_fin_timeout (self, value):
		self.setVar ("tcp_fin_timeout", value)
	tcp_fin_timeout = property (_get_tcp_fin_timeout, _set_tcp_fin_timeout, None, "tcp_fin_timeout property")
	def _get_tcp_frto (self):
		return self.getVar ("tcp_frto")
	def _set_tcp_frto (self, value):
		self.setVar ("tcp_frto", value)
	tcp_frto = property (_get_tcp_frto, _set_tcp_frto, None, "tcp_frto property")
	def _get_tcp_keepalive_intvl (self):
		return self.getVar ("tcp_keepalive_intvl")
	def _set_tcp_keepalive_intvl (self, value):
		self.setVar ("tcp_keepalive_intvl", value)
	tcp_keepalive_intvl = property (_get_tcp_keepalive_intvl, _set_tcp_keepalive_intvl, None, "tcp_keepalive_intvl property")
	def _get_tcp_keepalive_probes (self):
		return self.getVar ("tcp_keepalive_probes")
	def _set_tcp_keepalive_probes (self, value):
		self.setVar ("tcp_keepalive_probes", value)
	tcp_keepalive_probes = property (_get_tcp_keepalive_probes, _set_tcp_keepalive_probes, None, "tcp_keepalive_probes property")
	def _get_tcp_keepalive_time (self):
		return self.getVar ("tcp_keepalive_time")
	def _set_tcp_keepalive_time (self, value):
		self.setVar ("tcp_keepalive_time", value)
	tcp_keepalive_time = property (_get_tcp_keepalive_time, _set_tcp_keepalive_time, None, "tcp_keepalive_time property")
	def _get_tcp_low_latency (self):
		return self.getVar ("tcp_low_latency")
	def _set_tcp_low_latency (self, value):
		self.setVar ("tcp_low_latency", value)
	tcp_low_latency = property (_get_tcp_low_latency, _set_tcp_low_latency, None, "tcp_low_latency property")
	def _get_tcp_max_orphans (self):
		return self.getVar ("tcp_max_orphans")
	def _set_tcp_max_orphans (self, value):
		self.setVar ("tcp_max_orphans", value)
	tcp_max_orphans = property (_get_tcp_max_orphans, _set_tcp_max_orphans, None, "tcp_max_orphans property")
	def _get_tcp_max_syn_backlog (self):
		return self.getVar ("tcp_max_syn_backlog")
	def _set_tcp_max_syn_backlog (self, value):
		self.setVar ("tcp_max_syn_backlog", value)
	tcp_max_syn_backlog = property (_get_tcp_max_syn_backlog, _set_tcp_max_syn_backlog, None, "tcp_max_syn_backlog property")
	def _get_tcp_max_tw_buckets (self):
		return self.getVar ("tcp_max_tw_buckets")
	def _set_tcp_max_tw_buckets (self, value):
		self.setVar ("tcp_max_tw_buckets", value)
	tcp_max_tw_buckets = property (_get_tcp_max_tw_buckets, _set_tcp_max_tw_buckets, None, "tcp_max_tw_buckets property")
	def _get_tcp_mem_low (self):
		return self.getVar ("tcp_mem_low")
	def _set_tcp_mem_low (self, value):
		self.setVar ("tcp_mem_low", value)
	tcp_mem_low = property (_get_tcp_mem_low, _set_tcp_mem_low, None, "tcp_mem_low property")
	def _get_tcp_mem_pressure (self):
		return self.getVar ("tcp_mem_pressure")
	def _set_tcp_mem_pressure (self, value):
		self.setVar ("tcp_mem_pressure", value)
	tcp_mem_pressure = property (_get_tcp_mem_pressure, _set_tcp_mem_pressure, None, "tcp_mem_pressure property")
	def _get_tcp_mem_high (self):
		return self.getVar ("tcp_mem_high")
	def _set_tcp_mem_high (self, value):
		self.setVar ("tcp_mem_high", value)
	tcp_mem_high = property (_get_tcp_mem_high, _set_tcp_mem_high, None, "tcp_mem_high property")
	def _get_tcp_moderate_rcvbuf (self):
		return self.getVar ("tcp_moderate_rcvbuf")
	def _set_tcp_moderate_rcvbuf (self, value):
		self.setVar ("tcp_moderate_rcvbuf", value)
	tcp_moderate_rcvbuf = property (_get_tcp_moderate_rcvbuf, _set_tcp_moderate_rcvbuf, None, "tcp_moderate_rcvbuf property")
	def _get_tcp_no_metrics_save (self):
		return self.getVar ("tcp_no_metrics_save")
	def _set_tcp_no_metrics_save (self, value):
		self.setVar ("tcp_no_metrics_save", value)
	tcp_no_metrics_save = property (_get_tcp_no_metrics_save, _set_tcp_no_metrics_save, None, "tcp_no_metrics_save property")
	def _get_tcp_orphan_retries (self):
		return self.getVar ("tcp_orphan_retries")
	def _set_tcp_orphan_retries (self, value):
		self.setVar ("tcp_orphan_retries", value)
	tcp_orphan_retries = property (_get_tcp_orphan_retries, _set_tcp_orphan_retries, None, "tcp_orphan_retries property")
	def _get_tcp_reordering (self):
		return self.getVar ("tcp_reordering")
	def _set_tcp_reordering (self, value):
		self.setVar ("tcp_reordering", value)
	tcp_reordering = property (_get_tcp_reordering, _set_tcp_reordering, None, "tcp_reordering property")
	def _get_tcp_retrans_collapse (self):
		return self.getVar ("tcp_retrans_collapse")
	def _set_tcp_retrans_collapse (self, value):
		self.setVar ("tcp_retrans_collapse", value)
	tcp_retrans_collapse = property (_get_tcp_retrans_collapse, _set_tcp_retrans_collapse, None, "tcp_retrans_collapse property")
	def _get_tcp_retries1 (self):
		return self.getVar ("tcp_retries1")
	def _set_tcp_retries1 (self, value):
		self.setVar ("tcp_retries1", value)
	tcp_retries1 = property (_get_tcp_retries1, _set_tcp_retries1, None, "tcp_retries1 property")
	def _get_tcp_retries2 (self):
		return self.getVar ("tcp_retries2")
	def _set_tcp_retries2 (self, value):
		self.setVar ("tcp_retries2", value)
	tcp_retries2 = property (_get_tcp_retries2, _set_tcp_retries2, None, "tcp_retries2 property")
	def _get_tcp_rfc1337 (self):
		return self.getVar ("tcp_rfc1337")
	def _set_tcp_rfc1337 (self, value):
		self.setVar ("tcp_rfc1337", value)
	tcp_rfc1337 = property (_get_tcp_rfc1337, _set_tcp_rfc1337, None, "tcp_rfc1337 property")
	def _get_tcp_rmem_min (self):
		return self.getVar ("tcp_rmem_min")
	def _set_tcp_rmem_min (self, value):
		self.setVar ("tcp_rmem_min", value)
	tcp_rmem_min = property (_get_tcp_rmem_min, _set_tcp_rmem_min, None, "tcp_rmem_min property")
	def _get_tcp_rmem_default (self):
		return self.getVar ("tcp_rmem_default")
	def _set_tcp_rmem_default (self, value):
		self.setVar ("tcp_rmem_default", value)
	tcp_rmem_default = property (_get_tcp_rmem_default, _set_tcp_rmem_default, None, "tcp_rmem_default property")
	def _get_tcp_rmem_max (self):
		return self.getVar ("tcp_rmem_max")
	def _set_tcp_rmem_max (self, value):
		self.setVar ("tcp_rmem_max", value)
	tcp_rmem_max = property (_get_tcp_rmem_max, _set_tcp_rmem_max, None, "tcp_rmem_max property")
	def _get_tcp_sack (self):
		return self.getVar ("tcp_sack")
	def _set_tcp_sack (self, value):
		self.setVar ("tcp_sack", value)
	tcp_sack = property (_get_tcp_sack, _set_tcp_sack, None, "tcp_sack property")
	def _get_tcp_stdurg (self):
		return self.getVar ("tcp_stdurg")
	def _set_tcp_stdurg (self, value):
		self.setVar ("tcp_stdurg", value)
	tcp_stdurg = property (_get_tcp_stdurg, _set_tcp_stdurg, None, "tcp_stdurg property")
	def _get_tcp_synack_retries (self):
		return self.getVar ("tcp_synack_retries")
	def _set_tcp_synack_retries (self, value):
		self.setVar ("tcp_synack_retries", value)
	tcp_synack_retries = property (_get_tcp_synack_retries, _set_tcp_synack_retries, None, "tcp_synack_retries property")
	def _get_tcp_syn_retries (self):
		return self.getVar ("tcp_syn_retries")
	def _set_tcp_syn_retries (self, value):
		self.setVar ("tcp_syn_retries", value)
	tcp_syn_retries = property (_get_tcp_syn_retries, _set_tcp_syn_retries, None, "tcp_syn_retries property")
	def _get_tcp_timestamps (self):
		return self.getVar ("tcp_timestamps")
	def _set_tcp_timestamps (self, value):
		self.setVar ("tcp_timestamps", value)
	tcp_timestamps = property (_get_tcp_timestamps, _set_tcp_timestamps, None, "tcp_timestamps property")
	def _get_tcp_tw_recycle (self):
		return self.getVar ("tcp_tw_recycle")
	def _set_tcp_tw_recycle (self, value):
		self.setVar ("tcp_tw_recycle", value)
	tcp_tw_recycle = property (_get_tcp_tw_recycle, _set_tcp_tw_recycle, None, "tcp_tw_recycle property")
	def _get_tcp_tw_reuse (self):
		return self.getVar ("tcp_tw_reuse")
	def _set_tcp_tw_reuse (self, value):
		self.setVar ("tcp_tw_reuse", value)
	tcp_tw_reuse = property (_get_tcp_tw_reuse, _set_tcp_tw_reuse, None, "tcp_tw_reuse property")
	def _get_tcp_vegas_alpha (self):
		return self.getVar ("tcp_vegas_alpha")
	def _set_tcp_vegas_alpha (self, value):
		self.setVar ("tcp_vegas_alpha", value)
	tcp_vegas_alpha = property (_get_tcp_vegas_alpha, _set_tcp_vegas_alpha, None, "tcp_vegas_alpha property")
	def _get_tcp_vegas_beta (self):
		return self.getVar ("tcp_vegas_beta")
	def _set_tcp_vegas_beta (self, value):
		self.setVar ("tcp_vegas_beta", value)
	tcp_vegas_beta = property (_get_tcp_vegas_beta, _set_tcp_vegas_beta, None, "tcp_vegas_beta property")
	def _get_tcp_vegas_cong_avoid (self):
		return self.getVar ("tcp_vegas_cong_avoid")
	def _set_tcp_vegas_cong_avoid (self, value):
		self.setVar ("tcp_vegas_cong_avoid", value)
	tcp_vegas_cong_avoid = property (_get_tcp_vegas_cong_avoid, _set_tcp_vegas_cong_avoid, None, "tcp_vegas_cong_avoid property")
	def _get_tcp_vegas_gamma (self):
		return self.getVar ("tcp_vegas_gamma")
	def _set_tcp_vegas_gamma (self, value):
		self.setVar ("tcp_vegas_gamma", value)
	tcp_vegas_gamma = property (_get_tcp_vegas_gamma, _set_tcp_vegas_gamma, None, "tcp_vegas_gamma property")
	def _get_tcp_westwood (self):
		return self.getVar ("tcp_westwood")
	def _set_tcp_westwood (self, value):
		self.setVar ("tcp_westwood", value)
	tcp_westwood = property (_get_tcp_westwood, _set_tcp_westwood, None, "tcp_westwood property")
	def _get_tcp_window_scaling (self):
		return self.getVar ("tcp_window_scaling")
	def _set_tcp_window_scaling (self, value):
		self.setVar ("tcp_window_scaling", value)
	tcp_window_scaling = property (_get_tcp_window_scaling, _set_tcp_window_scaling, None, "tcp_window_scaling property")
	def _get_tcp_wmem_min (self):
		return self.getVar ("tcp_wmem_min")
	def _set_tcp_wmem_min (self, value):
		self.setVar ("tcp_wmem_min", value)
	tcp_wmem_min = property (_get_tcp_wmem_min, _set_tcp_wmem_min, None, "tcp_wmem_min property")
	def _get_tcp_wmem_default (self):
		return self.getVar ("tcp_wmem_default")
	def _set_tcp_wmem_default (self, value):
		self.setVar ("tcp_wmem_default", value)
	tcp_wmem_default = property (_get_tcp_wmem_default, _set_tcp_wmem_default, None, "tcp_wmem_default property")
	def _get_tcp_wmem_max (self):
		return self.getVar ("tcp_wmem_max")
	def _set_tcp_wmem_max (self, value):
		self.setVar ("tcp_wmem_max", value)
	tcp_wmem_max = property (_get_tcp_wmem_max, _set_tcp_wmem_max, None, "tcp_wmem_max property")
	def _get_tcp_ipfrag_time (self):
		return self.getVar ("tcp_ipfrag_time")
	def _set_tcp_ipfrag_time (self, value):
		self.setVar ("tcp_ipfrag_time", value)
	tcp_ipfrag_time = property (_get_tcp_ipfrag_time, _set_tcp_ipfrag_time, None, "tcp_ipfrag_time property")
	def _get_tcp_port_min (self):
		return self.getVar ("tcp_port_min")
	def _set_tcp_port_min (self, value):
		self.setVar ("tcp_port_min", value)
	tcp_port_min = property (_get_tcp_port_min, _set_tcp_port_min, None, "tcp_port_min property")
	def _get_tcp_port_max (self):
		return self.getVar ("tcp_port_max")
	def _set_tcp_port_max (self, value):
		self.setVar ("tcp_port_max", value)
	tcp_port_max = property (_get_tcp_port_max, _set_tcp_port_max, None, "tcp_port_max property")
	def _get_rmem_max (self):
		return self.getVar ("rmem_max")
	def _set_rmem_max (self, value):
		self.setVar ("rmem_max", value)
	rmem_max = property (_get_rmem_max, _set_rmem_max, None, "rmem_max property")
	def _get_wmem_max (self):
		return self.getVar ("wmem_max")
	def _set_wmem_max (self, value):
		self.setVar ("wmem_max", value)
	wmem_max = property (_get_wmem_max, _set_wmem_max, None, "wmem_max property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( TCPPlugin, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["tcp_abort_on_overflow"] = False
			self.managedProperties["tcp_adv_win_scale"] = 2
			self.managedProperties["tcp_app_win"] = 31
			self.managedProperties["tcp_bic"] = 0
			self.managedProperties["tcp_bic_fast_convergence"] = 1
			self.managedProperties["tcp_bic_low_window"] = 14
			self.managedProperties["tcp_dsack"] = True
			self.managedProperties["tcp_ecn"] = False
			self.managedProperties["tcp_fack"] = True
			self.managedProperties["tcp_fin_timeout"] = 60
			self.managedProperties["tcp_frto"] = 0
			self.managedProperties["tcp_keepalive_intvl"] = 75
			self.managedProperties["tcp_keepalive_probes"] = 9
			self.managedProperties["tcp_keepalive_time"] = 7200
			self.managedProperties["tcp_low_latency"] = 0
			self.managedProperties["tcp_max_orphans"] = 8192
			self.managedProperties["tcp_max_syn_backlog"] = 256
			self.managedProperties["tcp_max_tw_buckets"] = 16384
			self.managedProperties["tcp_mem_low"] = 6144
			self.managedProperties["tcp_mem_pressure"] = 8192
			self.managedProperties["tcp_mem_high"] = 12288
			self.managedProperties["tcp_moderate_rcvbuf"] = 0
			self.managedProperties["tcp_no_metrics_save"] = False
			self.managedProperties["tcp_orphan_retries"] = 0
			self.managedProperties["tcp_reordering"] = 3
			self.managedProperties["tcp_retrans_collapse"] = True
			self.managedProperties["tcp_retries1"] = 3
			self.managedProperties["tcp_retries2"] = 15
			self.managedProperties["tcp_rfc1337"] = False
			self.managedProperties["tcp_rmem_min"] = 4096
			self.managedProperties["tcp_rmem_default"] = 32768
			self.managedProperties["tcp_rmem_max"] = 174760
			self.managedProperties["tcp_sack"] = True
			self.managedProperties["tcp_stdurg"] = False
			self.managedProperties["tcp_synack_retries"] = 5
			self.managedProperties["tcp_syn_retries"] = 5
			self.managedProperties["tcp_timestamps"] = True
			self.managedProperties["tcp_tw_recycle"] = False
			self.managedProperties["tcp_tw_reuse"] = False
			self.managedProperties["tcp_vegas_alpha"] = 2
			self.managedProperties["tcp_vegas_beta"] = 6
			self.managedProperties["tcp_vegas_cong_avoid"] = 0
			self.managedProperties["tcp_vegas_gamma"] = 2
			self.managedProperties["tcp_westwood"] = 0
			self.managedProperties["tcp_window_scaling"] = True
			self.managedProperties["tcp_wmem_min"] = 4096
			self.managedProperties["tcp_wmem_default"] = 16384
			self.managedProperties["tcp_wmem_max"] = 131072
			self.managedProperties["tcp_ipfrag_time"] = 30
			self.managedProperties["tcp_port_min"] = 32770
			self.managedProperties["tcp_port_max"] = 61000
			self.managedProperties["rmem_max"] = 2621440
			self.managedProperties["wmem_max"] = 112640

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "TCPPlugin"


