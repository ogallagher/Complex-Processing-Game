//owen_Complex_Client

import processing.net.*;
import processing.sound.*;
import java.awt.*;

String serverAddress = "74.71.101.15";
int port = 55555;
String myAddress = "";

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

ArrayList<Block> blocks = new ArrayList<Block>();  // #|200,10,5,100?!  => blockWidth, cubicleWidth, complexWidth, blockMax
int complexWidth = 5;    //cubicles
int cubicleWidth = 10;   //blocks
int blockWidth = 200;    //pixels
int blockMax = 0;        //How to know when to stop asking for more blocks

PGraphics en;

Client client;
Camera camera;
Robot override;
SoundFile[] sounds;

int environmentStage = -1;

void setup() {
  size(800,800,P2D);
  
  client = new Client(this, serverAddress, port);
  for (int i=0; i<5; i++) {
    myAddress += str(int(random(0,9)));
  }
  
  try {
    override = new Robot();
  }
  catch (AWTException e) {
    println("Your OS doesn't allow the program to control the mouse for aiming...");
  }
  
  noCursor();
  camera = new Camera();
  override.mouseMove(int(displayWidth/2),int(displayHeight/2));
  
  sounds = new SoundFile[0];
}

void draw() {
  //TASKS:
  //  Handle pre-connection action (sign-in, entry request)
  //  Receive and interpret data
  //  Update lists of blocks, players, enemies, projectiles, announcements
  //  Draw environment, players, enemies, projectiles, announcements
  //  Control player movement, reorientation, gravity, collision
  //  Shoot projectiles
  //  Die
  //  Send new data
  //  Request new data
  listen();
  sendData();
  requestData();
}