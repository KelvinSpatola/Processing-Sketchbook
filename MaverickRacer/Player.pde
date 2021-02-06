class Player {
  float x, y, angle, max_speed;
  PImage img;
  int timer, timer2;
  boolean stopLeft, stopRight;

  Player() {
    img = loadImage("lambo.png");
    img.resize(30, 0);
    imageMode(CENTER);

    x = width/2;
    y = 3*height/4;
    max_speed = 20;
    angle = 0;
  }
  void decelerate() {
    if (road.speed <= 0) road.speed -= 0;
    else road.speed--;
  }
  void accelerate() {
    if (road.speed >= max_speed) road.speed += 0;
    else road.speed++;
  }
  void direction() {
    float max_amp = PI/6;  // maximum amplitude
    float amp_ratio = map(road.speed, 0, max_speed, PI/180, max_amp);  // amplitude depending on the speed of the car
    float rot_speed = map(road.speed, 0, max_speed, 0, radians(3));  // rotation speed depending on the road.speed
    float max_transl = 10;  // maximum X-axis translation speed
    float transl_speed = map(angle, -max_amp, max_amp, max_transl, -max_transl);  //X-axis translation factor depending on the angle of the car

    if (keyPressed && road.speed >= 1) {
      if (keyCode == LEFT) {
        if (stopLeft) {  // border restriction
          angle = 0;
          decelerate();
        } else {
          if (angle > amp_ratio) angle += 0;  // rotation restriction
          else angle += rot_speed;
        }
      } else if (keyCode == RIGHT) { 
        if (stopRight) {  // border restriction
          angle = 0;
          decelerate();
        } else {
          if (angle < -amp_ratio) angle += 0;  // rotation restriction
          else angle -= rot_speed;
        }
      }
    } else {  // when the player releases the Left or the Right key go, the angle gradually returns to zero
      if (angle < PI/50 && angle > -PI/50) angle = 0;
      else {
        if (angle > 0) angle -= rot_speed*2;  // left
        if (angle < 0) angle += rot_speed*2;  // right
      }
    }
    x += transl_speed;
  }
  void restriction() {
    if (x-15 <= 0) stopLeft = true;
    else stopLeft = false;
    if (x+15 > width) stopRight = true;
    else stopRight = false;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(PI);
    rotate(PI-angle);
    image(img, 0, 0);
    popMatrix();
  }
  void run() {
    display();
    direction();
    restriction();
    
    //println("\n\n\nstopLeft: "+stopLeft+" | stopRight: "+stopRight);
  }
}
