class Player extends Block {
  PVector future;
  String name;
  long lastUpdate;
  
  Player(String nam, int[] loc, int[] col) {
    super(new PVector(loc[0],loc[1],loc[2]), new PVector(blockWidth,blockWidth,blockWidth), col);
    future = location;
    name = nam;
    lastUpdate = 0;
  }
  
  void updateFuture(int[] newFuture, long newTime) {    
    location.set(future);
    future.x = newFuture[0];
    future.y = newFuture[1];
    future.z = newFuture[2];
    
    lastUpdate = newTime;
  }
  
  void move() {
    PVector velocity = new PVector(future.x,future.y,future.z);
    velocity.sub(location);
    velocity.mult(0.3333);
    if (velocity.mag() > camera.speed) {
      velocity.normalize();
      velocity.mult(camera.speed);
    }
    location.add(velocity);
  }
  
  void displayPlayer() {
    en.pushMatrix();
    en.fill(color(c[0],c[1],c[2]));
    en.noStroke();
    en.translate(location.x,location.y,location.z);
    en.box(camera.selfWidth);
    en.popMatrix();
  }
}

void movePlayers() {
  for (int i=0; i<players.size(); i++) {
    players.get(i).move();
  }
}