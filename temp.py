import time
from w1thermsensor import W1ThermSensor

def read():
    sensor = W1ThermSensor(W1ThermSensor.THERM_SENSOR_DS18B20,"000003b70d1e")
    temperature = sensor.get_temperature()
    return(temperature)
