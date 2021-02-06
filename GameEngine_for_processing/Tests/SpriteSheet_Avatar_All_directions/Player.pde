class Player {
  PVector pos = new PVector();
  PVector vel = new PVector();

  int size;
  float currentSpeed, walkingSpeed, runningSpeed;
  final float speedLoss = 0.7;

  // the following constants must have prime numbers as values so they never return equal results whem we combine (add) them in pairs.
  final int U = 1;  // up
  final int D = 3;  // down
  final int L = 7;  // left
  final int R = 11; // right

  int directionTaken;

  boolean isUp, isDown, isLeft, isRight;
  boolean isRunning;
  int offset = 0;

  SpriteSheet sp;


  // CONSTRUCTOR
  Player(PApplet app, int size, float speed) {
    this.size = size;
    walkingSpeed = speed;
    runningSpeed = walkingSpeed * 1.75;
    currentSpeed = walkingSpeed;

    pos = new PVector(width/2, height/2);

    sp = new SpriteSheet(app, "warrior.png", 8, 24);
    sp.resizeSprites(size, 0);
    sp.setFrameRate(5);
  }

  void display() {
    imageMode(CENTER);
    image(sp.draw(), pos.x, pos.y);
  }

  void update() {
    // ****************** ONE KEY PRESSED ******************
    if (isUp) {  
      vel.set(0, -currentSpeed);

      sp.animateRow(3, 8 +offset, 15 + offset);
      directionTaken = U;
    } 
    if (isDown) {  
      vel.set(0, currentSpeed);

      sp.animateRow(0, 8 +offset, 15 + offset);
      directionTaken = D;
    } 
    if (isLeft) {  
      vel.set(-currentSpeed, 0);

      sp.animateRow(1, 8 +offset, 15 + offset);
      directionTaken = L;
    } 
    if (isRight) {  
      vel.set(currentSpeed, 0);

      sp.animateRow(2, 8 +offset, 15 + offset);
      directionTaken = R;
    }

    // ****************** MULTIPLE KEYS PRESSED ******************  

    if (isUp && isLeft) {
      vel.set(-currentSpeed, -currentSpeed);
      vel.mult(speedLoss);

      sp.animateRow(7, 8 +offset, 15 + offset);
      directionTaken = U + L;
    }  
    if (isUp && isRight) {
      vel.set(currentSpeed, -currentSpeed);
      vel.mult(speedLoss);

      sp.animateRow(6, 8 +offset, 15 + offset);
      directionTaken = U + R;
    } 
    if (isDown && isLeft) {
      vel.set(-currentSpeed, currentSpeed);
      vel.mult(speedLoss);

      sp.animateRow(5, 8 +offset, 15 + offset);
      directionTaken = D + L;
    } 
    if (isDown && isRight) {
      vel.set(currentSpeed, currentSpeed);
      vel.mult(speedLoss);

      sp.animateRow(4, 8 +offset, 15 + offset);
      directionTaken = D + R;
    }

    // ****************** NO KEY PRESSED ******************
    if (!isUp && !isDown && !isLeft && !isRight) {
      if (directionTaken == U) sp.animateRow(3, 0, 7);
      if (directionTaken == D) sp.animateRow(0, 0, 7);
      if (directionTaken == L) sp.animateRow(1, 0, 7);
      if (directionTaken == R) sp.animateRow(2, 0, 7);

      if (directionTaken == U + L) sp.animateRow(7, 0, 7);
      if (directionTaken == U + R) sp.animateRow(6, 0, 7);
      if (directionTaken == D + L) sp.animateRow(5, 0, 7);
      if (directionTaken == D + R) sp.animateRow(4, 0, 7);
      vel.set(0, 0);
    }

    pos.add(vel);
  }

  void setMove(int k, boolean state) {
    if (k == CODED) {
      if (keyCode == UP)    isUp = state;
      if (keyCode == DOWN)  isDown = state;
      if (keyCode == LEFT)  isLeft = state;
      if (keyCode == RIGHT) isRight = state;
      if (keyCode == SHIFT && state) {
        isRunning = !isRunning;
        offset = isRunning ? 8 : 0;
        currentSpeed  = isRunning ? runningSpeed : walkingSpeed;
      }
    }
  }
}
