class Enemy_Boss {
  PVector location, velocity, acceleration;
  float size, topspeed;
  PImage img;
  //########################################## FINAL ENEMY ##########################################//
  Enemy_Boss() {
    location = new PVector(random(size, width/2), random(size, height/2));
    velocity = new PVector(round(random(-3, 3)), round(random(-3, 3)));
    acceleration = new PVector(0, 0);
    topspeed = 3;
    size = 50;
    img = loadImage("Boss.png");
  }
  void stalking() {

    PVector playerPosition = new PVector(player.x, player.y);

    playerPosition.sub(location);
    playerPosition.setMag(0.5);

    acceleration = playerPosition;
    acceleration.mult(random(2));

    velocity.add(acceleration);
    velocity.limit(topspeed);

    if (player.hasPassed) {
      location.add(0, 0);
    } else {
      location.add(velocity);
    }
  }

  boolean killsPlayer() {    
    float d = dist(location.x, location.y, player.x, player.y); // calculates the distance between the player and the enemy1
    return (d < player.size/2+size);
  }  

  void resetStatus() {
    location.set(random(size, width/2), random(size, height/2));
  }

  void display() { 
    imageMode(CENTER);
    image(img,location.x, location.y, 2*size+20, 2*size+20);
  }
}