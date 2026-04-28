import sys, os, imp, string, types, xml.sax.saxutils, threading, time, atexit, base64, xml.dom.minidom
import Aptixia_prv, traceback, win32process, win32con, win32api, win32event, win32pipe, win32file, socket, select
import weakref, TraceableLock

managedDataLock          = TraceableLock.TraceableLock("managedDataLock")
traceCommunication       = False

"""
class Lock:
    def __init__ (self, lock, text=""):
        self.lock = lock
        self.text = text
#        print "acquire",self.text
        self.lock.acquire ()

    def __del__ (self):
#        print "release",self.text
        self.lock.release ()
"""

class Messages:
    def __init__ (self, messagePath):
        self.messages = {}
        files = os.listdir (messagePath)
        for fileName in files:
            if fileName.find ('.xml') > 0:
                path = messagePath+'/'+fileName
                dom = xml.dom.minidom.parse (file(path))
                top = dom.documentElement
                if top.nodeName != "ixia_message_file":
                    raise LocalError ("Aptixia.ClientLibrary.BadMessageFileFormat", path)
                for child in top.childNodes:
                    if child.nodeType == child.ELEMENT_NODE:
                        if child.nodeName != "status":
                            raise LocalError ("Aptixia.ClientLibrary.BadMessageFileFormat", path)
                        id_string = None
                        text = None
                        description = None
                        for child2 in child.childNodes:
                            if child2.nodeType == child2.ELEMENT_NODE:
                                if child2.nodeName == "id_string":
                                    id_string = self.get_text (child2)
                                elif child2.nodeName == "text":
                                    text = self.get_text (child2)
                                elif child2.nodeName == "description":
                                    description = self.get_text (child2)
                        if id_string != None:
                            self.messages[str(id_string)] = str(text)
                    
    def get_text (self, node):
        text = ''
        for subnode in node.childNodes:
            if subnode.nodeType == subnode.TEXT_NODE:
                text += subnode.nodeValue
            elif subnode.nodeType == subnode.CDATA_SECTION_NODE:
                text += subnode.nodeValue
        return text

    def Resolve (self, id):
        if id in self.messages:
            return self.messages[id]
        else:
            return id
        
def Init (dataPath):
    global messageBase
    messageBase = Messages (dataPath+"/messages")

class Error (Exception):
    def __init__ (self, id=None, text=None, trace=None):
        self.id = id
        self.text = text
        self.trace = trace

    def __str__ (self):
        return self.text

class LocalError (Error):
    def __init__ (self, id, *args):
        global messageBase
        Error.__init__ (self, id)
        message = messageBase.Resolve (id)
        for i in range(1,10):
            while message.find ('%%%d%%' % i) >= 0 and i <= len(args):
                message = message.replace ('%%%d%%' % i, args[i-1])
        self.text = message

class Response:
    def __init__ (self):
        self.error=None
    pass

basicTypes = ( "int8", "int16", "int32", "int64", "string", "double", "bool", "octects", "file" )
lists = ["IxList"]
structs = ["IxStruct"]

class IxProperty( property ):
    def __init__( self, name, fget = None, fset = None, fdel = None, doc = None ):
        property.__init__( self, fget, fset, fdel, doc )
        self.__name = name
        self.blnDirty = False

    def __get__( self, obj, objtype = None ):
        lock = TraceableLock.ScopeLock(managedDataLock, "IxProperty.__get__")
        if obj is None:
            return self
        if self.fget is None:
            raise LocalError ("Aptixia.ClientLibrary.PropertyNotFound", self.__name)
        return self.fget( obj, self.__name )

    def __set__( self, obj, value ):
        lock = TraceableLock.ScopeLock(managedDataLock, "IxProperty.__get__")
        if self.fset is None:
            raise LocalError ("Aptixia.ClientLibrary.PropertyNotFound", self.__name)
        self.fset( obj, self.__name, value )
        self.blnDirty = True

class IxEnum (object):
    def toXmlClass (cls, strArgDirection, strMemberName, blnNaked, value):
        if blnNaked:
            strXML = ""
        else:
            if strMemberName:
                strXML = "<member name=\"%s\" type=\"%s\">" % ( strMemberName, cls.getType() )
            elif strArgDirection:
                strXML = "<argument type=\"%s\" direction=\"%s\">" % ( cls.getType(), strArgDirection )
            else:
                strXML = "<item type=\"%s\">" % cls.getType()

        strXML += "%d" % (value)

        if not blnNaked:
            if strMemberName:
                strXML = strXML + "</member>"
            elif strArgDirection:
                strXML = strXML + "</argument>"
            else:
                strXML = strXML + "</item>"
                
        return strXML

    toXmlClass = classmethod (toXmlClass)

    def toXML ( self, strArgDirection = None, strMemberName = None, blnNaked = False ):
        if blnNaked:
            strXML = ""
        else:
            if strMemberName:
                strXML = "<member name=\"%s\" type=\"%s\">" % ( strMemberName, self.getListType() )
            elif strArgDirection:
                strXML = "<argument type=\"%s\" direction=\"%s\">" % ( self.getType(), strArgDirection )
            else:
                strXML = "<item type=\"%s\">" % self.getType()

        strXML += self.getValue ()

        if not blnNaked:
            if strMemberName:
                strXML = strXML + "</member>"
            elif strArgDirection:
                strXML = strXML + "</argument>"
            else:
                strXML = strXML + "</item>"
                
        return strXML    

# functions mutable lists are supposed to support:
# append(), count(), index(), extend(), insert(), pop(), remove(), reverse() and sort(),         
# __add__(), __radd__(), __iadd__(), __mul__(), __rmul__() and __imul__()

