class Leaf {
  PImage leaf;
  PVector pos, lerpPos, vel, acc;
  float weight, xoff, angle;
  boolean isDefault;

  // This is the default constructor. It creates a Leaf object with a random position (with negative y coordinate).
  // The vel (velocity) vector is set to (0,0) so it can totally be influenced by the acc (acceleration) vector.
  Leaf() {
    pos = new PVector(random(width), random(-height));
    lerpPos = pos.copy();
    weight = random(20, 60);

    leaf = loadImage("folha"+round(random(2))+".png"); // it'll pick a random png image from the "data" folder
    leaf.resize((int)weight, 0); // resize the image relative to the width

    vel = new PVector(0, 0);
    acc = new PVector(0, weight/10000);

    xoff = random(100);
    angle = 0;
    isDefault = true;
  }

  // This constructor is needed for creating new Leaf objects only when mousePressed == true, having specific x and y coordinates.
  // Also, in this case the Leaf object will not have a swing movement.
  Leaf(float x, float y) {
    pos = new PVector(x, y);
    lerpPos = pos.copy();
    weight = random(20, 60);

    leaf = loadImage("folha"+round(random(2))+".png");
    leaf.resize((int)weight, 0);

    vel = new PVector(random(-2, 2), random(-2, 2));
    acc = new PVector(0, weight/1000);

    isDefault = false;
  }

  void display() {
    pushStyle();
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(spin());
    image(leaf, 0, 0);
    popMatrix();
    popStyle();
  }

  void update() {
    if (isDefault) { // if it is a default Leaf object, the leaf will have a swing movement. Otherwise it will just fall directly
      lerpPos.x = noise(xoff)*width;
      xoff += .005;
    }

    // adding the velocity to the lerpPos vector to change it's position. 
    // Then we use the lerp() function to calculate the number between the pos vector and the lerpPos vector.
    // This way the pos vector will always "follow" the lerpPos vector, as if it was chasing it. This will be convinient later because we 
    // will want to calculate the distance between these two vectors while they are moving away or closer to each other. 
    vel.add(acc);
    lerpPos.add(vel);
    pos.lerp(lerpPos.x, lerpPos.y, 0.0, 0.1);
  }

  float spin() {  
    // now it is the time to calculate de distance between pos and lerpPos. We only need their x coordinate 
    float distVar = lerpPos.x - pos.x;
    // and map this value. The idea is to determine a value for the leaf rotation, which is given by the 
    // distance variation between pos and lerpPos. In other words, if the distance is too much, 
    // it means that the leaf is moving rapidly so the rotation is larger and vice-versa.
    float rotation = map(distVar, -30.0, 30.0, radians(10), -radians(10));  
    angle += rotation;   
    return angle;
  }

  boolean disappear() {
    return pos.y - leaf.height > height;
  }
}
