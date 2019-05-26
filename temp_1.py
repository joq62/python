import time
from w1thermsensor import W1ThermSensor

def read():
    sensor = W1ThermSensor(W1ThermSensor.THERM_SENSOR_DS18B20,"000003b70d1e")
    while True:
        temperature = sensor.get_temperature()
        print("The temperature is %s celsius" % temperature)
        time.sleep(1)

read()
