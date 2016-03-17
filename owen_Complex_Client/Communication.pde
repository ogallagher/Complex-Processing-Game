void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    println(text);
    
    String messageText = "";
    if (text.indexOf(messageHD) > -1) {
      if (text.indexOf(endHD, text.indexOf(messageHD)) > -1) {
        messageText = extractString(text, messageHD, endHD);
      }
      else {
        messageText = text.substring(text.indexOf(messageHD) + 1);
      }
    }
    if (messageText.length() > 0) {
      readMessages(messageText);
    }
    
    String playerText = "";
    if (text.indexOf(playerHD) > -1) {
      if (text.indexOf(endHD, text.indexOf(playerHD)) > -1) {
        playerText = extractString(text, playerHD, endHD);
      }
      else {
        playerText = text.substring(text.indexOf(playerHD) + 1);
      }
    }
    if (playerText.length() > 0) {
      readPlayers(playerText);
    }
    
    String enemyText = "";
    if (text.indexOf(enemyHD) > -1) {
      if (text.indexOf(endHD, text.indexOf(enemyHD)) > -1) {
        enemyText = extractString(text, enemyHD, endHD);
      }
      else {
        enemyText = text.substring(text.indexOf(enemyHD) + 1);
      }
    }
    if (enemyText.length() > 0) {
      readEnemies(enemyText);
    }
    
    String projectileText = "";
    if (text.indexOf(projectileHD) > -1) {
      if (text.indexOf(endHD, text.indexOf(projectileHD)) > -1) {
        projectileText = extractString(text, projectileHD, endHD);
      }
      else {
        projectileText = text.substring(text.indexOf(projectileHD) + 1);
      }
    }
    if (projectileText.length() > 0) {
      readProjectiles(projectileText);
    }
    
    if (environmentStage < 1) {
      String blockText = "";
      if (text.indexOf(blockHD) > -1) {
        if (text.indexOf(endHD, text.indexOf(blockHD)) > -1) {
          blockText = extractString(text, blockHD, endHD);
        }
        else {
          blockText = text.substring(text.indexOf(blockHD) + 1);
        }
      }
      if (blockText.length() > 0) {
        readBlocks(blockText);
      }
    }
  }
}

void readMessages(String text) {
  int start = -1;
  
  while (text.indexOf(nameID,start) > -1) {
    String subtext = text.substring(text.indexOf(nameID,start));
    
    String message = extractString(subtext,nameID,endID);
    
    start = text.indexOf(nameID,start) + message.length() + 2;
  }
}

void readBlocks(String text) {
  int start = -1;
  
  if (environmentStage < 0 && text.indexOf(descriptionID) > -1 && text.indexOf(endID,text.indexOf(descriptionID)) > -1) {
    int[] complex = int(split(extractString(text,descriptionID,endID),','));
    blockWidth = complex[0];
    cubicleWidth = complex[1];
    complexWidth = complex[2];
    blockMax = complex[3];
    environmentStage = 0;
    
    println("BLOCK.MAX: " + blockMax);
    
    start = text.indexOf(endID,text.indexOf(descriptionID)) + 1;
  }
  
  while (text.indexOf(nameID,start) > -1 && start < text.length()-1) {
    int end = text.indexOf(nameID,start) + 1;
    String block = "";
    
    if (text.indexOf(nameID,end) < 0) {
      if (text.indexOf(dimensionsID,start) > -1 && text.indexOf(endID,text.indexOf(dimensionsID,start)) > -1) {
        block = text.substring(text.indexOf(nameID,start));
      }
    }
    else {
      block = text.substring(text.indexOf(nameID,start),text.indexOf(nameID,end));
    }
    
    println("BLOCK.DATA: " + block);
    
    if (block.length() > 0) {
      int id = int(extractString(block,nameID,endID));
      if (id == blocks.size()) {
        int[] location = int(split(extractString(block,locationID,endID),','));
        int[] dimensions = int(split(extractString(block,dimensionsID,endID),','));
        int[] c = {200,200,200};
        
        if (location.length == 3 && dimensions.length == 3) {
          blocks.add(new Block(new PVector(location[0]*blockWidth,location[1]*blockWidth,location[2]*blockWidth), new PVector(dimensions[0]*blockWidth,dimensions[1]*blockWidth,dimensions[2]*blockWidth), c)); 
        }
      }
    }
    
    if (block.length() > 0) {
      start = text.indexOf(nameID,start) + block.length();
    }
    else {
      start = text.length() - 1;
    }
  }
}

void readPlayers(String text) {
  int start = -1;
  
  while (text.indexOf(nameID,start) > -1 && start < text.length()-1) {
    int end = text.indexOf(nameID,start) + 1;
    String player = "";
    
    if (text.indexOf(nameID,end) < 0) {
      if (text.indexOf(locationID,start) > -1 && text.indexOf(endID,text.indexOf(locationID,start)) > -1) {
        player = text.substring(text.indexOf(nameID,start));
      }
    }
    else {
      player = text.substring(text.indexOf(nameID,start),text.indexOf(nameID,end));
    }
    
    if (player.length() > 0) {
      String name = extractString(player,nameID,endID);
      String timeStamp = extractString(player,timeID,endID);
      
      if (timeStamp.length() > 0) {
        int listed = -1;
        if (!name.equals(myName)) {
          for (int i=0; i<players.size(); i++) {
            if (listed == -1) {
              String otherName = players.get(i).name;
              
              if (name.equals(otherName)) {
                listed = i;
              }
            }
          }
          
          if (listed > -1 && toLong(timeStamp) > players.get(listed).lastUpdate) {
            int[] location = int(split(extractString(player,locationID,endID),','));
            
            players.get(listed).updateFuture(location,toLong(timeStamp));
          }
          else {
            int[] location = int(split(extractString(player,locationID,endID),','));
            int[] c = {int(random(0,255)),int(random(100,255)),int(random(100,255))};
            
            players.add(new Player(name, location, c));
          }
        }
        else if (selfStage < 0) {
          selfStage = 0;
        }
      }
    }
    
    if (player.length() > 0) {
      start = text.indexOf(nameID,start) + player.length();
    }
    else {
      start = text.length() - 1;
    }
  }
}

void readEnemies(String text) {
  
}

void readProjectiles(String text) {
  
}

void sendData() {
  String broadcast = playerHD + 
                       addressID + 
                         myAddress + 
                       endID + 
                       nameID + 
                         myName + 
                       endID + 
                       locationID + 
                         str(round(camera.location.x)) + ',' + 
                         str(round(camera.location.y)) + ',' + 
                         str(round(camera.location.z)) + 
                       endID + 
                     endHD;
  
  broadcast(broadcast);
}

void requestData() {
  if (environmentStage < 0) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + "-1" + endID + endHD);
    println("REQUESTING");
  }
  else if (blocks.size() < blockMax) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + blocks.size() + endID + endHD);
    println("REQUESTING");
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