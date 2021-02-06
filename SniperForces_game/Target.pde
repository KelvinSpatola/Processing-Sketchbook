class Target {
  PImage img;
  PVector pos;
  float size, health = 255;
  boolean isDead;

  TargetListHandler targetListHandler;


  // CONSTRUCTOR
  Target(String imgPath, float x, float y, int size, TargetListHandler targetListHandler) {
    img = loadImage(imgPath);
    img.resize(size, 0);

    pos = new PVector(x, y);
    this.size = size;
    this.targetListHandler = targetListHandler;
  }

  void display() {
    pushStyle();
    imageMode(CENTER);   
    tint(255, health);
    image(img, pos.x, pos.y);  
    popStyle();

    if (isDead) health -= 20;
    if (health <= 0) targetListHandler.removeTarget(this);
  }

  void kill() {
    isDead = true;
  }
}