class IxList:
    def __init__( self, strType ):
        self._strType = strType
        self.blnDirty = True
        self.internalList = []

    def getListType( self ):
        if not self._strType:
            raise LocalError ("Aptixia.ClientLibrary.InternalError")
        if self._strType[:3] == "int":
            return "IntList"
        elif self._strType == "double":
            return "DoubleList"
        elif self._strType == "string":
            return "StringList"
        else:
            return self._strType


    def toXmlClass (cls, strArgDirection, strMemberName, blnNaked, value):
        if blnNaked:
            strXML = ""
        else:
            if strMemberName:
                strXML = "<member name=\"%s\" type=\"%s\">" % ( strMemberName, cls.getType() )
            elif strArgDirection:
                strXML = "<argument type=\"%s\" direction=\"%s\">" % ( cls.getType(), strArgDirection )
            else:
                strXML = "<item type=\"%s\">" % cls.getType()

        elementType = cls.getElementType ()            
        for currentElement in value:
            if elementType == "bool":
                if currentElement:
                    strXML = strXML + "<item type=\"bool\">1</item>"
                else:
                    strXML = strXML + "<item type=\"bool\">0</item>"
            elif elementType == "octets":
                strXML = strXML + "<item type=\"octets\">%s</item>" % (base64.encodestring ( currentElement ))
            elif elementType == "string":
                strXML = strXML + "<item type=\"string\">%s</item>" % (xml.sax.saxutils.escape ( currentElement ))
            elif (isinstance( currentElement, IxList )) or (isinstance( currentElement, IxStruct )) :
                strXML = strXML + currentElement.toXML( None )
            elif isinstance( currentElement, ClientObjectBase ):
                strXML = strXML + currentElement.toXML( "item" )
            else:
                elementClass = cls.getElementClass ()
                if elementClass != None:
                    strXML += elementClass.toXmlClass (None, None, False, currentElement)
                else:
                    strXML += "<item type=\"%s\">%s</item>" % (elementType, str(currentElement) )

        if not blnNaked:
            if strMemberName:
                strXML = strXML + "</member>"
            elif strArgDirection:
                strXML = strXML + "</argument>"
            else:
                strXML = strXML + "</item>"

        return strXML
    toXmlClass = classmethod (toXmlClass)

    def toXML( self, strArgDirection = None, strMemberName = None, blnNaked = False ):
        if self.getType() != "IxList":
            return self.toXmlClass (strArgDirection, strMemberName, blnNaked, self)
        
        if blnNaked:
            strXML = ""
        else:
            if strMemberName:
                strXML = "<member name=\"%s\" type=\"%s\">" % ( strMemberName, self.getListType() )
            elif strArgDirection:
                strXML = "<argument type=\"%s\" direction=\"%s\">" % ( self.getType(), strArgDirection )
            else:
                strXML = "<item type=\"%s\">" % self.getType()
            
        for currentElement in self.internalList:
            if self._strType == "bool":
                if currentElement:
                    strXML = strXML + "<item type=\"bool\">1</item>"
                else:
                    strXML = strXML + "<item type=\"bool\">0</item>"
            elif self._strType == "string":
                    strXML = strXML + "<item type=\"string\">%s</item>" % (
                        xml.sax.saxutils.escape (currentElement))
            elif (isinstance( currentElement, IxList )) or (isinstance( currentElement, IxStruct )) :
                strXML = strXML + currentElement.toXML( None )
            elif isinstance( currentElement, ClientObjectBase ):
                strXML = strXML + currentElement.toXML( "item" )
            else:
                strXML = "%s<item type=\"%s\">%s</item>" % (strXML, self._strType, str(currentElement) )

        if not blnNaked:
            if strMemberName:
                strXML = strXML + "</member>"
            elif strArgDirection:
                strXML = strXML + "</argument>"
            else:
                strXML = strXML + "</item>"

        return strXML        
            
    def getType():
        return "IxList"
    getType = staticmethod(getType)

    def getArgType( self ):
        return "list"

    # internalAppend is used to populate a list without setting off the dirty flag
    def internalAppend (self, arg):
        lock = TraceableLock.ScopeLock(managedDataLock, "IxList.internalAppend")
        self.internalList.append (arg)

    def append (self, arg):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.append")
        self.blnDirty = True
        self.internalList.append (arg)

    def count (self, value):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.count")
        return self.internalList.count (value)

    def index (self, a):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.index")
        return self.internalList.index (a)

    def extend (self, a):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.extend")
        self.blnDirty = True
        self.internalList.extend (a)

    def insert (self, i, x):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.insert")
        self.blnDirty = True
        self.internalList.insert (i, x)

    def pop (self, i=0):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.pop")
        self.blnDirty = True
        return self.internalList.pop (i)

    def remove (self, x):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.remove")
        self.blnDirty = True
        self.internalList.remove (x)

    def clear (self):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.clear")
        self.blnDirty = True
        self.internalList = []

    def __iter__ (self):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__iter__")
        return self.internalList.__iter__ ()

    def __len__ (self):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__len__")
        return len (self.internalList)

    def __getitem__ (self, index):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__getitem__")
        return self.internalList[index]

    def __setitem__ (self, index, value):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__setitem__")
        self.blnDirty = True
        self.internalList[index] = value
        
    def __delitem__ (self, index):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__delitem__")
        self.blnDirty = True
        del self.internalList[index]

    def __eq__ (self, other):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__eq__")
        return self.internalList.__eq__ (other)
   
    def __ne__ (self, other):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxList.__ne__")
        return self.internalList.__ne__ (other)

class IxStruct:
    def __init__( self ):
        self._version = "0"
        self._types = dict()
        self.blnDirty = True

    def toXmlClass (cls, strArgDirection, strMemberName, blnNaked, value):
        return value.toXML (strArgDirection, strMemberName, blnNaked)
    toXmlClass = classmethod (toXmlClass)
    
    def toXML( self, strArgDirection = None, strMemberName = None, blnNaked = False ):
        if blnNaked:
            strXML = ""
        else:
            if strMemberName:
                strXML = "<member name=\"%s\" type=\"%s\" version=\"%s\">" % \
                         ( strMemberName, self.getType(), self._version )
            elif strArgDirection:
                strXML = "<argument type=\"%s\" version=\"%s\" direction=\"%s\">" % \
                         ( self.getType(), self._version, strArgDirection )
            else:
                strXML = "<item type=\"%s\">" % self.getType()
            
        for currentMember in self._types.keys():
            strType = self._types[currentMember]
            value = self.__dict__[currentMember]
            if strType == "bool":
                if value:
                    strXML = strXML + "<member name=\"%s\" type=\"bool\">1</member>" % currentMember
                else:
                    strXML = strXML + "<member name=\"%s\" type=\"bool\">0</member>" % currentMember
            elif strType == "octets":
                    strXML = strXML + "<member name=\"%s\" type=\"octets\">%s</member>" % (
                        currentMember, base64.encodestring (value))
            elif strType == "string":
                    strXML = strXML + "<member name=\"%s\" type=\"string\">%s</member>" % (
                        currentMember, xml.sax.saxutils.escape (value))
            elif ( isinstance( value, IxList ) ) or ( isinstance( value, IxStruct ) ):
                strXML = strXML + value.toXML( None, currentMember )
            else:
                strXML = "%s<member name=\"%s\" type=\"%s\">%s</member>" % \
                         (strXML, currentMember, strType, str(value) )


        if not blnNaked:
            if strMemberName:
                strXML = strXML + "</member>"
            elif strArgDirection:
                strXML = strXML + "</argument>"
            else:
                strXML = strXML + "</item>"
        return strXML
            
    def getType( self ):
        return "IxStruct"
            
    def getArgType( self ):
        return "struct"

