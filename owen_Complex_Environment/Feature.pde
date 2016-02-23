class Feature {
  int type;
  ArrayList<Block> blocks = new ArrayList<Block>();
  
  Feature(PVector origin, PVector plane, int t) {
    type = t;
    
    if (type == 1) {                                      //SPONGE
      float p = 0;
      
      for (int i=0; i<cubicleWidth+1; i++) {
        for (int j=0; j<cubicleWidth+1; j++) {
          p = random(0,1);
          
          if (p > 0.4) {
            int x = int(origin.x);
            int y = int(origin.y);
            int z = int(origin.z);
            
            if (plane.x == 0) {
              y += blockWidth*i;
              z += blockWidth*j;
            }
            else if (plane.y == 0) {
              x += blockWidth*i;
              z += blockWidth*j;
            }
            else if (plane.z == 0) {
              x += blockWidth*i;
              y += blockWidth*j;
            }
            
            blocks.add(new Block(new PVector(x,y,z), new PVector(blockWidth,blockWidth,blockWidth)));
          }
        }
      }
    }
    
    if (type == 2) {                                      //SOLID
      int x = int(origin.x);
      int y = int(origin.y);
      int z = int(origin.z);
      PVector dimensions = new PVector(blockWidth,blockWidth,blockWidth);
      
      if (plane.x == 0) {
        y += blockWidth*cubicleWidth*0.5;
        dimensions.y *= cubicleWidth+1;
        z += blockWidth*cubicleWidth*0.5;
        dimensions.z *= cubicleWidth+1;
      }
      else if (plane.y == 0) {
        x += blockWidth*cubicleWidth*0.5;
        dimensions.x *= cubicleWidth+1;
        z += blockWidth*cubicleWidth*0.5;
        dimensions.z *= cubicleWidth+1;
      }
      else if (plane.z == 0) {
        x += blockWidth*cubicleWidth*0.5;
        dimensions.x *= cubicleWidth+1;
        y += blockWidth*cubicleWidth*0.5;
        dimensions.y *= cubicleWidth+1;
      }
      blocks.add(new Block(new PVector(x,y,z), dimensions));
    }
    
    if (type == 3) {                                        //ISLAND
      int x = int(origin.x);
      int y = int(origin.y);
      int z = int(origin.z);
      PVector dimensions = new PVector(blockWidth,blockWidth,blockWidth);
      
      if (plane.x == 0) {
        dimensions.x *= round(random(1,3))*2 + 1;
        dimensions.y *= round(random(0,cubicleWidth*0.25))*2 + 1;
        dimensions.z *= round(random(0,cubicleWidth*0.25))*2 + 1;
        
        y += blockWidth*cubicleWidth*0.5;
        z += blockWidth*cubicleWidth*0.5;
        
        y += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
        z += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
      }
      else if (plane.y == 0) {
        dimensions.y *= round(random(1,3))*2 + 1;
        dimensions.x *= round(random(0,cubicleWidth*0.25))*2 + 1;
        dimensions.z *= round(random(0,cubicleWidth*0.25))*2 + 1;
        
        x += blockWidth*cubicleWidth*0.5;
        z += blockWidth*cubicleWidth*0.5;
        
        x += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
        z += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
      }
      else if (plane.z == 0) {
        dimensions.z *= round(random(1,3))*2 + 1;
        dimensions.x *= round(random(0,cubicleWidth*0.25))*2 + 1;
        dimensions.y *= round(random(0,cubicleWidth*0.25))*2 + 1;
        
        x += blockWidth*cubicleWidth*0.5;
        y += blockWidth*cubicleWidth*0.5;
        
        x += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
        y += int(random(-0.5*cubicleWidth,0.5*cubicleWidth)) * blockWidth;
      }
      
      blocks.add(new Block(new PVector(x,y,z), dimensions));
    }
    
    if (type == 4) {                                        //COLUMN
      int x = int(origin.x);
      int y = int(origin.y);
      int z = int(origin.z);
      PVector dimensions = new PVector(blockWidth,blockWidth,blockWidth);
      
      x += round(random(1,cubicleWidth-1)) * blockWidth * plane.x;
      y += round(random(1,cubicleWidth-1)) * blockWidth * plane.y;
      z += round(random(1,cubicleWidth-1)) * blockWidth * plane.z;
      
      if (plane.x == 0) {
        dimensions.x *= cubicleWidth*2 - 1;
      }
      else if (plane.y == 0) {
        dimensions.y *= cubicleWidth*2 - 1;
      }
      else if (plane.z == 0) {
        dimensions.z *= cubicleWidth*2 - 1;
      }
      
      blocks.add(new Block(new PVector(x,y,z), dimensions));
    }
    
    if (type == 5) {                                       //BRIDGE
      int x = int(origin.x);
      int y = int(origin.y);
      int z = int(origin.z);
      PVector dimensions = new PVector(blockWidth,blockWidth,blockWidth);
      float p = random(0,1);
      
      if (p < 0.5) {
        if (plane.x == 0) {
          y += round(random(1,cubicleWidth-1)) * blockWidth;
          z += 0.5 * cubicleWidth * blockWidth;
          dimensions.z *= cubicleWidth-1;
        }
        else if (plane.y == 0) {
          z += round(random(1,cubicleWidth-1)) * blockWidth;
          x += 0.5 * cubicleWidth * blockWidth;
          dimensions.x *= cubicleWidth-1;
        }
        else if (plane.z == 0) {
          x += round(random(1,cubicleWidth-1)) * blockWidth;
          y += 0.5 * cubicleWidth * blockWidth;
          dimensions.y *= cubicleWidth-1;
        }        
      }
      else {
        if (plane.x == 0) {
          z += round(random(1,cubicleWidth-1)) * blockWidth;
          y += 0.5 * cubicleWidth * blockWidth;
          dimensions.y *= cubicleWidth-1;
        }
        else if (plane.y == 0) {
          x += round(random(1,cubicleWidth-1)) * blockWidth;
          z += 0.5 * cubicleWidth * blockWidth;
          dimensions.z *= cubicleWidth-1;
        }
        else if (plane.z == 0) {
          y += round(random(1,cubicleWidth-1)) * blockWidth;
          x += 0.5 * cubicleWidth * blockWidth;
          dimensions.x *= cubicleWidth-1;
        } 
      }
      
      blocks.add(new Block(new PVector(x,y,z), dimensions));
    }
  }
  
  void display(color c) {
    for (int i=0; i<blocks.size(); i++) {
      blocks.get(i).display(c);
      blocks.get(i).detectCollision();
    }
  }
}