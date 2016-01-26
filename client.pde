//aki asgeirsson, jan 2016
//todo: 
//   verify ip connection, etc
//   catch exeption something
//   fix the "new Movie(this," scenario
//   add play controls (server side), rewind, pause etc
//   adjust screen size to video (is it possible?)


import processing.net.*;
Client c;
String ipNumber = "";
Boolean running = false;

import processing.video.*;
Movie mov1, mov2, selectedMovie;

void setup() 
{
  size(800, 600);
  //frameRate(20); 
  fill(255);
  mov1 = new Movie(this, "transit.mov");
  selectedMovie = mov1;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    mov2 = new Movie(this, selection.getAbsolutePath());
    selectedMovie = mov2;
    selectedMovie.jump(0);
    selectedMovie.play();
    selectedMovie.pause();
  }
}

void movieEvent(Movie m) {
  m.read();
}

void draw() 
{
  background(0);
  if (!running) {
    textSize(16);
    text("write ip number of server computer:", 22, 44);
    text(ipNumber, 22, 66);
  } else {
    if (c.available() > 0) {
      String textFromServer= c.readString();
      print(textFromServer);
      if (textFromServer.equals("play")) {
        selectedMovie.jump(0);
        selectedMovie.play();
        print("spila");
      }
    }
    image(selectedMovie, 0, 0);
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    c = new Client(this, ipNumber, 10002);
    c.write("connect");
    //background(222);
    selectInput("Select a video file:", "fileSelected"); 
    running = true;
  }
  if (keyCode == BACKSPACE) {
    if (ipNumber.length() > 0) {
      ipNumber = ipNumber.substring(0, ipNumber.length()-1);
    }
  } else {
    ipNumber = ipNumber + key;
  }
}
