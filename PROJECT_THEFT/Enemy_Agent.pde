class Enemy_Agent {
  PImage sheriff, sirens;
  PVector location, velocity, acceleration;
  boolean changeColor, alertPhase, sirensOn;
  float r, angle, topspeed;
  int timer;

  Enemy_Agent(float r) { 
    location = new PVector(random(r, width/2), random(r+80, height/2));
    velocity = new PVector(round(random(-3, 3)), round(random(-3, 3)));
    acceleration = new PVector(0, 0);
    topspeed = 3;
    alertPhase=false;
    sirensOn = false;
    timer=0;
    this.r = r;
    changeColor = false;
    sheriff= loadImage("Sheriff.png");
    sirens = loadImage("PoliceSirens.png");
  }
  void movement() {
    if (killsPlayer() || player.hasPassed) {
      velocity.set(0, 0);
    } else {
      while (velocity.x == 0 || velocity.y == 0) {
        velocity.set(round(random(-3, 3)), round(random(-3, 3)));
      }
      location.add(velocity);
    }
  }
  void stalking() {
    PVector mouse = new PVector(player.x, player.y);

    mouse.sub(location);
    mouse.setMag(0.5);

    acceleration = mouse;
    acceleration.mult(random(2));

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  void restriction() {
    if (location.x >= width - r || location.x <= r) { 
      velocity.x = -velocity.x;
    }
    if (location.y >= height - r -80 || location.y <= r+40) {
      velocity.y = -velocity.y;
    }
  }
  boolean intersects(Enemy_Agent other) {
    float distancia = location.dist(other.location);
    return distancia <= r + other.r;
  }
  boolean killsPlayer() {    
    float d = dist(location.x, location.y, player.x, player.y); // calculates the distance between the player and the enemy1
    return (d < player.size/2+r);
  }  
  void changeDirection(Enemy_Agent other) {
    if (location.x < other.location.x) {
      velocity.x = -abs(velocity.x);
      other.velocity.x = abs(other.velocity.x);
    } else {
      velocity.x = abs(velocity.x);
      other.velocity.x = -abs(other.velocity.x);
    }
    if (location.y < other.location.y) {
      velocity.y = -abs(velocity.y);
      other.velocity.y = abs(other.velocity.y);
    } else {
      velocity.y = abs(velocity.y);
      other.velocity.y = -abs(other.velocity.y);
    }
  }
  void resetStatus() {
    location.set(random(r, width/2), random(r+80, height/2));
    sirensOn = false;
    changeColor = false;
    alertPhase = false;
  }
  void alertPhase() {
    timer += seconds;
    if (timer%10 == 0) {
      changeColor = !changeColor;
    }          
    stalking();
  }
  void display() { 
    ellipseMode(CENTER);
    imageMode(CENTER);
    strokeWeight(5);
    stroke(0);

    angle += radians(15);

    if (sirensOn) {
      pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      tint(255, 150);
      image(sirens, 0, 0);
      popMatrix();
    }
    fill(changeColor? color(255, 0, 0) : color(50));
    ellipse(location.x, location.y, 2*r, 2*r);
    image(sheriff, location.x, location.y, 2*r, 2*r);
  }
}