#include <SPI.h>
#include <SD.h>
#include <TMRpcm.h> // install TMRpcm from tools>> manage libraries >> search for TMRpcm

TMRpcm tmrpcm;

#define SD_ChipSelectPin 10 // pins 11 through 14 are allocated for SPI communcation protocol between SD and Arduino 

void setup(){
tmrpcm.speakerPin = 9; // output pin 
tmrpcm.setVolume(6);// volume ranges from 0-7
 pinMode(2, INPUT); 
 digitalWrite(2,HIGH); 
 pinMode(3, INPUT); 
  digitalWrite(3,HIGH); 
 pinMode(4, INPUT); 
  digitalWrite(4,HIGH); 
 pinMode(5, INPUT); 
  digitalWrite(5,HIGH); 
 pinMode(6, INPUT); 
  digitalWrite(6,HIGH); 
 pinMode(7, INPUT); 
  digitalWrite(7,HIGH); 
 pinMode(8, INPUT);
  digitalWrite(8,HIGH); 
 pinMode(A0, INPUT);  
  //digitalWrite(A0,HIGH);   


Serial.begin(9600);
if (!SD.begin(SD_ChipSelectPin)) {
Serial.println("SD fail");
return;
}
else{Serial.print("Successful instantiation");}
}
void loop(){  

  if(digitalRead(2)== LOW)//if button 1 pressed , play 1.wav (name the files as 1 to 8 on your SD 
  {   delay(100);// delay is for switch debouncing , when you press a switch , it never really activates instantly , this compensates for that 
    tmrpcm.play("1.wav");
     Serial.print("button 1 pressed");
  }

  if(digitalRead(3)== LOW)
  {   delay(100); 
    tmrpcm.play("2.wav");
    Serial.print("button 2 pressed");
  }

  if(digitalRead(4)== LOW)
  {   delay(100); 
    tmrpcm.play("3.wav");
     Serial.print("button 3 pressed");
  }

  if(digitalRead(5)== LOW)
  {   delay(100); 
  
    tmrpcm.play("4.wav");
     Serial.print("button 4 pressed");
  }

  if(digitalRead(6)== LOW)
  {   delay(100); 
  
    tmrpcm.play("5.wav");
     Serial.print("button 5 pressed");
  }

  if(digitalRead(7)== LOW)
  {   delay(100); 
     
    tmrpcm.play("6.wav");
     Serial.print("button 6 pressed");
  }

 /* if(digitalRead(8)== HIGH)
  {   delay(100); 
    
    tmrpcm.play("7.wav");
     Serial.print("button 7 pressed");
  }*/

  /* if(digitalRead(A0)== LOW)
  {   delay(100); 
   
    tmrpcm.play("8.wav");
     Serial.print("button 8 pressed");
  }*/

   
  }
