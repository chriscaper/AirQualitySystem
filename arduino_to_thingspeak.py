import serial
import time
import RPi.GPIO as GPIO
import thingspeak
import threading
import requests
import json
import urllib.request
import random
import time

channel_id = 1752477
write_key = '6CQD9T0EAK439XTI'
lst = []
ser=serial.Serial("/dev/ttyACM0",9600)  #change ACM number as found from ls /dev/tty/ACM*
ser.baudrate=9600
GPIO.setmode(GPIO.BOARD)



while True:
    read_ser=ser.readline().decode("utf-8")
    read_ser = int(read_ser)
    

    lst.append(read_ser)
    while len(lst) == 5:
        
        NEW_URL5 = 'https://api.thingspeak.com/update?api_key=6CQD9TOEAK439XTI&field1={}&field2={}&field3={}&field4={}&field5={}'.format(lst[0],lst[1],lst[2],lst[3],lst[4])
        print(NEW_URL5)
        data = urllib.request.urlopen(NEW_URL5)
        print(data)
        
        lst.clear()
        time.sleep(30)
    


if __name__ == "__main__":
    channel = thingspeak.Channel(id = channel_id, api_key = write_key)