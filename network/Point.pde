
class Point {
  float x, y;
  float xoff, yoff, speed;
  float proximity;

  Point(float x, float y, float speed, float proximity) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.proximity = proximity;   
    xoff = random(50000);
    yoff = random(50000);
  }

  void show() {
    noStroke();
    fill(255, 30);
    ellipse(x, y, 8, 8);
  }

  void update() {
    x = noise(xoff) * (height);
    x += width/4; // this is here just to offset (to "center") the x coordinate.
    xoff += speed;

    y = noise(yoff) * (height);
    yoff += speed;
  }

  boolean isNear(Point other) {
    float d = dist(this.x, this.y, other.x, other.y);
    return d < proximity ;
  }
}