class IxObjectList:
    def __init__( self, transactionContext, strType ):
        self.transactionContext = transactionContext
        self._strType = strType
        self.blnDirty = True
        self.originalIds = [] # list of ids sent from the server
        self.objectList = [] # list of client object proxies

    def __len__ (self):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.__len__")
        return len (self.objectList)

    def __getitem__( self, key):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.__getitem__")
        return self.objectList[key]

    def __setitem__( self, key, newObject):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.__setitem__")
        self.blnDirty = True
        self.objectList[key] = newObject

    def __delitem__( self, key):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.__delitem__")
        self.blnDirty = True
        del self.objectList[key]

    def __iter__( self):
        return self.objectList.__iter__ ()

    def clear (self):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.clear")
        while len (self.objectList) > 0:
            self.__delitem__ (0)

    def append( self, newObject):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.append")
        newObject.MarkAsAdded()
        self.blnDirty = True
        self.objectList.append (newObject)

    def addOriginalEntry (self, newObject):
        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.addOriginalEntry")
        self.originalIds.append (newObject.objID)
        self.objectList.append (newObject)

    def getListType( self ):
        return self._strType

    def flushList (self, parent, listName):
        # because we only allow appending at the end, we know that
        # the pre-existing objects must be consecutive, minus any deleted
        # objects.

        lock = TraceableLock.ScopeLock (managedDataLock, "IxObjectList.flushList")
        currentIndex = 0
        for preExistingId in self.originalIds:
            if currentIndex >= len (self.objectList) or preExistingId != self.objectList[currentIndex].objID:
                # this object id was deleted, send message
                parent._DeleteListMember (listName, int(preExistingId));
            else:
                # this object still exists
                currentIndex += 1

        # currentIndex points to the first of the new objects
        while currentIndex < len (self.objectList):
            # send add message
            object = self.objectList[currentIndex]
            xml = object.toXML ()
            parent._AppendListMember (listName, object.getType (), int(object.objID), xml);
            #print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
            #print xml
            
            currentIndex += 1

        self.blnDirty = False
        self.updateShadowCopy ()        

    # only called when entire list is new - which implies all its members are new too        
    def toXML (self):
        strXML = ''
        for object in self.objectList:
            strXML += object.toXML (object.getType ())

        self.updateShadowCopy ()
        return strXML

    def updateShadowCopy (self):
        self.originalIds = []
        for object in self.objectList:
            self.originalIds.append (object.objID)

    def clean (self):
        self.blnDirty = False
        for object in self.objectList:
            object.cleanProperties ()

class ContextBase:
    def __init__( self, transactionContext, objectType, objectID, argTuple, callback = None, callbackArg = None ):
        if not isinstance (transactionContext, TransactionContext):
            raise LocalError ("Aptixia.ClientLibrary.InternalError")
        self.transactionContext = transactionContext
        self.socket = transactionContext.socket
        self.requestID = self.socket.GetNextRequestID()
        self.objectType = objectType
        self.strObjectID = str(objectID)
        self.argTuple = argTuple
        self.callback = callback
        self.callbackArg = callbackArg
        self.done = threading.Event()

        self.error   = None
        self.results = None
        self.blnCompleted = False
        self.blnAbort = False


    def Sync( self ):
        #print "Sync"
        if (threading.currentThread() == self.socket):
            raise LocalError ("Aptixia.ClientLibrary.DeadlockCondition")
        self.done.wait()
        if self.error:
            raise Error (self.error.id, self.error.text, self.error.trace)
        return self.results

    def SyncWait( self, intTimeout ):
        raise LocalError ("Aptixia.ClientLibrary.NotImplemented")
    
    def Failed( self ):
        self.done.set ()

    def Complete (self):
        self.done.set ()

class RpcContext (ContextBase):
    def __init__( self, transactionContext, objectType, objectID, method, argTuple, callback = None, callbackArg = None ):
        ContextBase.__init__ (self, transactionContext, objectType, objectID, argTuple, callback = None, callbackArg = None)
        
        #make the call
        self.socket.MakeAsyncCall( self, self.requestID, self.objectType, self.strObjectID, method, self.argTuple)
        
    def Complete (self):
        self.transactionContext.DeleteTransaction (self.requestID)
        ContextBase.Complete (self)

class EventContext (ContextBase):
    def __init__( self, transactionContext, objectType, objectID, eventName, argTuple, callback, callbackArg):
        self.eventName = eventName
        ContextBase.__init__ (self, transactionContext, objectType, objectID, argTuple, callback, callbackArg)

        # register the event
        self.socket.RegisterEventCall (self)
    
    def Complete (self):
        if len(dir(self.results)) > 4:
            # this response contains data
            self.callback (self.callbackArg, self.results)
        else:
            ContextBase.Complete (self)
     
    def Failed( self ):
        if self.callback:
            self.results.error=Error(self.error.id, self.error.text, self.error.trace)
            self.callback (self.callbackArg, self.results)

    def Unregister (self):
        self.socket.EventCancellationCall (self)

