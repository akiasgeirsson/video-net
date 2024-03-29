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
String filePath = "";
String fileInfo = "";

import processing.video.*;
Movie m;

void setup() 
{
  // size(1024, 768);
  fullScreen();
  frameRate(20); 
  fill(255);
  
  imageMode(CENTER);

  noLoop();
  selectInput("Select a video file:", "fileSelected");
  //m = new Movie(this, "launch2.mp4");
}



void draw() 
{
  if (!running) {
    background(111, 55, 11);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("select video file", width/2, height*0.33);
    textSize(18);
    text(filePath, width/2, height*0.66);
    text(fileInfo, width/2, height*0.72);
  } else {
    background(0);
    image(m, width/2, height/2);

    //if (!connected)
    //{
    //  // println("Not connected to server");
    //  // println("Start the server");
    //  //clientConnected = false;
    //  background(111, 55, 1);
    //} 


    if (connectDialog) {
      background(111);
      textSize(24);
      text("write ip number of server computer: (then press ENTER)", width/2, height*0.33);
      text(ipNumber, width/2, height*0.5);
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
    } else if(key != 'c') {
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
    loop();
    delay(111);
    filePath = selection.getAbsolutePath();
    fileInfo = m.width + "x" + m.height + " pixels  " + m.duration() + " seconds";
    delay(2222);
    running=true;
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
