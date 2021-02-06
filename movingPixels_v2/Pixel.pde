
class Pixel {
  PVector pos, vel;
  PVector destination;
  float speedRatio, ang, rot;
  color cor;
  int size = spacing - 0; // -1
  char ch;


  Pixel(float x, float y, color c) {
    pos = new PVector(x, y);
    destination = pos.copy();
    vel = new PVector();
    speedRatio = 5f;
    cor = c;
    ch = charTable[(int)random(charTable.length)];
    ang = random(TWO_PI);
    rot = radians(random(-5, 5));
    size = spacing;//(int)random(5, 30);
  }

  void display() {
    push();
    fill(cor);
    translate(pos.x, pos.y);
    //rotate(ang);
    textSize(size+5);
    text(ch, 0, 0);
    pop();
    ang += rot;
  }

  void update() {
    vel = PVector.sub(destination, pos).normalize();
    vel.setMag(speedRatio);
    pos.add(vel);

    if (pos.dist(destination) < speedRatio/2) {
      vel.set(0, 0);
      pos.set(destination);
    }
  }

  void setDestination(float x, float y) {
    destination.set(x, y);
  }

  PVector pos() {
    return pos;
  }

  int pixelColor() {
    return cor;
  }

  int size() {
    return size;
  }

  char pixelChar() {
    return ch;
  }
}
