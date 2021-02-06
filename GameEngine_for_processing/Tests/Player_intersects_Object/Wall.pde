class Wall extends StaticEntity {
  Wall() {}
  Wall(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
  public void display() {
    pushStyle();
    rectMode(CENTER);
    noStroke();
    rect(location.x, location.y, _width, _height);
    popStyle();
  }
}
