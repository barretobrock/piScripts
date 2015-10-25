#!/usr/bin/python

import sys
import Adafruit_DHT

# Parse command line parameters
sensor_args = { '11': Adafruit_DHT.DHT11,
			'22': Adafruit_DHT.DHT22,
			'2302': Adafruit_DHT.AM2302 }
if len(sys.argv) == 3 and sys.argv[1] in sensor_args:
	sensor = sensor_args[sys.argv[1]]
	pin = sys.argv[2]
else:
	print 'usage: sudo ./Adafruit_DHT.py [11|22|2302] GPIOpin#'
	print 'example: sudo ./Adafruit_DHT.py 2302 4 - Read from an AM2302 connected to GPIO #4'

humidity, temp = Adafruit_DHT.read_retry(sensor, pin)

def getTemp():
	if humidity is not None and temp is not None:
		print temp, humidity
	else:
		print 'Failed to get reading. Try again!'
		sys.exit(1)
getTemp()
