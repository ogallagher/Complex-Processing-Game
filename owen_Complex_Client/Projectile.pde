class Projectile {
  int[] locations;  //previous location and current location (need both to see if projectile passes "through" the camera between frames
  String name;      //UTC when fired
  int description;  //ammo type {notVerified(-2),explosion(-1),pushBack(0),gravitySwitch(1)}
  
  Projectile(int[] loc, String nam, int des) {
    locations[0] = loc[0];
    locations[1] = loc[1];
    locations[2] = loc[2];
    locations[3] = loc[0];
    locations[4] = loc[1];
    locations[5] = loc[2];
    name = nam;
    description = des;
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
    return false;
  }
  
  void display() {
    en.pushMatrix();
    en.popMatrix();
  }
}

void displayProjectilesAndCollision() {
  for (int i=0; i<projectiles.size(); i++) {
    if (projectiles.get(i).description > -1 && projectiles.get(i).collisionWithCamera()) {
      projectiles.get(i).description = -1;
    }
    
    projectiles.get(i).display();
  }
}