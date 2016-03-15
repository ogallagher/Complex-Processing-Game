void displayComplexAndCollision() {
  for (int i=0; i<blocks.size(); i++) {
    PVector distance = new PVector();
    distance.set(blocks.get(i).location);
    distance.sub(camera.location);
    
    if (distance.mag() < blockWidth*20) {
      blocks.get(i).display();  
      blocks.get(i).detectCollision();
    }
  }
}

void displayGoal() {
  PVector distance = new PVector();
  distance.set(camera.location);
  distance.sub(width/2,height/2,0);
  
  if (distance.mag() < blockWidth*20) {
    en.pushMatrix();
    en.fill(0,255,255);
    en.noStroke();
    en.strokeWeight(1.5);
    en.translate(width/2,height/2,0);
    en.rotateY(0.25 * PI);
    en.rotateX(0.25 * PI);
    en.box(blockWidth);
    en.popMatrix();
  }
}

void displayPlayersAndCollision() {
  for (int i=0; i<players.size(); i++) {
    PVector distance = new PVector();
    distance.set(players.get(i).location);
    distance.sub(camera.location);
    
    if (distance.mag() < blockWidth*20) {
      players.get(i).displayPlayer();
      players.get(i).detectCollision();
    }
  }
}