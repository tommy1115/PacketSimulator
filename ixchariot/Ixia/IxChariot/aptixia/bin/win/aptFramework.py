import traceback
import _PythonProxy

__all__ = []

#??? from Gui.Common.ixEventToGui import ixCallToGui


kMethod         = 0
kGetProperty    = 1
kSetProperty    = 2
kLoadDll        = 3
kNew            = 4
   


pyCount = 0  # use for debuging

class aptGCHandle:
    totalObj = 0 # use for debuging
    
    def __init__(self, handle):
        self.handle = handle
        aptGCHandle.totalObj += 1

    def getType(self):
        gchType = aptGCHandle(_PythonProxy.CallCSharp(self, kMethod, "GetType"))
        sType = _PythonProxy.CallCSharp(gchType, kMethod, "ToString")
        return sType
        

    def __del__(self):
        # print "Free GCH ",
        aptGCHandle.totalObj -= 1
        _PythonProxy.CallCSharp(None, kMethod, "Free", self.handle)


#################################################
   

class aptDotNetDll(object):
    """
        This class represents a .Net DLL. The application first loads it by creating an instance
        of this object, passing the DLL filename. Then, the application can create objects of the
        type specified in the filename by calling the New method on the aptDll object.
    """

    class aptDotNetObject(object):

        """
            Represents an object of a type within a .Net DLL. Currently we only support calling
            methods on these objects (no attribute get/set). This is because in python, methods are
            also attributes of an object, and calling a method is a two-step process: 1) get the method
            attribute which is a callable function, and then 2) calling that method attribute with
            a set of parameters. Since we don't know a priori whether the attribute is a method or
            not, for now we just assume a method. Later, we can implement a Get and Set method to
            work on attributes, or add some intelligence to introspect the class and determine
            which are which. Also, the call resolution is done a run-time, and will result in
            an exception if the referenced method does not exist.
        """
        class aptDotNetMethod(object):
            """
                Represents a .Net method on an object. This is a callable class, and
                created by accessing a method attribute on an aptObject. Calling it
                results in a dynamic call to the .Net object. This results in the
                standard python syntax obj.method(abc).
            """
            def __init__(self, cSharpObject, methodName):
                self._methodName = methodName
                self._object = cSharpObject

            def __call__(self, *args):
                """
                    Invoke _methodName on _object, passing in *args
                """
                try:
                    _PythonProxy.CallCSharp(self._object, kMethod, self._methodName, *args)
                except:
                    type, value, tb = sys.exc_info()
                    traceback.print_exception(type, value, tb)

        def __init__(self, cSharpObject):
            self._object = cSharpObject

        def __getattr__(self, attr):
            return aptDotNetDll.aptDotNetObject.aptDotNetMethod(self._object, attr)

    def __init__(self, filename):
        self._hAssembly = aptGCHandle(_PythonProxy.CallCSharp(None, kLoadDll, filename))
    
    def New(self, typeName, *args):
        return aptDotNetDll.aptDotNetObject(aptGCHandle(_PythonProxy.CallCSharp(self._hAssembly, kNew, typeName, *args)))

################################################################

class aptViewManager(object):
    def __init__(self, gchViewManager):
        self.gchViewManager = gchViewManager
        self.MainView  = None
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
    

    def CreatePanel(self, hWnd, id):
        print "py Create Panel"
        return aptPanel(aptGCHandle(_PythonProxy.CallCSharp(self.gchViewManager, kMethod, "CreatePanel", hWnd, id)))


    def GetPanel(self, i_id):
        gchPanel = aptGCHandle(_PythonProxy.CallCSharp(self.gchViewManager, kMethod, "GetPanel", i_id))
        wrapperObj = _PythonProxy.CallCSharp(gchPanel, kMethod, "GetWrapperObj")
        if wrapperObj!=None:  
            return wrapperObj;
        else:
            return aptPanel(aptGCHandle(_PythonProxy.CallCSharp(self.gchViewManager, kMethod, "GetPanel", i_id)))        



    def CreateNavBarRegion(self, i_id):
        return aptNavBarControl(aptGCHandle(_PythonProxy.CallCSharp(self.gchViewManager, kMethod, "CreateNavBarRegion", i_id)))
    
        
################################################

