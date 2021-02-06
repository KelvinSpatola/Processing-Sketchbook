public final class Player extends DynamicEntity {

  // CONSTRUCTOR
  public Player(int x, int y, int w, int h, int speedX, int speedY) {
    super(x, y, w, h, speedX, speedY);
  }

  public void display() {
    pushStyle();
    rectMode(CENTER);
    fill(0);
    rect(location.x, location.y, _width, _height);
    stroke(255, 255, 0);
    line(location.x, top, location.x, bottom);
    line(left, location.y, right, location.y);
    popStyle();
  }
}
