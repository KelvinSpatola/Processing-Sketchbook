
class Point {
  PVector pos;
  float xoff, yoff, speed;
  int proximity;
  float size = 3;

  Point(float speed, int radius) {
    pos = new PVector(0, 0);
    this.speed = speed;
    proximity = radius;

    xoff = random(50000);
    yoff = random(50000);
  }

  void display() {
    pg_a.strokeWeight(size);
    pg_a.stroke(#46C4D8);
    pg_a.point(pos.x, pos.y);
  }

  float offset = 150;
  void update() {
    pos.x = noise(xoff) * (height + offset);
    pos.x += width/4 - offset/2;
    xoff += speed;

    pos.y = noise(yoff) * (height);
    yoff += speed;
  }

  boolean isNear(Point other) {
    float d = PVector.dist(this.pos, other.pos);
    return d < proximity;
  }
  boolean isNear(PVector pv, int rad) {
    float d = PVector.dist(this.pos, pv);
    return d < rad;
  }
}
