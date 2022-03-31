#include <Wire.h>
#include <ADXL345.h>

ADXL345 adxl;
int x, y, z;
double g[3];

void setup() {
  Serial.begin(115200);
  adxl.powerOn();
}

void loop() {
  adxl.readXYZ(&x, &y, &z);
  int sensorValue0 = analogRead (A0);
  int sensorValue1 = analogRead (A1);
  adxl.getAcceleration(g);
  Serial.print(x);
  Serial.print(" ");
  Serial.print(y);
  Serial.print(" ");
  Serial.print(z);
  Serial.print(" ");
  Serial.print(sensorValue0);
  Serial.print(" ");
  Serial.println(sensorValue1);
  delay(10);
}
