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
    return false;
  }
  
  void display() {
    en.pushMatrix();
    en.fill(50,255,5);
    en.noStroke();
    for (int i=0; i<projectiles.size(); i++) {
      en.translate(projectiles.get(i).locations[3],projectiles.get(i).locations[4],projectiles.get(i).locations[5]);
      en.sphere(50);
      en.translate(-1*projectiles.get(i).locations[3],-1*projectiles.get(i).locations[4],-1*projectiles.get(i).locations[5]);
    }
    en.popMatrix();
  }
}