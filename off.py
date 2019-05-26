from gpiozero import LED
from time import sleep

def led_off(p):
    led = LED(p)    
    while True:
        led.off()
