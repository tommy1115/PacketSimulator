import Aptixia, TestServerPrivate, XPBootstrap, XPUnitTest, XPUnitTestA
import msvcrt, time

def WaitForAnyKey():
    while not msvcrt.kbhit():
        time.sleep( 0.1 )
    msvcrt.getch()

tsp = None
bs = None
ut = None
resp = None

def init():
    global tsp, bs, ut
    print "Initializing..."
    
    tc = Aptixia.TransactionContext ("localhost", 5568)
    tsp = TestServerPrivate.TestServerPrivate (None, "1", tc)
    resp = tsp.CreateTestObject_Sync()
    bs = resp.bootstrap
    resp = bs.CreateTestObject_Sync()
    ut = resp.unitTest
    print "Prefetching..."
    ut.Prefetch()

# these tests are invalid, they assume clones of references are supported
"""
def propertyTest():
    print "Testing properties:"
    print "\tInt Property: " + str( ut.intVar )
    print "\tChanging..."
    ut.intVar = 5
    ut.SyncProperties()

    ut2 = XPUnitTest.XPUnitTest( None, ut.objID, ut.transactionContext )
    ut2.Prefetch()
    print "\tChecked: " + str( ut2.intVar )
    if ut2.intVar != ut.intVar:
        raise Exception()

    print "\tBool Property: " + str( ut.boolVar )
    print "\tChanging..."
    ut.intVar = 5
    ut.boolVar = True
    print "ut.boolVar", ut.boolVar
    ut.SyncProperties()
    print "ut.boolVar", ut.boolVar

    ut2 = XPUnitTest.XPUnitTest( None, ut.objID, ut.transactionContext )
    ut2.Prefetch()
    print "\tChecked: " + str( ut2.boolVar )
    if ut2.boolVar != ut.boolVar:
        raise Exception()

    print "\tDouble Property: " + str( ut.doubleVar )
    print "\tChanging..."
    ut.doubleVar = 0.47
    ut.SyncProperties()

    ut2 = XPUnitTest.XPUnitTest(None, ut.objID, ut.transactionContext )
    ut2.Prefetch()
    print "\tChecked: " + str( ut2.doubleVar )
    if ut2.doubleVar != ut.doubleVar:
        raise Exception()

    print "\tString Property: " + str( ut.stringVar )
    print "\tChanging..."
    ut.stringVar = "Foo!"
    ut.SyncProperties()

    ut2 = XPUnitTest.XPUnitTest( None, ut.objID, ut.transactionContext )
    ut2.Prefetch()
    print "\tChecked: " + str( ut2.stringVar )
    if ut2.stringVar != ut.stringVar:
        raise Exception()

    print "\tClientObjectBase Property: " + str( ut.subNode )
    print "\t\tPrefetching..."
    ut3 = ut.subNode
    ut3.Prefetch()

    print "\t\tString property: " + str( ut3.stringVar )
    print "\t\tChanging..."
    ut3.stringVar = "Foo Too!"
    ut3.SyncProperties()
    ut4 = XPUnitTestA.XPUnitTestA( None, ut3.objID, ut.transactionContext )
    ut4.Prefetch()
    print "\t\tChecked: " + str( ut4.stringVar )
    if ut3.stringVar != ut4.stringVar:
        raise Exception()

    print "\tStringList Property: " + str( ut.stringList )
    print "\tChanging..."
    ut.stringList = ["abc", "xyz"]
    ut.SyncProperties()

    ut2 = XPUnitTest.XPUnitTest( None, ut.objID, ut.transactionContext  )
    ut2.Prefetch()
    print "\tChecked: " + str( ut2.stringList )
    if (ut2.stringList[0] != ut.stringList[0]) or \
       (ut2.stringList[1] != ut.stringList[1]):
        raise Exception()
"""

