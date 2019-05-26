from gpiozero import LED
from time import sleep

def led_on(p):
    led = LED(p)    
    while True:
        led.on()
