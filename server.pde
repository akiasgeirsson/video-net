

import processing.net.*;

int port = 10002;
boolean myServerRunning = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;

Server myServer;

void setup()
{
  size(300, 300);
  textFont(createFont("SanSerif", 16));
  myServer = new Server(this, port); 
  background(0);
  textSize(14);
}

void draw()
{
  Client thisClient = myServer.available();
  if (thisClient != null) {
    if (thisClient.available() > 0) {
      text("mesage from: " + thisClient.ip() + " : " + thisClient.readString(), 15, textLine);
      textLine = textLine + 22;
      if (textLine > height-35) {
        textLine = 35;
        background(0);
      }
      
    }
  }
  
  text("press mouse here to play video on client", 10, height/2);
} 

void mousePressed() {
 myServer.write("play");
}
