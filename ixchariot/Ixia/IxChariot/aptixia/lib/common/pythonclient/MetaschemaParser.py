import xml.sax.handler, xml.sax.xmlreader, string, sys, traceback, os, os.path

class MethodArg:
    strName = None
    strDirection = None
    strType = None
    strHelp = None

class Method:
    strName = None
    strHelp = None
    args = None
    
class Event:
    strName = None
    strHelp = None
    args = None

class EnumChoice:
    strName = None
    intValue = None

class Enum:
    strName = None
    values = None

class StructMember:
    strName = None
    strDefaultValue = None
    strHelp = None

class Struct:
    strName = None
    strHelp = None
    strVersion = None
    members = None

class List:
    strName = None
    strType = None
    members = None
    
class Property:
    strName = None
    strValue = None
    strType = None
    strHelp = None
    strDefault = None
    strDescription = None
    blnList = False
    isPolymorphic = False
    isObsolete = False

class GeneratedPyFile:
    strClassName = None
    strBaseClassName = None
    strHelpText = None
    strPreamble = "import string\nimport Aptixia, Aptixia_prv"
    additionalClasses = None
    properties = None
    enums = None
    structs = None
    lists = None
    methods = None
    properties = None
    events = None

    basicTypes = ( None, "string", "int", "int8", "int16", "int32", "int64",  "boolean", "bool", "double", "octets", "file"  )

    def reset( self ):
        self.strClassName = None
        self.strBaseClassName = None
        self.strHelpText = None
        self.strPreamble = "import string, threading\nimport Aptixia, Aptixia_prv"
        self.additionalClasses = None
        self.properties = None
        self.enums = None
        self.structs = None
        self.lists = None
        self.methods = None
        self.properties = None
        self.events = None

    def setClass( self, strClassName, strBaseClassName, strHelpText = None ):
        if strClassName:
            self.strClassName = strClassName
        if strBaseClassName:
            self.strBaseClassName = strBaseClassName + "." + strBaseClassName
        else:
            if strClassName != "XProtocolObject":
                self.strBaseClassName = "XProtocolObject.XProtocolObject"
        if strHelpText:
            self.strHelpText = strHelpText
        
    def addAdditonalClass( self, strClassName ):
        intDotIndex = string.find( strClassName, "." )
        if intDotIndex != -1:
            strTrimmedClassName = strClassName[:intDotIndex]
            if self.strClassName == strTrimmedClassName:
                pass
            else:
                if self.additionalClasses == None:
                    self.additionalClasses = list()
                    self.additionalClasses.append( strTrimmedClassName )
                elif strTrimmedClassName not in self.additionalClasses:
                    self.additionalClasses.append( strTrimmedClassName )
        else:
            if strClassName != self.strClassName:
                if self.additionalClasses == None:
                    self.additionalClasses = list()
                    self.additionalClasses.append( strClassName )
                elif strClassName not in self.additionalClasses:            
                    self.additionalClasses.append( strClassName )

    def addProperty( self, property ):
        if self.properties == None:
            self.properties = list()
        self.properties.append( property )
    
    def addEnum( self, newEnum ):
        if not self.enums:
            self.enums = list()
        self.enums.append( newEnum )

    def addList( self, newList ):
        if not self.lists:
            self.lists = list()
        self.lists.append( newList )

    def addStruct( self, newStruct ):
        if not self.structs:
            self.structs = list()
        self.structs.append( newStruct )
        
    def addMethod( self, strMethodName, methodArgs, strHelpText ):
        if self.methods == None:
            self.methods = list()
        else:
            for currentMethod in self.methods:
                if currentMethod.strName == strMethodName:
                    strMethodName = strMethodName + "Ex"

        newMethod = Method()
        newMethod.strName = strMethodName
        newMethod.args = methodArgs
        newMethod.strHelp = strHelpText                    
        self.methods.append( newMethod )

    def addEvent( self, strEventName, eventArgs, strHelpText ):
        if self.events == None:
            self.events = list()

        newEvent = Event()
        newEvent.strName = strEventName
        newEvent.args = eventArgs
        newEvent.strHelp = strHelpText                    
        self.events.append( newEvent )

    def generateFile( self ):
        outputFile = file( self.strClassName + ".py", "wt" )
        try:
            #write out import statements
            outputFile.write( self.strPreamble + "\n" )
            if self.strBaseClassName:
                intDotPos = string.find( self.strBaseClassName, "." )
                strImportName = self.strBaseClassName[:intDotPos]
                outputFile.write( "import " + strImportName + "\n" )
            if self.additionalClasses:
                blnFirstClass = True
                for currentClass in self.additionalClasses:
                    if not self.isLocalStructOrList( currentClass ):
                        if blnFirstClass:
                            outputFile.write( "import " + currentClass )
                            blnFirstClass = False
                        else:
                            outputFile.write( ", " + currentClass )
                outputFile.write( "\n" )

            outputFile.write( "\n\n" )

            #write out class definition            
            outputFile.write( "class " + self.strClassName )
            if self.strBaseClassName and (len(self.strBaseClassName) > 0 ):
                outputFile.write( "( %s ):\n" % self.strBaseClassName )
            else:
                self.strBaseClassName = "Aptixia.ClientObjectBase"
                outputFile.write( "( Aptixia.ClientObjectBase ):\n" )

            if self.strHelpText:
                outputFile.write( "\t\"\"\" " + self.strHelpText + " \"\"\"\n" )

            #write out enum classes
            if self.enums:
                outputFile.write( "\t# Enums\n" )
                for currentEnum in self.enums:
                    outputFile.write( "\tclass %s (Aptixia.IxEnum):\n" % currentEnum.strName )
                    for currentChoice in currentEnum.values:
                        outputFile.write( "\t\t%s = %i\n" % (currentChoice.strName, currentChoice.intValue ) )
                    outputFile.write( "\t\t__value = 0\n" )
                    outputFile.write( "\t\tdef __init__( self, value = 0, ignored = None ):\n\t\t\tself.__value = int(value)\n" )
                    outputFile.write( "\t\tdef __str__( self ):\n\t\t\treturn str( self.__value )\n" )
                    outputFile.write( "\t\tdef getType():\n\t\t\treturn \"%s.%s\"\n\t\tgetType = staticmethod(getType)\n" % (self.strClassName, currentEnum.strName))
                    outputFile.write( "\t\tdef getValue( self ):\n\t\t\treturn self.__value\n" )
                outputFile.write( "\n" )

            #add lists
            if self.lists:
                outputFile.write( "\t# List properties\n" )
                for currentList in self.lists:
                    userDefinedType = "None"
                    if currentList.strType.find('.') >= 0:
                        userDefinedType = currentList.strType
                    
                    outputFile.write( "\tclass %s( Aptixia.IxList ):\n" % currentList.strName )
                    outputFile.write( "\t\tdef __init__( self ):\n\t\t\tAptixia.IxList.__init__(self, \"%s\")\n" % \
                                      currentList.strType )
                    outputFile.write( "\t\tif \"%(container)s.%(type)s\" not in Aptixia.lists:\n\t\t\tAptixia.lists.append( \"%(container)s.%(type)s\" )\n" % \
                                      {"container":self.strClassName, "type":currentList.strName} )
                    outputFile.write( "\t\tdef getType():\n\t\t\treturn \"%s.%s\"\n\t\tgetType = staticmethod(getType)\n" % (self.strClassName, currentList.strName))
                    outputFile.write( "\t\tdef getElementType():\n\t\t\treturn \"%s\"\n\t\tgetElementType = staticmethod(getElementType)\n" % (currentList.strType))
                    outputFile.write( "\t\tdef getElementClass():\n\t\t\treturn %s\n\t\tgetElementClass = staticmethod(getElementClass)\n" % (userDefinedType))
