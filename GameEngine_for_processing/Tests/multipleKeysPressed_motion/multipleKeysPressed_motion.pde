
boolean isUp, isDown, isLeft, isRight;
PVector pos, vel;
float speed = 7, speedLoss = 0.7;

void setup() {
  size(700, 500);
  pos = new PVector(width/2, height/2);
  vel = new PVector();
}
void draw() {
  background(255);

  // one key pressed
  if (isUp)    vel.set(0, -speed);
  if (isDown)  vel.set(0, speed);
  if (isLeft)  vel.set(-speed, 0);
  if (isRight) vel.set(speed, 0); 

  // two keys pressed
  if (isUp && isLeft) {
    vel.set(-speed, -speed);
    vel.mult(speedLoss);
  }  
  if (isUp && isRight) {
    vel.set(speed, -speed);
    vel.mult(speedLoss);
  } 
  if (isDown && isLeft) {
    vel.set(-speed, speed);
    vel.mult(speedLoss);
  } 
  if (isDown && isRight) {
    vel.set(speed, speed);
    vel.mult(speedLoss);
  }
  
  // no key pressed
  if (!isUp && !isDown && !isLeft && !isRight) vel.set(0, 0);

  pos.add(vel);

  fill(255, 0, 0);
  ellipse(pos.x, pos.y, 60, 60);
}
void keyPressed() {
  setMove(key, true);
}
void keyReleased() {
  setMove(key, false);
}
void setMove(int k, boolean state) {
  if (k == CODED) {
    if (keyCode == UP)    isUp = state;
    if (keyCode == DOWN)  isDown = state;
    if (keyCode == LEFT)  isLeft = state;
    if (keyCode == RIGHT) isRight = state;
  }
}
