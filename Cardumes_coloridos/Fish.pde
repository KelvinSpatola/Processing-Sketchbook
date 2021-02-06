abstract class Mover {
  float x, y, size;
  float xoff, yoff, inc_y;
  float colorLifespan, strokeLifespan;
  boolean dying;
  color c;
  int type;

  Mover(float size) {
    this.size = size;
    inc_y = random(.5, 1.5);
    colorLifespan = 100;
    strokeLifespan = -100;
    c = color(random(360), random(80, 100), random(50, 100), 50);
  }

  abstract Mover display();

  Mover move() {
    if (dying) {
      y += inc_y;
      colorLifespan -= 0.6;
      strokeLifespan += 2;
    } else {
      float x_range = width * 2; //domínio da função
      float x_offset = x_range / 4;
      x = noise(xoff) * x_range;
      x -= x_offset; //centrar x
      xoff += random(0.007);

      float y_range = height * 2; //domínio da função
      float y_offset = y_range / 4;
      y = noise(yoff) * y_range;
      y -= y_offset; //centrar y
      yoff += random(0.007);
    }    
    return this;
  }

  boolean intersects(Mover other) {
    float d = dist(x, y, other.x, other.y);
    return d <= size/2 + other.size/2;
  }

  void die() {
    dying = true; 
    c = 0;
  }
}
