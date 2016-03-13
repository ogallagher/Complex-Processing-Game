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
String lampID = ":";
String descriptionID = "|";
String endID = "?";

StringList environment = new StringList();
ArrayList<Cubicle> cubicles = new ArrayList<Cubicle>();
int complexWidth = 5;   //  cubicles (5 X 5 X 5)
int cubicleWidth = 10;  //  blocks
int blockWidth = 200;    //  pixels

Client client;

float time = 0;

void setup() {
  size(200,200,P2D);
  
  client = new Client(this, serverAddress, port);
  
  loadEnvironment();
  compressEnvironment();
  recordEnvironment();
  
}

void draw() {
  listen();
}