class aptPanel(object):
    def __init__(self, gchPanel):
        self.gchPanel = gchPanel
        _PythonProxy.CallCSharp(self.gchPanel, kMethod, "SetWrapperObj", self)
        self.m_activeParent = None;
        
        self.m_OnSizeEvent      = None
        self.m_Enter  = None
        self.m_Leave  = None
        
        global pyCount
        pyCount+=1
        print "aptPanel", self
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def Show(self):
        _PythonProxy.CallCSharp(self.gchPanel, kMethod, "Show")
        

    def SetOnSizeEvent(self, callback):
        _PythonProxy.CallCSharp(self.gchPanel, kMethod, "SetOnSizeEvent")
        self.m_OnSizeEvent = callback;

    def SetEnterEvent(self, i_enter):
        _PythonProxy.CallCSharp(self.gchPanel, kMethod, "SetEnterEvent")
        self.m_Enter = i_enter;

    def SetLeaveEvent(self, i_leave):
        _PythonProxy.CallCSharp(self.gchPanel, kMethod, "SetLeaveEvent")
        self.m_Leave = i_leave;

    def OnSizeEvent(self, x, y):
        self.m_OnSizeEvent(x, y)

    def OnEnter(self):
        if (self.m_Enter!=None):
            self.m_Enter()

    def OnLeave(self):
        if self.m_Leave!=None:
            self.m_Leave()
            
    def _getActiveParent(self):
        h = _PythonProxy.CallCSharp(self.gchPanel, kGetProperty, "ActiveParent")
        if h==None:
            return None
        gchActiveParent = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchActiveParent, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            s = gchActiveParent.getType()
            if gchActiveParent.getType()=="guiFramework.FWNavBarGroup":
                self.m_activeParent = aptNavButton(gchActiveParent)
            elif gchActiveParent.getType()=="guiFramework.FWDockRegion":
                self.m_activeParent = aptDockRegion(gchActiveParent)
            else:
                self.m_activeParent = None
        return self.m_activeParent;
    ActiveParent = property(fget=_getActiveParent, fset=None, fdel=None, doc="")

    


class aptRegion(object):
    def __init__(self, gchRegion):
        self.gchRegion = gchRegion
        self.m_activeParent = None;
        #self.m_activeParent = aptRegion(None);
        if gchRegion!=None:
            _PythonProxy.CallCSharp(self.gchRegion, kMethod, "SetWrapperObj", self)
        self.m_OnActiveButtonChanged = None
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def setHandel(self, i_handle):
        print "Py setHandel"
        print "oldHandel=", self.gchRegion
        self.gchRegion = aptGCHandle(i_handle)
        print "newHandel=", self.gchRegion
        
   
    def _getActiveParent(self):
        h = _PythonProxy.CallCSharp(self.gchRegion, kGetProperty, "ActiveParent")
        if h==None:
            return None
        gchActiveParent = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchActiveParent, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            s = gchActiveParent.getType()
            if gchActiveParent.getType()=="guiFramework.FWDockRegion":
                self.m_activeParent = aptDockRegion(gchActiveParent)
            elif gchActiveParent.getType()=="guiFramework.FWNavBarControl":
                self.m_activeParent = aptNavBarControl(gchActiveParent)
            else:
                self.m_activeParent = None
        return self.m_activeParent;
    ActiveParent = property(fget=_getActiveParent, fset=None, fdel=None, doc="")


    def _getParentGuiForm(self):
        gchParentGuiForm = aptGCHandle(_PythonProxy.CallCSharp(self.gchRegion, kGetProperty, "ParentGuiForm"))
        return _PythonProxy.CallCSharp(gchParentGuiForm, kMethod, "GetWrapperObj")
    ParentGuiForm = property(fget=_getParentGuiForm, fset=None, fdel=None, doc="")
   
      
      
    def SelectNavButton(self, i_button):
        _PythonProxy.CallCSharp(self.gchRegion, kMethod, "SelectNavButton", i_button.gchRegion)
        
        
####        
class aptNavButton(aptRegion):
    
    def __init__(self, gchRegion):
        aptRegion.__init__(self, gchRegion)
        print "&&& init aptNavButton"
    
    def SetActiveButtonChanged(self, i_callback):
        self.m_OnActiveButtonChanged = i_callback
        _PythonProxy.CallCSharp(self.gchRegion, kMethod, "SetActiveButtonChanged")
        
    
    # callbacks
    def OnActiveButtonChanged(self):
        self.m_OnActiveButtonChanged(self)


