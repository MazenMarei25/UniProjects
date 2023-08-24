#include<IRremote.h>

#include <AFMotor.h> 


int recv_pin = A5;
int distance = 6500;
unsigned long  OK = 0xFF38C7 ;

IRrecv receiver(recv_pin);
decode_results results;
AF_DCMotor motor3(3, MOTOR34_1KHZ);
AF_DCMotor motor4(4, MOTOR34_1KHZ);



void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  receiver.enableIRIn();
}

void loop() {
  // put your main code here, to run repeatedly:
  if(receiver.decode()){
      Serial.println(results.value, HEX);
      receiver.resume();
    }
   
}
 void translateIR(){

   if(receiver.decode()== OK && receiver.decode()!= 0xFFFFFF){
     
   motor3.setSpeed(200);
   motor4.setSpeed(200);
  
    motor3.run(FORWARD);
    motor4.run(FORWARD);
    

    delay(distance);
    motor3.run(RELEASE);
    motor4.run(RELEASE);
    delay(1000); 
    
    motor3.run(BACKWARD);
    motor4.run(BACKWARD);
    motor3.setSpeed(200);
  motor4.setSpeed(200);

    delay(distance); 
    
    motor3.run(RELEASE);
    motor4.run(RELEASE);
    delay(1000); 
  
     }
  
 }
