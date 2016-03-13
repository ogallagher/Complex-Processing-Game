class Player extends Block {
  String name;
  
  Player(String nam, int[] loc, int[] col) {
    super(new PVector(loc[0],loc[1],loc[2]), new PVector(blockWidth,blockWidth,blockWidth), col);
    name = nam;
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