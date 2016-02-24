class Block {
  PVector location;
  PVector dimensions;
  
  Block(PVector l, PVector d) {
    location = new PVector(l.x,l.y,l.z);
    dimensions = new PVector(d.x,d.y,d.z);
  }
  
  void display(color c) {
    en.pushMatrix();
    en.fill(c);
    en.noStroke();
    en.translate(location.x,location.y,location.z);
    en.box(dimensions.x,dimensions.y,dimensions.z);
    en.popMatrix();
  }
  
  void detectCollision() {  //Keeps camera outside of block
    PVector difference = new PVector();
    difference.set(camera.location);
    difference.sub(location);
    
    if (abs(difference.x) < (0.5*camera.selfWidth + 0.5*dimensions.x) && abs(difference.y) < (0.5*camera.selfWidth + 0.5*dimensions.y) && abs(difference.z) < (0.5*camera.selfWidth + 0.5*dimensions.z)) {
      float dx = 0;
      float dy = 0;
      float dz = 0;
      
      dx = abs(abs(difference.x) - (0.5*camera.selfWidth + 0.5*dimensions.x));
      dy = abs(abs(difference.y) - (0.5*camera.selfWidth + 0.5*dimensions.y));
      dz = abs(abs(difference.z) - (0.5*camera.selfWidth + 0.5*dimensions.z));
      
      if (dx < dy && dx < dz) {
        if (camera.upDirection == 1 || camera.upDirection == 3) {
          camera.velocity.x = 0;
        }
        if (difference.x > 0) {
          camera.location.x += dx;
          camera.target.x += dx;
          camera.touchingWall.append(3);
        }
        else {
          camera.location.x -= dx;
          camera.target.x -= dx;
          camera.touchingWall.append(1);
        }
      }
      else if (dy < dx && dy < dz) {
        if (camera.upDirection == 0 || camera.upDirection == 2) {
          camera.velocity.y = 0;
        }
        if (difference.y > 0) {
          camera.location.y += dy;
          camera.target.y += dy;
          camera.touchingWall.append(4);
        }
        else {
          camera.location.y -= dy;
          camera.target.y -= dy;
          camera.touchingWall.append(2);
        }
      }
      else {
        if (camera.upDirection == 4 || camera.upDirection == 5) {
          camera.velocity.z = 0;
        }
        if (difference.z > 0) {
          camera.location.z += dz;
          camera.target.z += dz;
          camera.touchingWall.append(6);
        }
        else {
          camera.location.z -= dz;
          camera.target.z -= dz;
          camera.touchingWall.append(5);
        }
      }
    }
  }
}