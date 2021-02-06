class Coin {
  private PVector location, velocity;
  private int size;
  private boolean moving, spinning;
  private boolean collected;

  private SpriteSheet sp;

  // CONSTRUCTORS
  public Coin(int type, int size) {
    sp = new SpriteSheet(parent,  "Coin_Sprite_Sheet_2.png", 3, 6);
    sp.resizeSprites(size, 0);

    setType(type);

    location = map.getCenter();
    velocity = new PVector(0, 0);

    this.size = size;
    this.moving = false;
    this.spinning = true;
    this.collected = false;
  }
  public Coin(int type, int x, int y, int size) {
    sp = new SpriteSheet(parent,  "Coin_Sprite_Sheet_2.png", 3, 6);
    sp.resizeSprites(size, 0);

    setType(type);

    location = new PVector(x, y);
    velocity = new PVector(0, 0);

    this.size = size;
    this.moving = false;
    this.spinning = true;
    this.collected = false;
  }

  public void run() {
    display();
    spin();
    move();
  }

  private void display() {    
    imageMode(CENTER);
    image(sp.draw(), location.x, location.y, size, size);

    if (collected) {
      setSpinningSpeed(10);
      size--;
      location.y -= 3;
    }
  }

  private void spin() {
    if (spinning) sp.animateRow(sp.currentRow());
  }

  public void isSpinning(boolean state) {
    this.spinning = state;
  }

  public void setSpinningSpeed(int speed) {  
    sp.setFrameRate((int)map(speed, 1, 10, 20, 1));
  }

  private void move() {
    if (moving) location.add(velocity);
  }

  public void isMoving(boolean state) {
    this.moving = state;
  }

  public void setVelocity(int speedX, int speedY) {
    this.velocity.set(speedX, speedY);
  }

  public void collected() {
    this.collected = true;
  }

  public boolean disappeared() {
    return size <= 0;
  }

  public void setType(int type) {
    switch(type) {
    case GOLDEN: 
      sp.setCurrentFrame(0, 0);
      setSpinningSpeed(9);
      break;
    case SILVER: 
      sp.setCurrentFrame(1, 0);
      setSpinningSpeed(8);
      break;
    case BRASS: 
      sp.setCurrentFrame(2, 0);
      setSpinningSpeed(7);
      break;
    }
  }

  // This is the default border restriction method. 
  // It is set to restrain the location inside the canvas.
  private void borderRestriction() {
    if (location.x - size/2 < 0 || location.x + size/2 > width)  velocity.x = -velocity.x;
    if (location.y - size/2 < 0 || location.y + size/2 > height) velocity.y = -velocity.y;
  }

  // This is the enhanced border restriction. 
  // This is meant to define a restriction box. The location will now be restrained inside this box.
  public void borderRestriction(float l_side, float r_side, float top, float bottom) {
    if (location.x - size/2 < l_side || location.x + size/2 > r_side)  velocity.x = -velocity.x;
    if (location.y - size/2 < top || location.y + size/2 > bottom) velocity.y = -velocity.y;
  }
}
