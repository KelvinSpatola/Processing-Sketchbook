class ControlRoom {
  PImage controlRoomOff, controlRoomOn, gear1, gear2;
  float x, y, room_w, room_h, alpha;
  float gear_size, angle1, angle2;
  int value, inc;
  boolean isWorking;

    //########################################## POINTS ROOMS ##########################################//
  ControlRoom() {
    controlRoomOff = loadImage("ControlRoomOff.png");
    controlRoomOn = loadImage("ControlRoomOn.png");
    gear1 = loadImage("Gear.png");
    gear2 = loadImage("Gear.png");

    room_w = 100;
    room_h = (room_w*60)/100;
    alpha = 0;
    gear_size = (room_h*68.6)/100;
    value = 50;
    inc = 1;
    isWorking = false;
  }
  void location(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void getValue() {         //########################################## TAKES POINTS FROM PLAYER ##########################################//
    if (player.value <= 0) {
      inc = 0;
    } else {
      inc = 1;
    }
    if (value == 0) {
      inc = 0;
    }
    value -= abs(inc);
    player.value -= abs(inc);
  }                         //*************************************************************************************************************
  void resetStatus() {
    value = 50;
    alpha = 0;
  }
  void display() {
    imageMode(CENTER);
    if (isWorking) {
      alpha = map(value, 0, 50, 255, 0);
      angle1 += radians(2);
      angle2 += radians(-2);
    } else {
      angle1 += 0;
      angle2 += 0;
    }
    tint(255);
    image(controlRoomOff, x, y, room_w, room_h);
    tint(255, alpha);
    image(controlRoomOn, x, y, room_w, room_h);

    pushMatrix();                                     //########################################## GEAR IMAGES ##########################################//
    translate(x-18, y+4);
    rotate(angle1);
    imageMode(CENTER);
    tint(255);
    image(gear1, 0, 0, gear_size, gear_size);
    popMatrix();

    pushMatrix();
    translate(x+18, y-4);
    rotate(angle2);
    imageMode(CENTER);
    image(gear2, 0, 0, gear_size, gear_size);
    popMatrix();                                        //***************************************************************************************************
    
    textAlign(CENTER);
    textSize(30);
    fill(255);
    text(value, x, y+10);
  }
}