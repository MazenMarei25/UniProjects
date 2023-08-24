#include <Servo.h> 

const int servoPin = 3; // 490HZ dt 1ms ? 
const int PotRef = A1 ; // Read the reference pot 
const int PotFeed = A0 ; // Read the feedback pot 
const float KP = 13.8;//.328 
const float KI =  14.3995555693; //14.3995555693;
const float KD =  9.14;
float Integral ; 
int OldTime ; 
int NewTime ; 
int dt ; 
int Output ; 
int Setpoint ; 
float Error ; 
float PrevError;
float NewReading ; 
float OldReading = 0 ; 

Servo myservo; 

void setup() {
Serial.begin(9600);
myservo.attach(servoPin);
Setpoint = map(analogRead(PotRef),0,1023,0,180);
Error = Setpoint - OldReading ;  
PrevError = 0 ;
 //Serial.print(Setpoint);
NewTime = millis(); 
}
void loop() {
Setpoint = map(analogRead(PotRef),0,1023,0,180);  
NewReading = map(analogRead(PotFeed),0,1023,0,180) ; 
OldTime = NewTime ; 
NewTime = millis();
dt = NewTime - OldTime ; 
Error = Setpoint - NewReading ;
Integral += KI*((PrevError + Error)*(dt/2));
Output = KP*Error + Integral + KD*((Error - PrevError)/(dt)); // What if the Output is negative or float ? 
if (Output < 0)
{ Output = 0 ; // 0 CLOCKWISE ROATATION 
  } 
  else{
if (Output > 180)
{ Output = 180 ; // 180 ANTICLOCKWISE ROATION 
  }   
 }

myservo.write(Output); // servo.write() does not take negative values and analogWrite will just truncate 2s complement !
PrevError = Error ;

//  Serial.println("SETPOINT");
//Serial.println(Setpoint); // SETPOINT 
//delay(500);
//Serial.println("FEEDBACK");
Serial.println(Output); // FEEDBACK
delay(15);
}
