class Enemy {
  PVector location, velocity, acceleration;
  float radius, topspeed;
  PImage img1, img2;

  Enemy() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  void setSize(float r) {
    this.radius = r;
  }
  void setLocation(float x, float y) {
    this.location.set(x, y);
  }
}