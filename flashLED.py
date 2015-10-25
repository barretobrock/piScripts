#!/usr/bin/python

import RPi.GPIO as GPIO
import sys
from time import sleep

#TURN OFF ANY GPIO WARNINGS
GPIO.setwarnings(False)
#GET PIN FROM ARGUMENTS
p = int(sys.argv[1])
n = 1

#USE THE PIN NUMBERS FROM THE RIBBON CABLE BOARD
GPIO.setmode(GPIO.BCM)

#SET UP THE PIN YOU ARE USING AS OUTPUT
GPIO.setup(p,GPIO.OUT)

#TURN ON THE PIN AND SEE LED LIGHT UP
GPIO.output(p, GPIO.HIGH)
sleep(0.05)
#TURN OFF THE PIN TO TURN OFF THE LED
GPIO.output(p,GPIO.LOW)

#FLASHING SEQUENCE
while n < 10:
	GPIO.setup(p, GPIO.OUT)
	GPIO.output(p, GPIO.HIGH)
	sleep(0.05)
	GPIO.output(p, GPIO.LOW)
	sleep(0.05)
	n += 1