def functionTest():
    print "Running Test Functions:"
    print "Int8Test:"
    inInt = 47
    inoutInt = 19
    resp = bs.Int8Test_Sync( inInt, inoutInt )
    if (resp.outInt8 != inoutInt + 1) or (resp.inoutInt8 != inInt + 1):
        raise Exception( "int8 test failed" )
    print "\tpassed"

    print "Int16Test:"
    resp = bs.Int16Test_Sync( inInt, inoutInt )
    if (resp.outInt16 != inoutInt + 1) or (resp.inoutInt16 != inInt + 1):
        raise Exception( "int16 test failed" )
    print "\tpassed"

    print "Int32Test:"
    resp = bs.Int32Test_Sync( inInt, inoutInt )
    if (resp.outInt32 != inoutInt + 1) or (resp.inoutInt32 != inInt + 1):
        raise Exception( "int32 test failed" )
    print "\tpassed"

    print "Int64Test:"
    resp = bs.Int64Test_Sync( inInt, inoutInt )
    if (resp.outInt64 != inoutInt + 1) or (resp.inoutInt64 != inInt + 1):
        raise Exception( "int64 test failed" )
    print "\tpassed"

    print "BoolTest:"
    b1 = True
    b2 = False
    resp = bs.BoolTest_Sync( b1, b2 )
    if (resp.outBool != b1) or (resp.inoutBool != b2):
        raise Exception( "bool test failed" )
    print "\tpassed"

    print "DoubleTest:"
    d1 = 0.16
    d2 = 2.01
    resp = bs.DoubleTest_Sync( d1, d2 )
    if (resp.outDouble != d2 + 1) or (resp.inoutDouble != d1 + 1 ):
        raise Exception( "double test failed" )
    print "\tpassed"

    print "StringTest:"
    s1 = "str1"
    s2 = "str2"
    resp = bs.StringTest_Sync( s1, s2 )
    if (resp.outString != s2 + s2) or (resp.inoutString != s1 + s1):
        raise Exception( "string test failed" )
    print "\tpassed"

    print "EnumTest:"
    resp = bs.EnumTest_Sync( 5, 6 )
    if (resp.outEnum != 6) or (resp.inoutEnum != 5):
        raise Exception( "enum test failed" )
    print "\tpassed"

    print "StructTest"
    inStruct = XPBootstrap.XPBootstrap.MyStruct()
    inStruct.aList.append(8)
    inStruct.anOctets = buffer( "abcd" )
    inStruct.anEnum = XPBootstrap.XPBootstrap.eMyEnum( 5 )
    inoutStruct = XPBootstrap.XPBootstrap.MyStruct()
    inoutStruct.aList.append(16)
    inoutStruct.anOctets = buffer( "efgh" )
    inoutStruct.anEnum = XPBootstrap.XPBootstrap.eMyEnum( 6 )
    resp = bs.StructTest_Sync( inStruct, inoutStruct )
    #parsing test: Throws an exception if the struct isn't parsed properly
    print "\tpassed"

