
class Letter {
  char ch;
  Particle particle;
  PVector originalPos;

  float speedRatio;
  boolean resetPosition;

  Letter(char ch, float x, float y) {
    this.ch = ch;
    particle = physics.makeParticle(1, x, y, 0);
    originalPos = new PVector(x, y);
    speedRatio = 30.0f;
  }

  void display() {
    text(ch, particle.position().x(), particle.position().y());
  }

  void update() {
    PVector currentPos = new PVector(particle.position().x(), particle.position().y());

    if (resetPosition && !currentPos.equals(originalPos)) {
      PVector vel = PVector.sub(originalPos, currentPos).div(speedRatio);
      particle.position().add(vel.x, vel.y, 0);
      
      if (PVector.dist(currentPos, originalPos) < 1) {
        particle.position().setX(originalPos.x);
        particle.position().setY(originalPos.y);
      }
    }
  }
}