class XProtocolSocket( threading.Thread ):
    _socket = None
    _intNextRequestID = 0
    _blnAbort = False
    _pendingResults = dict()
    _ProcessResponseDepth = 0;
        
    def __init__( self, transactionContext, strAddress, intPort, intStartingID = 0 ):
        self.socketThreadLock = TraceableLock.TraceableLock("socketThreadLock")
        
        self.targetHostname = strAddress
        self.targetPort = intPort

        if not isinstance (transactionContext, TransactionContext):
            raise LocalError ("Aptixia.ClientLibrary.InternalError")
        self.transactionContext = transactionContext
        try:
            self._intNextRequestID = intStartingID
            self._socket = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
            self._socket.connect( (strAddress, intPort) )
            self._socket.setblocking( 1 )
        except:
            raise LocalError ("Aptixia.XProtocol.FailedToConnect", strAddress + ":" + str(intPort) )

        threading.Thread.__init__( self )
        self.setDaemon( True )
        self.start()
        
    def __del__( self ):
        if self._socket != None:
            self._socket.close()

    def writeToSocket (self, data):
        lock = TraceableLock.ScopeLock (self.socketThreadLock, 'writeToSocket')
        try:
            self._socket.sendall( data )
        except:
            traceback.print_exc ()
            raise LocalError ("Aptixia.XProtocol.SocketError")

    def MakeAsyncCall( self, rpcContext, intRequestID, objectType, strObjectID, strMethodName, tupleArgs = None,
                       callback = None, callbackArg = None ):
        request = rpcContext
        request.strRequestXML = "<object-request request-id=\"%i\" type=\"%s\" address=\"ts/%s\">" % \
                (intRequestID, objectType, strObjectID )
        request.strRequestXML = request.strRequestXML + "<method>" + strMethodName + "</method>"
        
        for currentArg in tupleArgs:
            request.strRequestXML += currentArg.toXml (self.transactionContext, currentArg.direction)

        request.strRequestXML = request.strRequestXML + "</object-request>\0"

        self.transactionContext.AddTransaction (intRequestID, request)
        self.writeToSocket (request.strRequestXML)        

        return intRequestID

    def RegisterEventCall( self, eventContext):
        request = eventContext
        request.strRequestXML = "<event-request request-id=\"%i\"  type=\"%s\" address=\"ts/%s\">" % \
                (request.requestID, request.objectType, request.strObjectID )
        request.strRequestXML = request.strRequestXML + "<event>" + eventContext.eventName + "</event>"
        request.strRequestXML = request.strRequestXML + "</event-request>\0"

        self.transactionContext.AddTransaction (request.requestID, request)
        self.writeToSocket (request.strRequestXML)        

    def EventCancellationCall( self, eventContext):
        request = eventContext
        request.strRequestXML = "<event-cancellation request-id=\"%i\"  type=\"%s\" address=\"ts/%s\">" % \
                (request.requestID, request.objectType, request.strObjectID )
        request.strRequestXML = request.strRequestXML + "<event>" + eventContext.eventName + "</event>"
        request.strRequestXML = request.strRequestXML + "</event-cancellation>\0"
        self.writeToSocket (request.strRequestXML)        
    
    def run( self ):
        strPendingData = ""
        while not self._blnAbort:
            resultTuple = select.select( [self._socket], [], [self._socket], 1.0 )
            if not self._blnAbort:
                if len( resultTuple[2] ):
                    #socket error
                    pass
                if len( resultTuple[0] ):
                    #data to read
                    strReceivedXML = strPendingData
                    
                    lock = TraceableLock.ScopeLock (self.socketThreadLock, 'run')
                    recvBuf = self._socket.recv (16384)
                    del lock # release lock to free socket for writing
                    
                    strReceivedXML = strReceivedXML + recvBuf
                    intNullPos = string.find( strReceivedXML, "\0" )
                    
                    while intNullPos >= 0:
                        self.ProcessResponse( strReceivedXML[:intNullPos] )
                        strReceivedXML = strReceivedXML[intNullPos + 1:]
                        intNullPos = string.find(strReceivedXML , "\0" )
                        
                    strPendingData = strReceivedXML

    def get_text (self, node):
        text = ''
        for subnode in node.childNodes:
            if subnode.nodeType == subnode.TEXT_NODE:
                text += subnode.nodeValue
            elif subnode.nodeType == subnode.CDATA_SECTION_NODE:
                text += subnode.nodeValue
        return text

    def parseStruct (self, struct, node):
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                if child.nodeName == "member":
                    v = self.parseTypedValue (child)
                    setattr (struct, child.getAttribute ('name'), v)
                    
    def parseList (self, newList, node):
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                if child.nodeName == "item":
                    v = self.parseTypedValue (child)
                    newList.append (v)

    def parseTypedValue (self, node):
        typeString = node.getAttribute ("type")
        if typeString == "int8" or typeString == "int16" or typeString == "int32" or typeString == "int64":
            return int (self.get_text (node))
        elif typeString == "double":
            return float (self.get_text (node))
        elif typeString == "bool":
            return self.get_text (node) == u"1"
        elif typeString == "string":
            return str (self.get_text (node))
        elif typeString == "octets":
            return base64.decodestring(self.get_text (node))
        elif typeString == "file":
            return Aptixia_prv.DownloadFile (self.transactionContext, int (self.get_text (node)))
        else:
            # user defined type or object reference
            intDotPos = string.find( typeString, "." )
            if intDotPos >= 0:
                # user defined type
                strContainerType = typeString[:intDotPos]
                
                #load module if necessary
                if not globals().has_key( strContainerType ):
                    mod = __import__( strContainerType, globals(), locals(), [] )
                    globals()[strContainerType] = mod

                #create object:                    
                strCmd = "%(containerType)s.%(type)s()" % \
                         { "containerType":strContainerType, "type":typeString }
                obj = eval( strCmd )
                if isinstance (obj, IxEnum):
                    return int (self.get_text (node))
                elif isinstance (obj, IxList):
                    self.parseList (obj, node)
                    return obj
                elif isinstance (obj, IxStruct):
                    self.parseStruct (obj, node)
                    return obj
            else:
                # object reference
                strContainerType = typeString
                
                if not globals().has_key( strContainerType ):
                    mod = __import__( strContainerType, globals(), locals(), [] )
                    globals()[strContainerType] = mod

                # this is an object
                objectId = str(self.get_text (node))
                newObj = self.transactionContext.getObject (objectId)
                if newObj == None:
                    strCmd = "%(containerType)s.%(type)s (None, objectId, self.transactionContext )" % \
                             { "containerType":strContainerType, "type":typeString }
                    newObj = eval(strCmd)
                return newObj
                    
    def parseRetval (self, responseObj, node, arg):
        v = self.parseTypedValue (node)
        setattr (responseObj, arg.name, v)

    def parseObjectResponse (self, top, argTuple):
        responseObj = Response()
        argIter = argTuple.__iter__ ()
        for child in top.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                if child.nodeName == "retval":
                    while 1:
                        arg = argIter.next ()
                        if arg.direction != "in":
                            break
                    self.parseRetval (responseObj, child, arg)
        return responseObj

    def parseIxiaStatus (self, top):
        error = Error
        for child in top.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                if child.nodeName == "ixia-status":
                    for child2 in child.childNodes:
                        if child2.nodeType == child.ELEMENT_NODE:
                            if child2.nodeName == "id":
                                error.id = self.get_text (child2)
                            elif child2.nodeName == "text":
                                error.text = self.get_text (child2)
                            elif child2.nodeName == "trace":
                                error.trace = self.get_text (child2)
        return error

    def ProcessResponse( self, strReceivedXML ):
        #get the request ID
        self._ProcessResponseDepth=self._ProcessResponseDepth+1
        try:        
            dom = xml.dom.minidom.parseString(strReceivedXML)
        except Exception, ex:
            msg = "_ProcessResponseDepth=%d: %s" % (
                self._ProcessResponseDepth, str(ex)
            )
            raise LocalError(
                "Aptixia.XProtocol.XmlResponseParseError",
                strReceivedXML,
                msg
            )
        self._ProcessResponseDepth=self._ProcessResponseDepth-1

        top = dom.documentElement
        requestId = int (top.getAttribute ("request-id"))
        if top.nodeName == "object-response" or top.nodeName == "event-preliminary-resp":
            request = self.transactionContext.GetTransaction (requestId)
            if request != None:
                results = self.parseObjectResponse (top, request.argTuple)
                self.transactionContext.ProcessResult (requestId, results)
        elif top.nodeName == "object-failure":
            error = self.parseIxiaStatus (top)
            self.transactionContext.HandleError (requestId, error)
        elif top.nodeName == "event-failure":
            error = self.parseIxiaStatus (top)
            if error.id == "Aptixia.Cancel":
                request = self.transactionContext.GetTransaction (requestId)
                self.transactionContext.CancelEvent (requestId)
            else:
                self.transactionContext.HandleError (requestId, error)
        else:
            raise LocalError ("Aptixia.XProtocol.BadTopElement")
        
    def GetNextRequestID( self ):
        id = self._intNextRequestID
        self._intNextRequestID = self._intNextRequestID + 1
        return id
        
    def GetResultXML( self, intRequestID, intTimeout = 0 ):
        if self._pendingResults.has_key( intRequestID ):
            return self._pendingResults[intRequestID].strResponseXML

    def Abort( self ):
        self._blnAbort = True

