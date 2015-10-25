#!/usr/bin/python
import os
import time
import datetime
import sys

def getTime(fmt):
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime(fmt)
    return st

pin = int(sys.argv[1])   #GET PIN NUMBER

#PICK TYPE OF DATA COMING IN BASED ON PIN NUMBER
if pin == 4:
    tuba = 'elutuba'
    ledPin = 26
elif pin == 10:
    tuba = 'magatuba'
    ledPin = 21

path = '/home/pi/Temps/data/'   #PATH TO FILE STORAGE
wwwpath = '/var/www/html/tempnow/'  #PATH TO REALTIME TXT FILE STORAGE

#COMMANDS FOR OTHER SCRIPTS
readTempStr = 'sudo ' + path + 'tempread.py 22 ' + str(pin)  #TAKE TEMP READING
flashLEDStr = path + 'flashLED.py ' + str(ledPin) #FLASH LED
realtimeStr = 'sudo Rscript ' + wwwpath + 'realtime.R ' + tuba

#GET TEMP READING BY PASSING PIN ARG THROUGH OTHER SCRIPT
x = os.popen(readTempStr).read()
timeStmp = getTime('%Y-%m-%d_%H:%M:%S')
#FLASH LED TO SHOW WHEN MEASUREMENT IS BEING TAKEN
os.system(flashLEDStr)

#FORMAT STRINGS RECEIVED FROM PY SCRIPT
#SOMETIMES THE READINGS ARE ONLY ONE DECIMAL PLACE
t = x.index('.')    #FIND LOCATION OF FIRST DECIMAL POINT (TEMP)
y = x[t + 1:]       #SET HUMIDITY'S STRING AS BEING AFTER TEMP'S DECIMAL POINT
h = y.index('.')    #FIND LOCATION OF NEXT DECIMAL POINT IN HUM'S NUMBERS
temp = x[:t + 2]    #FINAL TEMPERATURE
hum = x[h + 1 : h + 5]  #FINAL HUMIDITY

#WRITE DATA TO RDA FILES
dateTempHum = timeStmp + "/" + str(temp) + "/" + str(hum)
rDataAddStr = 'Rscript ' + path + 'addToDataTable.R ' + tuba + ' ' + dateTempHum 

os.system(rDataAddStr)
#SAVE NEWEST TEMP AND HUMIDITY READINGS AS TXT FILES FOR REALTIME SECTION
os.system(realtimeStr)
