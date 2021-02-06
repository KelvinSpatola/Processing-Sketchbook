class Enemy_Pause {
  PVector location, velocity;
  float r;
  PImage[] img = new PImage[2];

//########################################## PAUSING ENEMY ##########################################//
  Enemy_Pause(float r) { 
    location = new PVector(random(r, width/2), random(r+80, height/2));
    velocity = new PVector(round(random(-3, 3)), round(random(-3, 3)));
    this.r = r;
    for (int i = 0; i<img.length; i++) {
      img[i] = loadImage("EnemyPause"+i+".png");
    }
  }
  void movement() {
    if (killsPlayer() || pause == true || player.hasPassed) {
      velocity.set(0, 0);
    } else {     
      while (velocity.x == 0 || velocity.y == 0) {
        velocity.set(round(random(-3, 3)), round(random(-3, 3)));
      }
      location.add(velocity);
    }
  }
  void restriction() {
    if (location.x >= width - r || location.x <= r) { 
      velocity.x = -velocity.x;
    }
    if (location.y >= height - r -80 || location.y <= r+40) {
      velocity.y = -velocity.y;
    }
  }
  boolean intersects(Enemy_Pause other) {
    float distancia = location.dist(other.location);
    return distancia <= r + other.r;
  }
  boolean killsPlayer() {
    float d = dist(location.x, location.y, player.x, player.y); // calculates the distance between the player and the enemy1
    return (d < player.size/2+r);
  }
  boolean mouseIntercept() {
    return (dist(mouseX, mouseY, location.x, location.y) < r);
  }
  void changeDirection(Enemy_Pause other) {
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
    pause = false;
  }
  void display() { 
      image(pause? img[0] : img[1], location.x, location.y, 2*r, 2*r);  
  }
}