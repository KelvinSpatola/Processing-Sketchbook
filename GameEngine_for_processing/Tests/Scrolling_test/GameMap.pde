class Background {
  final int WIDTH;
  final int HEIGHT;
  int top, bottom, l_side, r_side;

  PImage img;
  PVector pos;

  Background() {
    img = loadImage("world_map.jpg");
    WIDTH = img.width;
    HEIGHT = img.height;

    pos = new PVector(width/2, height/2);
  }

  public void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();
  }

  void updateBorderValues() {
    top    = (int)pos.y - HEIGHT/2;
    bottom = (int)pos.y + HEIGHT/2;
    l_side = (int)pos.x - WIDTH/2;
    r_side = (int)pos.x + WIDTH/2;
  }

  public boolean hitTop() {
    return top >= 0;
  }
  public boolean hitBottom() {
    return bottom <= height;
  }
  public boolean hitLeft() {
    return l_side >= 0;
  }
  public boolean hitRight() {
    return r_side <= width;
  }
}
