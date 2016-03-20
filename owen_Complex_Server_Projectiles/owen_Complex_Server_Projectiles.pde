//owen_Complex_Server_Projectiles
import processing.net.*;

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
String descriptionID = "|";
String timeID = "+";
String endID = "?";

//Coordinated Universal Time (UTC)
long clock = 0;

ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
int speed = 1;
int[] projectileRadius = {50,50};  //bullet size for each type {pushBack,gravitySwitch}

int environmentStage = -1;
int complexWidth = 5;    //cubicles
int cubicleWidth = 10;   //blocks
int blockWidth = 200;    //pixels
int blockMax = 0;        //When to stop asking for more blocks

Client client;

void setup() {
  size(200,200,P2D);
  
  client = new Client(this, serverAddress, port);
}

void draw() {
  /* Procedures
    > Client asks for a new projectiles w/ address?,name,location,velocity
    > Client asks to delete projectiles (they collisions w/ themselves) so the server doesn't have to
    > Server creates new projectiles
    > Server deletes projectiles
    > Server moves projectiles
    > Server checks for block collisions
    > Server sends all projectile information
  */
  
  listen();
  
  if (environmentStage == 1) {
    moveProjectiles();
    collideProjectiles();
    sendProjectiles();
  }
  else {
    requestData();
  }
  
  tick();
}