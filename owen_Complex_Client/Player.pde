class Player extends Block {
  String name;
  int[] lamp;
  
  Player(String nam, int[] loc, int[] lam, int[] col) {
    super(new PVector(loc[0],loc[1],loc[2]), new PVector(blockWidth,blockWidth,blockWidth), col);
    name = nam;
    lamp = lam;
  }
  
  void displayPlayer() {
    en.pushMatrix();
    en.fill(color(c[0],c[1],c[2]));
    en.noStroke();
    en.translate(location.x,location.y,location.z);
    en.box(dimensions.x,dimensions.y,dimensions.z);
    en.popMatrix();
  }
  
  void drawLamp() {
    en.pointLight(255, 255, 255, lamp[0], lamp[1], lamp[2]);
  }
}