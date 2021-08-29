//aki asgeirsson, jan 2016
// updated august 2021

/*
 todo:
 catch exception?
 ip dialouge only numbers and dot
 orange screen 
 full screen always
 video expand to screen size
 add play controls (server side), rewind, pause etc
 add instructions on screen
 add info on screen
 */


import processing.net.*;
Client c;
String ipNumber = "";
Boolean connectDialog = false;
Boolean running = false;
Boolean connected = false;

import processing.video.*;
Movie m;

void setup() 
{
  size(1024, 768);
  frameRate(20); 
  fill(255);

  noLoop();
  selectInput("Select a video file:", "fileSelected");
  //m = new Movie(this, "launch2.mp4");
}



void draw() 
{
  if (!running) {
    background(111, 55, 11);
  } else {
    background(0);
    image(m, 0, 0, width, height);

    //if (!connected)
    //{
    //  // println("Not connected to server");
    //  // println("Start the server");
    //  //clientConnected = false;
    //  background(111, 55, 1);
    //} 


    if (connectDialog) {
      background(111);
      textSize(16);
      text("write ip number of server computer: (then press ENTER)", 22, 44);
      text(ipNumber, 22, 66);
    }
  }
}

void keyPressed() {

  loop();

  //connect to server
  if (key=='c') {
    connectDialog = true;
  }

  if (connectDialog) {
    if (keyCode == ENTER) {
      c = new Client(this, ipNumber, 10002);
      //c.write("connect");
      println("connecting....");
      delay(1111);
      if (c.active()) {
        connected = true;
        println("connected!!!!!") ;
        connectDialog=false;
      }
    }

    if (keyCode == BACKSPACE) {
      if (ipNumber.length() > 0) {
        ipNumber = ipNumber.substring(0, ipNumber.length()-1);
      }
    } else {
      ipNumber = ipNumber + key;
    }
  }



  //start playback
  if (key==' ') {
    m.jump(0);
    m.play();
  }
}






void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    m = new Movie(this, selection.getAbsolutePath());
    running=true;
    //loop();
  }
}

void movieEvent(Movie m) {
  m.read();
}


void clientEvent(Client someClient) {
  print("Server Says:  ");
  String s = c.readString();
  println(s);
  if (s.equals("play")) {
    m.jump(0);
    m.play();
  }
  if (s.equals("stop")) {
    m.stop();
  }
  if (s.equals("test")) {
    println("testing...");
  }
}
