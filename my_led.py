import RPi.GPIO as GPIO
import time

    
def on(pin):
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pin,GPIO.OUT)
    GPIO.output(pin, GPIO.HIGH)

def off(pin):
    GPIO.output(pin, GPIO.LOW)
    GPIO.cleanup()


def read(pin):
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pin,GPIO.IN)
    value=GPIO.input(pin)
    return(value)
