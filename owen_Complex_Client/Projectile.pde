class Projectile {
  int[] locations = new int[6];  //previous location and current location (need both to see if projectile passes "through" the camera between frames
  int[] velocity = new int[3];
  String name;      //UTC when fired
  int description;  //ammo type {explosion(-1),pushBack(0),gravitySwitch(1)}
  long lastUpdate;
  boolean verified;
  
  Projectile(int[] loc, int[] vel, String nam, int des) {
    locations[0] = loc[0];
    locations[1] = loc[1];
    locations[2] = loc[2];
    locations[3] = loc[0];
    locations[4] = loc[1];
    locations[5] = loc[2];
    velocity[0] = vel[0];
    velocity[1] = vel[1];
    velocity[2] = vel[2];
    name = nam;
    description = des;
    lastUpdate = 1;
    verified = false;
  }
  
  void updateLocation(int[] newLoc) {
    locations[0] = locations[3];
    locations[1] = locations[4];
    locations[2] = locations[5];
    
    locations[3] = newLoc[0];
    locations[4] = newLoc[1];
    locations[5] = newLoc[2];
  }
  
  boolean collisionWithCamera() {
    int radius = projectileRadius[description];
    
    //..................................................................FINDING POSSIBLE PROJECTILE LOCATION
    PVector shot = new PVector(locations[3],locations[4],locations[5]);
    shot.sub(locations[0],locations[1],locations[2]);
    
    PVector terminal = new PVector(camera.location.x,camera.location.y,camera.location.z);
    terminal.sub(locations[0],locations[1],locations[2]);
    
    float angle = PVector.angleBetween(shot,terminal);
    PVector position = new PVector();
    if (!(angle < PI*0.5)) {
      position.set(locations[0],locations[1],locations[2]);
    }
    else {
     position.set(shot);
     position.normalize();
     position.mult(shot.mag()*cos(angle));
     position.add(locations[0],locations[1],locations[2]);
    }
    //..................................................................END
    
    //..................................................................CHECKING COLLISION
    boolean collision = false;
    
    if ((position.x + radius) > (camera.location.x - 0.5*camera.selfWidth) && (position.x - radius) < (camera.location.x + 0.5*camera.selfWidth)) {
      if ((position.y + radius) > (camera.location.y - 0.5*camera.selfWidth) && (position.y - radius) < (camera.location.y + 0.5*camera.selfWidth)) {
        if ((position.z + radius) > (camera.location.z - 0.5*camera.selfWidth) && (position.z - radius) < (camera.location.z + 0.5*camera.selfWidth)) {
          collision = true;
        }
      } 
    }
    //..................................................................END
    
    return collision;
  }
  
  void display() {
    en.pushMatrix();
    if (description > -1) {
      en.fill(50,255,5);
    }
    else {
      en.fill(255,0,50);
    }
    en.noStroke();
    en.sphereDetail(8);
    for (int i=0; i<projectiles.size(); i++) {
      en.translate(projectiles.get(i).locations[3],projectiles.get(i).locations[4],projectiles.get(i).locations[5]);
      en.sphere(20);
      en.translate(-1*projectiles.get(i).locations[3],-1*projectiles.get(i).locations[4],-1*projectiles.get(i).locations[5]);
    }
    en.popMatrix();
  }
  
  void sound() {
    int id = round(random(1,2));         //sound selection
    PVector aspects = new PVector(0,0);  //(amplitude, pan)
    PVector difference = new PVector(locations[0],locations[1],locations[2]);
    
    difference.sub(camera.location);
    
    float mag = difference.mag();
    mag = constrain(mag,1,blockWidth*cubicleWidth*1.5);
    mag = map(mag,blockWidth*cubicleWidth*1.5,1,0,0.5);
    aspects.x = mag;
    
    difference.normalize();
    PVector heading = new PVector();
    heading.set(camera.target);
    heading.sub(camera.location);
    heading.normalize();
    
    PVector initial = new PVector();
    PVector terminal = new PVector();
    
    if (camera.upDirection == 0 || camera.upDirection == 2) {
      initial.set(heading.x,heading.z);
      initial = PVector.fromAngle(initial.heading() - (PI*0.5));
      terminal.set(difference.x,difference.z);
      
      float angle = PVector.angleBetween(terminal,initial);
      
      aspects.y = cos(angle);
      if (camera.upDirection == 0) {
        aspects.y *= -1;
      }
    }
    else if (camera.upDirection == 1 || camera.upDirection == 3) {
      initial.set(heading.y,heading.z);
      initial = PVector.fromAngle(initial.heading() - (PI*0.5));
      terminal.set(difference.y,difference.z);
      
      float angle = PVector.angleBetween(terminal,initial);
      
      aspects.y = cos(angle);
      if (camera.upDirection == 3) {
        aspects.y *= -1;
      }
    }
    else if (camera.upDirection == 4 || camera.upDirection == 5) {
      initial.set(heading.x,heading.y);
      initial = PVector.fromAngle(initial.heading() - (PI*0.5));
      terminal.set(difference.x,difference.y);
      
      float angle = PVector.angleBetween(terminal,initial);
      
      aspects.y = cos(angle);
      if (camera.upDirection == 5) {
        aspects.y *= -1;
      }
    }
    
    playSound(id, aspects);
  }
}