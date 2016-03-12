void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    println("Incoming: " + text);
    
    String messageText = extractString(text, messageHD, endHD);
    String blockText = extractString(text, blockHD, endHD);
    String playerText = extractString(text, playerHD, endHD);
    String enemyText = extractString(text, enemyHD, endHD);
    String projectileText = extractString(text, projectileHD, endHD);
    
    readMessages(messageText);
    readBlocks(blockText);
    readPlayers(playerText);
    readEnemies(enemyText);
    readProjectiles(projectileText);
  }
}

void readMessages(String text) {
  int start = -1;
  
  while (text.indexOf(nameID,start) > -1) {
    String subtext = text.substring(text.indexOf(nameID,start));
    
    String message = extractString(subtext,nameID,endID);
    println("MESSAGE: " + message);
    
    start = text.indexOf(nameID,start) + message.length() + 2;
  }
}

void readBlocks(String text) {
  
}

void readPlayers(String text) {
  
}

void readEnemies(String text) {
  
}

void readProjectiles(String text) {
  
}

void sendData() {
  
}

void requestData() {
  
}

void broadcast(String text) {
  if (text.length() > 0) {
    client.write(nameID + myAddress + endID + text);
  }
}

String extractString(String text, String begin, String end) {
  String extracted = "";
  int i = text.indexOf(begin) + 1;

  if (i - 1 > -1) {
    int j = text.indexOf(end, i);                  //indexOf("",i) == first index of "" after index i.

    if (j > -1 && i > -1) {                        //just in case
      extracted = text.substring(i, j);
    }
  }

  return extracted;
}