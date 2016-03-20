void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    
    if (environmentStage == 1) {
      String projectileText = extractString(text,projectileHD,endHD);
      if (projectileText.length() > 0) {
        analyzeProjectiles(projectileText);
      }
    }
    else {
      String blockText = extractString(text,blockHD,endHD);
      if (blockText.length() > 0) {
        fillComplex(blockText);
      }
    }
  }
}

void fillComplex(String text) {
  int start = -1;
  
  if (environmentStage < 0 && text.indexOf(descriptionID) > -1 && text.indexOf(endID,text.indexOf(descriptionID)) > -1) {
    int[] complex = int(split(extractString(text,descriptionID,endID),','));
    blockWidth = complex[0];
    cubicleWidth = complex[1];
    complexWidth = complex[2];
    blockMax = complex[3];
    environmentStage = 0;
        
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
        
    if (block.length() > 0) {
      int id = int(extractString(block,nameID,endID));
      if (id == blocks.size()) {
        int[] location = int(split(extractString(block,locationID,endID),','));
        int[] dimensions = int(split(extractString(block,dimensionsID,endID),','));
        
        if (location.length == 3 && dimensions.length == 3) {
          blocks.add(new Block(new PVector(location[0]*blockWidth,location[1]*blockWidth,location[2]*blockWidth), new PVector(dimensions[0]*blockWidth,dimensions[1]*blockWidth,dimensions[2]*blockWidth))); 
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

void requestData() {
  if (environmentStage < 0) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + "-1" + endID + endHD);
  }
  else if (blocks.size() < blockMax) {
    broadcast(requestHD + nameID + "ENV" + endID + locationID + blocks.size() + endID + endHD);
    println("ENVIRONMENT FILLING... (" + blocks.size() + '/' + blockMax + ')');
  }
  else {
    environmentStage = 1;
    println("READY");
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
        broadcast(projectileHD + nameID + name + endID + descriptionID + "X" + endID + timeID + str(clock) + endID + endHD);
      }
    }
    else {
      if (description.equals("X")) {
        broadcast(projectileHD + nameID + name + endID + descriptionID + "X" + endID + timeID + str(clock) + endID + endHD);
      }
      else {
        int[] location = int(split(extractString(projectile,locationID,endID),','));
        int[] velocity = int(split(extractString(projectile,velocityID,endID),','));
        
        projectiles.add(new Projectile(location,velocity,name,int(description)));
      }
    }
  }
}

void sendProjectiles() {
  String broadcast = projectileHD;
  
  for (int i=0; i<projectiles.size(); i++) {
    Projectile projectile = projectiles.get(i);
    broadcast += nameID + projectile.name + endID + descriptionID + projectile.description + endID + locationID + projectile.locations[3] + ',' + projectile.locations[4] + ',' + projectile.locations[5] + endID + timeID + str(clock) + endID;
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