class aptNavBarControl(aptRegion):
    def __init__(self, gchRegion):
        aptRegion.__init__(self, gchRegion)
        print "&&& init aptNavButton"
        
        
class aptDockRegion(aptRegion):
    def __init__(self, gchRegion):
        aptRegion.__init__(self, gchRegion)
        print "&&& init aptDockRegion"
      
    def _getTabbed(self):
        print "{1{{{ aptDockRegion._getTabbed"
        return _PythonProxy.CallCSharp(self.gchRegion, kGetProperty, "Tabbed")    
    def _setTabbed(self, tabbed):
        print "{2{{{ aptDockRegion._setTabbed"
        _PythonProxy.CallCSharp(self.gchRegion, kSetProperty, "Tabbed", tabbed)
    Tabbed = property(fget=_getTabbed, fset=_setTabbed, fdel=None, doc="")
        

    def _getWidth(self):
        return _PythonProxy.CallCSharp(self.gchRegion, kGetProperty, "Width")    
    def _setWidth(self, width):
        _PythonProxy.CallCSharp(self.gchRegion, kSetProperty, "Width", width)
    Width = property(fget=_getWidth, fset=_setWidth, fdel=None, doc="")

    def _getHeight(self):
        return _PythonProxy.CallCSharp(self.gchRegion, kGetProperty, "Height")    
    def _setHeight(self, height):
        _PythonProxy.CallCSharp(self.gchRegion, kSetProperty, "Height", height)
    Height = property(fget=_getHeight, fset=_setHeight, fdel=None, doc="")


        
################################################

class aptImageManager:
    def __init__(self, gchImageManager):
        self.gchImageManager = gchImageManager
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        
    def AddImage(self, fileName, key):
        _PythonProxy.CallCSharp(self.gchImageManager, kMethod, "AddImage", fileName, key)
        
    def SetTransperentColor(self, key, x, y):
        _PythonProxy.CallCSharp(self.gchImageManager, kMethod, "SetTransperentColor", key, x, y)
        
    
#################################################

class aptCommandManager(object):
    def __init__(self, gchCommandManager):
        self.gchCommandManager = gchCommandManager
        self.MenuBar   = aptBar(aptGCHandle(_PythonProxy.CallCSharp(gchCommandManager, kMethod, "GetMenuBar")))
        self.StatusBar = aptBar(aptGCHandle(_PythonProxy.CallCSharp(gchCommandManager, kMethod, "GetStatusBar")))
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
    

    def CreateCommandGroup(self, sText):
        return aptCommandGroup(aptGCHandle(_PythonProxy.CallCSharp(self.gchCommandManager, kMethod, "CreateCommandGroup", sText)))
        
       
    def CreateCommand(self, sText):
        return aptCommand(aptGCHandle(_PythonProxy.CallCSharp(self.gchCommandManager, kMethod, "CreateCommand", sText)))

    def CreateCommandStatic(self, sText):
       return aptCommand(aptGCHandle(_PythonProxy.CallCSharp(self.gchCommandManager, kMethod, "CreateCommandStatic", sText)))
        
    def GetToolBar(self, sCategory):
        return aptBar(aptGCHandle(_PythonProxy.CallCSharp(self.gchCommandManager, kMethod, "GetToolBar", sCategory)))


    def CreateCommandPopup(self): 
        return aptCommandPopup(aptGCHandle(_PythonProxy.CallCSharp(self.gchCommandManager, kMethod, "CreateCommandPopup")))        
    

class aptCommandBase(object):
    def __init__(self, gchCommandBase):
        self.gchCommandBase = gchCommandBase 
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def _getText(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "Text")    
    def _setText(self, text):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "Text", text)
    Text = property(fget=_getText, fset=_setText, fdel=None, doc="")


    def _getTooltip(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "Tooltip")    
    def _setTooltip(self, tooltip):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "Tooltip", tooltip)
    Tooltip = property(fget=_getTooltip, fset=_setTooltip, fdel=None, doc="")


    def _getEnabled(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "Enabled")    
    def _setEnabled(self, enabled):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "Enabled", enabled)
    Enabled = property(fget=_getEnabled, fset=_setEnabled, fdel=None, doc="")
    


class aptCommandGroup(aptCommandBase):

    def __init__(self, gchCommandGroup):
        aptCommandBase.__init__(self, gchCommandGroup)
        self._insertSeparatorOnNextAdd = False
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
    
