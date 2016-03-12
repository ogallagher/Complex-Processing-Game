void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    //println("Incoming: " + text);
    
    String messageText = extractString(text, messageHD, endHD);
    String blockText = extractString(text, blockHD, endHD);
    String playerText = extractString(text, playerHD, endHD);
    String enemyText = extractString(text, enemyHD, endHD);
    String projectileText = extractString(text, projectileHD, endHD);
    
    readMessages(messageText);
    if (environmentStage < 1) {
      readBlocks(blockText);
    }
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
    //println("MESSAGE: " + message);
    
    start = text.indexOf(nameID,start) + message.length() + 2;
  }
}

void readBlocks(String text) {
  int start = -1;
  
  if (text.indexOf(descriptionID) > -1 && text.indexOf(endID,text.indexOf(descriptionID)) > -1) {
    if (environmentStage < 0) {
      int[] complex = int(split(extractString(text,descriptionID,endID),','));
      blockWidth = complex[0];
      cubicleWidth = complex[1];
      complexWidth = complex[2];
      blockMax = complex[3];
      environmentStage = 0;
      
      println("BLOCK.MAX: " + blockMax);
    }
    
    start = text.indexOf(endID,text.indexOf(descriptionID)) + 1;
  }
  
  while (text.indexOf(nameID,start) > -1) {
    int end = text.indexOf(nameID,start) + 1;
    String block;
    
    if (text.indexOf(nameID,end) < 0) {
      block = text.substring(text.indexOf(nameID,start));
    }
    else {
      block = text.substring(text.indexOf(nameID,start),text.indexOf(nameID,end));
    }
    
    println("BLOCK.DATA: " + block);
    
    int id = int(extractString(block,nameID,endID));
    println("SIZE,ID: " + blocks.size() + ',' + id);
    if (id == blocks.size()) {
      int[] location = int(split(extractString(block,locationID,endID),','));
      int[] dimensions = int(split(extractString(block,dimensionsID,endID),','));
      
      blocks.add(new Block(new PVector(location[0]*blockWidth,location[1]*blockWidth,location[2]*blockWidth), new PVector(dimensions[0]*blockWidth,dimensions[1]*blockWidth,dimensions[2]*blockWidth))); 
    }
    
    start = text.indexOf(nameID,start) + block.length();
  }
  println("BLOCK.#: " + blocks.size());
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
  if (environmentStage < 0) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + "-1" + endID + endHD);
  }
  else if (blocks.size() < blockMax) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + blocks.size() + endID + endHD);
  }
  else {
    environmentStage = 1;
  }
}

void broadcast(String text) {
  if (text.length() > 0) {
    client.write(addressID + myAddress + endID + text);
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