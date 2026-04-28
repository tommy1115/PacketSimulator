import sys, xml.dom.minidom

pf = file( sys.argv[1], "rt" )
strXML = pf.read()
pf.close()

if strXML[len(strXML)-1] == "\0":
    strXML = strXML[:len(strXML) - 1]
docObj = xml.dom.minidom.parseString( strXML )

strNewXML = ""

for currentNode in docObj.documentElement.childNodes:
    strType = currentNode.getAttribute( "type" )
    if strType == "string":
        strNewXML =  currentNode.firstChild.nodeValue

pf = file( "str_" + sys.argv[1], "wt" )
pf.write( strNewXML )
pf.close()
