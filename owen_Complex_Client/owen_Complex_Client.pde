//owen_Complex_Client

import processing.net.*;
import processing.sound.*;
import java.awt.*;

String serverAddress = "74.71.101.15";
int port = 55555;
String myAddress = "";
String myName = "";

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
String descriptionID = "|";
String timeID = "+";
String endID = "?";

//Coordinated Universal Time (UTC)
long clock = 0;

ArrayList<Block> blocks = new ArrayList<Block>();  // #|200,10,5,100?!  => blockWidth, cubicleWidth, complexWidth, blockMax
int complexWidth = 5;    //cubicles
int cubicleWidth = 10;   //blocks
int blockWidth = 200;    //pixels
int blockMax = 0;        //When to stop asking for more blocks

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

PGraphics en;

Client client;
Camera camera;
Robot override;
SoundFile[] sounds;

int environmentStage = -1;
int selfStage = -1;

void setup() {
  size(800,800,P2D);
  en = createGraphics(800,800,P3D);
  
  client = new Client(this, serverAddress, port);
  for (int i=0; i<5; i++) {
    myAddress += str(int(random(0,9)));
  }
  myName = myAddress;
  
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
  //  Handle UI pre-connection (sign-in, entry request)
  //  Receive and interpret data
  //  Update lists of blocks, players, enemies, projectiles, announcements
  //  Control player movement, reorientation, gravity, collision
  //  Draw environment, players, enemies, projectiles, announcements
  //  Shoot projectiles (and continue to send those that haven't been validated)
  //  Die (to check if shot, just keep previoud and current projectile locations, then draw lines between them and see if lines pass through camera block)
  //  Send new data
  //  Request new data
  
  if (environmentStage != 0) {
    background(0);
  }
  
  listen();
  println("PLAYERS.#: " + players.size());
  
  if (environmentStage > -1) {
    camera.orient();
    camera.look();
    
    movePlayers();
    
    en.beginDraw();
    en.background(0);
    
    camera.drawLamp();
    
    displayComplexAndCollision();
    displayGoal();
    displayPlayersAndCollision();
    
    en.endDraw();
    image(en,0,0);
    
    if (environmentStage == 1) {
      camera.control();
      camera.fall();
      camera.move();
      camera.drawSights();
      camera.touchingWall.clear();
    }
    else {
      pushMatrix();
      fill(0,230,80,30);
      noStroke();
      rect(10, (height/2)-100, float(blocks.size()) / float(blockMax) * float(width-20), 200);
      popMatrix();
    }
  }
  
  sendData();
  requestData();
  tick();
}