def listTest():    
    print "ListTestInt8"
    inList = XPBootstrap.XPBootstrap.ListInt8()
    inList.append( 8 )
    inList.append( 24 )
    inoutList = XPBootstrap.XPBootstrap.ListInt8()
    inoutList.append( 16 )
    inoutList.append( 96 )
    resp = bs.ListTestInt8_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestInt8 failed" )
    print "\tpassed"

    print "ListTestInt16"
    inList = XPBootstrap.XPBootstrap.ListInt16()
    inList.append( 8 )
    inList.append( 24 )
    inoutList = XPBootstrap.XPBootstrap.ListInt16()
    inoutList.append( 16 )
    inoutList.append( 96 )
    resp = bs.ListTestInt16_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestInt16 failed" )
    print "\tpassed"

    print "ListTestInt32"
    inList = XPBootstrap.XPBootstrap.ListInt32()
    inList.append( 8 )
    inList.append( 24 )
    inoutList = XPBootstrap.XPBootstrap.ListInt32()
    inoutList.append( 16 )
    inoutList.append( 96 )
    resp = bs.ListTestInt32_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestInt32 failed" )
    print "\tpassed"

    print "ListTestInt64"
    inList = XPBootstrap.XPBootstrap.ListInt64()
    inList.append( 8 )
    inList.append( 24 )
    inoutList = XPBootstrap.XPBootstrap.ListInt64()
    inoutList.append( 16 )
    inoutList.append( 96 )
    resp = bs.ListTestInt64_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestInt64 failed" )
    print "\tpassed"

    print "ListTestBool"
    inList = XPBootstrap.XPBootstrap.ListBool()
    inList.append( True )
    inList.append( False )
    inoutList = XPBootstrap.XPBootstrap.ListBool()
    inoutList.append( False )
    inoutList.append( True )
    resp = bs.ListTestBool_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestBool failed" )
    print "\tpassed"

    print "ListTestDouble"
    inList = XPBootstrap.XPBootstrap.ListDouble()
    inList.append( 0.47 )
    inList.append( 26.94 )
    inoutList = XPBootstrap.XPBootstrap.ListDouble()
    inoutList.append( 8.3164 )
    inoutList.append( 10000 )
    resp = bs.ListTestDouble_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestDouble failed" )
    print "\tpassed"

    print "ListTestString"
    inList = XPBootstrap.XPBootstrap.ListString()
    inList.append( "stringA" )
    inList.append( "stringB" )
    inoutList = XPBootstrap.XPBootstrap.ListString()
    inoutList.append( "the quick brown fox jumped over the lazy dog" )
    inoutList.append( "antidisestablishmenttarianism" )
    resp = bs.ListTestString_Sync( inList, inoutList )
    if (inList[0] != resp.inoutList[0]) or\
       (inList[1] != resp.inoutList[1]) or\
       (inoutList[0] != resp.outList[0] ) or\
       (inoutList[1] != resp.outList[1] ):
        raise Exception( "ListTestString failed" )
    print "\tpassed"

##	def ListTestStruct_Sync( self, inList, inoutList ):
##	def ListTestList_Sync( self, inList, inoutList ):

def asyncTest():
    print "Running Async Tests"
    print "\tIn-order Async"
    inInt8 = 47
    inoutInt8 = 19
    inInt16 = 2945
    inoutInt16 = 309
    inInt32 = 203716
    inoutInt32 = 9978432
    
    ctx1 = bs.Int8Test( inInt8, inoutInt8 )
    ctx2 = bs.Int16Test( inInt16, inoutInt16 )
    ctx3 = bs.Int32Test( inInt32, inoutInt32 )

    resp = ctx1.Sync()
    if (resp.outInt8 != inoutInt8 + 1) or (resp.inoutInt8 != inInt8 + 1):
        raise Exception( "int8 test failed" )
    resp = ctx2.Sync()
    if (resp.outInt16 != inoutInt16 + 1) or (resp.inoutInt16 != inInt16 + 1):
        raise Exception( "int16 test failed" )
    resp = ctx3.Sync()
    if (resp.outInt32 != inoutInt32 + 1) or (resp.inoutInt32 != inInt32 + 1):
        raise Exception( "int32 test failed" )
    print "\t\tpassed"

    print "\tOut of order Async"    
    inInt8 = 12
    inoutInt8 = 3
    inInt16 = 845
    inoutInt16 = 963
    inInt32 = 224346
    inoutInt32 = 98234132
    
    ctx1 = bs.Int8Test( inInt8, inoutInt8 )
    ctx2 = bs.Int16Test( inInt16, inoutInt16 )
    ctx3 = bs.Int32Test( inInt32, inoutInt32 )

    resp = ctx2.Sync()
    if (resp.outInt16 != inoutInt16 + 1) or (resp.inoutInt16 != inInt16 + 1):
        raise Exception( "int16 test failed" )
    resp = ctx3.Sync()
    if (resp.outInt32 != inoutInt32 + 1) or (resp.inoutInt32 != inInt32 + 1):
        raise Exception( "int32 test failed" )
    resp = ctx1.Sync()
    if (resp.outInt8 != inoutInt8 + 1) or (resp.inoutInt8 != inInt8 + 1):
        raise Exception( "int8 test failed" )
    print "\t\tpassed"

def test():
    pass

if __name__ == "__main__":
    init()
#    propertyTest()
    functionTest()
    listTest()
    asyncTest()
    tsp.ShutdownSocket()
