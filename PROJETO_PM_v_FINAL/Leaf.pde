class Leaf {
  private PImage leaf;
  private PVector pos, lerpPos, vel, acc;
  private float weight, xoff, angle;
  private boolean isNormal;

  Leaf(float x, float y) {
    this.pos = new PVector(x, y);
    lerpPos = pos.copy();

    weight = random(20, 60);
    leaf = loadImage("data/Menu Files/Images/leaf"+round(random(2))+".png");
    leaf.resize((int)weight, 0);

    vel = new PVector(random(-2, 2), random(-2, 2));
    acc = new PVector(0, weight/1000);
    isNormal = false;
  }
  Leaf() {
    weight = random(20, 60);
    leaf = loadImage("data/Menu Files/Images/leaf"+round(random(2))+".png");
    leaf.resize((int)weight, 0);

    pos = new PVector(random(width), random(-height));
    lerpPos = pos.copy();

    xoff = random(100);
    angle = 0;

    vel = new PVector(0, 0);
    acc = new PVector(0, weight/10000);
    isNormal = true;
  }
  public boolean disappear() {
    return pos.y-leaf.height > height;
  }
  public void update() {
    if (isNormal) {
      lerpPos.x = noise(xoff)*width;
      xoff += .005;
    }

    vel.add(acc);
    lerpPos.add(vel);
    pos.lerp(lerpPos.x, lerpPos.y, 0.0, 0.1);
  }
  public float spin() {    
    float distVar = lerpPos.x - pos.x;
    float rotation = map(distVar, -40.0, 40.0, radians(15), -radians(15));  
    angle += rotation;   
    return angle;
  }
  public void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(spin());
    image(leaf, 0, 0);
    popMatrix();
  }
}