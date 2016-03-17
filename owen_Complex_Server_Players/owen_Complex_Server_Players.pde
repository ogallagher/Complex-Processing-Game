//owen_Complex_Server_Players
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

ArrayList<Player> players = new ArrayList<Player>();

Client client;

void setup() {
  size(200,200,P2D);
  
  client = new Client(this, serverAddress, port);
}

void draw() {
  listen();
  tick();
  println("PLAYERS.#: " + players.size());
}