def Upload (portGroup, fileNameWithPath, fileName):
    sizeToRead = 500000
    f = file (fileNameWithPath, 'rb')
    resp = portGroup.DodBeginDownLoad_Sync (fileName, 1000)
    sessionId = resp.sessionId
    while 1:
        bytes = f.read (sizeToRead)
        if len(bytes) == 0: break
        portGroup.DodUpLoadFileSegment (sessionId, bytes) # asynchronous call
    portGroup.DodEndDownLoad_Sync (sessionId)