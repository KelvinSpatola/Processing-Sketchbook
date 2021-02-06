
class Pixel {
  PVector pos, vel;
  PVector destination;

  float distX, distY, speedX, speedY;
  float speedRatio;

  boolean smooth;
  color cor;
  float lerpInc = 0;

  int size = spacing - 1; // -1
  
  char ch;


  Pixel(float x, float y, color c) {
    pos = new PVector(x, y);
    destination = pos.copy();
    vel = new PVector();
    speedRatio = 50.0f;
    cor = c;
    ch = charTable[(int)random(charTable.length)];
  }
/*
  void display() {
    //push();
    //translate(pos.x, pos.y);
    fill(cor);
    noStroke();
    square(pos.x, pos.y, size);
    //pop();
  }
*/
  void update() {
    if (pos.equals(destination) == false) { 
      if (smooth) {
        distX = destination.x - pos.x;
        distY = destination.y - pos.y;

        speedX = distX / speedRatio;
        speedY = distY / speedRatio;
      }
      vel.set(speedX, speedY);
      pos.add(vel);

      //if (smooth) return;
      float d = PVector.dist(pos, destination);    
      if (d < 1) {
        vel.set(0, 0);
        pos.set(destination);
      }
    }
  }

  void setDestination(float x, float y, boolean smooth, boolean random) {
    destination = new PVector(x, y);
    this.smooth = smooth;
    speedRatio = 50.0f;
    if (random) speedRatio = random(10, 100);

    if (smooth == false) {
      distX = destination.x - pos.x;
      distY = destination.y - pos.y;

      speedX = distX / speedRatio;
      speedY = distY / speedRatio;
    }
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
  
  char pixelChar(){
    return ch;
  }
}
