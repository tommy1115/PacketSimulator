import sys, os,threading, time,traceback, thread

ReleaseRun = True     # set to True - will run without deadlock tracing, False - with deadlock tracing (maybe slow)


if ReleaseRun:
    class TraceableLock:
        def __init__ (self, name="Unknown",framesToSkip=3,traceTimeOut=10.0):
            self.lock = threading.RLock()
            self.lockTimeOut    = traceTimeOut
            self.name           = name
            self.framesToSkip   = framesToSkip
            pass            
            
        def acquire(self):
            self.lock.acquire()
            pass
    
        def release(self):
            self.lock.release()
            pass
else:

    curdir      = os.path.dirname(sys._getframe().f_code.co_filename)
    deadlockLog = os.path.abspath(os.path.join(curdir,"deadlock.log"))
    logFile     = open(deadlockLog,'a+',0)


    class TraceableLock:
        def __init__ (self, name="Unknown",framesToSkip=3,traceTimeOut=10.0):
            self.lock           = threading.RLock()
            self.lockCondition  = threading.Condition()
            self.lockCount      = 0
            self.lockStack      = []
            self.lockThread     = None
            self.lockTimeOut    = traceTimeOut
            self.name           = name
            self.framesToSkip   = framesToSkip
            self.waitCount      = 0
        
        def acquire(self):
            self.lockCondition.acquire()
            
            if self.lockCount==0:    # safe to lock - nobody own the lock object
                self.lock.acquire()
                self.__push_lock_context__()
            elif self.lockThread==threading.currentThread():    # safe to lock - recursive call
                self.lock.acquire()
                self.__push_lock_context__()
            else:
                start_time=time.time()
                while True:
                    #print >>logFile, "Wait for ",self.name
                    self.waitCount+=1
                    self.lockCondition.wait(self.lockTimeOut)
                    self.waitCount-=1
                    #print >>logFile, "Triggered ",self.name
                    if self.lockCount==0:      # must be safe to obtain lock in here
                        self.lock.acquire()
                        wait_time=time.time()-start_time
                        #print >>logFile, "Obtained ",self.name, wait_time
                        self.__push_lock_context__()
                        break
                    else:   # check if timeouted
                        wait_time=time.time()-start_time
                        if wait_time > self.lockTimeOut:
                            self.__report_deadlock__()
            
            self.lockCondition.release()
        
        def release(self):
            self.lockCondition.acquire()
            self.lockCount-=1
            self.lockStack.pop()
            self.lock.release()
            if self.lockCount==0:
                self.lockThread=None
                if  self.waitCount>0:
                    #print >>logFile, ">>Trigger ",self.name
                    self.lockCondition.notify()     # relase waiting thread
            self.lockCondition.release()
        
        def __push_lock_context__(self):
            self.lockCount+=1
            frame=sys._getframe(self.framesToSkip)
            self.lockStack.append(traceback.extract_stack(frame,2))
            self.lockThread=threading.currentThread()
            
        def __report_deadlock__(self):
            print >>logFile, "Warning : possible deadlock - \'%s\' locked by thread \'%s\'" % (self.name,self.lockThread.getName(),)
            print >>logFile, "Trying from :"
            frame=sys._getframe(self.framesToSkip)
            stack=traceback.extract_stack(frame)
            list=traceback.format_list(stack)
            for line in list:
                print >>logFile, line
                
            print >>logFile, "Locked from :"
            for stack in self.lockStack:
                list=traceback.format_list(stack)
                for line in list:
                    print >>logFile, line
                print >>logFile, "--"
            
class ScopeLock:
    def __init__ (self, locker,text=""):
        self.lock = locker
        self.text = text
        #print "acquire ",self.text        
        self.lock.acquire()
        #print "acquired ",self.text        
        
    def __del__ (self):
        #print "release ",self.text
        self.lock.release()
        #print "released ",self.text


dataLock=TraceableLock('Main Lock')

class MyTread(threading.Thread):
    def run( self ):
        lock=ScopeLock(dataLock,"from thread")
        pass

def call():
    lock=ScopeLock(dataLock,"from call")
    pass

if __name__ == "__main__":
    lock=ScopeLock(dataLock,"from main")
    thread=MyTread()
    call()
    thread.setDaemon( True )
    print "start"
    thread.start()
    time.sleep (100)
    print "exit"