#                    outputFile.write( "\t\tdef getType( self ):\n\t\t\treturn \"%s.%s\"\n\n" % \
#                                      ( self.strClassName, currentList.strName ) )
                                      
                outputFile.write( "\n" )

            #write out struct classes.
            if self.structs:
                outputFile.write( "\t# Structs\n" )
                for currentStruct in self.structs:
                    outputFile.write( "\tclass %s( Aptixia.IxStruct ):\n" % currentStruct.strName )
                    if currentStruct.strHelp:
                        outputFile.write( "\t\t\"\"\" %s \"\"\"\n" % currentStruct.strHelp )
                    outputFile.write( "\t\tif \"%(container)s.%(type)s\" not in Aptixia.structs:\n\t\t\tAptixia.structs.append(\"%(container)s.%(type)s\")\n" % \
                                      {"container":self.strClassName, "type":currentStruct.strName} )
                    outputFile.write( "\t\tdef __init__( self ):\n\t\t\tAptixia.IxStruct.__init__( self )\n" )
                    for currentMember in currentStruct.members:
                        if currentMember.strDefaultValue:
                            if currentMember.strType == "string":
                                outputFile.write( "\t\t\tself.%s = \"%s\"\n" % (currentMember.strName, currentMember.strDefaultValue ) )
                            else:
                                outputFile.write( "\t\t\tself.%s = %s\n" % (currentMember.strName, currentMember.strDefaultValue ) )
                        else:
                            if currentMember.strType == "string":
                                outputFile.write( "\t\t\tself.%s = \"\"\n" % currentMember.strName )
                            elif currentMember.strType == "bool":
                                outputFile.write( "\t\t\tself.%s = False\n" % currentMember.strName )
                            elif currentMember.strType[:3] == "int":
                                outputFile.write( "\t\t\tself.%s = 0\n" % currentMember.strName )
                            elif currentMember.strType == "double":
                                outputFile.write( "\t\t\tself.%s = 0.0\n" % currentMember.strName )
                            elif currentMember.strType == "octets":
                                outputFile.write( "\t\t\tself.%s = buffer( \"\" )\n" % currentMember.strName )
                            else:
                                intDotPos = string.find( currentMember.strType, "." )
                                if (intDotPos < 0) or (currentMember.strType[:intDotPos] == self.strClassName):
                                    outputFile.write( "\t\t\tself.%s = %s()\n" % (currentMember.strName, currentMember.strType) )
                                else:
                                    outputFile.write( "\t\t\tself.%s = %s.%s()\n" % \
                                                      (currentMember.strName, currentMember.strType[:intDotPos], currentMember.strType ) )
                                
                    if currentStruct.strVersion:
                        outputFile.write( "\t\t\tself._version = \"%s\"\n" % currentStruct.strVersion )
                    else:
                        outputFile.write( "\t\t\tself._version = \"0\"\n" )
                    outputFile.write( "\t\t\tself._types = { " )
                    blnFirstType = True
                    for currentMember in currentStruct.members:
                        if blnFirstType:
                            outputFile.write( "\"%s\":\"%s\"" % (currentMember.strName, currentMember.strType) )
                            blnFirstType = False
                        else:
                            outputFile.write( ",\n\t\t\t\t \"%s\":\"%s\"" % (currentMember.strName, currentMember.strType) )
                    outputFile.write( " }\n" )
                    outputFile.write( "\t\tdef getType( self ):\n\t\t\treturn \"%s.%s\"\n\n" %\
                                      (self.strClassName, currentStruct.strName) )
                outputFile.write( "\n" )

            #add properties
            outputLists = {}
            properiesCount=0
            if self.properties:
                outputFile.write( "\t# Class Properties\n" )
                #write out getters/setters (base class will populate variables)
                for currentProp in self.properties:
                    if currentProp.isObsolete:
                        print 'obsolete property: '+currentProp.strName+' - skipped.'
                        continue
                    properiesCount+=1
                    if not currentProp.blnList:
                        if (currentProp.strType == 'int32' or currentProp.strType == 'double' or \
                               currentProp.strType == 'string' or currentProp.strType == 'boolean'):
                            # simple types
                            outputFile.write( "\tdef _get_" + currentProp.strName + " (self):\n")
                            outputFile.write( '\t\treturn self.getVar ("%s")\n' % currentProp.strName)
                            
                            outputFile.write( "\tdef _set_" + currentProp.strName + " (self, value):\n")
                            outputFile.write( '\t\tself.setVar ("%s", value)\n' % currentProp.strName)
                            
                            outputFile.write( '\t%s = property (_get_%s, _set_%s, None, "%s property")\n' % (
                                currentProp.strName, currentProp.strName, currentProp.strName, currentProp.strName))
                        else:
                            # member objects
                            outputFile.write( "\tdef _get_" + currentProp.strName + " (self):\n")
                            outputFile.write( '\t\treturn self.getListVar ("%s")\n' % currentProp.strName)

                            if currentProp.isPolymorphic:
                                outputFile.write( "\tdef _set_" + currentProp.strName + " (self, value):\n")
                                outputFile.write( '\t\tself.setVar ("%s", value)\n' % currentProp.strName)
                            
                                outputFile.write( '\t%s = property (_get_%s, _set_%s, None, "%s property")\n' % (
                                    currentProp.strName, currentProp.strName, currentProp.strName, currentProp.strName))
                            else:
                                outputFile.write( '\t%s = property (_get_%s, None, None, "%s property")\n' % (
                                    currentProp.strName, currentProp.strName, currentProp.strName))
                    elif currentProp.blnList:
                        # lists (simple and object lists)
                        outputFile.write( "\tdef _get_" + currentProp.strName + " (self):\n")
                        outputFile.write( '\t\treturn self.getListVar ("%s")\n' % currentProp.strName)
                        
                        outputFile.write( '\t%s = property (_get_%s, None, None, "%s property")\n' % (
                            currentProp.strName, currentProp.strName, currentProp.strName))
                    """
                    elif currentProp.blnList:
                        outputFile.write( "\tdef getList_%s_%s( self ):\n" % (currentProp.strName, currentProp.strType) )
                        if currentProp.strDescription:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strDescription )                        
                        elif currentProp.strHelp:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strHelp )
                        else:
                            outputFile.write( "\t\tpass\n" )

                        outputFile.write( "\tdef setList_%s_%s( self ):\n" % (currentProp.strName, currentProp.strType) )
                        if currentProp.strDescription:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strDescription )                        
                        elif currentProp.strHelp:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strHelp )
                        else:
                            outputFile.write( "\t\tpass\n" )
                        outputLists[currentProp.strName] = currentProp.strType
                    else:
                        outputFile.write( "\tdef get_" + currentProp.strName + "( self ):\n")
                        if currentProp.strDescription:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strDescription )                        
                        elif currentProp.strHelp:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strHelp )
                        else:
                            outputFile.write( "\t\tpass\n" )
                        outputFile.write( "\tdef set_" + currentProp.strName + "( self, newValue ):\n" )
                        if currentProp.strHelp:
                            outputFile.write( "\t\t\"\"\" %s \"\"\"\n\t\tpass\n" % currentProp.strHelp )
                        else:
                            outputFile.write( "\t\tpass\n" )
                    """
                        
                outputFile.write( "\n" )                        
                                    
            #add methods
            outputFile.write( "\t# Constructor\n" )
            outputFile.write( "\tdef __init__( self, parent, objectId=None, transactionContext=None, preFetch=False):\n" )
            outputFile.write( "\t\tsuper( %s, self ).__init__(parent, objectId, transactionContext, preFetch)\n" % self.strClassName )
            for currentList in outputLists.keys():
                outputFile.write( "\t\tself._listTypes[\"%s\"] = \"%s\"\n" % (currentList, outputLists[currentList] ) )
                
            if self.properties:
                outputFile.write( "\t\t# defaults\n" )
                #write out getters/setters (base class will populate variables)
                outputFile.write( "\t\tif not self.isInstantiated:\n" )
                for currentProp in self.properties:
                    if currentProp.isObsolete:
                        continue
                    if currentProp.blnList:
                        if currentProp.strType == 'int' or currentProp.strType == 'double' or currentProp.strType == 'string':
                            outputFile.write( '\t\t\tself.managedProperties["%s"] = Aptixia.IxList ("%s")\n' %
                                              (currentProp.strName, currentProp.strType))
                        else:
                            outputFile.write( '\t\t\tself.managedProperties["%s"] = Aptixia.IxObjectList (self.transactionContext, "%s")\n' %
                                              (currentProp.strName, currentProp.strType))
                    else:
                        if currentProp.strType == 'int32':
                            if currentProp.strDefault == None or currentProp.strDefault == "(Select)":
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = 0\n' % (currentProp.strName ))
                            else:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = %s\n' % (currentProp.strName, currentProp.strDefault))
                        elif currentProp.strType == 'string':
                            if currentProp.strDefault == None:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = ""\n' % (currentProp.strName ))
                            else:                        
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = "%s"\n' % (currentProp.strName, currentProp.strDefault))
                        elif currentProp.strType == 'double':
                            if currentProp.strDefault == None:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = 0.0\n' % (currentProp.strName ))
                            else:                        
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = float(%s)\n' % (currentProp.strName, currentProp.strDefault))
                        elif currentProp.strType == 'boolean':
                            if currentProp.strDefault == None:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = False\n' % (currentProp.strName ))
                            else:
                                if currentProp.strDefault == "1" or currentProp.strDefault == "true":
                                    outputFile.write( '\t\t\tself.managedProperties["%s"] = True\n' % (currentProp.strName))
                                elif currentProp.strDefault == "0" or currentProp.strDefault == "false":
                                    outputFile.write( '\t\t\tself.managedProperties["%s"] = False\n' % (currentProp.strName))
                                else:
                                    raise "Illegal boolean default '%s' for property %s" % (
                                        currentProp.strDefault, currentProp.strName)
                        else:
                            # this is a subnode
                            if currentProp.isPolymorphic:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = None\n' % (currentProp.strName))
                            else:
                                outputFile.write( '\t\t\tself.managedProperties["%s"] = %s.%s (self)\n' %
                                    (currentProp.strName, currentProp.strType, currentProp.strType))
            outputFile.write( "\n" )
                    
            outputFile.write( "\t# Type identifier (used internally)\n" )
            outputFile.write( "\tdef getType( self ):\n" ) 
            outputFile.write( "\t\t\"\"\"Returns the type of the object as a string\"\"\"\n" )
            outputFile.write( "\t\treturn \"%s\"\n\n" % self.strClassName )

            if self.events:
                outputFile.write( "\t# Class Events\n" )
                for currentEvent in self.events:
                    outputFile.write( '\tdef register_' + currentEvent.strName + '_event (self, callback, callbackArg):\n' )
                    self.writeArgTuple (outputFile, True, currentEvent.args)
                    outputFile.write( '\t\treturn self.registerEvent ("%s", argTuple, callback, callbackArg)\n\n' % (currentEvent.strName))
                              
            if self.methods:
                outputFile.write( "\t# Class Methods\n" )
                for currentMethod in self.methods:
                    #write out asynchronous methods
                    strRealName = currentMethod.strName
                    while strRealName[-2:] == "Ex":
                        strRealName = strRealName[:-2]
                    outputFile.write( "\tdef " + currentMethod.strName + "( self" )
                    strAdditionalHelp = ""
                    if currentMethod.args:
                        for currentArg in currentMethod.args:
                            if currentArg.strDirection != "out":
                                outputFile.write( ", " + currentArg.strName )
                                if currentArg.strHelp:
                                    strAdditionalHelp = "%s\n\t\t\t%s: %s" % ( strAdditionalHelp, currentArg.strName, currentArg.strHelp )
                        for currentArg in currentMethod.args:
                            if (currentArg.strDirection == "out") and currentArg.strHelp:
                                strAdditionalHelp = "%s\n\t\t\tReturns %s: %s" % ( strAdditionalHelp, currentArg.strName, currentArg.strHelp )
                    outputFile.write( ", callback = None, callbackArg = None ):\n" )
                    if currentMethod.strHelp:
                        outputFile.write( "\t\t\"\"\" " + currentMethod.strHelp )
                        if len(strAdditionalHelp) > 0:
                            outputFile.write( strAdditionalHelp )
                        outputFile.write( " \"\"\"\n" )

                    self.writeMethodImpl( outputFile, currentMethod, strRealName )                    

                    #write out synchronous copies
                    outputFile.write( "\tdef " + currentMethod.strName + "_Sync( self" )
                    strAdditionalHelp = ""
                    if currentMethod.args:
                        for currentArg in currentMethod.args:
                            if currentArg.strDirection != "out":
                                outputFile.write( ", " + currentArg.strName )
                                if currentArg.strHelp:
                                    strAdditionalHelp = "%s\n\t\t\t%s: %s" % ( strAdditionalHelp, currentArg.strName, currentArg.strHelp )
                        for currentArg in currentMethod.args:
                            if (currentArg.strDirection == "out") and currentArg.strHelp:
                                strAdditionalHelp = "%s\n\t\t\tReturns %s: %s" % ( strAdditionalHelp, currentArg.strName, currentArg.strHelp )
                    outputFile.write( " ):\n" )
                    if currentMethod.strHelp:
                        outputFile.write( "\t\t\"\"\" " + currentMethod.strHelp )
                        if len(strAdditionalHelp) > 0:
                            outputFile.write( strAdditionalHelp )
                        outputFile.write( " \"\"\"\n" )

                    self.writeMethodImpl( outputFile, currentMethod, strRealName, True )
                    outputFile.write( "\n" )
                    
            if (properiesCount==0) and (not self.methods):
                outputFile.write( "\t\tpass\n" )
            outputFile.write( "\n" )                    
        finally:
            outputFile.close()            

    def writeArgTuple (self, outputFile, isEvent, args):
        intArgCounter = 0
        if args:
            for currentArg in args:
                if isEvent:
                    currentArg.strDirection = "out"
                userDefinedType = "None"
                p = currentArg.strType.find('.')
                if p >= 0:
                    userDefinedType = currentArg.strType
                    if self.strClassName != currentArg.strType[:p]:
                        userDefinedType = currentArg.strType[:p] + '.' + userDefinedType
                if currentArg.strDirection != "out":
                    outputFile.write( "\t\targ%i = Aptixia_prv.MethodArgument( \"%s\", %s, \"%s\", \"%s\", %s)\n" %
                                      (intArgCounter, currentArg.strName, currentArg.strName, currentArg.strDirection, currentArg.strType, userDefinedType) )
                else:
                    outputFile.write( "\t\targ%i = Aptixia_prv.MethodArgument( \"%s\", None, \"%s\", \"%s\", %s)\n" %
                                      (intArgCounter, currentArg.strName, currentArg.strDirection, currentArg.strType, userDefinedType) )
                intArgCounter = intArgCounter + 1

            if intArgCounter > 0:
                outputFile.write( "\t\targTuple = ( " )
                for i in range( intArgCounter ):
                    if i == 0:
                        outputFile.write( "arg" + str( i ) )
                    else:
                        outputFile.write( ", arg" + str( i ) )
                outputFile.write( ", )\n" )
            else:
                outputFile.write( "\t\targTuple = []\n" )
        else:
            outputFile.write( "\t\targTuple = []\n" )

    def writeMethodImpl( self, outputFile, method, strRealName, blnSync = False ):
        blnHasResult = False
        
        self.writeArgTuple (outputFile, False, method.args)

        outputFile.write( "\t\tself.FlushProperties()\n" )
        if blnSync:
            outputFile.write( "\t\tcontext = Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, \"%s\", argTuple)\n" % \
                              strRealName )
            outputFile.write( "\t\treturn context.Sync()\n" )
        else:
            outputFile.write( "\t\treturn Aptixia.RpcContext( self.transactionContext, self.getType(), self.objID, \"%s\", argTuple, callback, callbackArg )\n" % \
                              strRealName )

    def isLocalStructOrList( self, strType ):
        if self.structs:
            for currentStruct in self.structs:
                if currentStruct.strName == strType:
                    return True

        if self.lists:
            for currentList in self.lists:
                if currentList.strName == strType:
                    return True

        return False
    
    def IsBasicType( self, strType ):
        if strType in self.basicTypes:
            return True
        else:
            return False
        
