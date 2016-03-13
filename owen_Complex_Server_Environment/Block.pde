class Block {
  PVector location;
  PVector dimensions;
  
  Block(PVector l, PVector d) {
    location = new PVector(l.x,l.y,l.z);
    dimensions = new PVector(d.x,d.y,d.z);
  }
}