#    def CreateCommand(self, sText):
#        return aptCommand(_PythonProxy.CallCSharp(self.gchCommand, kMethod, "CreateCommand", sText))

    def AddSeparator(self):
        """
            Emulated command that cause separator to be added above next item added
        """
        self._insertSeparatorOnNextAdd = True
        
    def Add(self, commandBase, beginGroup=None):
        if beginGroup is None:
            beginGroup = self._insertSeparatorOnNextAdd
        _PythonProxy.CallCSharp(self.gchCommandBase, kMethod, "Add", commandBase.gchCommandBase, beginGroup)
        self._insertSeparatorOnNextAdd = False


    
        
class aptCommand(aptCommandBase):
    kStyleDefault = 0
    kStyleCheck   = 1
    
    def __init__(self, gchCommand):
        aptCommandBase.__init__(self, gchCommand)
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def _getImageId(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "ImageId")
    def _setImageId(self, id):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "ImageId", id)        
    ImageId = property(fget=_getImageId, fset=_setImageId, fdel=None, doc="")        


    def setCallback(self, onCommand):
        _PythonProxy.CallCSharp(self.gchCommandBase, kMethod, "SetOnCommand", onCommand)


    def _getStyle(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "Style")
    def _setStyle(self, style):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "Style", style)
    Style = property(fget=_getStyle, fset=_setStyle, fdel=None, doc="")        


    def _getChecked(self):
        return _PythonProxy.CallCSharp(self.gchCommandBase, kGetProperty, "Checked")
    def _setChecked(self, checked):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "Checked", checked)        
    Checked = property(fget=_getChecked, fset=_setChecked, fdel=None, doc="")        



    def _setItemShortcut(self, itemShortcut):
        _PythonProxy.CallCSharp(self.gchCommandBase, kSetProperty, "ItemShortcut", itemShortcut)        
    ItemShortcut = property(fget=None, fset=_setItemShortcut, fdel=None, doc="")        


        

class aptBar(object):
    def __init__(self, gchBar):
        self._gchBar = gchBar
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        
    def _getCaption(self):
        return _PythonProxy.CallCSharp(self._gchBar, kGetProperty, "Caption")
    def _setCaption(self, caption):
        _PythonProxy.CallCSharp(self._gchBar, kSetProperty, "Caption", caption)
    Caption = property(fget=_getCaption, fset=_setCaption, fdel=None, doc="")        
        
    def Add(self, commandBase, beginGroup=False):
        _PythonProxy.CallCSharp(self._gchBar, kMethod, "Add", commandBase.gchCommandBase, beginGroup)


    def _getVisible(self):
        return _PythonProxy.CallCSharp(self._gchBar, kGetProperty, "Visible")
    def _setVisible(self, visible):
        _PythonProxy.CallCSharp(self._gchBar, kSetProperty, "Visible", visible)
    Visible = property(fget=_getVisible, fset=_setVisible, fdel=None, doc="")        





class aptCommandPopup(object):
    def __init__(self, gchCommandPopup):
        self._gchCommandPopup = gchCommandPopup
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        
    def Add(self, commandBase, beginGroup=False):
        _PythonProxy.CallCSharp(self._gchCommandPopup, kMethod, "Add", commandBase.gchCommandBase, beginGroup)



