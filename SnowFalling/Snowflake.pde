class Snowflake {
  PVector pos, lerpPos, vel, acc;
  float weight, xoff, alpha = 255;
  float bottom;
  boolean dir, blow;

  // CONSTRUCTOR **********
  Snowflake() {    
    pos = new PVector(random(width), random(-height));
    lerpPos = pos.copy();

    float rand = random(1);
    weight = rand > .9 ? random(1, 20) : random(1, 7);
    bottom = map(weight, 1, 20, height-height/4, height+height/4);

    vel = new PVector();
    acc = new PVector(0, weight/1000);

    xoff = random(10000);   
    dir = xoff > 5000;
  }
  // **********************

  void display() {
    push();
    translate(pos.x, pos.y);
    tint(255, alpha);
    image(img, 0, 0, weight*2, weight*2);
    pop();

    if (pos.y >= bottom-height/10) alpha -=10;
  }

  void update() {
    if (blow) {
      acc.x = (noise(xoff) * 2*width) - width/2;
      if (dir) acc.x *= 0.0001;
      else acc.x *= -0.0001;
      xoff += .001;
      blow = false;
    }

    vel.add(acc);
    pos.add(vel);    
  }

  
  boolean isDead() {
    return pos.y - weight > bottom;
  }
}
