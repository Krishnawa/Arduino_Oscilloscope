
int a = 0;    // First Channel
int b = 0;   // Second Channel
//int c = 0;  // Third Channel
//int d = 0; // Fourth Channel

int inByte = 0;         // incoming serial byte

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
  // if we get a valid byte, read analog ins:
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
 
    a = analogRead(A0)/4 ;// 1024/4 =255
    b = analogRead(A1)/4;
    delay(10);
  //  c = analogRead(A2);
   // delay(10);
   // c = analogRead(A3);
    //delay(10);
    // send sensor values:
        

   Serial.write(a);
   Serial.write(b);
 //   Serial.write(c);
//    Serial.write(d);
   // Serial.write(thirdSensor);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
