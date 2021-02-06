class Bubble extends Mover {

  Bubble(float size) {
    super(size);
    xoff = 5000;
    yoff = 15000;
    type = 0;
  }

  Mover display() { 
    if (dying) stroke(strokeLifespan);
    else noStroke();
    fill(c, colorLifespan);
    circle(x, y, size);
    return this;
  }
}