#################################################
class aptTreeControl(object):
    def __init__(self, gchCollection):
        self.gchCollection = gchCollection
        self.TreeNodes = aptTreeCollection(aptGCHandle(_PythonProxy.CallCSharp(gchCollection, kMethod, "GetCollection")))
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def GetToolbar(self):
        return aptBar(aptGCHandle(_PythonProxy.CallCSharp(self.gchCollection, kMethod, "GetToolbar")))

    def _getEnableRename(self):
        return _PythonProxy.CallCSharp(self.gchCollection, kGetProperty, "EnableRename")    
    def _setEnableRename(self, enable):
        _PythonProxy.CallCSharp(self.gchCollection, kSetProperty, "EnableRename", enable)
    EnableRename = property(fget=_getEnableRename, fset=_setEnableRename, fdel=None, doc="")

    
    def SetOnSelected(self, callback):
        _PythonProxy.CallCSharp(self.gchCollection, kMethod, "SetOnSelected", callback)

    def SetOnUnSelected(self, callback):
        _PythonProxy.CallCSharp(self.gchCollection, kMethod, "SetOnUnSelected", callback)
        

    def SetOnAfterLabelEdit(self, callback):
        _PythonProxy.CallCSharp(self.gchCollection, kMethod, "SetOnAfterLabelEdit", callback)


    def SetOnBeforeLabelEdit(self, callback):
        _PythonProxy.CallCSharp(self.gchCollection, kMethod, "SetOnBeforeLabelEdit", callback)
    
        
    def _getSelectedNode(self):
        handle = _PythonProxy.CallCSharp(self.gchCollection, kGetProperty, "SelectedNode1")
        if handle!=None:
            gchNode = aptGCHandle(handle)
            node = _PythonProxy.CallCSharp(gchNode, kGetProperty, "Tag")
            return node
        else:
            return None
        
    def _setSelectedNode(self, node):
        _PythonProxy.CallCSharp(self.gchCollection, kSetProperty, "SelectedNode1", node.gchNode)
    SelectedNode = property(fget=_getSelectedNode, fset=_setSelectedNode, fdel=None, doc="")

    def ExpandAll(self):
        _PythonProxy.CallCSharp(self.gchCollection, kMethod, "ExpandAll")

    def IsModuleRegistered(self, gchNode):
        return _PythonProxy.CallCSharp(aptGCHandle(gchNode), kMethod, "IsModuleRegistered")
    

class aptTreeNode(object):
    def __init__(self, gchCollection, id):
        self.gchNode      = aptGCHandle(_PythonProxy.CallCSharp(gchCollection, kMethod, "AddChild", id))
        self.Block = None
        
        self.Nodes = aptTreeCollection(aptGCHandle(_PythonProxy.CallCSharp(self.gchNode, kMethod, "GetCollection")))
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        

    def _getText(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Text")
    
    def _setText(self, sText):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Text", sText)
    Text = property(fget=_getText, fset=_setText, fdel=None, doc="")

    def _getId(self):
        #print "Python getId"
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Id")
    def _setId(self, sId):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Id", sId)
    Id = property(fget=_getId, fset=_setId, fdel=None, doc="")
    
        
    def _getTag(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Tag")
    def _setTag(self, tag):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Tag", tag)
    Tag = property(fget=_getTag, fset=_setTag, fdel=None, doc="")        


    def _getEnabled(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Enabled")    
    def _setEnabled(self, enabled):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Enabled", enabled)
    Enabled = property(fget=_getEnabled, fset=_setEnabled, fdel=None, doc="")

    def _getChecked(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Checked")    
    def _setChecked(self, checked):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Checked", checked)
    Checked = property(fget=_getChecked, fset=_setChecked, fdel=None, doc="")

    def _getImageId(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "ImageId")
    def _setImageId(self, id):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "ImageId", id)        
    ImageId = property(fget=_getImageId, fset=_setImageId, fdel=None, doc="")        

    def _getSelectedImageId(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "SelectedImageId")
    def _setSelectedImageId(self, id):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "SelectedImageId", id)        
    SelectedImageId = property(fget=_getSelectedImageId, fset=_setSelectedImageId, fdel=None, doc="")        

    def _getCheckedImageId(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "CheckedImageId")
    def _setCheckedImageId(self, id):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "CheckedImageId", id)        
    CheckedImageId = property(fget=_getCheckedImageId, fset=_setCheckedImageId, fdel=None, doc="")        


    def _getParent(self):
        prt = _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Parent")
        if prt==None:
            return None
        gchParentNode = aptGCHandle(prt)
        tag = _PythonProxy.CallCSharp(gchParentNode, kGetProperty, "Tag")
        return tag
    Parent = property(fget=_getParent, fset=None, fdel=None, doc="")                

    def _isEditable(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Editable")
    def _setEditable(self, editable):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "Editable", editable)
    Editable = property(fget=_isEditable, fset=_setEditable, fdel=None, doc="")        


    def BeginEdit(self):
        _PythonProxy.CallCSharp(self.gchNode, kMethod, "BeginEdit")

    def EndEdit(self, i_cancel):
        _PythonProxy.CallCSharp(self.gchNode, kMethod, "EndEdit", i_cancel)

    def _getCommandPopup(self):
        return _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "CommandPopup")
    def _setCommandPopup(self, CommandPopup):
        _PythonProxy.CallCSharp(self.gchNode, kSetProperty, "CommandPopup", CommandPopup._gchCommandPopup)
    CommandPopup = property(fget=_getCommandPopup, fset=_setCommandPopup, fdel=None, doc="")        



