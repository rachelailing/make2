#include <SoftwareSerial.h>

SoftwareSerial BTSerial (2,3);
const int trigPin = 9;
const int echoPin = 10;
int duration, distance;
char Data;

void setup() {
    // put your setup code here, to run once:
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  Serial.begin(9600);
  BTSerial.begin(9600);
  Serial.println("BT on");
  BTSerial.print("Location: Seminar room"); //can be name for eah place
}

void loop() 
  {
  // put your main code here, to run repeatedly:
  if(BTSerial.available())
  {
  Data = BTSerial.read(); //read from phone
  } 

    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(5);
    digitalWrite(trigPin, LOW);

    duration = pulseIn(echoPin, HIGH);
    distance = (duration/2)/29.1;
    
    

    if (distance <= 7 && distance >=0){
      Serial.print("Full\n");
      BTSerial.print("Full\n");
    }
    else if(distance >=100 || distance <0){
    Serial.print("Empty\n");
    BTSerial.print("Empty\n");
    }
    else 
    {
    //Serial.print("Distance: ");
    //Serial.println(distance); //deisplay in laptop (serial monitor)
    BTSerial.print("Not Full\n");
    //BTSerial.println(distance);//display in phone 
    }
    delay(3000);
  }