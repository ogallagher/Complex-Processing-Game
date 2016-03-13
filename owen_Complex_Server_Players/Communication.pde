void listen() {
  if (client.available() > 0) {
    String text = client.readString();  
    String playerText = extractString(text,playerHD,endHD);
    
    analyzePlayers(playerText);
    
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
      int[] c = int(split(extractString(player,colorID,endID),','));
      
      players.get(listed).location = location;
      players.get(listed).c = c;
    }
    else {
      String name = extractString(player,nameID,endID);
      int[] location = int(split(extractString(player,locationID,endID),','));
      int[] c = int(split(extractString(player,colorID,endID),','));
      
      players.add(new Player(address, name, location, c));
    }
    
    start = text.indexOf(addressID,start) + player.length();
  }
}

void sendPlayers() {
  String broadcast = playerHD;
  
  for (int i=0; i<players.size(); i++) {
    Player player = players.get(i);
    
    broadcast += nameID + player.name + endID;
    broadcast += locationID + str(player.location[0]) + ',' + str(player.location[1]) + ',' + str(player.location[2]) + endID;
    broadcast += colorID + str(player.c[0]) + ',' + str(player.c[1]) + ',' + str(player.c[2]) + endID;
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