class aptTreeCollection:
    def __init__(self, gchCollection):
        self._gchCollection = gchCollection
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        
    def AddChild(self, id):
        node = aptTreeNode(self._gchCollection, id)
        return node

    def RemoveChild(self, node):
        _PythonProxy.CallCSharp(self._gchCollection, kMethod, "RemoveChild", node.gchNode)
   
    def _getCount(self):
        return _PythonProxy.CallCSharp(self._gchCollection, kGetProperty, "Count")
    Count = property(fget=_getCount, fset=None, fdel=None, doc="")        
    
    def GetNode(self, index):
        csNode = _PythonProxy.CallCSharp(self._gchCollection, kMethod, "GetNode", index)
        if csNode==None:
            return None
        gchNode = aptGCHandle(csNode)
        pyNode = _PythonProxy.CallCSharp(gchNode, kGetProperty, "Tag")
        return pyNode
    
        prt = _PythonProxy.CallCSharp(self.gchNode, kGetProperty, "Parent")
        if prt==None:
            return None
        gchParentNode = aptGCHandle(prt)
        tag = _PythonProxy.CallCSharp(gchParentNode, kGetProperty, "Tag")
        return tag
    
    
   

################################################################


class aptMessageDispatcher(object):
    def __init__(self, gchMessageDispatcher):
        self.gchMessageDispatcher = gchMessageDispatcher
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def HasModule(self, id):   
        return _PythonProxy.CallCSharp(self.gchMessageDispatcher, kMethod, "HasModule", id)
    
    def Send(self, ReceiverModuleId, Command, *Args):
        print "@ Python Send to %s, Command %s" % (ReceiverModuleId, Command)
        result = _PythonProxy.CallCSharp(self.gchMessageDispatcher, kMethod, "Send", ReceiverModuleId, Command, Args)
        print "@ Python Send result", result
        return result
    
    def Broadcast(self, Command, *Args):
        _PythonProxy.CallCSharp(self.gchMessageDispatcher, kMethod, "Broadcast", Command, Args)


    
################################################################



class aptGuiForm(object):
    def __init__(self, gchGuiForm):
        self.gchGuiForm = gchGuiForm
        self.CommandManager = None
        self.RegionManager = None
        if gchGuiForm:
            _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "SetWrapperObj", self)
        global pyCount
        pyCount+=1
   
    def __del__(self):
        global pyCount
        pyCount-=1

    def _getCaption(self):
        return _PythonProxy.CallCSharp(self.gchGuiForm, kGetProperty, "Caption")
    def _setCaption(self, caption):
        _PythonProxy.CallCSharp(self.gchGuiForm, kSetProperty, "Caption", caption)
    Caption = property(fget=_getCaption, fset=_setCaption, fdel=None, doc="")


    def _getStartMode(self):
        return _PythonProxy.CallCSharp(self.gchGuiForm, kGetProperty, "StartMode")
    StartMode = property(fget=_getStartMode, fset=None, fdel=None, doc="")

    def _getCurrentMode(self):
        return _PythonProxy.CallCSharp(self.gchGuiForm, kGetProperty, "CurrentMode")
    CurrentMode = property(fget=_getCurrentMode, fset=None, fdel=None, doc="")
    
    def _getParentGuiForm(self):
        h = _PythonProxy.CallCSharp(self.gchGuiForm, kGetProperty, "ParentGuiForm")
        if h==None:
            return None
        gchParentGuiForm = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchParentGuiForm, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            return aptGuiForm( gchParentGuiForm )
    ParentGuiForm = property(fget=_getParentGuiForm, fset=None, fdel=None, doc="")
    
    def LoadMode(self, i_mode):
        _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "LoadMode", i_mode)    

    def SaveMode(self):
        print "Py SaveMode", self.gchGuiForm
        _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "SaveMode")    

    def Show(self):
        _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "Show")    
        
    def Hide(self):
        _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "Hide")    

    def ResetAllModes(self):
        _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "ResetAllModes")    

    def GetFormCommandManager(self):
        if self.CommandManager == None :
            h = _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "GetFormCommandManager")
            if h==None:
                return None
            gchCommandManager = aptGCHandle(h)
            wrapperObj = _PythonProxy.CallCSharp(gchCommandManager, kMethod, "GetWrapperObj")
            if wrapperObj!=None:
                self.CommandManager = wrapperObj;
            else:
                self.CommandManager = aptFormCommandManager( gchCommandManager )
        return self.CommandManager

    def GetFramework(self):
        return aptFramework.GetFramework()

    def GetRegionManager(self):
        if self.RegionManager == None :
            h = _PythonProxy.CallCSharp(self.gchGuiForm, kMethod, "GetRegionManager")
            if h==None:
                return None
            gchRegionManager = aptGCHandle(h)
            wrapperObj = _PythonProxy.CallCSharp(gchRegionManager, kMethod, "GetWrapperObj")
            if wrapperObj!=None:
                self.RegionManager = wrapperObj;
            else:
                self.RegionManager = aptRegionManager( gchRegionManager )
        return self.RegionManager
    
    def _getHandle(self):
        return _PythonProxy.CallCSharp(self.gchGuiForm, kGetProperty, "Handle")
    Handle = property(fget=_getHandle, fset=None, fdel=None, doc="")


