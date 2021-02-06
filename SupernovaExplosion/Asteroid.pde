class Asteroid {
  PVector pos;
  float speed, minSpeed, maxSpeed;
  float size, maxSize;
  float rotX, rotY, rotZ, angX, angY, angZ;
  final int minSize = 1;
  final color colour = color(80);
  final int detail;

  Asteroid(PVector pos, int detail, float maxSize) {
    this.pos = pos;
    this. detail = detail;
    this.maxSize = maxSize;

    rotX = radians(random(-5, 5));
    rotY = radians(random(-5, 5));
    rotZ = radians(random(-5, 5));
  }

  void update() {
    if (mousePressed) warpSpeed(true);
    else warpSpeed(false);

    speed = map(pos.z, -width, width, minSpeed, maxSpeed);
    pos.z += speed;

    size = map(pos.z, -width, width, minSize, maxSize);
    angX += rotX;
    angY += rotY;
    angZ += rotZ;
  }

  void display() {
    pushStyle();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(angX);
    rotateY(angY);
    rotateZ(angZ);

    noStroke();
    fill(colour);
    sphereDetail(detail);
    sphere(size);

    popMatrix();
    popStyle();
  }

  void warpSpeed(boolean state) {
    if (state) {
      minSpeed = 30;
      maxSpeed = 100;
    } else {
      minSpeed = 5;
      maxSpeed = 30;
    }
  }
}