class TransactionContext:
    def __init__ (self, strHostName, intPort):
        

        # locks:
        #   userLock synchronizes user threads entering the transaction domain
        #   coreLock protects most members of TransactionContext
        #   socketThreadLock (in XProtocolSocket) protects objects the socket thread uses
        #   managedDataLock (global) protects managed data
        #
        # rules:
        #   no lock may be taken when holding coreLock
        #   no lock may be taken when holding socketThreadLock
        #   socketThreadLock may be taken when holding userLock or managedDataLock
        #   userLock may not be taken when holding any other lock
        #
        #   in other words, the following locking sequences are ok:
        #     userLock
        #     userLock->coreLock
        #     userLock->socketThreadLock
        #     userLock->managedDataLock
        #     userLock->managedDataLock->socketThreadLock
        #     userLock->managedDataLock->coreLock
        #     socketThreadLock
        #     coreLock
        #     managedDataLock
        #     managedDataLock->socketThreadLock
        #     managedDataLock->coreLock
        
        self.userLock = TraceableLock.TraceableLock("userLock")
        
        self.coreLock = TraceableLock.TraceableLock("coreLock")
        # members protected by coreLock
        self.objects = {}
        self.isSyncing = False
        self.transactions = {}
        self.nextNewId = None
        self.newIdCount = None
        self.errorCallback = None
        self.errorCallbackArg = None
        # end of members protected by coreLock

        # note: passing self to XProtocolSocket creates a circular reference
        self.socket = XProtocolSocket (self, strHostName, intPort )

        self.classVersions = {"XProtocolObject":(1,False)}

        # get object ID range from server
        import XProtocolObject
        import TestServerPrivate
        self.rootObject = XProtocolObject.XProtocolObject (None, "1", self)
        
        resp = self.rootObject._GetNewObjectIdRange_Sync()
        self.nextNewId = resp.start
        self.newIdCount = resp.count

        resp = self.rootObject._GetClassVersionList_Sync()
        for item in resp.versionList:
            self.classVersions[item.name] = (item.version, item.serverInstantiate)
            
        self.testServer = TestServerPrivate.TestServerPrivate (None,"1",self)
        self.testServer.register_InvalidateObjectEvent_event(TransactionContext.invalidateEventCallback,self)
            
    def registerErrorCallback(self, callback, args):
        self.errorCallback = callback
        self.errorCallbackArg = args
        

    def invalidateEventCallback (self, results):
        self.calledBack = True
        lock = TraceableLock.ScopeLock (self.coreLock, 'getObject')
        obj=self.getObject(str(results.objectId))
        if (obj!=None):
            obj.blnInitialized=False
            if (traceCommunication):
                print "invalidated %s: %s" % (obj.getType(),obj.objID)
            
            
        
    def getNewId (self):
        lock = TraceableLock.ScopeLock (self.coreLock, 'getObject')
        if self.newIdCount <= 0:
            raise LocalError ("Aptixia.ClientLibrary.OutOfNewObjectIds")
        self.newIdCount -= 1
        id = self.nextNewId
        self.nextNewId += 1
        return str(id)

    def getObject (self, id):
        lock = TraceableLock.ScopeLock (self.coreLock, 'getObject')
        if id in self.objects:
            ref=self.objects[id]
            if ref:
                return ref()
        return None

    def addObject (self, o):
        lock = TraceableLock.ScopeLock (self.coreLock, 'addObject')
        self.objects[o.objID] = weakref.ref(o)
        #print "---------------------> object count :",len(self.objects)

    def removeObject (self, o):        
        lock = TraceableLock.ScopeLock (self.coreLock, 'removeObject')
        if o.objID in self.objects:
            del self.objects[o.objID]
        '''            
        print "unref %s %s" %(o.objID,o.getType(),)
        print "---------------------< object count :",len(self.objects)
        for ref in self.objects.values ():
            obj=ref()
            if obj:
                print "alive %s %s" %(obj.objID,obj.getType(),)
        '''

    def Invalidate (self):            
        lock = TraceableLock.ScopeLock (self.userLock, 'Invalidate')
        lock2 = TraceableLock.ScopeLock (self.coreLock, 'Invalidate2')
        for ref in self.objects.values ():
            obj=ref()
            if obj:
                obj.blnInitialized = False

    def SyncAllProperties (self):
        context=self.FlushAllProperties()
        if context != None:
            #print "Sync Flush"
            context.Sync()
            
    def FlushAllProperties (self):      # flushes all changed data without waiting
        lock = TraceableLock.ScopeLock (self.userLock, 'FlushAllProperties')
        lock2 = TraceableLock.ScopeLock (self.coreLock, 'FlushAllProperties')
        if self.isSyncing:
            return # avoid recursion
        self.isSyncing = True
        lastContext=None
      
        try:
            # get list of objects inside coreLock and find the dirty ones
            objects = self.objects.values ()
            sync_list = []
            for ref in objects:
                obj=ref()
                if obj and not obj.isNew:
                    sync_list.append (obj)
                    
            del lock2 # release core lock and call SyncProperties on all listed objects
            
            
            for o in sync_list:
                current=o.flushPropertiesInternal()
                if current != None:
                    lastContext=current
        except:
            traceback.print_exc()
        
        self.isSyncing = False
        return lastContext

    def AddTransaction (self, id, rpcObject):
        lock = TraceableLock.ScopeLock (self.coreLock, 'AddTransaction')
        self.transactions[id] = rpcObject

    def GetTransaction (self, id):
        lock = TraceableLock.ScopeLock (self.coreLock, 'GetTransaction')
        return self.transactions.get (id)

    def DeleteTransaction (self, id):
        lock = TraceableLock.ScopeLock (self.coreLock, 'DeleteTransaction')
        del self.transactions[id]

    def ProcessResult (self, id, results):        
        lock = TraceableLock.ScopeLock (self.coreLock, 'ProcessResult')
        transaction = self.transactions.get (id)
        if transaction != None:
            transaction.results = results
            transaction.Complete()

    def CancelEvent (self, id):
        self.DeleteTransaction (id)

    def HandleError (self, id, error):
        lock = TraceableLock.ScopeLock (self.coreLock, 'HandleError')
        transaction = self.transactions.get (id)
        print "Error received :",error.text
        print error.trace
        if transaction != None:
            transaction.error = error
            transaction.Failed()
        if self.errorCallback:
            error=Error(error.id, error.text, error.trace)
            self.errorCallback(self.errorCallbackArg,error)

