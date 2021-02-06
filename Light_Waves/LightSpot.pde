
class LightSpot {
  PVector pos, lerpPos, vel, acc;
  float weight, xoff;
  float alpha = 255;
  float bottom;
  color cor;

  // CONSTRUCTOR
  LightSpot(int val) {    
    pos = new PVector(random(width), random(-height));
    lerpPos = pos.copy();

    float rand = random(1);
    weight = rand > .9 ? random(1, 20) : random(1, 7);
    bottom = map(weight, 1, 20, height-height/4, height+height/4);

    vel = new PVector();
    acc = new PVector(0, weight/500);

    xoff = val;
    
    float r = random(90, 255);
    float g = random(r + 10, 255);
    cor = color(r, g, 255);
  }


  void display() {
    push();
    translate(pos.x, pos.y);
    tint(cor, alpha);
    image(img, 0, 0, weight*2, weight*2);
    pop();
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    pos.x = (noise(xoff) * 2*width) - width/2;
    xoff += .001;

    if (pos.y >= bottom-height/10) alpha -=10;
  }

  boolean isDead() {
    return pos.y - weight > bottom;
  }
}
