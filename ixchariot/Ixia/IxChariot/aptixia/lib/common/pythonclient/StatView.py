import string, threading
import Aptixia, Aptixia_prv
import TreeNode
import ChartXAxis, ChartYAxis, StatFilterGroup, StatSpec, StatAttributeList, CsvHeaderField, CsvRequestOptions, StatConsumer


class StatView( TreeNode.TreeNode ):
	""" A container for a group of stats """
	# Class Properties
	def _get_caption (self):
		return self.getVar ("caption")
	def _set_caption (self, value):
		self.setVar ("caption", value)
	caption = property (_get_caption, _set_caption, None, "caption property")
	def _get_enabled (self):
		return self.getVar ("enabled")
	def _set_enabled (self, value):
		self.setVar ("enabled", value)
	enabled = property (_get_enabled, _set_enabled, None, "enabled property")
	def _get_useCaption (self):
		return self.getVar ("useCaption")
	def _set_useCaption (self, value):
		self.setVar ("useCaption", value)
	useCaption = property (_get_useCaption, _set_useCaption, None, "useCaption property")
	def _get_autoColumnWidth (self):
		return self.getVar ("autoColumnWidth")
	def _set_autoColumnWidth (self, value):
		self.setVar ("autoColumnWidth", value)
	autoColumnWidth = property (_get_autoColumnWidth, _set_autoColumnWidth, None, "autoColumnWidth property")
	def _get_windowPosition (self):
		return self.getVar ("windowPosition")
	def _set_windowPosition (self, value):
		self.setVar ("windowPosition", value)
	windowPosition = property (_get_windowPosition, _set_windowPosition, None, "windowPosition property")
	def _get_allowUserEdit (self):
		return self.getVar ("allowUserEdit")
	def _set_allowUserEdit (self, value):
		self.setVar ("allowUserEdit", value)
	allowUserEdit = property (_get_allowUserEdit, _set_allowUserEdit, None, "allowUserEdit property")
	def _get_frequency (self):
		return self.getVar ("frequency")
	def _set_frequency (self, value):
		self.setVar ("frequency", value)
	frequency = property (_get_frequency, _set_frequency, None, "frequency property")
	def _get_timeSamples (self):
		return self.getVar ("timeSamples")
	def _set_timeSamples (self, value):
		self.setVar ("timeSamples", value)
	timeSamples = property (_get_timeSamples, _set_timeSamples, None, "timeSamples property")
	def _get_viewType (self):
		return self.getVar ("viewType")
	def _set_viewType (self, value):
		self.setVar ("viewType", value)
	viewType = property (_get_viewType, _set_viewType, None, "viewType property")
	def _get_showGridLines (self):
		return self.getVar ("showGridLines")
	def _set_showGridLines (self, value):
		self.setVar ("showGridLines", value)
	showGridLines = property (_get_showGridLines, _set_showGridLines, None, "showGridLines property")
	def _get_grayScale (self):
		return self.getVar ("grayScale")
	def _set_grayScale (self, value):
		self.setVar ("grayScale", value)
	grayScale = property (_get_grayScale, _set_grayScale, None, "grayScale property")
	def _get_xAxis (self):
		return self.getListVar ("xAxis")
	xAxis = property (_get_xAxis, None, None, "xAxis property")
	def _get_yAxis (self):
		return self.getListVar ("yAxis")
	yAxis = property (_get_yAxis, None, None, "yAxis property")
	def _get_legendEnabled (self):
		return self.getVar ("legendEnabled")
	def _set_legendEnabled (self, value):
		self.setVar ("legendEnabled", value)
	legendEnabled = property (_get_legendEnabled, _set_legendEnabled, None, "legendEnabled property")
	def _get_dataLegendEnabled (self):
		return self.getVar ("dataLegendEnabled")
	def _set_dataLegendEnabled (self, value):
		self.setVar ("dataLegendEnabled", value)
	dataLegendEnabled = property (_get_dataLegendEnabled, _set_dataLegendEnabled, None, "dataLegendEnabled property")
	def _get_legendPosition (self):
		return self.getVar ("legendPosition")
	def _set_legendPosition (self, value):
		self.setVar ("legendPosition", value)
	legendPosition = property (_get_legendPosition, _set_legendPosition, None, "legendPosition property")
	def _get_legendSpanPercentage (self):
		return self.getVar ("legendSpanPercentage")
	def _set_legendSpanPercentage (self, value):
		self.setVar ("legendSpanPercentage", value)
	legendSpanPercentage = property (_get_legendSpanPercentage, _set_legendSpanPercentage, None, "legendSpanPercentage property")
	def _get_backgroundColor (self):
		return self.getVar ("backgroundColor")
	def _set_backgroundColor (self, value):
		self.setVar ("backgroundColor", value)
	backgroundColor = property (_get_backgroundColor, _set_backgroundColor, None, "backgroundColor property")
	def _get_fontColor (self):
		return self.getVar ("fontColor")
	def _set_fontColor (self, value):
		self.setVar ("fontColor", value)
	fontColor = property (_get_fontColor, _set_fontColor, None, "fontColor property")
	def _get_title (self):
		return self.getVar ("title")
	def _set_title (self, value):
		self.setVar ("title", value)
	title = property (_get_title, _set_title, None, "title property")
	def _get_statFilterGroupList (self):
		return self.getListVar ("statFilterGroupList")
	statFilterGroupList = property (_get_statFilterGroupList, None, None, "statFilterGroupList property")
	def _get_statSpecList (self):
		return self.getListVar ("statSpecList")
	statSpecList = property (_get_statSpecList, None, None, "statSpecList property")
	def _get_swapRowsColumns (self):
		return self.getVar ("swapRowsColumns")
	def _set_swapRowsColumns (self, value):
		self.setVar ("swapRowsColumns", value)
	swapRowsColumns = property (_get_swapRowsColumns, _set_swapRowsColumns, None, "swapRowsColumns property")
	def _get_matrixConfiguration (self):
		return self.getVar ("matrixConfiguration")
	def _set_matrixConfiguration (self, value):
		self.setVar ("matrixConfiguration", value)
	matrixConfiguration = property (_get_matrixConfiguration, _set_matrixConfiguration, None, "matrixConfiguration property")
	def _get_publisherLabels (self):
		return self.getVar ("publisherLabels")
	def _set_publisherLabels (self, value):
		self.setVar ("publisherLabels", value)
	publisherLabels = property (_get_publisherLabels, _set_publisherLabels, None, "publisherLabels property")
	def _get_threeD (self):
		return self.getVar ("threeD")
	def _set_threeD (self, value):
		self.setVar ("threeD", value)
	threeD = property (_get_threeD, _set_threeD, None, "threeD property")
	def _get_threeDRotate (self):
		return self.getVar ("threeDRotate")
	def _set_threeDRotate (self, value):
		self.setVar ("threeDRotate", value)
	threeDRotate = property (_get_threeDRotate, _set_threeDRotate, None, "threeDRotate property")
	def _get_threeDRotateX (self):
		return self.getVar ("threeDRotateX")
	def _set_threeDRotateX (self, value):
		self.setVar ("threeDRotateX", value)
	threeDRotateX = property (_get_threeDRotateX, _set_threeDRotateX, None, "threeDRotateX property")
	def _get_threeDRotateY (self):
		return self.getVar ("threeDRotateY")
	def _set_threeDRotateY (self, value):
		self.setVar ("threeDRotateY", value)
	threeDRotateY = property (_get_threeDRotateY, _set_threeDRotateY, None, "threeDRotateY property")
	def _get_statAttributeListList (self):
		return self.getListVar ("statAttributeListList")
	statAttributeListList = property (_get_statAttributeListList, None, None, "statAttributeListList property")
	def _get_lineStyle (self):
		return self.getVar ("lineStyle")
	def _set_lineStyle (self, value):
		self.setVar ("lineStyle", value)
	lineStyle = property (_get_lineStyle, _set_lineStyle, None, "lineStyle property")
	def _get_csvHeaderFieldList (self):
		return self.getListVar ("csvHeaderFieldList")
	csvHeaderFieldList = property (_get_csvHeaderFieldList, None, None, "csvHeaderFieldList property")
	def _get_csvRequestOptions (self):
		return self.getListVar ("csvRequestOptions")
	csvRequestOptions = property (_get_csvRequestOptions, None, None, "csvRequestOptions property")
	def _get_visible (self):
		return self.getVar ("visible")
	def _set_visible (self, value):
		self.setVar ("visible", value)
	visible = property (_get_visible, _set_visible, None, "visible property")
	def _get_sampleDataRequired (self):
		return self.getVar ("sampleDataRequired")
	def _set_sampleDataRequired (self, value):
		self.setVar ("sampleDataRequired", value)
	sampleDataRequired = property (_get_sampleDataRequired, _set_sampleDataRequired, None, "sampleDataRequired property")

	# Constructor
	def __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):
		super( StatView, self ).__init__(parent, objectId, transactionContext, preFetch)
		# defaults
		if not self.isInstantiated:
			self.managedProperties["caption"] = "View"
			self.managedProperties["enabled"] = True
			self.managedProperties["useCaption"] = True
			self.managedProperties["autoColumnWidth"] = True
			self.managedProperties["windowPosition"] = ""
			self.managedProperties["allowUserEdit"] = True
			self.managedProperties["frequency"] = float(2)
			self.managedProperties["timeSamples"] = 3600
			self.managedProperties["viewType"] = "Line"
			self.managedProperties["showGridLines"] = True
			self.managedProperties["grayScale"] = False
			self.managedProperties["xAxis"] = ChartXAxis.ChartXAxis (self)
			self.managedProperties["yAxis"] = ChartYAxis.ChartYAxis (self)
			self.managedProperties["legendEnabled"] = True
			self.managedProperties["dataLegendEnabled"] = True
			self.managedProperties["legendPosition"] = "Right"
			self.managedProperties["legendSpanPercentage"] = 30
			self.managedProperties["backgroundColor"] = "Black"
			self.managedProperties["fontColor"] = "White"
			self.managedProperties["title"] = True
			self.managedProperties["statFilterGroupList"] = Aptixia.IxObjectList (self.transactionContext, "StatFilterGroup")
			self.managedProperties["statSpecList"] = Aptixia.IxObjectList (self.transactionContext, "StatSpec")
			self.managedProperties["swapRowsColumns"] = False
			self.managedProperties["matrixConfiguration"] = False
			self.managedProperties["publisherLabels"] = False
			self.managedProperties["threeD"] = False
			self.managedProperties["threeDRotate"] = False
			self.managedProperties["threeDRotateX"] = 30
			self.managedProperties["threeDRotateY"] = 30
			self.managedProperties["statAttributeListList"] = Aptixia.IxObjectList (self.transactionContext, "StatAttributeList")
			self.managedProperties["lineStyle"] = "Solid"
			self.managedProperties["csvHeaderFieldList"] = Aptixia.IxObjectList (self.transactionContext, "CsvHeaderField")
			self.managedProperties["csvRequestOptions"] = CsvRequestOptions.CsvRequestOptions (self)
			self.managedProperties["visible"] = True
			self.managedProperties["sampleDataRequired"] = False

	# Type identifier (used internally)
	def getType( self ):
		"""Returns the type of the object as a string"""
		return "StatView"

	# Class Methods
	def MaxViewTime( self, callback = None, callbackArg = None ):
		""" Get the maximum time that a view will hold before dropping visible data, after this point theTestServer DataStore still contains data back to the beginning of a test
			Returns time: The maximum time that a view will hold before dropping visible data, after this point theTestServer DataStore still contains data back to the beginning of a test """
		arg0 = Aptixia_prv.MethodArgument( "time", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MaxViewTime", argTuple, callback, callbackArg )
	def MaxViewTime_Sync( self ):
		""" Get the maximum time that a view will hold before dropping visible data, after this point theTestServer DataStore still contains data back to the beginning of a test
			Returns time: The maximum time that a view will hold before dropping visible data, after this point theTestServer DataStore still contains data back to the beginning of a test """
		arg0 = Aptixia_prv.MethodArgument( "time", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "MaxViewTime", argTuple)
		return context.Sync()

	def Commit( self, callback = None, callbackArg = None ):
		""" After adding new stats and setting properties commit adds the new stats a live test """
		argTuple = []
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Commit", argTuple, callback, callbackArg )
	def Commit_Sync( self ):
		""" After adding new stats and setting properties commit adds the new stats a live test """
		argTuple = []
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "Commit", argTuple)
		return context.Sync()

	def SaveAsTemplate( self, name, callback = None, callbackArg = None ):
		""" Save this view as a template in the DataStore for use in other tests
			name: Save the view as a template in the DataStore with this name """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAsTemplate", argTuple, callback, callbackArg )
	def SaveAsTemplate_Sync( self, name ):
		""" Save this view as a template in the DataStore for use in other tests
			name: Save the view as a template in the DataStore with this name """
		arg0 = Aptixia_prv.MethodArgument( "name", name, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "SaveAsTemplate", argTuple)
		return context.Sync()

	def GetStatSourceTypes( self, callback = None, callbackArg = None ):
		""" Concatenates all stat source types from every stat spec in this view
			Returns statSourceTypes: Concatenation all stat source types from every stat spec in this view """
		arg0 = Aptixia_prv.MethodArgument( "statSourceTypes", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStatSourceTypes", argTuple, callback, callbackArg )
	def GetStatSourceTypes_Sync( self ):
		""" Concatenates all stat source types from every stat spec in this view
			Returns statSourceTypes: Concatenation all stat source types from every stat spec in this view """
		arg0 = Aptixia_prv.MethodArgument( "statSourceTypes", None, "out", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStatSourceTypes", argTuple)
		return context.Sync()

	def GetResultStartTime( self, callback = None, callbackArg = None ):
		""" Gets the starting time of a test result from the TestServer DataStore
			Returns time: The starting time of a test result from the TestServer DataStore """
		arg0 = Aptixia_prv.MethodArgument( "time", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetResultStartTime", argTuple, callback, callbackArg )
	def GetResultStartTime_Sync( self ):
		""" Gets the starting time of a test result from the TestServer DataStore
			Returns time: The starting time of a test result from the TestServer DataStore """
		arg0 = Aptixia_prv.MethodArgument( "time", None, "out", "int64", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetResultStartTime", argTuple)
		return context.Sync()

	def ExportCsv( self, fileName, callback = None, callbackArg = None ):
		""" Writes test results from the DataStore in csv format into a file on the TestServer
			fileName: The name of file to write on the TestServer """
		arg0 = Aptixia_prv.MethodArgument( "fileName", fileName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ExportCsv", argTuple, callback, callbackArg )
	def ExportCsv_Sync( self, fileName ):
		""" Writes test results from the DataStore in csv format into a file on the TestServer
			fileName: The name of file to write on the TestServer """
		arg0 = Aptixia_prv.MethodArgument( "fileName", fileName, "in", "string", None)
		argTuple = ( arg0, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "ExportCsv", argTuple)
		return context.Sync()

	def GetStats( self, beginTimestamp, endTimestamp, callback = None, callbackArg = None ):
		""" Get Stats from the DataStore on the TestServer
			beginTimestamp: Relative timestamp of the begining of requested stats
			endTimestamp: Relative timestamp of the end of requested stats
			Returns statSetList: List of the stats returned """
		arg0 = Aptixia_prv.MethodArgument( "statSetList", None, "out", "StatConsumer.StatSetList", StatConsumer.StatConsumer.StatSetList)
		arg1 = Aptixia_prv.MethodArgument( "beginTimestamp", beginTimestamp, "in", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "endTimestamp", endTimestamp, "in", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		return Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStats", argTuple, callback, callbackArg )
	def GetStats_Sync( self, beginTimestamp, endTimestamp ):
		""" Get Stats from the DataStore on the TestServer
			beginTimestamp: Relative timestamp of the begining of requested stats
			endTimestamp: Relative timestamp of the end of requested stats
			Returns statSetList: List of the stats returned """
		arg0 = Aptixia_prv.MethodArgument( "statSetList", None, "out", "StatConsumer.StatSetList", StatConsumer.StatConsumer.StatSetList)
		arg1 = Aptixia_prv.MethodArgument( "beginTimestamp", beginTimestamp, "in", "int64", None)
		arg2 = Aptixia_prv.MethodArgument( "endTimestamp", endTimestamp, "in", "int64", None)
		argTuple = ( arg0, arg1, arg2, )
		self.FlushProperties()
		context = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, "GetStats", argTuple)
		return context.Sync()


