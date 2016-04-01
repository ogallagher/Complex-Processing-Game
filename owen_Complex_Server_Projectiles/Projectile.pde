class Projectile {
  int[] locations;
  int[] velocity;
  String name;         //When fired
  int description;     //Type of bullet
  
  Projectile(int[] loc, int[] vel, String nam, int des) {
    locations = new int[6];
    velocity = new int[3];
    
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
  }
  
  void move() {
    locations[0] = locations[3];
    locations[1] = locations[4];
    locations[2] = locations[5];
    
    locations[3] += velocity[0]*speed;
    locations[4] += velocity[1]*speed;
    locations[5] += velocity[2]*speed;
  }
  
  boolean collision(Block block) {
    int radius = projectileRadius[description];
    
    //..................................................................FINDING POSSIBLE PROJECTILE LOCATION
    PVector shot = new PVector(locations[3],locations[4],locations[5]);
    shot.sub(locations[0],locations[1],locations[2]);
    
    PVector terminal = new PVector(block.location.x,block.location.y,block.location.z);
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
    
    if ((position.x + radius) > (block.location.x - 0.5*block.dimensions.x) && (position.x - radius) < (block.location.x + 0.5*block.dimensions.x)) {
      if ((position.y + radius) > (block.location.y - 0.5*block.dimensions.y) && (position.y - radius) < (block.location.y + 0.5*block.dimensions.y)) {
        if ((position.z + radius) > (block.location.z - 0.5*block.dimensions.z) && (position.z - radius) < (block.location.z + 0.5*block.dimensions.z)) {
          collision = true;
        }
      } 
    }
    //..................................................................END
    
    return collision;
  }
}

void moveProjectiles() {
  for (int i=0; i<projectiles.size(); i++) {
    projectiles.get(i).move();
  }
}

void collideProjectiles() {
  for (int i=0; i<projectiles.size(); i++) {
    boolean collided = false;
    
    for (int j=0; j<blocks.size() && !collided; j++) {
      if (projectiles.get(i).description > -1) {
        if (projectiles.get(i).collision(blocks.get(j))) {
          projectiles.get(i).description = -1;
          collided = true;
        }
      }
      else {
        if (projectiles.get(i).description < -20) {
          projectiles.remove(i);
          i--;
        }
        else {
          projectiles.get(i).description--;
          String broadcast = projectileHD + nameID + projectiles.get(i).name + endID + descriptionID + "X" + endID + timeID + clock + endID + endHD;
          broadcast(broadcast);
          collided = true;
        }
      }
    }
  }
}