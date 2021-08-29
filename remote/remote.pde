// server
//


import processing.net.*;

int port =  10002;
boolean myServerRunning = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;

boolean pressed = false;
int pressedTime = 0;
int pressedSquare;

Server myServer;

void setup()
{
  size(300, 300);
  frameRate(30);
  myServer = new Server(this, port); 
  println(myServer.ip());
  background(0);
  textSize(24);
  textAlign(CENTER,CENTER);
}

void draw()
{
  if (pressed) {
    fill(0, 111, 77);
    if (pressedSquare==1) rect(0, 0, width/2, height/2);
    if (pressedSquare==2) rect(width/2, 0, width/2, height/2);
    if (pressedSquare==3) rect(0, height/2, width/2, height/2);
    if (pressedSquare==4) rect(width/2, height/2, width/2, height/2);
  } else {
    background(77);
  }
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  fill(0);
  text("play", width/4, height/4);
  text("stop", width/4*3, height/4);
  text("bang", width/4, height/4*3);
  text("test", width/4*3, height/4*3);

  if (pressedTime<0) {
    pressed = false;
  } else {
    pressedTime--;
  }
  textSize(12);
  text("this computer ip address is: " + myServer.ip(), width/2,height/2);
} 

void mousePressed() {
  pressed = true;
  pressedTime = 3;
  if(mouseX<width/2 && mouseY<height/2) {
    pressedSquare = 1;
      myServer.write("play");
  }
  if(mouseX>width/2 && mouseY<height/2) {
    pressedSquare = 2;
      myServer.write("stop");
  }
  if(mouseX<width/2 && mouseY>height/2) {
    pressedSquare = 3;
      myServer.write("bang");
  }
  if(mouseX>width/2 && mouseY>height/2) {
    pressedSquare = 4;
      myServer.write("test");
  }

  background(66);
}
