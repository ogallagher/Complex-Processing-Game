//owen_Complex_Server

import processing.net.*;

Server server;
int serverPort = 55555;

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

void setup() {
  size(600,300);
  server = new Server(this,serverPort);
}

void draw() {
  //TASKS:
  //  Receive incoming messages from clients and specialized servers
  //  Distribute messages to everyone
  //  Admit new players
  //  Manage games (end games, start new ones, declare winners, send announcements)
  
  echo();
  tick();
}