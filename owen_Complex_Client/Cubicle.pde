class Cubicle {
  PVector location;
  int diameter;
  //color c;
  
  ArrayList<Face> faces = new ArrayList<Face>();
  
  Cubicle(PVector l) {
    location = new PVector(l.x,l.y,l.z);
    diameter = cubicleWidth * blockWidth;
    //c =color(int(random(50,255)),int(random(50,255)),int(random(50,255)),255);
    
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
  
  void display() {
    for (int i=0; i<faces.size(); i++) {
      faces.get(i).display();
    }
  }
}