//aki asgeirsson, jan 2016
// updated august 2021
// todo:
//   verify ip connection, etc
//   catch exeption something
//   fix the "new Movie(this," scenario
//   add play controls (server side), rewind, pause etc
//   adjust screen size to video (is it possible?)
// fit to screen

import processing.net.*;
Client c;
String ipNumber = "";
Boolean running = false;

import processing.video.*;
Movie movie, testMovie, selectedMovie;

void setup() 
{
  size(1024, 768);
  //frameRate(20); 
  fill(255);
  testMovie = new Movie(this, "launch2.mp4");
  movie = testMovie;
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    selectedMovie = new Movie(this, selection.getAbsolutePath());
  }
}

void movieEvent(Movie m) {
  m.read();
}

void draw() 
{
  background(111);
  if (!running) {
    background(111);
    textSize(16);
    text("write ip number of server computer: (then press ENTER)", 22, 44);
    text(ipNumber, 22, 66);
  } else {
  background(0);
    image(movie, 0, 0, width, height);
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



void clientEvent(Client someClient) {
  print("Server Says:  ");
  String s = c.readString();
  println(s);
  if (s.equals("play")) {
     movie = selectedMovie;
    movie.jump(0);
    movie.play();
  }
  if (s.equals("stop")) {
    movie.stop();
  }
  if (s.equals("test")) {
    movie = testMovie;
    movie.jump(0);
    movie.play();
  }
}
