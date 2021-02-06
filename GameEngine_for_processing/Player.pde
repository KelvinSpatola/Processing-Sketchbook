public final class Player {
  private int size;
  private float speed, originalSpeed;
  private float currentSpeed, walkingSpeed, runningSpeed;
  private final float speedLoss = 0.7;

  // the following constants must have prime numbers as values so they never return equal results whem we combine (add) them in pairs.
  final int U = 1;  // up
  final int D = 3;  // down
  final int L = 7;  // left
  final int R = 11; // right

  private int directionTaken;

  private boolean isUp, isDown, isLeft, isRight;
  private boolean isRunning;
  private int offsetSprites = 0;
  
  private PVector location = new PVector();
  private PVector velocity = new PVector();

  private SpriteSheet sp;

  // CONSTRUCTOR
  public Player(int size, float speed, int dir) {
    sp = new SpriteSheet(parent, "warrior.png", 8, 24);
    sp.resizeSprites(size, 0);
    sp.setFrameRate((int)map(speed, 1, 10, 10, 1));
    facing(dir);

    location = new PVector(width/2, height/2);
    this.size = size;
    this.speed = speed;
    this.originalSpeed = speed;
  }

  public void display() {
    imageMode(CENTER);
    image(sp.draw(), location.x, location.y);
  }

  public void setMove(int k, boolean state) {
    if (k == 'w' || k == 'W' || (k == CODED && keyCode == UP))    isUp = state;
    if (k == 's' || k == 'S' || (k == CODED && keyCode == DOWN))  isDown = state;
    if (k == 'a' || k == 'A' || (k == CODED && keyCode == LEFT))  isLeft = state;
    if (k == 'd' || k == 'D' || (k == CODED && keyCode == RIGHT)) isRight = state;
    if (k == CODED && keyCode == SHIFT && state) {
      isRunning = !isRunning;
      offsetSprites = isRunning ? 8 : 0;
      currentSpeed  = isRunning ? runningSpeed : walkingSpeed;
    }
  }

  public void update() {
    // ****************** ONE KEY PRESSED ******************

    if (isUp) {  

      //      for (GameObject o : obj) {
      //        if (!o.interceptBottom(this)) location.sub(0, speed);
      //        else location.y = o.Y2 + size/2;
      //      }


      if (location.y - size/2 <= map.getUpperSide()) return;
      if (map.hitTop() || map.hitBottom() && location.y > height/2) location.sub(0, speed);
      else {
        //for (GameObject o : obj) {
        //if (!o.interceptBottom(this)) {
        //  o.location.add(0, speed);
        map.center.add(0, speed);
        for (Coin c : coins) c.location.add(0, speed);
        //} 
        //else location.y = o.Y2 + size/2;
      }
      //}
      sp.animateRow(3, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = U;
    }

    if (isDown) {
      //for (GameObject ob : obj) if (ob.intercept(this)) return;
      if (location.y + size/2 >= map.getLowerSide()) return;
      if (map.hitBottom() || map.hitTop() && location.y <= height/2) location.add(0, speed);
      else {
        map.center.sub(0, speed);
        //for (GameObject o : obj) o.location.sub(0, speed);
        for (Coin c : coins) c.location.sub(0, speed);
      }
      sp.animateRow(0, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = D;
    }

    if (isLeft) {
      //for (GameObject ob : obj) if (ob.intercept(this)) return;
      if (location.x - size/2 <= map.getLeftSide()) return;
      if (map.hitLeft() || map.hitRight() && location.x >= width/2) location.sub(speed, 0);
      else {
        map.center.add(speed, 0);   
        //for (GameObject o : obj) o.location.add(speed, 0);
        for (Coin c : coins) c.location.add(speed, 0);
      }
      sp.animateRow(1, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = L;
    }

    if (isRight) {
      //for (GameObject ob : obj) if (ob.intercept(this)) return;
      if (location.x + size/2 >= map.getRightSide()) return;
      if (map.hitRight() || map.hitLeft() && location.x <= width/2) location.add(speed, 0);
      else {
        map.center.sub(speed, 0);
        //for (GameObject o : obj) o.location.sub(speed, 0);
        for (Coin c : coins) c.location.sub(speed, 0);
      }
      sp.animateRow(2, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = R;
    }

    // ****************** MULTIPLE KEYS PRESSED ******************

    if (isUp && isRight) {
      //speed = originalSpeed * speedLoss;
      sp.animateRow(6, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = U + R;
    }
    //  return;
    //} else speed = originalSpeed;

    if (isUp && isLeft) {
      //speed = originalSpeed * speedLoss;
      sp.animateRow(7, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = U + L;
    }
    //  return;
    //} else speed = originalSpeed;

    if (isDown && isRight) {
      //speed = originalSpeed * speedLoss;
      sp.animateRow(4, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = D + R;
    }
    //  return;
    //} else speed = originalSpeed;

    if (isDown && isLeft) {
      //speed = originalSpeed * speedLoss;
      sp.animateRow(5, 8 + offsetSprites, 15 + offsetSprites);
      directionTaken = D + L;
    }
    //  return;
    //} else speed = originalSpeed;

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
      //vel.set(0, 0);
    }

    // ****************** OTHER COMMANDS ******************

    /*if (keyPressed && key == ' ') {
      sp.setCurrentFrame(4, 0);
      directionTaken = DOWN;
    }*/
  }

  public void facing(int dir) {
    if (dir == UP)    sp.setCurrentFrame(1, 0);
    if (dir == DOWN)  sp.setCurrentFrame(0, 0);
    if (dir == LEFT)  sp.setCurrentFrame(2, 0);
    if (dir == RIGHT) sp.setCurrentFrame(3, 0);
    this.directionTaken = dir;
  }

  public boolean intersects(Coin c) {
    float d = dist(location.x, location.y, c.location.x, c.location.y);
    return d < size/2 + c.size/2;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
  }
  public float getOriginalSpeed() {
    return this.originalSpeed;
  }
}