class aptRegionManager:
    def __init__(self, gchRegionManager):
        self.gchRegionManager = gchRegionManager
        if gchRegionManager:
            _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "SetWrapperObj", self)
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1
        
    def CreateDocRegion(self):
        h = _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "CreateDocRegion")
        if h==None:
            return None
        gchDocRegion = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchDocRegion, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            return aptDockRegion( gchDocRegion )


    def RemoveDocRegion(self, i_region):
        _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "RemoveDocRegion", i_region)
        
    def GetNavBarRegion(self):
        h = _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "GetNavBarRegion")
        if h==None:
            return None
        gchNavBarRegion = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchNavBarRegion, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            navBarRegion = aptNavBarControl( gchNavBarRegion )
            _PythonProxy.CallCSharp(gchNavBarRegion, kMethod, "SetWrapperObj", navBarRegion)
            return navBarRegion
    ### new, unused functions of RegionManager
    #def GetMainRegion(self):
    #    return aptMainRegion( aptGCHandle( _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "GetMainRegion") ) )
    
    #def CreateTabsRegion(self, i_id):
    #    return aptTabsRegion( aptGCHandle( _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "CreateTabsRegion"), i_id ) )

    #def CreateMdiRegion(self, i_id):
    #    return aptMdiRegion( aptGCHandle( _PythonProxy.CallCSharp(self.gchRegionManager, kMethod, "CreateMdiRegion"), i_id ) )

class aptFormCommandManager(object):
    def __init__(self, gchFormCommandManager):
        self.gchFormCommandManager = gchFormCommandManager
        self.MenuBar   = aptBar(aptGCHandle(_PythonProxy.CallCSharp(gchFormCommandManager, kMethod, "GetMenuBar")))
        self.StatusBar = aptBar(aptGCHandle(_PythonProxy.CallCSharp(gchFormCommandManager, kMethod, "GetStatusBar")))
        if gchFormCommandManager:
            _PythonProxy.CallCSharp(self.gchFormCommandManager, kMethod, "SetWrapperObj", self)

        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def GetToolBar(self, sCategory):
        h = _PythonProxy.CallCSharp(self.gchFormCommandManager, kMethod, "GetToolBar", sCategory)
        if h==None:
            return None
        gchToolBar = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchToolBar, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            bar = aptBar( gchToolBar )
            _PythonProxy.CallCSharp(gchToolBar, kMethod, "SetWrapperObj", bar)
            return bar

    def CreateCommandGroup(self, sText):
        h = _PythonProxy.CallCSharp(self.gchFormCommandManager, kMethod, "CreateCommandGroup", sText)
        if h==None:
            return None
        gchCommandGroup = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchCommandGroup, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            comandGroup = aptCommandGroup( gchCommandGroup )
            _PythonProxy.CallCSharp(gchCommandGroup, kMethod, "SetWrapperObj", comandGroup)
            return comandGroup
        
    def CreateCommandPopup(self): 
        h = _PythonProxy.CallCSharp(self.gchFormCommandManager, kMethod, "CreateCommandPopup", sText)
        if h==None:
            return None
        gchCommandPopup = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchCommandPopup, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            comandPopup = aptCommandPopup( gchCommandPopup )
            _PythonProxy.CallCSharp(gchCommandPopup, kMethod, "SetWrapperObj", comandPopup)
            return comandPopup
        
    ### new unused function of FormCommandManager
    #def CreateCommandContainer(self, sText):
    #    return aptCommandContainer(aptGCHandle(_PythonProxy.CallCSharp(self.gchFormCommandManager, kMethod, "CreateCommandGroup", sText)))
        

