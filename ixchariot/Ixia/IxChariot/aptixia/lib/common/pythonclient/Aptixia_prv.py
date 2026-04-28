import threading, xml, base64, tempfile

maxTransferSize = 100000

def UploadFile (transactionContext, fileObject):
    # create file context on server
    id = transactionContext.rootObject._CreateFileTransferContext_Sync ().id

    # send file segments in chunks asynchronously    
    while 1:
        data = fileObject.read (maxTransferSize)
        if len(data) == 0:
            break
        transactionContext.rootObject._WriteFileBlock (id, data)

    # return id for passing to server
    return id


class DownloadFile:
    def __init__ (self, transactionContext, id):
        self.transactionContext = transactionContext
        self.id = id

    def read (self, length=None):
        data = ""
        while length == None or length > 0:
            transferSize = maxTransferSize
            if length != None and length < transferSize:
                transferSize = length
            resp = self.transactionContext.rootObject._ReadFileBlock_Sync (self.id, transferSize)
            data += resp.data
            if len(resp.data) == 0:
                break
            if length != None:
                length -= len(data)
        return data
        
class MethodArgument:
    def __init__( self, name, value, strDirection, aptixiaType, userDefinedType):
        self.name = name
        self.value = value
        self.direction = strDirection
        self.userDefinedType = userDefinedType
        if aptixiaType:
            self.aptixiaType = aptixiaType
        else:
            if type( self.value ) is int:
                self.aptixiaType = "int32"
            elif type( self.value ) is str:
                self.aptixiaType = "string"
            elif type( self.value ) is bool:
                self.aptixiaType = "bool"
            elif type( self.value ) is float:
                self.aptixiaType = "double"
            elif type( self.value ) is buffer:
                self.aptixiaType = "octects"
            

    def getArgumentType( self ):
        if self.aptixiaType is not None:
            return self.aptixiaType
        elif type( self.value ) is int:
            return "int32"
        elif type( self.value ) is str:
            return "string"
        elif type( self.value ) is bool:
            return "bool"
        elif type( self.value ) is float:
            return "double"
        elif type( self.value ) is buffer:
            self.aptixiaType = "octects"
        else:
            return None

    def getValue( self ):
        if self.aptixiaType == "bool":
            if self.value:
                return "1"
            else:
                return "0"
        elif self.aptixiaType == "string":
            if self.value:
                return xml.sax.saxutils.escape ( self.value )
            else:
                return ""
        elif self.aptixiaType == "octets":
            if self.value:
                return base64.encodestring ( self.value )
            else:
                return ""
        else:
            return self.value

    def toString (self, transactionContext):
        if self.aptixiaType in ("int8", "int16", "int32", "int64"):
            return "%d" % (self.value)
        elif self.aptixiaType == "double":
            return "%f" % (self.value)
        elif self.aptixiaType == "bool":
            if self.value:
                return "1"
            else:
                return "0"
        elif self.aptixiaType == "string":
            if self.value:
                return xml.sax.saxutils.escape ( self.value )
            else:
                return ""
        elif self.aptixiaType == "octets":
            if self.value:
                return base64.encodestring ( self.value )
            else:
                return ""
        elif self.aptixiaType == "file":
            id = UploadFile (transactionContext, self.value)
            return str(id)
        else:
            raise Aptixia.LocalError ("Aptixia.ClientLibrary.InternalError")
        

    def toXml (self, transactionContext, direction):
        if direction == "out":
            return "<argument type=\"%s\" direction=\"out\"/>" % (self.aptixiaType)
        if self.userDefinedType != None:
            return self.userDefinedType.toXmlClass (direction, None, None, self.value)
        return "<argument type=\"%s\" direction=\"%s\" >%s</argument>" % (self.aptixiaType, direction, self.toString (transactionContext))
       
class CallbackThread( threading.Thread ):
    def __init__( self, id, callback, arg = None ):
        self._callback = callback
        self._arg = arg
        self._id = id
        threading.Thread.__init__( self )

    def run( self ):
        if self._arg:
            self._callback( self._arg, self._id )
        else:
            self._callback( self._id )