#include <dht11.h>
#define DHT11PIN 4
dht11 DHT11;
int A[5] ={};

int x, sensorValue;
int dhtValue = 0;
int measurePin=A5;  //PM2.5

int samplingTime =280;
int deltaTime =40;
int sleepTime =9680;

float voMeasured = 0;
float calcVoltage= 0;
float dustDensity= 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  delayMicroseconds(samplingTime);
  voMeasured = analogRead(measurePin);
  delayMicroseconds(deltaTime);
  delayMicroseconds(sleepTime);           //PM2.5
  calcVoltage = voMeasured*(5.0/1024.0);
  dustDensity = 170*calcVoltage-0.1;
  
  x = analogRead(A0); // MQ-6 Data A0
  sensorValue = analogRead(A1);   //MQ-135 Data A1
  
  // MQ6 - MQ135 - PM2.5 - DHT11  HUMIDITY - TEMP
  A[0] = x;
  delay(500);
  
  //Serial.println("MQ-135 Value: ");
  //Serial.println(sensorValue);
  A[1] = sensorValue;
  delay(500);
  
  //Serial.println("PM2.5 Value: ");
  //Serial.println (dustDensity);
  A[2] = dustDensity;
  delay(500);

  //DHT sensor
  //Serial.println();

  int chk = DHT11.read(DHT11PIN);

  //Serial.print("Humidity (%): ");
  //Serial.println((float)DHT11.humidity, 2);
  A[3] = (int)DHT11.humidity;
  //Serial.print("Temperature (C): ");
  //Serial.println((float)DHT11.temperature, 2);
  A[4] = (int)DHT11.temperature;

  delay(500);

  for(int i = 0; i<5; i++){
    Serial.println(A[i]);
    delay(500);
  }
  

}
