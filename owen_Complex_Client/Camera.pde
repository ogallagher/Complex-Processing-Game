class Camera {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  PVector newTarget;
  PVector angularVelocity;
  PVector orientation;
  float speed;
  int upDirection;
  boolean orienting;
  int selfWidth;
  IntList touchingWall;
  
  Camera() {
    location = new PVector(width/2, height/2, (-1*blockWidth*cubicleWidth*complexWidth*0.5) + (blockWidth*cubicleWidth*0.5));
    velocity = new PVector();
    acceleration = new PVector();
    target = new PVector(0,0,1);
    newTarget = new PVector(0,0,1);
    angularVelocity = new PVector();
    orientation = new PVector(0,1,0);
    target.add(location);
    speed = 3;
    upDirection = 0;
    orienting = false;
    selfWidth = blockWidth - 30;
    touchingWall = new IntList();
  }
  
  void orient() {
    if (keys[4] && !orienting) {
      PVector radial = new PVector();
      radial.set(target);
      radial.sub(location);
      
      PVector axis = new PVector();
      float bestAngle = 0.5*PI;
      float angle;
      
      axis.set(0,-1,0);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 2) {
        bestAngle = angle;
        upDirection = 2;
        orienting = true;
      }
      axis.set(1,0,0);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 1) {
        bestAngle = angle;
        upDirection = 1;
        orienting = true;
      }
      axis.set(0,1,0);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 0) {
        bestAngle = angle;
        upDirection = 0;
        orienting = true;
      }
      axis.set(-1,0,0);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 3) {
        bestAngle = angle;
        upDirection = 3;
        orienting = true;
      }
      axis.set(0,0,-1);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 5) {
        bestAngle = angle;
        upDirection = 5;
        orienting = true;
      }
      axis.set(0,0,1);
      angle = PVector.angleBetween(radial,axis);
      if (angle < bestAngle && upDirection != 4) {
        bestAngle = angle;
        upDirection = 4;
        orienting = true;
      }
    }
  }
  
  void control() {
    PVector heading = new PVector();
    if (upDirection == 0 || upDirection == 2) {
      heading.set(target.x,target.z);
      heading.sub(location.x,location.z);
    }
    else if (upDirection == 1 || upDirection == 3) {
      heading.set(target.y,target.z);
      heading.sub(location.y,location.z);
    }
    else if (upDirection == 4 || upDirection == 5) {
      heading.set(target.x,target.y);
      heading.sub(location.x,location.y);
    }
    heading.normalize();
    heading.mult(speed);
    
    if (keys[1]) {
      float angle = heading.heading();
      float magnitude = heading.mag();
      PVector movement = new PVector();
      
      if (upDirection == 0) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 1) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 2) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 3) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 4) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
      else if (upDirection == 5) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
    }
    if (keys[3]) {
      float angle = heading.heading();
      float magnitude = heading.mag();
      PVector movement = new PVector();
      
      if (upDirection == 0) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 1) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 2) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 3) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 4) {
        angle -= 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
      else if (upDirection == 5) {
        angle += 0.5*PI;
        movement = PVector.fromAngle(angle);
        movement.mult(magnitude);
        
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
    }
    if (keys[0]) {
      PVector movement = new PVector(heading.x,heading.y);
      
      if (upDirection == 0 || upDirection == 2) {
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 1 || upDirection == 3) {
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 4 || upDirection == 5) {
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
    }
    if (keys[2]) {
      float angle = heading.heading();
      float magnitude = heading.mag();
      PVector movement = new PVector();
      angle += PI;
      movement = PVector.fromAngle(angle);
      movement.mult(magnitude);
      
      if (upDirection == 0 || upDirection == 2) {
        velocity.x += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 1 || upDirection == 3) {
        velocity.y += movement.x;
        velocity.z += movement.y;
      }
      else if (upDirection == 4 || upDirection == 5) {
        velocity.x += movement.x;
        velocity.y += movement.y;
      }
    }
    if (keys[5]) {
      if (upDirection == 0 && touchingWall.hasValue(2)) {
        velocity.y = -1 * speed * 10;
      }
      else if (upDirection == 1 && touchingWall.hasValue(1)) {
        velocity.x = -1 * speed * 10;
      }
      else if (upDirection == 2 && touchingWall.hasValue(4)) {
        velocity.y = speed * 10;
      }
      else if (upDirection == 3 && touchingWall.hasValue(3)) {
        velocity.x = speed * 10;
      }
      else if (upDirection == 4 && touchingWall.hasValue(5)) {
        velocity.z = -1 * speed * 10;
      }
      else if (upDirection == 5 && touchingWall.hasValue(6)) {
        velocity.z = speed * 10;
      }
    }
  }
  
  void fall() {
    PVector gravity = new PVector();
    float k = 1;
    
    if (upDirection == 0) {
      gravity.set(0,1,0);
    }
    else if (upDirection == 1) {
      gravity.set(1,0,0);
    }
    else if (upDirection == 2) {
      gravity.set(0,-1,0);
    }
    else if (upDirection == 3) {
      gravity.set(-1,0,0);
    }
    else if (upDirection == 4) {
      gravity.set(0,0,1);
    }
    else if (upDirection == 5) {
      gravity.set(0,0,-1);
    }
    
    gravity.mult(k);
    acceleration.add(gravity);
  }
  
  void move() {
    velocity.add(acceleration);
    
    float friction = 0.8;
    float drag = 0.95;
    if (upDirection == 0 || upDirection == 2) {
      velocity.x *= friction;
      velocity.y *= drag;
      velocity.z *= friction;
    }
    else if (upDirection == 1 || upDirection == 3) {
      velocity.x *= drag;
      velocity.y *= friction;
      velocity.z *= friction;
    }
    else if (upDirection == 4 || upDirection == 5) {
      velocity.x *= friction;
      velocity.y *= friction;
      velocity.z *= drag;
    }
    
    location.add(velocity);
    target.add(velocity);
    acceleration.mult(0);
  }
  
  void look() {     
    PVector radial = new PVector();
    radial.set(target);
    radial.sub(location);
    
    float angleVertical = 0;
    float angleHorizontal = 0;
    int signX = 0;
    int signY = 0;
    
    if (upDirection == 0) {
      angleHorizontal = atan(radial.z/radial.x);        //T
      angleVertical = acos(radial.y);                   //P
      
      if (radial.x < 0 && radial.z > 0) {
        angleHorizontal += PI;
      }
      if (radial.x < 0 && radial.z < 0) {
        angleHorizontal += PI;
      }
      
      signX = 1;
      signY = -1;
    }
    else if (upDirection == 1) {
      angleHorizontal = atan(radial.z/radial.y);        //T
      angleVertical = acos(radial.x);                   //P
      
      if (radial.y < 0 && radial.z > 0) {
        angleHorizontal += PI;
      }
      if (radial.y < 0 && radial.z < 0) {
        angleHorizontal += PI;
      }
      
      signX = -1;
      signY = -1;
    }
    else if (upDirection == 2) {
      angleHorizontal = atan(radial.z/radial.x);        //T
      angleVertical = acos(radial.y);                   //P
      
      if (radial.x < 0 && radial.z > 0) {
        angleHorizontal += PI;
      }
      if (radial.x < 0 && radial.z < 0) {
        angleHorizontal += PI;
      }
      
      signX = -1;
      signY = 1;
    }
    else if (upDirection == 3) {
      angleHorizontal = atan(radial.z/radial.y);        //T
      angleVertical = acos(radial.x);                   //P
      
      if (radial.y < 0 && radial.z > 0) {
        angleHorizontal += PI;
      }
      if (radial.y < 0 && radial.z < 0) {
        angleHorizontal += PI;
      }
      
      signX = 1;
      signY = 1;
    }
    else if (upDirection == 4) {
      angleHorizontal = atan(radial.y/radial.x);        //T
      angleVertical = acos(radial.z);                   //P
      
      if (radial.x < 0 && radial.y > 0) {
        angleHorizontal += PI;
      }
      if (radial.x < 0 && radial.y < 0) {
        angleHorizontal += PI;
      }
      
      signX = -1;
      signY = -1;
    }
    else if (upDirection == 5) {
      angleHorizontal = atan(radial.y/radial.x);        //T
      angleVertical = acos(radial.z);                   //P
      
      if (radial.x < 0 && radial.y > 0) {
        angleHorizontal += PI;
      }
      if (radial.x < 0 && radial.y < 0) {
        angleHorizontal += PI;
      }
      
      signX = 1;
      signY = 1;
    }
    
    while (angleHorizontal < 0) {
      angleHorizontal += 2*PI;
    }
    while (angleHorizontal > 2*PI) {
      angleHorizontal -= 2*PI;
    }
    while (angleVertical < 0) {
      angleVertical += 2*PI;
    }
    while (angleVertical > 2*PI) {
      angleVertical -= 2*PI;
    }
    
    if (upDirection == 0) {
      orientation.set(0,1,0);
    }
    else if (upDirection == 1) {
      orientation.set(1,0,0);
    }
    else if (upDirection == 2) {
      orientation.set(0,-1,0);
    }
    else if (upDirection == 3) {
      orientation.set(-1,0,0);
    }
    else if (upDirection == 4) {
      orientation.set(0,0,1);
    }
    else if (upDirection == 5) {
      orientation.set(0,0,-1);
    }
    
    if (orienting) {
      if (angleVertical < 0.3*PI) {
        angleVertical += 0.01*PI;
      }
      else if (angleVertical > 0.7*PI) {
        angleVertical -= 0.01*PI;
      }
      else {
        orienting = false;
      }
    }
    else {
      PVector mouseMovement = new PVector(mouseX,mouseY);
      mouseMovement.sub(width/2,height/2);
      
      float magnitudeX = 0;
      float magnitudeY = 0;
      
      magnitudeX = constrain(mouseMovement.x, -5, 5);
      magnitudeY = constrain(mouseMovement.y, -5, 5);
      
      angularVelocity.x += signX*(magnitudeX/2)*0.01*PI;
      angularVelocity.y += signY*(magnitudeY/2)*0.01*PI;
      
      angularVelocity.x *= 0.5;
      angularVelocity.y *= 0.5;
      
      angleHorizontal += angularVelocity.x;
      angleVertical += angularVelocity.y;
      
      angleVertical = constrain(angleVertical,0.1*PI,0.9*PI);
    }
    
    if (upDirection == 0 || upDirection == 2) {
      radial.x = cos(angleHorizontal)*sin(angleVertical);
      radial.y = cos(angleVertical);
      radial.z = sin(angleHorizontal)*sin(angleVertical);
    }
    else if (upDirection == 1 || upDirection == 3) {
      radial.x = cos(angleVertical);
      radial.y = cos(angleHorizontal)*sin(angleVertical);
      radial.z = sin(angleHorizontal)*sin(angleVertical);
    }
    else if (upDirection == 4 || upDirection == 5) {
      radial.x = cos(angleHorizontal)*sin(angleVertical);
      radial.y = sin(angleHorizontal)*sin(angleVertical);
      radial.z = cos(angleVertical);
    }
    
    target.set(location);
    target.add(radial);
    
    override.mouseMove(int(displayWidth/2),int(displayHeight/2));
  }
  
  void drawLamp() {    
    en.camera(location.x,location.y,location.z,target.x,target.y,target.z,orientation.x,orientation.y,orientation.z);
    en.pointLight(255, 255, 255, location.x, location.y, location.z);
  }
  
  void drawSights() {
    pushMatrix();
    noFill();
    stroke(200);
    translate(width/2,height/2);
    line(-10,0,10,0);
    rect(0,-10,0,20);
    popMatrix();
  }
}