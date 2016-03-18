void listen() {
  if (client.available() > 0) {
    String text = extractString(client.readString(),projectileHD,endHD);
    
    if (text.length() > 0) {
      analyzeProjectiles(text);
    }
  }
}

void analyzeProjectiles(String text) {
  int start = -1;
  
  while (text.indexOf(nameID,start) > -1) {
    int end = text.indexOf(nameID,start) + 1;
    String projectile;
    
    if (text.indexOf(nameID,end) < 0) {
      projectile = text.substring(text.indexOf(nameID,start));
    }
    else {
      projectile = text.substring(text.indexOf(nameID,start),text.indexOf(nameID,end));
    }
    
    String name = extractString(projectile,nameID,endID);
    String description = extractString(projectile,descriptionID,endID);
    
    int listed = -1;
    for (int i=0; i<projectiles.size() && listed == -1; i++) {
      if (projectiles.get(i).name.equals(name)) {
        listed = i;
      }
    }
    
    if (listed > -1) {
      if (description.equals("X")) {
        projectiles.remove(listed);
      }
    }
    else {
      if (description.equals("X")) {
        broadcast(projectileHD + nameID + name + endID + descriptionID + "X" + endID + timeID + str(clock) + endID + endHD);
      }
      else {
        int[] location = int(split(extractString(projectile,locationID,endID),','));
        int[] velocity = int(split(extractString(projectile,velocityID,endID),','));
        
        projectiles.add(new Projectile(location,velocity,name,description));
      }
    }
  }
}

void sendProjectiles() {
  String broadcast = projectileHD;
  
  for (int i=0; i<projectiles.size(); i++) {
    Projectile projectile = projectiles.get(i);
    broadcast += nameID + projectile.name + endID + descriptionID + projectile.description + endID + locationID + projectile.location + endID + timeID + str(clock) + endID;
  }
  
  broadcast += endHD;
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