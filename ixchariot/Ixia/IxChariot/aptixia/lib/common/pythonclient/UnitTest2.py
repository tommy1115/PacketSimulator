import Aptixia, TestServerPrivate, XPBootstrap, XPUnitTest, XPUnitTestA, XPUnitTestB, XPUnitTestC
import DodWrapper, PortGroup, StatCatalogStat, StatSpec, StatCatalogItem, StatFilter, StatView, SonetATMBasePlugin
import msvcrt, time, traceback, StringIO, os, sys

import EthernetPlugin, IpV4V6Plugin, IpV4V6Range

import unittest

codePath = os.path.dirname (sys.argv[0])

def init ():
    global tsp, bs
    Aptixia.Init (codePath+"/../../../data")
    tc = Aptixia.TransactionContext ("localhost", 5568)
    tsp = TestServerPrivate.TestServerPrivate (None, "1", tc)
    bs = tsp.CreateTestObject_Sync().bootstrap

init ()

class Test (unittest.TestCase):
    
    def test_amultiReferences(self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        self.assertEqual (None, unitTest.polymorphicSubNode)
        
        unitTest.polymorphicSubNode = XPUnitTestC.XPUnitTestC(unitTest)
        unitTest.SyncProperties()
        #unitTest.Prefetch()                 # for some unknown reason runs ok when stand alone, fails when all tests are running.
        self.assertEqual(1,len(unitTest.subNodeListD))
        obj=unitTest.polymorphicSubNode.secondReference
        obj1=unitTest.subNodeListD[0]
        self.assertEqual(obj1,obj)

    def TestInt8 (self, bootstrap, value1, value2, result1, result2):
        resp = bootstrap.Int8Test_Sync (value1, value2)
        self.assertEqual (result1, resp.inoutInt8)
        self.assertEqual (result2, resp.outInt8)

    def TestInt16 (self, bootstrap, value1, value2, result1, result2):
        resp = bootstrap.Int16Test_Sync (value1, value2)
        self.assertEqual (result1, resp.inoutInt16)
        self.assertEqual (result2, resp.outInt16)

    def TestInt32 (self, bootstrap, value1, value2, result1, result2):
        resp = bootstrap.Int32Test_Sync (value1, value2)
        self.assertEqual (result1, resp.inoutInt32)
        self.assertEqual (result2, resp.outInt32)

    def TestInt64 (self, bootstrap, value1, value2, result1, result2):
        resp = bootstrap.Int64Test_Sync (value1, value2)
        self.assertEqual (result1, resp.inoutInt64)
        self.assertEqual (result2, resp.outInt64)

    def TestBool (self, bootstrap, value1, value2):
        target3 = not value2
        resp = bootstrap.BoolTest_Sync (value1, value2)
        self.assertEqual (not value1, resp.inoutBool)
        self.assertEqual (target3, resp.outBool)

    def TestDouble (self, bootstrap, value1, value2):
        target2 = value1 + 1.0
        target3 = value2 + 1.0
        resp = bootstrap.DoubleTest_Sync (value1, value2)
        self.assertEqual (target2, resp.inoutDouble)
        self.assertEqual (target3, resp.outDouble)

    def TestString (self, bootstrap, value1, value2):
        target2 = value1 + value1
        target3 = value2 + value2
        resp = bootstrap.StringTest_Sync (value1, value2)
        self.assertEqual (target2, str(resp.inoutString))
        self.assertEqual (target3, str(resp.outString))

    def TestOctets (self, bootstrap, value1, value2):
        target2 = value1 
        target3 = value2 
        resp = bootstrap.OctetsTest_Sync (value1, value2)
        self.assertEqual (target2, resp.inoutOctets)
        self.assertEqual (target3, resp.outOctets)

    def TestEnums (self, bootstrap, value1, value2):
        target2 = value1
        target3 = value2
        resp = bootstrap.EnumTest_Sync (value1, value2)
        self.assertEqual (target2, resp.inoutEnum)
        self.assertEqual (target3, resp.outEnum)

    def test_int8 (self):
        self.TestInt8 (bs, 11, 17, 12, 18)
        self.TestInt8 (bs, 0x7e, 17, 0x7f, 18)
        self.TestInt8 (bs, -0x80, 17, -0x7f, 18)

    def test_int16 (self):
        self.TestInt16 (bs, 11, 17, 12, 18)
        self.TestInt16 (bs, 0x7ffe, 17, 0x7fff, 18)
        self.TestInt16 (bs, -0x8000, 17, -0x7fff, 18)

    def test_int32 (self):
        self.TestInt32 (bs, 11, 17, 12, 18)
        self.TestInt32 (bs, 0x7ffffffe, 17, 0x7fffffff, 18)
        self.TestInt32 (bs, -0x80000000L, 17, -0x7fffffff, 18)

    def test_int64 (self):
        self.TestInt64 (bs, 11, 17, 12, 18)
        self.TestInt64 (bs, 0x7ffffffffffffffeL, 17, 0x7fffffffffffffffL, 18)
        self.TestInt64 (bs, -0x8000000000000000L, 17, -0x7fffffffffffffffL, 18)

    def test_bool (self):
        self.TestBool (bs, False, False);
        self.TestBool (bs, False, True);
        self.TestBool (bs, True, False);
        self.TestBool (bs, True, True);

    def test_double (self):
        self.TestDouble (bs, 3.5, 7.5);
        self.TestDouble (bs, -3.5, -7.5);

    def test_string (self):
        self.TestString (bs, "a", "b");
        self.TestString (bs, "<&abc>", "<&def>");
        self.TestString (bs, "<![CDATA[ some stuff ]]>", "]]> <![CDATA[");

    def test_octets (self):
        self.TestOctets (bs, "a", "b");
        self.TestOctets (bs, "ab", "bc");
        self.TestOctets (bs, "abc", "bcd");
        self.TestOctets (bs, "abcd", "bcde");
        self.TestOctets (bs, "abcde", "bcdef");
        self.TestOctets (bs, "abcdef", "bcdefg");
        self.TestOctets (bs, "abcdefg", "bcdefgh");

        self.TestOctets (bs, "<&abc>", "<&def>");
        self.TestOctets (bs, "<![CDATA[ some stuff ]]>", "]]> <![CDATA[");
        evil = "abc\0def";
        self.TestOctets (bs, evil, "b");

    def test_enum (self):
        self.TestEnums (bs,
                        XPBootstrap.XPBootstrap.eMyEnum.kSymbol1,
                        XPBootstrap.XPBootstrap.eMyEnum.kSymbol2)

    def test_listInt8 (self):
        list1 = [-0x80, 8]
        list2 = [0x7f, -3, 9]
        resp = bs.ListTestInt8_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listInt16 (self):
        list1 = [-0x8000, 8]
        list2 = [0x7fff, -3, 9]
        resp = bs.ListTestInt16_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listInt32 (self):
        list1 = [-0x80000000L, 8]
        list2 = [0x7fffffff, -3, 9]
        resp = bs.ListTestInt32_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listInt64 (self):
        list1 = [-0x8000000000000000L, 8]
        list2 = [0x7fffffffffffffffL, -3, 9]
        resp = bs.ListTestInt64_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)
        
    def test_listBool (self):
        list1 = [True, False]
        list2 = [True, True, False]
        resp = bs.ListTestBool_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listDouble (self):
        list1 = [5.6, 3.9]
        list2 = [7.2, -3.1, 8.2]
        resp = bs.ListTestDouble_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listString (self):
        list1 = ["abc", "def"]
        list2 = ["1<", "2>", "3", "<![CDATA[ some stuff ]]>", "]]> <![CDATA["]
        resp = bs.ListTestString_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listOctets (self):
        list1 = ["abc", "def"]
        list2 = ["1", "2", "<![CDATA[ some stuff ]]>", "]]> <![CDATA["]
        resp = bs.ListTestOctets_Sync (list1, list2)
        self.assertEqual (list1, resp.inoutList)
        self.assertEqual (list2, resp.outList)

    def test_listEnum (self):
        list1 = [XPBootstrap.XPBootstrap.eMyEnum.kSymbol1, XPBootstrap.XPBootstrap.eMyEnum.kSymbol2]
        list2 = [XPBootstrap.XPBootstrap.eMyEnum.kSymbol3]
        resp = bs.ListTestEnum_Sync (list1, list2)
        self.assertEqual (2, len(resp.inoutList))
        self.assertEqual (1, len(resp.outList))
        
        self.assertEqual (list1[0], resp.inoutList[0])
        self.assertEqual (list2[0], resp.outList[0])

    def test_struct (self):
        inStruct = XPBootstrap.XPBootstrap.MyStruct()
        inStruct.anInt8 = 95
        inStruct.aList.append(8)
        inStruct.anOctets = "abcd<"
        inStruct.aString = "<![CDATA["
        inStruct.aBool = False
        inStruct.anEnum = XPBootstrap.XPBootstrap.eMyEnum.kSymbol1
        inStruct.aStruct.anInt32 = 65539
        
        inoutStruct = XPBootstrap.XPBootstrap.MyStruct()
        inoutStruct.anInt8 = 96
        inoutStruct.aList.append(16)
        inoutStruct.anOctets = "efgh"
        inoutStruct.aBool = True
        inoutStruct.anEnum = XPBootstrap.XPBootstrap.eMyEnum.kSymbol2
        
        resp = bs.StructTest_Sync( inStruct, inoutStruct )

        self.assertEqual (95, resp.inoutStruct.anInt8)
        self.assertEqual (1, len(resp.inoutStruct.aList))
        self.assertEqual (8, resp.inoutStruct.aList[0])
        self.assertEqual ("abcd<", resp.inoutStruct.anOctets)
        self.assertEqual ("<![CDATA[", resp.inoutStruct.aString)
        self.assertEqual (False, resp.inoutStruct.aBool)
        self.assertEqual (65539, resp.inoutStruct.aStruct.anInt32)
        self.assertEqual (XPBootstrap.XPBootstrap.eMyEnum.kSymbol1, resp.inoutStruct.anEnum)

        self.assertEqual (1, len(resp.outStruct.aList))
        self.assertEqual (16, resp.outStruct.aList[0])
        self.assertEqual (True, resp.outStruct.aBool)
        self.assertEqual (XPBootstrap.XPBootstrap.eMyEnum.kSymbol2, resp.outStruct.anEnum)

    def test_listStruct (self):
        struct1 = XPBootstrap.XPBootstrap.MyStruct()
        struct2 = XPBootstrap.XPBootstrap.MyStruct()
        struct3 = XPBootstrap.XPBootstrap.MyStruct()
        struct1.anInt8 = 3
        struct2.anInt8 = 5
        struct3.anInt8 = 10
        list1 = [struct1, struct2]
        list2 = [struct3, struct2, struct1]
        
        resp = bs.ListTestStruct_Sync (list1, list2)

        self.assertEqual (2, len(resp.inoutList))
        self.assertEqual (3, len(resp.outList))
                
        self.assertEqual (3, resp.inoutList[0].anInt8)
        self.assertEqual (5, resp.inoutList[1].anInt8)
        self.assertEqual (10, resp.outList[0].anInt8)
        self.assertEqual (5, resp.outList[1].anInt8)
        self.assertEqual (3, resp.outList[2].anInt8)
        
    def test_listList (self):
        list1 = [[5,3], [6,7]]
        list2 = [[73,1,2]]
        resp = bs.ListTestList_Sync (list1, list2)
        
        self.assertEqual (2, len(resp.inoutList))
        self.assertEqual (1, len(resp.outList))

        self.assertEqual (5, resp.inoutList[0][0])
        self.assertEqual (3, resp.inoutList[0][1])
        self.assertEqual (6, resp.inoutList[1][0])
        self.assertEqual (7, resp.inoutList[1][1])
        
        self.assertEqual (73, resp.outList[0][0])
        self.assertEqual (1, resp.outList[0][1])
        self.assertEqual (2, resp.outList[0][2])

    def test_managedInt (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        unitTest.intVar = 123
        self.assertEqual (123, unitTest.intVar)
        resp1 = unitTest.GetTestInt ()
        testPoint1 = resp1.Sync ().v
        
        unitTest.intVar = 456
        self.assertEqual (456, unitTest.intVar)
        resp2 = unitTest.GetTestInt ()

        testPoint2 = resp2.Sync ().v
        
        self.assertEqual (123, testPoint1)
        self.assertEqual (456, testPoint2)
        
    def test_managedIntExtremes (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        unitTest.intVar = 5000000000L
        self.assertEqual (5000000000L, unitTest.intVar)
        resp1 = unitTest.GetTestInt_Sync ()
        self.assertEqual (resp1.v, 5000000000L)

        unitTest.Invalidate ()
        self.assertEqual (resp1.v, 5000000000L)
        
        unitTest.intVar = -5000000000L
        self.assertEqual (-5000000000L, unitTest.intVar)
        resp1 = unitTest.GetTestInt_Sync ()
        self.assertEqual (resp1.v, -5000000000L)

        unitTest.Invalidate ()
        self.assertEqual (unitTest.intVar, -5000000000L)
        
    def test_managedBool (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        unitTest.boolVar = True
        self.assertEqual (True, unitTest.boolVar)
        resp1 = unitTest.GetTestBool ()
        testPoint1 = resp1.Sync ().v
        
        unitTest.boolVar = False
        self.assertEqual (False, unitTest.boolVar)
        resp2 = unitTest.GetTestBool ()

        testPoint2 = resp2.Sync ().v
        
        self.assertEqual (True, testPoint1)
        self.assertEqual (False, testPoint2)

    def test_managedDouble (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        unitTest.doubleVar = 123.7
        self.assertEqual (123.7, unitTest.doubleVar)
        resp1 = unitTest.GetTestDouble ()
        testPoint1 = resp1.Sync ().v
        
        unitTest.doubleVar = 456.3
        self.assertEqual (456.3, unitTest.doubleVar)
        resp2 = unitTest.GetTestDouble ()

        testPoint2 = resp2.Sync ().v
        
        self.assertEqual (123.7, testPoint1)
        self.assertEqual (456.3, testPoint2)

    def test_managedString (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        unitTest.stringVar = "123"
        self.assertEqual ("123", unitTest.stringVar)
        resp1 = unitTest.GetTestString ()
        testPoint1 = resp1.Sync ().v
        
        unitTest.stringVar = "456"
        self.assertEqual ("456", unitTest.stringVar)
        resp2 = unitTest.GetTestString ()

        testPoint2 = resp2.Sync ().v
        
        self.assertEqual ("123", testPoint1)
        self.assertEqual ("456", testPoint2)

    def test_managedIntList (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        unitTest.intList.append (5)        
        unitTest.intList.append (77)
        unitTest.intList.append (5000000000L)

        unitTest.SyncProperties()
        unitTest.Invalidate()

        self.assertEqual (3, len (unitTest.intList))
        self.assertEqual (5, unitTest.intList[0])
        self.assertEqual (77, unitTest.intList[1])
        self.assertEqual (5000000000L, unitTest.intList[2])
        
    def test_managedListMethods (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        l = unitTest.intList

        # test append        
        l.blnDirty = False
        l.append (5)
        l.append (6)
        l.append (7)
        l.append (6)
        self.assertEqual (True, l.blnDirty)

        # test count        
        self.assertEqual (2, l.count (6))

        # test index        
        self.assertEqual (2, l.index (7))

        # test extend        
        l.blnDirty = False
        l.extend ([-1,-2,-3])
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([5,6,7,6,-1,-2,-3], l)

        # test insert
        l.blnDirty = False
        l.insert (1, 3)
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([5,3,6,7,6,-1,-2,-3], l)
        
        # test pop
        l.blnDirty = False
        self.assertEqual (5, l.pop ())
        self.assertEqual (-1, l.pop (4))
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([3,6,7,6,-2,-3], l)
        
        # test remove
        l.blnDirty = False
        l.remove (6)
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([3,7,6,-2,-3], l)

        # test iterator
        l2 = []
        for value in l:
            l2.append (value)
        self.assertEqual ([3,7,6,-2,-3], l2)

        # test len        
        self.assertEqual (5, len(l))
        
        # test getitem
        self.assertEqual (6, l[2])
        self.assertEqual ([6,-2], l[2:4])
        
        # test setitem
        l.blnDirty = False
        l[2] = 9
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([3,7,9,-2,-3], l)
        
        # test delitem
        l.blnDirty = False
        del l[3]
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([3,7,9,-3], l)

        # test __eq__
        self.assertEqual (True, l == [3,7,9,-3])
        self.assertEqual (False, l == [3,7,9,-4])
        
        # test __ne__
        self.assertEqual (False, l != [3,7,9,-3])
        self.assertEqual (True, l != [3,7,9,-4])

        # test clear
        l.blnDirty = False
        l.clear ()
        self.assertEqual (True, l.blnDirty)
        self.assertEqual ([], l)
        

    def test_managedStringList (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        unitTest.stringList.append ("5")        
        unitTest.stringList.append ("77")
        unitTest.stringList.append ("9")

        unitTest.SyncProperties ()
        unitTest.Invalidate ()

        self.assertEqual (3, len (unitTest.stringList))
        self.assertEqual ("5", unitTest.stringList[0])
        self.assertEqual ("77", unitTest.stringList[1])
        self.assertEqual ("9", unitTest.stringList[2])

    def test_managedDoubleList (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        unitTest.doubleList.append (5.3)        
        unitTest.doubleList.append (77.9)
        unitTest.doubleList.append (9.2)

        unitTest.SyncProperties()
        unitTest.Invalidate ()

        self.assertEqual (3, len (unitTest.doubleList))
        self.assertEqual (5.3, unitTest.doubleList[0])
        self.assertEqual (77.9, unitTest.doubleList[1])
        self.assertEqual (9.2, unitTest.doubleList[2])

    def test_managedSubnode (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        unitTest.intVar = 993
        unitTest.subNode.stringVar = "ghi"
        resp2 = unitTest.GetTestInt_Sync ()
        unitTest.Invalidate ()

        self.assertEqual (993, unitTest.intVar)
        self.assertEqual ("ghi", unitTest.subNode.stringVar)
        
    def test_polymorphicSubnode (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        self.assertEqual (None, unitTest.polymorphicSubNode)
        unitTest.polymorphicSubNode = XPUnitTestB.XPUnitTestB (unitTest)
        unitTest.polymorphicSubNode.stringVarB = "12345"
        unitTest.polymorphicSubNode.stringVar = "ghij"
        string1 = unitTest.polymorphicSubNode.GetTestStringA_Sync ().v
        string2 = unitTest.polymorphicSubNode.GetTestStringB_Sync ().v
        self.assertEqual ("ghij", string1)
        self.assertEqual ("12345", string2)
        
    def test_polymorphicSubnodeDeletion (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        
        self.assertEqual (None, unitTest.polymorphicSubNode)
        unitTest.polymorphicSubNode = XPUnitTestB.XPUnitTestB (unitTest)
        unitTest.FlushProperties ()
        unitTest.Invalidate ()
        
        self.assertNotEqual (None, unitTest.polymorphicSubNode)
        
        unitTest.polymorphicSubNode = None
        unitTest.FlushProperties ()
        unitTest.Invalidate ()

        self.assertEqual (None, unitTest.polymorphicSubNode)

    def test_polymorphicReinstantiation (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest

        self.assertEqual (None, unitTest.polymorphicSubNode)
        unitTest.polymorphicSubNode = XPUnitTestB.XPUnitTestB (unitTest)

        objectId1 = unitTest.polymorphicSubNode.objID
        
        unitTest.polymorphicSubNode.stringVar = "ghij"
        unitTest.SyncProperties ()
                
        unitTest.polymorphicSubNode = XPUnitTestB.XPUnitTestB (unitTest)
        unitTest.polymorphicSubNode.stringVar = "klm"

        objectId2 = unitTest.polymorphicSubNode.objID
        self.assertNotEqual (objectId1, objectId2)

        unitTest.FlushProperties ()
        unitTest.Invalidate ()

        objectId3 = unitTest.polymorphicSubNode.objID   
        self.assertEqual (objectId2, objectId3)


    def test_foreignScope (self):
        utStruct = XPUnitTest.XPUnitTest.UnitTestStruct ()
        utEnum = XPUnitTest.XPUnitTest.eUnitTestEnum.kSymbol1
        utList = XPUnitTest.XPUnitTest.UnitTestList ()
        bs.TestUserDefinedTypeScope_Sync (utEnum, utStruct, utList)

    def test_objectList (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        l = unitTest.intList

        l = unitTest.subNodeList

        o1 = XPUnitTestC.XPUnitTestC (unitTest)
        o2 = XPUnitTestC.XPUnitTestC (unitTest)
        o3 = XPUnitTestC.XPUnitTestC (unitTest)
        l.append (o1)
        l.append (o2)
        l.append (o3)

        o1.stringVarC = "abcd1"        
        o2.stringVarC = "abcd2"        
        o3.stringVarC = "abcd3"        
        unitTest.FlushProperties ()
        unitTest.Invalidate ()
        
        l = unitTest.subNodeList
        self.assertEqual (3, len(l))

        self.assertEqual ("abcd1", l[0].stringVarC)
        self.assertEqual ("abcd2", l[1].stringVarC)
        self.assertEqual ("abcd3", l[2].stringVarC)

        # test iterator
        result = []
        for o in l:
            result.append (o)
        
        self.assertEqual ("abcd1", result[0].stringVarC)
        self.assertEqual ("abcd2", result[1].stringVarC)
        self.assertEqual ("abcd3", result[2].stringVarC)

        del l[1]
        unitTest.FlushProperties ()
        unitTest.Invalidate ()
        
        l = unitTest.subNodeList
        self.assertEqual (2, len(l))

        self.assertEqual ("abcd1", l[0].stringVarC)
        self.assertEqual ("abcd3", l[1].stringVarC)

        l.clear ()        
        unitTest.FlushProperties ()
        unitTest.Invalidate ()

        l = unitTest.subNodeList
        self.assertEqual (0, len(l))
                

    def test_polymorphicObjectList (self):
        unitTest = bs.CreateTestObject_Sync ().unitTest
        l = unitTest.intList

        l = unitTest.polymorphicSubNodeList

        o1 = XPUnitTestB.XPUnitTestB (unitTest)
        o2 = XPUnitTestC.XPUnitTestC (unitTest)
        o3 = XPUnitTestC.XPUnitTestC (unitTest)
        l.append (o1)
        l.append (o2)
        l.append (o3)

        o1.stringVar = "ghi1"        
        o1.stringVarB = "abcd1"        
        o2.stringVar = "ghi2"        
        o2.stringVarC = "abcd2"        
        o3.stringVar = "ghi2"        
        o3.stringVarC = "abcd3"        
        unitTest.FlushProperties ()
        unitTest.Invalidate ()
        
        l = unitTest.polymorphicSubNodeList
        self.assertEqual (3, len(l))

        self.assertEqual ("ghi1", l[0].stringVar)
        self.assertEqual ("abcd1", l[0].stringVarB)
        self.assertEqual ("ghi2", l[1].stringVar)
        self.assertEqual ("abcd2", l[1].stringVarC)
        self.assertEqual ("ghi2", l[2].stringVar)
        self.assertEqual ("abcd3", l[2].stringVarC)

        del l[1]
        unitTest.FlushProperties ()
        unitTest.Invalidate ()
        
        l = unitTest.polymorphicSubNodeList
        self.assertEqual (2, len(l))

        self.assertEqual ("ghi1", l[0].stringVar)
        self.assertEqual ("abcd1", l[0].stringVarB)
        self.assertEqual ("ghi2", l[1].stringVar)
        self.assertEqual ("abcd3", l[1].stringVarC)

    def eventCallback (self, results):
        self.calledBack = True
        self.assertEqual (9, results.anInt8)
        self.assertEqual (32767, results.anInt16)
        self.assertEqual (100000, results.anInt32)
        self.assertEqual (123, results.anInt64)
        self.assertEqual (True, results.aBool)
        self.assertEqual (5.3, results.aDouble)
        self.assertEqual ("abc", results.aString)
        self.assertEqual ("def", results.anOctets)
        try:
            unitTest = bs.CreateTestObject_Sync ().unitTest
            raise "should not get here"
        except Aptixia.Error, e:
            pass
        
        
    def test_events (self):
        self.calledBack = False
        unitTest = bs.CreateTestObject_Sync ().unitTest
        context = unitTest.register_MyEvent_event (Test.eventCallback, self)

        aStruct = XPUnitTest.XPUnitTest.UnitTestStruct ()
        aList = XPUnitTest.XPUnitTest.UnitTestList ()
        unitTest.TestEvent_Sync (9, 32767, 100000, 123, True, 5.3, "abc", "def",
                   XPUnitTest.XPUnitTest.eUnitTestEnum.kSymbol2,
                   aStruct, aList)
        self.assertEqual (True, self.calledBack)
        
        context.Unregister ()
        self.calledBack = False
        unitTest.TestEvent_Sync (9, 32767, 100000, 123, True, 5.3, "abc", "def",
                   XPUnitTest.XPUnitTest.eUnitTestEnum.kSymbol2,
                   aStruct, aList)
        self.assertEqual (False, self.calledBack)
        
    def _errors_callback(self,error):
        self.errorCalled=True

    def test_errors (self):
        try:
            self.errorCalled=False
            bs.transactionContext.registerErrorCallback(Test._errors_callback,self)
            resp = bs.Int8Test_Sync (500, 600)
        except Aptixia.Error, e:
            #self.assertEqual ("Aptixia.XProtocol.BadParameter", e.id)
            self.assertEqual (self.errorCalled,True)
            return
        raise "should not get here"
    
    def test_messageBase (self):
        try:
            raise Aptixia.LocalError ("Aptixia.XProtocol.FailedToConnect", "abc")
        except Aptixia.Error, e:
            self.assertEqual ("Aptixia.XProtocol.FailedToConnect", e.id)
            #self.assertEqual ("Unable to connect to host abc.", e.text.strip())
            return
        raise "should not get here"
    
    def test_emptyArgList (self):
        tsp.Ping_Sync ()

    def test_localError (self):
        try:
            dummy = Aptixia.ContextBase (5,"", 5,5)
        except Aptixia.Error, e:
            self.assertEqual ("Aptixia.ClientLibrary.InternalError", e.id)
            return
        raise "should not get here"

    def test_dodUpload (self):
        file(codePath+"/largefile.tmp", "wb").write (" " * 1000001)
        resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
        session = resp.session
        resp = session.CreateTest_Sync ()
        test = resp.test
        portGroupList = test.portGroupList
        pg = PortGroup.PortGroup (test)
        portGroupList.append (pg)
        DodWrapper.Upload (pg, codePath+"/largefile.tmp", "largefile.tmp")
        try:
            os.unlink (codePath+"/largefile.tmp")
        except:
            pass

    def test_lyleTest1 (self):
        resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
        session = resp.session
        resp = session.CreateTest_Sync ()
        tsTest = resp.test
        tsPortGroupList = tsTest.portGroupList
        tsPortGroup = PortGroup.PortGroup(tsTest) #, self.name, transactionContext = tsTest.transactionContext)
        tsPortGroupList.append(tsPortGroup)

        # make sure the filter plugin has ben server-side-instantiated        
        self.assertEqual (1, len(tsPortGroup.globalPluginList))
        tsTest.SyncProperties ()
        
    def test_lyleTest2 (self):
        resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
        session = resp.session
        resp = session.CreateTest_Sync ()
        tsTest = resp.test
        tsPortGroupList = tsTest.portGroupList
        tsPortGroup = PortGroup.PortGroup(tsTest)
        tsPortGroupList.append(tsPortGroup)
        tsPortGroup.SyncProperties ()
        tsTest.SyncProperties ()

    def test_lyleTest3 (self):
        try:
            resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
            session = resp.session
            resp = session.CreateTest_Sync ()
            tsTest = resp.test
            tsPortGroupList = tsTest.portGroupList
            tsPortGroup = PortGroup.PortGroup(tsTest)
            tsPortGroupList.append(tsPortGroup)
            tsPortGroupList.append(tsPortGroup)
            tsTest.SyncProperties ()
        except Aptixia.Error, e:
            self.assertEqual ("Aptixia.ClientLibrary.InternalError", e.id)
            return
        raise "should not get here"

    def test_lyleTest4(self):
        import EthernetPlugin, IpV4V6Plugin, IpV4V6Range
        resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
        session = resp.session
        resp = session.CreateTest_Sync ()
        tsTest = resp.test
        tsPortGroupList = tsTest.portGroupList
        tsPortGroup = PortGroup.PortGroup(tsTest) #, self.name, transactionContext = tsTest.transactionContext)
        tsPortGroupList.append(tsPortGroup)
        ethernetPlugin = EthernetPlugin.EthernetPlugin(tsPortGroup)
        tsPortGroup.stack = ethernetPlugin
        ipV4V6Plugin = IpV4V6Plugin.IpV4V6Plugin(ethernetPlugin)
        ethernetPlugin.childrenList.append (ipV4V6Plugin)
        tsRangeList = ipV4V6Plugin.rangeList
        tsRange = IpV4V6Range.IpV4V6Range(ipV4V6Plugin)
        tsRangeList.append(tsRange)
        tsRange.ipType = "IPv4"
        tsRange.Name = "Some Name"
        tsRange.address = "192.168.0.1"
        tsRange.count = 100
        tsRange.incrementBy = "0.0.0.1"
        tsRange.prefix = 16
        tsRange.gatewayaddress = "0.0.0.0"
        tsRange.mss = 1460
        tsRange.SyncProperties()
        tsPortGroup.SyncProperties()
        tsTest.SyncProperties()

    def test_lyleTest5 (self):
        file(codePath+"/largefile.tmp", "wb").write (" " * 1000001)
        resp = tsp.OpenSession_Sync ("username", "sessionname", 0)
        session = resp.session
        resp = session.CreateTest_Sync ()
        test = resp.test
        portGroupList = test.portGroupList
        pg = PortGroup.PortGroup (test)
        portGroupList.append (pg)
        DodWrapper.Upload (pg, codePath+"/largefile.tmp", "largefile.tmp")
        pg = PortGroup.PortGroup (test)
        portGroupList.append (pg)
        DodWrapper.Upload (pg, codePath+"/largefile.tmp", "largefile.tmp")
        try:
            os.unlink (codePath+"/largefile.tmp")
        except:
            pass

    def test_configureIpRange (self):
            session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
            test = session.CreateTest_Sync ().test
            portGroupList = test.portGroupList
            portGroup = PortGroup.PortGroup(test)
            portGroupList.append(portGroup)
            portGroup.stack = EthernetPlugin.EthernetPlugin (portGroup)
            stack = portGroup.stack
            children = stack.childrenList
            ip = IpV4V6Plugin.IpV4V6Plugin (stack)
            children.append (ip)
            rangeList = ip.rangeList
            range = IpV4V6Range.IpV4V6Range (ip)
            rangeList.append (range)
            range.enabled = True
            range.iptype = "IPv4"
            range.address = "10.0.0.1"
            range.incrementBy = "0.0.0.1"
            range.count = 100
            test.FlushProperties ()
            
            test.Invalidate ()
            
            stack = test.portGroupList[0].stack
            childrenList = stack.childrenList[0]
            range = childrenList.rangeList[0]
            self.assertEqual (True, range.enabled)

    def test_configureCatalog (self):
        session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
        test = session.CreateTest_Sync ().test
        statManager = test.statManager
        statCatalog = statManager.statCatalog
        
        statCatalogItem = StatCatalogItem.StatCatalogItem (statManager)
        statCatalog.append(statCatalogItem)
        statList = statCatalogItem.statList
        statFilterList = statCatalogItem.statFilterList

        stat = StatCatalogStat.StatCatalogStat(statCatalogItem)
        statList.append(stat)
        ags = stat.availableAggregationTypeList
        ags.append(StatSpec.StatSpec.eAggregationTypeEnum.kWeightedAverage)

        filter = StatFilter.StatFilter (statCatalogItem)
        statFilterList.append (filter)
        valueList = filter.valueList
        valueList.append ("abc")
        valueList.append ("def")

        test.FlushProperties ()
        test.Invalidate ()
        statCatalog = statManager.statCatalog
        self.assertEqual (StatSpec.StatSpec.eAggregationTypeEnum.kWeightedAverage,
                          statCatalog[0].statList[0].availableAggregationTypeList[0])
        self.assertEqual ("abc",
                          statCatalog[0].statFilterList[0].valueList[0])
        self.assertEqual ("def",
                          statCatalog[0].statFilterList[0].valueList[1])

    '''
    def test_startTestServer (self):
        # note: data path is relative to server executable
        binPath = os.path.abspath (codePath+"/../../../bin/wind")
        ts = Aptixia.StartTestServer (binPath, "../../data")
        ts.Ping_Sync ()
        
    '''                

    def test_statViewerXml (self):
        data = file (codePath+'/statviewer.xml', 'rb').read ()

        session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
        test = session.CreateTest_Sync ().test
        statManager = test.statManager
        statViewer = statManager.statViewer
        statViewer._ImportXml_Sync (data, False)
        test.Invalidate ()

    def test_fileTransferSmall (self):
        testData = "test data"
        f = StringIO.StringIO (testData)
        
        self.calledBack = False
        resp = bs.FileTest_Sync (f)
        resultData = resp.outFile.read ()
        self.assertEqual (testData, resultData)
        
    def test_fileTransferLarge (self):
        testData = "x" * 250000
        f = StringIO.StringIO (testData)
        
        self.calledBack = False
        resp = bs.FileTest_Sync (f)
        resultData = resp.outFile.read (5000)
        resultData += resp.outFile.read ()
        self.assertEqual (testData, resultData)

    def test_configureView (self):
        session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
        test = session.CreateTest_Sync ().test
        statManager = test.statManager
        statViewer = statManager.statViewer
        statViewList = statViewer.statViewList
        statView = StatView.StatView (statViewer)
        statViewList.append (statView)
        statSpecList = statView.statSpecList
        statSpec = StatSpec.StatSpec (statView)
        statSpecList.append (statSpec)
        statSpec.enabled = True
        statSpec.caption = "this is a caption"
        statSpec.statSourceType = "HTTP client"
        statSpec.statName = "abc"
        statSpec.aggregationType = StatSpec.StatSpec.eAggregationTypeEnum.kWeightedAverage
        statSpec.enumerated = False
        statSpec.interpolated = False
        statSpec.index = 0
        statSpec.indexLast = 0
        statSpec.statType = StatSpec.StatSpec.eStatTypeEnum.kDefault
        statSpec.yAxisRange = "0-500" # not sure what to put here
        statSpec.csvStatLabel = "def"
        statSpec.csvFunctionLabel = "google"
        test.SyncProperties ()

    def test_mohit1 (self):
        session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
        test = session.CreateTest_Sync ().test
        statManager = test.statManager
        statViewer = statManager.statViewer
        statViewList = statViewer.statViewList
        statView = StatView.StatView (statViewer)
        statViewList.append (statView)
        statSpecList = statView.statSpecList

        stat = StatSpec.StatSpec(statView)
        stat.statName = "abc"                
        stat.enabled = True
        stat.statSourceType = "some type"
        
        enumItems = [StatSpec.StatSpec.eAggregationTypeEnum.kSum,
                     StatSpec.StatSpec.eAggregationTypeEnum.kMax,
                     StatSpec.StatSpec.eAggregationTypeEnum.kMin,
                     StatSpec.StatSpec.eAggregationTypeEnum.kAverage,
                     StatSpec.StatSpec.eAggregationTypeEnum.kWeightedAverage,
                     StatSpec.StatSpec.eAggregationTypeEnum.kRate,
                     StatSpec.StatSpec.eAggregationTypeEnum.kMaxRate,
                     StatSpec.StatSpec.eAggregationTypeEnum.kMinRate,
                     StatSpec.StatSpec.eAggregationTypeEnum.kAverageRate,
                     StatSpec.StatSpec.eAggregationTypeEnum.kNone
                    ]
                        
        stat.aggregationType = StatSpec.StatSpec.eAggregationTypeEnum.kAverageRate                
        statView.statSpecList.append(stat)
        test.SyncProperties ()

    def test_yossi1 (self):
            session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
            test = session.CreateTest_Sync ().test
            portGroupList = test.portGroupList
            portGroup = PortGroup.PortGroup(test)
            portGroupList.append(portGroup)
            test.SyncProperties ()

#            portGroupList = test.portGroupList
#            portGroup = portGroupList[0]
            l = portGroup.portList
            l.append ("123")
            l.append ("234")
            test.FlushProperties ()

            test.Invalidate ()
            
            portGroupList = test.portGroupList
            portGroup = portGroupList[0]
            l = portGroup.portList

            self.assertEqual (2, len(l))
            self.assertEqual ("123", l[0])
            self.assertEqual ("234", l[1])

    def test_yossi2 (self):
            session = tsp.OpenSession_Sync ("username", "sessionname", 0).session
            test = session.CreateTest_Sync ().test
            portGroupList = test.portGroupList
            portGroup = PortGroup.PortGroup(test)
            portGroupList.append(portGroup)
            
            l = portGroup.portList
            l.append ("123")
            l.append ("234")
            test.FlushProperties ()

            test.Invalidate ()
            
            portGroupList = test.portGroupList
            portGroup = portGroupList[0]
            l = portGroup.portList

            self.assertEqual (2, len(l))
            self.assertEqual ("123", l[0])
            self.assertEqual ("234", l[1])
            
if __name__ == "__main__":
    #tstSuite=unittest.TestSuite()
    #tstSuite.addTest(Test("test_managedDoubleList"))
    #runner=unittest.TextTestRunner()
    #runner.run(tstSuite)
    suite = unittest.makeSuite(Test)
    runner=unittest.TextTestRunner()
    runner.run(suite)
    print "calling tsp.ShutdownSocket()"
    tsp.ShutdownSocket()