def createClientBaseObject(transactionContext, strType, strObjectID):

    preFetch = False;
    if strObjectID != None:
        strObjectID = str(strObjectID)
        # try to obtain object from cache
        old=transactionContext.getObject(strObjectID)   
        if old != None:                                         
            # return cached object 
            return old                                  
        else:
            # object not cached but we are supposed to use a specific 
            # object id. so get it from the server
            preFetch = True;

    #load module if necessary
    intDotPos = string.find( strType, "." )
    if intDotPos >= 0:
        strContainerType = strType[:intDotPos]
        strType = strType[intDotPos + 1:]
    else:
        strContainerType = strType

    if not globals().has_key( strContainerType ):
        mod = __import__( strContainerType, globals(), locals(), [] )
        globals()[strContainerType] = mod

    strCmd = \
    "%s.%s(None, strObjectID, transactionContext, %s)" % (
        strContainerType,
        strType,
        str(preFetch),
    )
    obj = eval(strCmd)
    return obj
        
class ClientObjectBase( object ):

    def __init__(
        self, 
        parentObject,
        objectId=None,
        transactionContext=None,
        preFetch=False):

        if parentObject != None and not isinstance (parentObject, ClientObjectBase):
            print parentObject
            raise LocalError ("Aptixia.ClientLibrary.InternalError")

        if objectId != None and not type(objectId) == str:
            print type(objectId)
            raise LocalError ("Aptixia.ClientLibrary.InternalError")

        if transactionContext != None and not isinstance(transactionContext, TransactionContext):
            raise LocalError ("Aptixia.ClientLibrary.InternalError")

        self.transactionContext = transactionContext
        if parentObject != None:
            self.transactionContext = parentObject.transactionContext

        if preFetch and objectId==None:
            raise LocalError("Aptixia.ClientLibrary.InternalError.PreFetch")

        self.objID = objectId
        self.blnInitialized = False
        self.blnDirty = False

        self.isNew = False
        if self.objID == None:
            self.objID = self.transactionContext.getNewId ()
            self.isNew = True
            self.blnInitialized = True
            

        self.managedProperties = dict()

        self.transactionContext.addObject (self)
        self.hasBeenAdded = False

        self.isInstantiated = False

        if preFetch:
            # object on server already, mark data as 
            # 1) un-initialized (to cause pull of data from server)
            # 2) server-instantiated, to prevent local (client side)
            #    property initialization from occuring later
            #    in subclass constructors
            self.blnInitialized = False
            self.isInstantiated = True
        else:
            versionStuff = self.transactionContext.classVersions[self.getType()]
            # versionStuff seems to be of the form:
            # ((int)versionNumber, (bool)instantiateFromSserver)
            if versionStuff[1]:
                resp = self.transactionContext.rootObject._GetInstantiationXml_Sync (self.getType ())
                self.parseObjectXml (resp.xml)
                self.isInstantiated = True

    def __del__( self ):
        #print "-----------------> delete %s %s" %(self.objID,self.getType(),)
        #traceback.print_stack()
        self.transactionContext.removeObject (self)

    def getType( self ):
        return "ClientObjectBase"

    def MarkAsAdded (self):
        if self.hasBeenAdded == True:
            # it is illegal to add the same object to a list twice
            raise LocalError ("Aptixia.ClientLibrary.InternalError")
        self.hasBeenAdded = True            

    def Invalidate (self):
        self.blnInitialized = False
    
    def createClientBaseObject( self, strType, strObjectID ):
        strObjectID = str(strObjectID)
        old=self.transactionContext.getObject(strObjectID)      # try to obtain object from cache
        if old !=None :  
            return old
        #load module if necessary
        intDotPos = string.find( strType, "." )
        if intDotPos >= 0:
            strContainerType = strType[:intDotPos]
            strType = strType[intDotPos + 1:]
        else:
            strContainerType = strType

        if not globals().has_key( strContainerType ):
            mod = __import__( strContainerType, globals(), locals(), [] )
            globals()[strContainerType] = mod

        strCmd = "%(containerType)s.%(type)s( None, str(strObjectID), self.transactionContext)" % \
                 { "containerType":strContainerType, "type":strType }
        obj = eval( strCmd )
        return obj

    def registerEvent (self, eventName, argTuple, callback, callbackArg):
        lock = TraceableLock.ScopeLock (self.transactionContext.userLock, 'registerEvent')
        context = EventContext (self.transactionContext, self.getType(), self.objID, eventName, argTuple, callback, callbackArg)
        return context
    
    def get_text (self, node):
        text = ''
        for subnode in node.childNodes:
            if subnode.nodeType == subnode.TEXT_NODE:
                text += subnode.nodeValue
            elif subnode.nodeType == subnode.CDATA_SECTION_NODE:
                text += subnode.nodeValue
        return text

    def parseDoubleList (self, memberName, node):
        myList = IxList( "double" )
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                myList.internalAppend (float (self.get_text (child)))
        self.setVar (memberName, myList)

    def parseStringList (self, memberName, node):
        myList = IxList( "string" )
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                myList.internalAppend (str (self.get_text (child)))
        self.setVar (memberName, myList)

    def parseIntList (self, memberName, node):
        myList = IxList( "int" )
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                myList.internalAppend (int (self.get_text (child)))
        self.setVar (memberName, myList)
        
    def hasChildElements (self, node):
        has_child = False
        for grandchild in node.childNodes:
            if grandchild.nodeType == grandchild.ELEMENT_NODE:
                has_child = True
                break
        return has_child

    def parseObjectList (self, memberName, node):
        myList = IxObjectList (self.transactionContext, None)
        for child in node.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                # subnodes can be sent explicitly or by id
                # if sent by id they have no children elements
                childType = child.getAttribute ('type')
                childId = str(child.getAttribute ('objectid'))
                if len(childId) == 0: childId = None
                childObject = createClientBaseObject (self.transactionContext, childType, childId )
                if self.hasChildElements (child):
                    childObject.parseObject (child)
                myList.addOriginalEntry (childObject)
        self.setVar (memberName, myList)

    def parseSubObject (self, memberName, node):
        childType = node.getAttribute ('type')
        childId = str(node.getAttribute ('objectid'))
        if len(childId) == 0 or childId=='0' : 
            childId = None
        if childId==None:
            childObject=None
        else:
            childObject = createClientBaseObject (self.transactionContext, childType, childId )
        if self.hasChildElements (node):
            childObject.parseObject (node)
        self.setVar (memberName, childObject)

    def parseMember (self, node):
        memberName = node.nodeName
        if hasattr(self,'_get_'+memberName)==False:
            #print "skip :"+memberName
            return
        memberType = node.getAttribute ('type')
        if memberType == 'Int':
            self.setVar (memberName, int (self.get_text (node)))
        elif memberType == 'Double':
            self.setVar (memberName, float (self.get_text (node)))
        elif memberType == 'String':
            self.setVar (memberName, str (self.get_text (node)))
        elif memberType == 'Bool':
            self.setVar (memberName, u'1' == self.get_text (node))
        elif memberType == 'DoubleList':
            self.parseDoubleList (memberName, node)
        elif memberType == 'StringList':
            self.parseStringList (memberName, node)
        elif memberType == 'IntList':
            self.parseIntList (memberName, node)
        elif memberType == 'ListNode':
            self.parseObjectList (memberName, node)
        else:
            self.parseSubObject (memberName, node)

    def parseObject (self, node):            
        tag = node.nodeName
        self.blnInitialized=True
        for member in node.childNodes:
            if member.nodeType == node.ELEMENT_NODE:
                self.parseMember (member)

    def parseObjectXml (self, xmlString):
        dom = xml.dom.minidom.parseString (xmlString)
        top = dom.documentElement
        if top.nodeName != "aptixia":
            raise LocalError ("Aptixia.XProtocol.BadTopElement")
        for child in top.childNodes:
            if child.nodeType == child.ELEMENT_NODE:
                self.parseObject (child)        

    def toXML( self, strRootName = None ):
        if not self.blnInitialized:
            self.Prefetch()

        newIdString = ""
        wasNew = self.isNew
        newIdString = ' objectid="%s"' % (self.objID)
        if self.isNew:
            self.isNew = False
        strXML = ""
        if strRootName == None:
            strXML = "<aptixia formatVersion=\"1\" schemaVersion=\"1\">"
            strXML += "<%s type=\"%s\"%s>" % (self.getType(), self.getType(), newIdString)
        else:
            strXML = "<%s type=\"%s\"%s>" % (strRootName, self.getType(), newIdString)
        for currentProperty in self.managedProperties.keys():
            blnComplexType = False
            propValue = self.managedProperties[currentProperty]
            propType = type( propValue )
            if propType == types.NoneType:
                strXML += '<%s new-objectid="0" />' % (currentProperty)
            else:
                strType = None
                if propType == types.BooleanType:
                    strType = "Bool"
                elif propType == types.IntType or propType == types.LongType:
                    strType = "Int"
                elif propType in types.StringTypes:
                    strType = "String"
                elif propType == types.FloatType:
                    strType = "Double"
                elif isinstance( propValue, IxObjectList ):
                    blnComplexType = True
                    if wasNew:
                        if len(propValue) <= 0:
                            strXML = "%s<%s type=\"ListNode\"/>" % (strXML, currentProperty)
                        else:
                            strXML = "%s<%s type=\"ListNode\">" % ( strXML, currentProperty)
                            strXML = strXML + propValue.toXML()
                            strXML = strXML + "</%s>" % currentProperty
                    else:
                        propValue.flushList (self, currentProperty)
                elif isinstance( propValue, IxList ):
                    blnComplexType = True
                    if len(propValue) <= 0:
                        strXML = "%s<%s type=\"%s\"/>" % (strXML, currentProperty, propValue.getListType () )
                    else:
                        strXML = "%s<%s type=\"%s\">" % ( strXML, currentProperty, propValue.getListType () )
                        strXML = strXML + propValue.toXML(blnNaked = True)
                        strXML = strXML + "</%s>" % currentProperty
                elif isinstance( propValue, ClientObjectBase ):
                    if propValue.isNew:
                        strXML = strXML + propValue.toXML( currentProperty )
                    else:
                        blnComplexType = True
                        strXML = "%s<%s type=\"%s\" objectid=\"%s\"/>" % ( strXML, currentProperty,
                                                                        propValue.getType(),
                                                                            str(propValue.objID) )

                if not blnComplexType and strType:
                    if strType == "Bool":
                        if propValue:
                            strXML = "%s<%s type=\"%s\">1</%s>" % ( strXML, currentProperty, strType,
                                                                     currentProperty )
                        else:
                            strXML = "%s<%s type=\"%s\">0</%s>" % ( strXML, currentProperty, strType,
                                                                     currentProperty )
                    else:
                        strXML = "%s<%s type=\"%s\">%s</%s>" % ( strXML, currentProperty, strType,
                                                                 str(propValue),
                                                                 currentProperty )
        if (traceCommunication):
            print "Flush %s:%s" %(self.getType(),self.objID)
        '''                        
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        print strXML
        '''
                        
        if strRootName != None:
            strXML = "%s</%s>" % ( strXML, strRootName )
            return strXML
        else:
            strXML = "%s</%s></aptixia>" % (strXML, self.getType())        
            return strXML
