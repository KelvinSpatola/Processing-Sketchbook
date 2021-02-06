class Player {
  PImage[] img = new PImage[26];
  boolean up, down, left, right, isRunningUp, isRunningDown, isRunningLeft, isRunningRight, hasPassed;

  float x, y, size;
  float speed;
  int value, interval;

  Player() {
    for (int i = 0; i < img.length; i++) {
      img[i] = loadImage("Avatar"+i+".png");
    }
    x = width-size/2;
    y = height-size/2-100;
    speed = 6;
    //speed = 10;
    size = 65;
    interval = 5;
    down = true;
    hasPassed=false;
  }
  void center(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void movementRestriction() {
    if (x-size/2 < 0) {
      x = size/2;
    }
    if (x+size/2 > width) {
      x = width-size/2;
    }
    if (y-size/2 < 40) {
      y = (size/2)+40;
    }
    if (y+size/2 +80> height) {
      y = height-size/2-80;
    }
  }
  boolean isInside(ControlRoom controlRoom) {
    float d = dist(x, y, controlRoom.x, controlRoom.y);
    return (d <= size);
  }
  boolean intersectCoin(int index) {
    float num = 0;
    for (int i=0; i< coins.length; i++) {
      float d = dist(x, y, coins[index].location.x, coins[index].location.y);
      if (d < size/2+coins[index].w/2) {
        num = 1;
      }
    }
    return (num == 1);
  }
  boolean passesThroughTheDoor() {
    float d = dist(x, y, exitDoor.x, exitDoor.y);
    return d < size/2+exitDoor.l2/2;
  }
  void resetStatus() {
    if (levelIndex==1) {
      player.center(width-size/2, height-size/2-100);
    }
    if (levelIndex==2) {
      player.center(width-size/2, height-size/2-100);
    }
    if (levelIndex==3) {
      player.center(width-size/2, size/2+80);
    }
    if (levelIndex==4) {
      player.center(width/2, height/10);
    }
    if (levelIndex==4) {
      player.center(width/10, 500);
    }
    if (levelIndex==5) {
      player.center(width/2, height-size/2-100);
    }
    value = 0;
    speed = 6;
  }
  void display() {

    int checkUp = int(map(y, 0, height, 0, height/2));
    if (checkUp%interval == 0) {
      isRunningUp = !isRunningUp;
    }
    int checkDown = int(map(y, 0, height, 0, height/2));
    if (checkDown%interval == 0) {
      isRunningDown = !isRunningDown;
    }
    int checkLeft = int(map(x, 0, width, 0, width/2));
    if (checkLeft%interval == 0) {
      isRunningLeft = !isRunningLeft;
    }
    int checkRight = int(map(x, 0, width, 0, width/2));
    if (checkRight%interval == 0) {
      isRunningRight = !isRunningRight;
    }

    if (hasPassed == true) {
      image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[12] : img[25], x, y, size, size);
    } else {
      if (keyPressed) {
        if (key == 'w' || key == 'W') {
          y -= speed;
          if (isRunningUp) {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[10] : img[23], x, y, size, size);
          } else {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[11] : img[24], x, y, size, size);
          }
          up = true;
          down = false;
          right = false;
          left = false;
        }
        if (key == 's' || key == 'S') {
          y += speed;
          if (isRunningDown) {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[1] : img[14], x, y, size, size);
          } else {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[2] : img[15], x, y, size, size);
          }
          up = false;
          down = true;
          right = false;
          left = false;
        }
        if (key == 'a' || key == 'A') {
          x -= speed;
          if (isRunningLeft) {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[4] : img[17], x, y, size, size);
          } else {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[5] : img[18], x, y, size, size);
          }
          up = false;
          down = false;
          right = false;
          left = true;
        }
        if (key == 'd' || key == 'D') {
          x += speed;
          if (isRunningRight) {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[7] : img[20], x, y, size, size);
          } else {
            image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[8] : img[21], x, y, size, size);
          }
          up = false;
          down = false;
          right = true;
          left = false;
        }
      } else {
        if (up) {
          image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[9] : img[22], x, y, size, size);
        } 
        if (down) {
          image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[0] : img[13], x, y, size, size);
        }
        if (left) {
          image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[3] : img[16], x, y, size, size);
        } 
        if (right) {
          image(menu.avatar1Chosen || gameLoaded && loadedAvatar.equals("blackAvatar")? img[6] : img[19], x, y, size, size);
        }
      }
    }
  }
}