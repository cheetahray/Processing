import processing.serial.*;

Serial arduinoPort;
Serial myPort;
int val;
Timer timer;
int flag = 1;
int sec = 5;

void setup()
{
  println( Serial.list());
  ///*
  String rs232PortName = Serial.list()[0];
  String arduinoPortName = Serial.list()[1];
  myPort = new Serial(this, rs232PortName, 38400);
  arduinoPort = new Serial(this, arduinoPortName, 9600);
  //*/
}

void draw()
{
  if ( arduinoPort.available() > 0) {  // If data is available,
    val = arduinoPort.read();         // read it and store it in val
    print(val + ";");
    if ('A' == val) {
      mode2();
      timer = new Timer(sec * 1000);
      timer.start();
      //println("1");
    }else if ('B' == val) println("2");
  }
  //  char D1 = arduinoPort.read();
  // println(D1);



  //  if(arduinoPort.read()=='A') print("MODE1");
  //if(arduinoPort.read()=='B') print("MODE2");
  //println(byte(0x4C));
  // mode1();
   if (flag == 2 && timer.isFinished()) {
      mode1();
  }
}

void mode1()
{
  flag = 1;
  println(111);
  //4C 45 44 53 0D 10 01 14 14 00 14 14 00 14 14 96 00 8A 77 88
  myPort.write(byte(0x4C));
  myPort.write(byte(0x45));
  myPort.write(byte(0x44));
  myPort.write(byte(0x53));

  myPort.write(byte(0x0D));
  myPort.write(byte(0x10));
  myPort.write(byte(0x01));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x00));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x00));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x96));
  myPort.write(byte(0x00));
  myPort.write(byte(0x8A));

  myPort.write(byte(0x77));
  myPort.write(byte(0x88));
  
  
}

void mode2()
{
  flag = 2;
  println(222);
  //4C 45 44 53 0D 10 03 14 14 00 14 14 00 14 14 98 00 86 77 88
  myPort.write(byte(0x4C));
  myPort.write(byte(0x45));
  myPort.write(byte(0x44));
  myPort.write(byte(0x53));

  myPort.write(byte(0x0D));
  myPort.write(byte(0x10));
  myPort.write(byte(0x03));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x00));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x00));

  myPort.write(byte(0x14));
  myPort.write(byte(0x14));
  myPort.write(byte(0x98));
  myPort.write(byte(0x00));
  myPort.write(byte(0x86));

  myPort.write(byte(0x77));
  myPort.write(byte(0x88));
}

