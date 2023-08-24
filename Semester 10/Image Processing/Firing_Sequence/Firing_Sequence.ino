#include <Servo.h>
int cmd = 0;
int up = 0 ; // lower servo angle offset 
int low = 0 ; // upper servo angle offset 
int fire = 0 ;
int cmd_map=0;
const int FiringTime = 2000; 
Servo sweep ; 
Servo upr ;
int pin3=7;


void setup() {
  sweep.attach(10);
  upr.attach(9);
  sweep.write(90);
  upr.write(90);
  pinMode(pin3, OUTPUT);
  digitalWrite(pin3, HIGH);
  Serial.begin(9600);
}
void loop() {    
  if (Serial.available() > 0) {
    cmd = Serial.read();
      up = 30;
      //low = 90-cmd;
        cmd_map=map(cmd,0,180,52,128);
        digitalWrite(pin3, LOW);
        sweep.write(cmd_map);
        upr.write(90+up);
        delay(FiringTime);
        upr.write(90-up);
        digitalWrite(pin3, HIGH);
        upr.write(90);
        delay(500);
        sweep.write(90);    

  }
}