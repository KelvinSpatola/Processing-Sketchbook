class Enemy_Spotlight {
  float x, y, r, ang;
  float c1, c2, movementRadius, inc;
  float inc2, xmove, ymove;
  float ax, ay, bx, by, cx, cy, mov;
  float px, py, qx, qy;
  color col1;
  String path1, path2, path3;
  boolean up, down, left, right;
  int speedx, speedy;

  float rot = PI;

  //########################################## SPOTLIGHT ##########################################//
  Enemy_Spotlight() {
    movementRadius = 150;
    r = 60;
    inc2 = -3;
    x = width/2;
    y = height/2;
    xmove = 3;
    ymove = 0;
    inc = radians(1);
    ang = 0;
    c1 = width/2;
    c2 = height/2;
    col1 = color(255, 100);
    path1 = "square";         //************* SQUARE MOVEMENT ************//
    path2 = "ellipse";         //************* CIRCULAR MOVEMENT ************//
    path3 = "circle";
    right = true;
    speedx = 3;
    speedy = 0;
  }
  //########################################## MOVEMENT ##########################################//
  void move(String shape) {
    if (path1.equalsIgnoreCase(shape)) {   //************* SQUARE MOVEMENT ************//
      x += speedx;
      y += speedy;
      if (x+(r*2) > width && right) {
        speedx = 0;
        speedy = 3;
        left = false;
        up = false;
        right = false;
        down = true;
      }
      if (y+(r*2) > height && down) {
        speedx = -3;
        speedy = 0;
        left = true;
        up = false;
        right = false;
        down = false;
      }
      if (x-(r*2) < 0 && left) {
        speedx = 0;
        speedy = -3;
        left = false;
        up = true;
        right = false;
        down = false;
      }
      if (y-(r*2) < 0 && up) {
        speedx = 3;
        speedy = 0;
        left = false;
        up = false;
        right = true;
        down = false;
      }
    }
    if (path2.equalsIgnoreCase(shape)) {   //************* ELLIPSOID MOVEMENT ************//
      ang += -inc;
      x = (movementRadius*2)*cos(ang)+c1;
      y = movementRadius*sin(ang)+c2;
    }
    if (path3.equalsIgnoreCase(shape)) {   //************* CIRCULAR MOVEMENT ************//
      ang += -inc;
      x = movementRadius*cos(ang)+c1;
      y = movementRadius*sin(ang)+c2;
    }
  }
  boolean catchesPlayer() {
    float d = dist(x, y, player.x, player.y); // calculates the distance between the player and the spotlight 
    return (d < player.size/2+r);
  }
  void alert() {                    //************* SPOTS PLAYER ************//
    if (frameCount%10 >= 5 && frameCount%10 <= 55 ) {
      background(255, 0, 0);
      textSize(100);
      text("ALERT! ", width/2, height/2);
    } 
    player.value = 0;
    controlRoom1.resetStatus();
    controlRoom2.resetStatus();
    bank.resetStatus();
    exitDoor.resetStatus();
    for (int i=0; i < coins.length; i++) {
      coins[i].resetStatus();
    }
  }
  void display() {
    float ang2 = map(x, 0, width, PI/2.1, 0);
    ax = r*cos(ang2)+x;
    ay = r*sin(ang2)+y;
    bx = -r*cos(ang2)+x;
    by = -r*sin(ang2)+y;

    noStroke();
    fill(col1);
    triangle(ax, ay, bx, by, width, 0);
    arc(x, y, r*2, r*2, ang2, ang2+PI);
    ellipse(x, y, r*2, r*2);
  }
  void display2() {
    rot += -radians(1);
    float xx = (movementRadius*2)*cos(rot)+c1;
    float yy = movementRadius*sin(rot)+c2;

    float ang3 = map(xx, width, 0, -PI/2.1, 0);
    px = r*cos(ang3)+xx;
    py = r*sin(ang3)+yy;
    qx = -r*cos(ang3)+xx;
    qy = -r*sin(ang3)+yy;
    noStroke();
    fill(col1);
    triangle( qx, qy, px, py, 0, 0);
    arc(xx, yy, r*2, r*2, ang3, ang3+PI);
    ellipse(xx, yy, r*2, r*2);
  }
}