#            return xml.sax.saxutils.escape( strXML )
                
    def getVar( self, varName):
        lock = TraceableLock.ScopeLock (managedDataLock, "ClientObjectBase.setVar")
        if not self.blnInitialized:
            self.Prefetch()
            
        if self.managedProperties.has_key( varName ):
            return self.managedProperties[varName]

    def getListVar( self, varName ):
        lock = TraceableLock.ScopeLock (managedDataLock, "ClientObjectBase.setVar")
        if not self.blnInitialized:
            self.Prefetch()

        if not self.managedProperties.has_key(varName):            
                raise LocalError ("Aptixia.ClientLibrary.PropertyNotFound", varName)
            
        return self.managedProperties[varName]

    def setVar( self, varName, varValue = None):
        lock = TraceableLock.ScopeLock (managedDataLock, "ClientObjectBase.setVar")
        if not self.blnInitialized:
            self.Prefetch()

        if hasattr(self,'_get_'+varName):   
            self.managedProperties[varName] = varValue
        else:   #property does not exist
            return
        if self.blnInitialized:
            self.blnDirty = True
            if (isinstance( self.managedProperties[varName], IxList )) or \
               (isinstance( self.managedProperties[varName], IxStruct )) or \
               (isinstance( self.managedProperties[varName], ClientObjectBase )):
                    self.managedProperties[varName].blnDirty = True

    def propertiesAreDirty( self ):
        if self.blnDirty:
            return True
        for currentProp in self.managedProperties.keys():
            prop = self.managedProperties[currentProp ]
            if isinstance (prop, IxProperty) or isinstance(prop, IxList) or isinstance (prop, IxStruct) or isinstance (prop, IxObjectList):
                if prop.blnDirty:
                    return True
