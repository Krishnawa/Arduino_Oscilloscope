import processing.serial.*;

  int a = 0;           // Background color
  int b = 0;   
  //int c = 0;           // Fill color
  //int d = 0;           // Fill color
  float i = 1;
  Serial myPort;                       // The serial port
  int[] serialInArray = new int[2];    // Where we'll put what we receive
  int serialCount = 0;                 // A count of how many bytes we receive
  
  boolean firstContact = false;        // Whether we've heard from the microcontroller

  void setup() {
    size(500, 500);  // Stage size
    background(0);// colour is black
    grid();
    noStroke();      // No border on the next thing drawn

   
  

    // Print a list of the serial ports for debugging purposes
    // if using Processing 2.1 or later, use Serial.printArray()
   // println(Serial.list());

    // I know that the first port in the serial list on my Mac is always my FTDI
    // adaptor, so I open Serial.list()[0].
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    //String portName = Serial.list()[0];
    myPort = new Serial(this,"/dev/ttyUSB1", 9600);
   // myPort.bufferUntil('\n');

  }

  void draw() {
  
    if (i>=500)
    {
    i=0;
    background(0); // colour --> black
    grid();
    
    }
    fill(255, 0, 0);// R , G , B --> colours -->red colour
    stroke(255,0,0);// outline of the shape
    circle(i,400-a,2);// it's our shape
    i=i+1;// it's incrementing by 1
    fill(255, 255, 0);// yellow  colour 
    stroke(255,255,0);
    circle(i,400-b,2);//(x,y,the size of the circle )
    i=i+1;
    
   // stroke(0,255,0);
   // circle(i,400-c,2);
   // i=i+1;
    
   // stroke(255,0,255);
   // circle(i,400-d,2);
    //i=i+1;
  }
  void grid()
{
    stroke(0,255,0);
  line(50,0,50,500);
  line(100, 0, 100, 500);
  line(150, 0, 150, 500);
  line(200, 0, 200, 500);
  line(250, 0, 250, 500);
  line(300, 0, 300, 500);
  line(350, 0, 350, 500);
  line(400, 0, 400, 500);
  line(450, 0, 450, 500);
  line(500, 0, 500, 500);
  
  ///////////////////////
  
  

  line(0,50,500,50);
  line(0, 100, 500, 100);
  line(0, 150, 500, 150);
  text("5V",10,150);// 5v
  line(0, 200, 500, 200);
  text("4V",10,200);//4v
  line(0, 250, 500, 250);
  text("3V",10,250);//3v
  line(0, 300, 500, 300);
  text("2V",10,300);//2v
  line(0, 350, 500, 350);
  text("1V",10,350);//1v
  line(0, 400, 500, 400);
  text("0V",10,400);// 0v
  line(0, 450, 500, 450);
  line(0, 500, 500, 500);
}
  

  void serialEvent(Serial myPort) {
    // read a byte from the serial port:
    int inByte = myPort.read();
    // if this is the first byte received, and it's an A, clear the serial
    // buffer and note that you've had first contact from the microcontroller.
    // Otherwise, add the incoming byte to the array:
    if (firstContact == false) {
      if (inByte == 'A') {
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      }
    }
    else {
      // Add the latest byte from the serial port to array:
      serialInArray[serialCount] = inByte;
      serialCount++;

      // If we have 3 bytes:
      if (serialCount > 1 ) // here we are using only 2 variable/channel
      {
        a = serialInArray[0];
        b = serialInArray[1];
       // c = serialInArray[2];
       // d = serialInArray[3];

        // print the values (for debugging purposes only):
        println(a + "\t" + b + "\t" + "c "+ "\t" + "d");

        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }
