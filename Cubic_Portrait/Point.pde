class Point {
  PVector pos;
  float xoff, yoff, speed;
  float proximity;

  Point(PVector pos, float speed, float proximity) {
    this.pos = pos;
    this.speed = speed;
    this.proximity = proximity;

    xoff = random(50000);
    yoff = random(50000);
  }

  public void display() {
    pushStyle();
    stroke(255);
    point(pos.x, pos.y);
    popStyle();
  }

  public void updateNoise() {
    pos.x = noise(xoff) * (width);
    xoff += speed;

    pos.y = noise(yoff) * (height);
    yoff += speed;
  }
  
  public boolean isNear(PVector pv) {
    float d = PVector.dist(this.pos, pv);
    return d < proximity ;
  }
}
