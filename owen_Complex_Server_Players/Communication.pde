void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    
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
      analyzePlayers(playerText);
    }
        
    sendPlayers();
  }
}

void analyzePlayers(String text) {
  int start = -1;
  
  while (text.indexOf(addressID,start) > -1) {
    int end = text.indexOf(addressID,start) + 1;
    String player;
    
    if (text.indexOf(addressID,end) < 0) {
      player = text.substring(text.indexOf(addressID,start));
    }
    else {
      player = text.substring(text.indexOf(addressID,start),text.indexOf(addressID,end));
    }
    
    if (player.length() > 0) {
      String address = extractString(player,addressID,endID);
      int listed = -1;
      for (int i=0; i<players.size(); i++) {
        if (listed == -1) {
          String otherAddress = players.get(i).address;
          if (address.equals(otherAddress)) {
            listed = i;
          }
        }
      }
      
      if (listed > -1) {
        int[] location = int(split(extractString(player,locationID,endID),','));
        if (location.length == 3) {
          players.get(listed).location = location;
        }
      }
      else {
        String name = extractString(player,nameID,endID);
        int[] location = int(split(extractString(player,locationID,endID),','));
        if (name.length() > 0 && location.length == 3) {
          players.add(new Player(address, name, location));
        }
      }
    }
    
    if (player.length() > 0) {
      start = text.indexOf(addressID,start) + player.length();
    }
    else {
      start = text.length() - 1;
    }
  }
}

void sendPlayers() {
  String broadcast = playerHD;
  
  for (int i=0; i<players.size(); i++) {
    Player player = players.get(i);
    
    broadcast += nameID + player.name + endID;
    broadcast += locationID + str(player.location[0]) + ',' + str(player.location[1]) + ',' + str(player.location[2]) + endID;
    broadcast += timeID + longToString(clock) + endID;
  }
  
  broadcast += endHD;
  broadcast(broadcast);
}

void broadcast(String text) {
  if (text.length() > 0) {
    client.write(text);
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