class Cubicle {
  PVector location;
  int diameter;  
  
  ArrayList<Face> faces = new ArrayList<Face>();
  
  Cubicle(PVector l) {
    location = new PVector(l.x,l.y,l.z);
    diameter = cubicleWidth * blockWidth;
    
    faces.add(new Face(location,new PVector(-0.5*(cubicleWidth*blockWidth),0,0)));
    if (location.x == (width/2) + (0.5*(complexWidth-1)*cubicleWidth*blockWidth)) {
      faces.add(new Face(location,new PVector(0.5*(cubicleWidth*blockWidth),0,0)));
    }
    
    faces.add(new Face(location,new PVector(0,-0.5*(cubicleWidth*blockWidth),0)));
    if (location.y == (height/2) + (0.5*(complexWidth-1)*cubicleWidth*blockWidth)) {
      faces.add(new Face(location,new PVector(0,0.5*(cubicleWidth*blockWidth),0)));
    }
    
    faces.add(new Face(location,new PVector(0,0,-0.5*(cubicleWidth*blockWidth))));
    if (location.z == 0.5*(complexWidth-1)*cubicleWidth*blockWidth) {
      faces.add(new Face(location,new PVector(0,0,0.5*(cubicleWidth*blockWidth))));
    }
  }
}