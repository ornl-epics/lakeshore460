#!../../bin/linux-x86_64/Lakeshore460

## You may have to change Lakeshore460 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

#Define protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(LAKESHORE460)/protocol/")
#Moxa 9600 7 1 Odd no flow



## Register all support components
dbLoadDatabase "dbd/Lakeshore460.dbd"
Lakeshore460_registerRecordDeviceDriver pdbbase
drvAsynIPPortConfigure ("Lakeshore460","10.112.63.59:4002",0,0,0)


#This prints low level commands and responses
#asynSetTraceMask("Lakeshore460",0,0xFF)
#asynSetTraceIOMask("Lakeshore460",0,0xFF)






## Load record instances
#dbLoadRecords("db/xxx.db","user=zmaHost")

dbLoadRecords(db/Lakeshore460.db)

#################################################
# autosave

epicsEnvSet IOCNAME secage-SE-lakeshore460
epicsEnvSet SAVE_DIR /home/controls/var/$(IOCNAME)


set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass0_restoreFile("$(IOCNAME)_pass0.sav")
set_pass1_restoreFile("$(IOCNAME).sav")

#################################################


cd ${TOP}/iocBoot/${IOC}
iocInit

var mediatorVerbosity 7

var mySubDebug 7

# Create request file and start periodic 'save'
epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME)_pass0.req", "autosaveFields_pass0")
create_monitor_set("$(IOCNAME).req", 5)
create_monitor_set("$(IOCNAME)_pass0.req", 30)