class MetaschemaHandler( xml.sax.handler.ContentHandler ):    
    def __init__( self, generatedFile ):
        self.generatedFile = generatedFile
        xml.sax.handler.ContentHandler.__init__(self)
        
    def setDocumentLocator( self, locator ):
        pass

    def startDocument( self ):
        self.strListName = None
        self.listElements = None

        self.isMethod = False        
        self.strMethodName = None
        self.methodArgs = None

        self.currentProperty = None
        self.currentEnum = None
        self.currentStruct = None
        self.currentList = None
        
        self.strEnumName = None
        self.enumChoices = None
        
        self.strClassName = None
        self.strBaseClass = None
        
        self.strChars = None
        self.strHelpText = None
        self.blnInArgument = False
        self.blnInStructMember = False

        self.generatedFile.reset()        

    def endDocument( self ):
        self.generatedFile.generateFile()
        
    def startElement( self, strEleName, attrs ):
        if strEleName == "Method2":
            self.strMethodName = attrs.getValue( "name" )
            self.isMethod = True
        elif strEleName == "Event":
            self.strMethodName = attrs.getValue( "name" )
            self.isMethod = False
        elif (strEleName == "Argument") and self.strMethodName:
            self.blnInArgument = True
            newArg = MethodArg()
            newArg.strName = attrs.getValue( "name" )
            try:
                newArg.strDirection = attrs.getValue( "direction" )
            except:
                newArg.strDirection = "in"
                
            newArg.strType = attrs.getValue( "type" )
            if self.methodArgs == None:
                self.methodArgs = list()
            self.methodArgs.append( newArg )
            if not self.generatedFile.IsBasicType( newArg.strType ):
                self.generatedFile.addAdditonalClass( newArg.strType )
                
        elif strEleName == "PropertyNode":
            self.currentProperty = Property()
            self.currentProperty.strType = attrs.getValue( "nodeType" )
            if not self.generatedFile.IsBasicType( self.currentProperty.strType ):
                self.generatedFile.addAdditonalClass( self.currentProperty.strType )
            self.currentProperty.isPolymorphic = attrs.has_key("polymorphic") and attrs.getValue( "polymorphic" ) == "1"
        elif strEleName == "PropertyNodeList":
            self.currentProperty = Property()
            self.currentProperty.strType = attrs.getValue( "nodeType" )
            if not self.generatedFile.IsBasicType( self.currentProperty.strType ):
                self.generatedFile.addAdditonalClass( self.currentProperty.strType )
            self.currentProperty.blnList = True
            self.currentProperty.isPolymorphic = attrs.has_key("polymorphic") and attrs.getValue( "polymorphic" ) == "1"
        elif strEleName == "PropertyString":
            self.currentProperty = Property()
            self.currentProperty.strType = "string"
        elif strEleName == "PropertyStringList":
            self.currentProperty = Property()
            self.currentProperty.strType = "string"
            self.currentProperty.blnList = True
        elif strEleName == "PropertyBoolean":
            self.currentProperty = Property()
            self.currentProperty.strType = "boolean"
        elif strEleName == "PropertyInt":
            self.currentProperty = Property()
            self.currentProperty.strType = "int32"
        elif strEleName == "PropertyIntList":
            self.currentProperty = Property()
            self.currentProperty.strType = "int"
            self.currentProperty.blnList = True
        elif strEleName == "PropertyDoubleList":
            self.currentProperty = Property()
            self.currentProperty.strType = "double"            
            self.currentProperty.blnList = True
        elif strEleName == "PropertyDouble":
            self.currentProperty = Property()
            self.currentProperty.strType = "double"
        elif strEleName == "Struct":
            self.currentStruct = Struct()
            self.currentStruct.strName = attrs.getValue( "name" )
            self.currentStruct.strVersion = attrs.getValue( "version" )
        elif (strEleName == "Member") and self.currentStruct:
            newMember = StructMember()
            newMember.strName = attrs.getValue( "name" )
            newMember.strType = attrs.getValue( "type" )
            try:
                newMember.strDefaultValue = attrs.getValue( "default" )
            except:
                pass
            if not self.currentStruct.members:
                self.currentStruct.members = list()
            self.currentStruct.members.append( newMember )
            self.blnInStructMember = True
            if not self.generatedFile.IsBasicType( newMember.strType ):
                self.generatedFile.addAdditonalClass( newMember.strType )
        elif strEleName == "List":
            self.currentList = List()
            self.currentList.strName = attrs.getValue( "name" )
            self.currentList.strType = attrs.getValue( "type" )
            if not self.generatedFile.IsBasicType( self.currentList.strType ):
                self.generatedFile.addAdditonalClass( self.currentList.strType )
        elif strEleName == "Enum":
            self.currentEnum = Enum()
            self.currentEnum.strName = attrs.getValue( "name" )
        elif (strEleName == "Choice") and self.currentEnum:
            newEnum = EnumChoice()
            newEnum.strName = attrs.getValue( "symbol" )
            newEnum.intValue = int( attrs.getValue( "value" ) )
            if not self.currentEnum.values:
                self.currentEnum.values = list()
            self.currentEnum.values.append( newEnum )
        elif strEleName == "Node":
            self.strClassName = attrs.getValue( "nodeType" )
            self.strBaseClass = attrs.getValue( "baseType" )
            self.generatedFile.setClass( self.strClassName, self.strBaseClass )
        self.strChars = None

    def endElement( self, strEleName ):
        if strEleName == "Method2":
            self.generatedFile.addMethod( self.strMethodName, self.methodArgs, self.strHelpText )
            self.strMethodName = None
            self.methodArgs = None
            self.strHelpText = None
        if strEleName == "Event":
            self.generatedFile.addEvent( self.strMethodName, self.methodArgs, self.strHelpText )
            self.strMethodName = None
            self.methodArgs = None
            self.strHelpText = None
        elif strEleName == "Argument" and self.blnInArgument:
            self.blnInArgument = False
        elif (strEleName == "PropertyNode" ) or (strEleName == "PropertyString") or \
             (strEleName == "PropertyBoolean") or (strEleName == "PropertyInt") or \
             (strEleName == "PropertyDouble") or (strEleName == "PropertyStringList" ) or \
             (strEleName == "PropertyIntList" ) or (strEleName == "PropertyDoubleList" ) or \
             (strEleName == "PropertyNodeList") :
            self.generatedFile.addProperty( self.currentProperty )
            self.currentProperty = None
        elif (strEleName == "obsolete") and self.currentProperty:
            self.currentProperty.isObsolete = True
            self.strChars = None
        elif (strEleName == "name") and self.currentProperty:
            self.currentProperty.strName = self.strChars
            self.strChars = None
        elif (strEleName == "default") and self.currentProperty:
            self.currentProperty.strDefault = self.strChars
            self.strChars = None
        elif (strEleName == "description") and self.currentProperty:
            self.currentProperty.strDescription = self.strChars
            self.strChars = None
        elif strEleName == "help":
            if self.blnInArgument:
                self.methodArgs[len(self.methodArgs)-1].strHelp = self.strChars
            elif self.currentProperty:
                self.currentProperty.strHelp = self.strChars
            elif self.strMethodName:
                self.strHelpText = self.strChars
            elif self.currentStruct:
                if self.blnInStructMember:
                    self.currentStruct.members[len(self.currentStruct.members)-1].strHelp = self.strChars
                else:
                    self.currentStruct.strHelp = self.strChars
            elif (not self.currentEnum) and (not self.currentList):
                self.generatedFile.setClass( self.strClassName, self.strBaseClass, self.strChars )
            self.strChars = None
        elif strEleName == "Node":
            self.generatedFile.setClass( self.strClassName, self.strBaseClass )
        elif strEleName == "Struct":
            self.generatedFile.addStruct( self.currentStruct )
            self.currentStruct = None
        elif strEleName == "List":
            self.generatedFile.addList( self.currentList )
            self.currentList = None
        elif strEleName == "Enum":
            self.generatedFile.addEnum( self.currentEnum )
            self.currentEnum = None
        elif (strEleName == "Member") and self.currentStruct:
            self.blnInStructMember = False

    def characters( self, strContent ):
        if self.strChars:
            self.strChars = self.strChars + string.strip( strContent )
        else:
            self.strChars = string.strip( strContent )

if __name__ == "__main__":
    reader = xml.sax.make_parser()
    gen = GeneratedPyFile()
    handler = MetaschemaHandler( gen )
    reader.setContentHandler( handler )
    blnErrors = False
    if (len(sys.argv) < 2) or (sys.argv[1] == "-h"):
        print "Usage:"
        print "\tpython MetaschemaParser.py <Metaschema.xml> [anotherMetaschema.xml...]"
        print "\tpython MetaschemaParser.py -d <directory with metaschemas> [specificMetaschema.xml....]"
        sys.exit( -1 )
    if sys.argv[1] == "-d":
        strDirectory = sys.argv[2]
        if len( sys.argv ) > 3:
            files = sys.argv[3:]
        else:
            files = list()
            for root, dirs, dirFiles in os.walk( strDirectory ):
                for name in dirFiles:
                    files.append( os.path.join( root, name ) )
    else:
        files = sys.argv[1:]
        
    for currentFile in files:
        try:
            print "Parsing " + currentFile + "..."
            reader.parse( currentFile )
        except:
            print "Error parsing " + currentFile + ":"
            traceback.print_exc()
            blnErrors = True
    if blnErrors:
        print "!!!Errors while parsing!!!"
        sys.exit( -1 )
        
    print "Done"
