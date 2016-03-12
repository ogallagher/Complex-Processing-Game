// owen_Complex_Server_Envorinment

import processing.net.*;
import java.awt.*;

String serverAddress = "74.71.101.15";
int port = 55555;

//Headers
String messageHD = "&";
String requestHD = "$";
String blockHD = "#";
String playerHD = "@";
String enemyHD = "*";
String projectileHD = "^";
String endHD = "!";

//Identifiers
String addressID = "≤";
String nameID = "{";
String locationID = "(";
String velocityID = "<";
String dimensionsID = "[";
String colorID = "/";
String descriptionID = "|";
String endID = "?";

StringList environment = new StringList();
ArrayList<Cubicle> cubicles = new ArrayList<Cubicle>();
int complexWidth = 5;   //  cubicles (5)
int cubicleWidth = 10;  //  blocks
int blockWidth = 200;    //  pixels

PGraphics en;

Client client;
Camera camera;
Robot override;

float time = 0;

void setup() {
  size(800,800,P2D);
  
  client = new Client(this, serverAddress, port);
  
  loadEnvironment();
  compressEnvironment();
  recordEnvironment();
  en = createGraphics(800,800,P3D);
  
  try {
    override = new Robot();
  }
  catch (AWTException e) {
    println("Your OS doesn't allow the program to control the mouse for aiming...");
  }
  
  noCursor();
  camera = new Camera();
  override.mouseMove(int(displayWidth/2),int(displayHeight/2));
}

void draw() {
  /*background(0);
  en.beginDraw();
  en.background(0);
  
  camera.orient();
  camera.look();
  
  for (int i=0; i<cubicles.size(); i++) {
    PVector distance = new PVector();
    distance.set(cubicles.get(i).location);
    distance.sub(camera.location);
    
    if (distance.mag() < blockWidth*20) {
      cubicles.get(i).display();             //This also calls all block functions, including:   block.display()  block.detectCollision()
    }
  }
  
  en.pushMatrix();
  en.fill(0,255,255);
  en.noStroke();
  en.strokeWeight(1.5);
  en.translate(width/2,height/2,0);
  en.rotateY(time * PI);
  en.rotateX(time * PI * 0.15);
  en.box(blockWidth);
  en.popMatrix();
  en.endDraw();
  
  image(en,0,0);
  
  camera.control();
  camera.fall();
  camera.move();
  camera.drawSights();
  camera.touchingWall.clear();
  time += 0.01;*/
  
  listen();
}