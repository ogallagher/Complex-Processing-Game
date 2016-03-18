class Projectile {
  int[] location;
  int[] velocity;
  String name;        //When fired
  String description; //Type of bullet
  
  Projectile(int[] loc, int[] vel, String nam, String des) {
    location = loc;
    velocity = vel;
    name = nam;
    description = des;
  }
  
  void move() {
    location[0] += velocity[0]*speed;
    location[1] += velocity[1]*speed;
    location[2] += velocity[2]*speed;
  }
}

void moveProjectiles() {
  for (int i=0; i<projectiles.size(); i++) {
    projectiles.get(i).move();
  }
}