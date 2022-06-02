# AirQualitySystem
 
 Air Quality Monitoring System is used to monitor the air quality over an android application.
 
 Contributors involved in the project: Aniket Pai, Chinmaya S Ram, and Chris Xavier Mathias.
 

Sensors used : MQ9, MQ-135, PM2.5 and DHT11
Hardware used : Arduino UNO Board and Raspberry Pi 3b
Coding IDE : Arduino IDE, Python, Visual Studio Code
Cloud Services : ThingSpeak
Mobile Application Development: Flutter


In Brief, the sensors are used to record the values and send them to the arduino board. The arduino board further sends these values to the Raspberry Pi through UART communication link, and the Pi sends these values over to the ThingSpeak cloud. A basic android application developed in Flutter reads the data from the ThingSpeak cloud and displays the information on the app. Various other functions are proposed which will be further implemented.