#            elif isinstance( prop, ClientObjectBase ):
#                if prop.propertiesAreDirty():
#                    return True
        return False

    def cleanProperties( self ):
        self.blnDirty = False
        for currentProp in self.managedProperties.keys():
            value = self.managedProperties[currentProp]
            if isinstance (value, IxProperty) or isinstance (value, IxList) or isinstance (value, IxStruct):
                value.blnDirty = False
            elif isinstance (value, IxObjectList):
                value.clean ()
            elif isinstance (value, ClientObjectBase ):
                value.cleanProperties()
            
    def flushPropertiesInternal( self):
        lock = TraceableLock.ScopeLock (self.transactionContext.userLock, 'flushPropertiesInternal')
        lock = TraceableLock.ScopeLock (managedDataLock, "flushPropertiesInternal")
        if self.isNew:
            return None# has no representation on the server
        if not self.propertiesAreDirty():
            return None
        xmlText = self.toXML()
        #print "###########################################################"
        #print self.objID
        #print xmlText
        
        arg0    = Aptixia_prv.MethodArgument( "xml", xmlText, "in", "string", None)
        context = RpcContext( self.transactionContext, self.getType(), self.objID, "_SetManagedDataXml",(arg0,), None)
        self.cleanProperties()
        return context
    
    def SyncPropertiesInternal( self ):
        self.SyncWaitPropertiesInternal ( -1 )
   
    def SyncWaitPropertiesInternal( self, fltTimeout ):
        context=self.flushPropertiesInternal()
        # release transaction lock to enable callbacks from the socket handler
        if fltTimeout > 0:
            context.SyncWait( fltTimeout )
        else:
            context.Sync()
        self.cleanProperties()

    def SyncProperties( self ):
        self.transactionContext.SyncAllProperties ()
        
    def FlushProperties( self ):
        self.transactionContext.FlushAllProperties ()
        
            
    def Prefetch( self, blnDeep = False ):
        lock = TraceableLock.ScopeLock (self.transactionContext.userLock, 'Prefetch')
        lock = TraceableLock.ScopeLock (managedDataLock, "Prefetch")
        
        self.blnInitialized = True

        try:        
            import XProtocolObject # FIXME: Need to do this here due to a circular dependency
            xml=self._GetManagedDataXml_Sync(blnDeep).xml
            if (traceCommunication):
                print "Prefetch %s %s" %(self.getType(),self.objID,)
            '''
            print "#####################################################################################"
            print xml
            '''
            self.parseObjectXml (xml)
            self.cleanProperties()
            
        except:
            self.blnInitialized = False
            raise            

    def PrefetchAll( self ):
        self.Prefetch (True)

    def ShutdownSocket( self ):
        self.transactionContext.socket.Abort()
        time.sleep(0.5)

def startAptixiaProcess (exe, args, wShowWindow):
    command = exe + " " + args
    startupinfo = win32process.STARTUPINFO()
    startupinfo.wShowWindow = wShowWindow
    startupinfo.dwFlags = win32con.STARTF_USESHOWWINDOW
    hProcess, hThread, dwProcessId, dwThreadId = \
        win32process.CreateProcess (None, command, None, None, 0, win32con.CREATE_NEW_CONSOLE,
                                                     None, None, startupinfo)
    return hProcess

def StartTestServer (binPath, dataPath):
    # launch TestServer hidden as a background process
    semaphore = win32event.CreateSemaphore (None, 1, 1, "TEST_SERVER_LAUNCH_SEMAPHORE")
    win32event.WaitForSingleObject (semaphore, win32event.INFINITE)
    pipe = win32pipe.CreateNamedPipe (
        "\\\\.\\pipe\\TEST_SERVER_LAUNCH_PIPE",
        win32pipe.PIPE_ACCESS_DUPLEX,
        win32pipe.PIPE_NOWAIT, 1, 1000, 1000, 1, None)
    processHandle = None
    try:
        args = '--local --auto-exit'
        processHandle = startAptixiaProcess (binPath+'/ixAptixiaTestServer.exe', args, win32con.SW_HIDE)
            #win32con.SW_HIDE)
            #win32con.SW_NORMAL)
    except Exception, e:
        traceback.print_exc ()
        raise LocalError ("Aptixia.ClientLibrary.FailedToLaunchProcess", binPath, "ixAptixiaTestServer.exe")
        
    while 1:
        try:
            if win32process.GetExitCodeProcess(processHandle) != 259:
                #process is no longer active
                raise LocalError("Aptixia.ClientLibrary.InternalError");
            result = win32pipe.ConnectNamedPipe(pipe, None)
            break     
        except Exception, e:
            if e.args[0] == 536:
                # not yet connected
                time.sleep (0.1)
                continue
            if e.args[0] == 535:
                # already connected
                break
            raise

    win32file.WriteFile (pipe, '*')

    buffer = ''
    while 1:
        if win32process.GetExitCodeProcess(processHandle) != 259:
            #process is no longer active
            raise LocalError("Aptixia.ClientLibrary.InternalError");
        (data, bytesRead, bytesAvailable) = win32pipe.PeekNamedPipe (pipe, 10000)
        if len(data):
            (result, data) = win32file.ReadFile (pipe, 10000)
            buffer += data
            openTag = '<XPPort>'
            closeTag = '</XPPort>'
            pos1 = buffer.find (openTag)
            pos2 = buffer.find (closeTag)
            if pos1 >= 0 and pos2 >= 0:
                port = int (buffer[pos1+len(openTag):pos2])
                win32event.ReleaseSemaphore (semaphore, 1)
                transactionContext = TransactionContext ("localhost", port)
                import TestServer
                return TestServer.TestServer (None, "1", transactionContext)
        else:
            time.sleep (0.1)