class aptFramework(object):

    _singleton = None  # singleton

    def GetFramework():
        """
            returns the singleton instance of the framework
        """
        return aptFramework._singleton
    GetFramework = staticmethod(GetFramework)
    
    def __init__(self, hFramework):
        """
            inititializes the framework
        """
        if aptFramework._singleton:
            raise Exception, "Attempt to reinitialize singleton aptFramework"
        self.gchFramework = aptGCHandle(hFramework)
   
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "SetWrapperObj", self)
   
        self.ViewManager        = aptViewManager(aptGCHandle(_PythonProxy.CallCSharp(self.gchFramework, kMethod,   "GetViewManager")))

        self.ImageManager       = aptImageManager(aptGCHandle(_PythonProxy.CallCSharp(self.gchFramework, kMethod,  "GetImageManager")))
        self.TreeControl        = aptTreeControl(aptGCHandle(_PythonProxy.CallCSharp(self.gchFramework, kMethod,   "GetTreeControl")))
        self.CommandManager     = aptCommandManager(aptGCHandle(_PythonProxy.CallCSharp(self.gchFramework, kMethod,   "GetCommandManager")))
        self.m_messageDispatcher  = aptMessageDispatcher(aptGCHandle(_PythonProxy.CallCSharp(self.gchFramework, kMethod,   "GetMessageDispatcher")))
        aptFramework._singleton = self
        global pyCount
        pyCount+=1
        
    def __del__(self):
        global pyCount
        pyCount-=1

    def CreateGuiForm(self, i_gchGuiForm):
        gchGuiForm = aptGCHandle(i_gchGuiForm)
        wrapperObj = _PythonProxy.CallCSharp(gchGuiForm, kMethod, "GetWrapperObj")
        if wrapperObj==None:
            pyGuiForm = aptGuiForm(gchGuiForm)
        
    def GetActiveGuiForm(self):
        h = _PythonProxy.CallCSharp(self.gchFramework, kMethod, "GetActiveGuiForm")
        if h==None:
            return None
        gchActiveGuiForm = aptGCHandle(h)
        wrapperObj = _PythonProxy.CallCSharp(gchActiveGuiForm, kMethod, "GetWrapperObj")
        if wrapperObj!=None:
            return wrapperObj;
        else:
            guiForm = aptGuiForm( gchActiveGuiForm )
            return guiForm

    def _getCaption(self):
        return _PythonProxy.CallCSharp(self.gchFramework, kGetProperty, "Caption")
    def _setCaption(self, caption):
        _PythonProxy.CallCSharp(self.gchFramework, kSetProperty, "Caption", caption)
    Caption = property(fget=_getCaption, fset=_setCaption, fdel=None, doc="")


    def _getStartMode(self):
        return _PythonProxy.CallCSharp(self.gchFramework, kGetProperty, "StartMode")
    StartMode = property(fget=_getStartMode, fset=None, fdel=None, doc="")


    def _getCurrentMode(self):
        return _PythonProxy.CallCSharp(self.gchFramework, kGetProperty, "CurrentMode")
    CurrentMode = property(fget=_getCurrentMode, fset=None, fdel=None, doc="")
    
    def LoadMode(self, i_mode):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "LoadMode", i_mode)    

    def SaveMode(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "SaveMode")    


    def ResetAllModes(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "ResetAllModes")    
        

    def AcquireModal(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "AcquireModal")

    def ReleaseModal(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "ReleaseModal")
        

    def NotifyTestServer(self, host, port):
        self.m_messageDispatcher.Broadcast("Aptixia.Message.SetTestServer", str(host), int(port))

    def NotifyTest(self, testID):
        self.m_messageDispatcher.Broadcast("Aptixia.Message.SetTest", int(testID))

    def NotifySession(self, sessionID):
        self.m_messageDispatcher.Broadcast("Aptixia.Message.SetSession", int(sessionID))

    def BringToFront(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "BringToFront")
        
    def Show(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "Show")
       
    def Hide(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "Hide")
        
    def Exit(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "Exit")

    def Activate(self):
        _PythonProxy.CallCSharp(self.gchFramework, kMethod, "Activate")
        

def InitFramework(hFramework):
    print "InitFramework"
    aptFramework(hFramework)
