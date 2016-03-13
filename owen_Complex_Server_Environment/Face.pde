class Face {
  PVector origin;
  PVector plane;
  int[] c = {int(random(0,100)), int(random(150,255)), int(random(150,255))};
  
  ArrayList<Feature> features = new ArrayList<Feature>();
  
  Face(PVector cubicle, PVector center) {
    origin = new PVector(cubicle.x,cubicle.y,cubicle.z);
    plane = new PVector(0,0,0);
    
    origin.add(center);
    
    if (origin.x != cubicle.x) {
      origin.y -= cubicleWidth*blockWidth/2;
      origin.z -= cubicleWidth*blockWidth/2;
      plane.set(0,1,1);
    }
    else if (origin.y != cubicle.y) {
      origin.x -= cubicleWidth*blockWidth/2;
      origin.z -= cubicleWidth*blockWidth/2;
      plane.set(1,0,1);
    }
    else if (origin.z != cubicle.z) {
      origin.x -= cubicleWidth*blockWidth/2;
      origin.y -= cubicleWidth*blockWidth/2;
      plane.set(1,1,0);
    }
    
    float p = random(0,1);
    if (p < 0.25) {
      features.add(new Feature(origin, plane, 1));
    }
    else if (p < 0.5) {
      features.add(new Feature(origin, plane, 2));
      for (int i=0; i<int(random(1,10)); i++) {
        features.add(new Feature(origin, plane, 3));
      }
    }
    else if (p < 0.65) {
      features.add(new Feature(origin, plane, 4));
    }
    else if (p < 0.8) {
      features.add(new Feature(origin, plane, 5));
    }
  }
}