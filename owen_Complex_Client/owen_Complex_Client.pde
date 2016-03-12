//owen_Complex_Client

import processing.net.*;
import java.awt.*;

ArrayList<Cubicle> cubicles = new ArrayList<Cubicle>();
int complexWidth = 5;   //  cubicles (5)
int cubicleWidth = 10;  //  blocks
int blockWidth = 200;    //  pixels

PGraphics en;

Client client;
Camera camera;
Robot override;

void setup() {
  size(800,800,P2D);
  
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
  
}