class ExitDoor {
  PImage closedDoor, openDoor;
  float x, y, l1, l2, size;
  color col;
  boolean doorIsOpen;
  int timer;

  ExitDoor() {
    closedDoor = loadImage("ExitDoor1.png");
    openDoor = loadImage("ExitDoor2.png");
    col = color(255);
    x = width/2;
    y = 30;
    size = 80;
    l1 = 60;
    l2 = 30;
    doorIsOpen = false;
    timer = 0;
  }
  //########################################## TRANSFER TO NEW ROUND ##########################################//
  void setNextLevel() {
    player.speed = 0;
    timer += seconds;
    player.hasPassed = true;
    if (timer > 100) {
      timer = 0;
      beginLevel.timer = 0;
      player.resetStatus();
      controlRoom1.resetStatus();
      controlRoom2.resetStatus();
      bank.resetStatus();
      exitDoor.resetStatus();
      player.hasPassed = false;

      for (int i = 0; i<agent.length; i++) {
        agent[i].resetStatus();
      }
      for (int i = 0; i<enemyPause.length; i++) {
        enemyPause[i].resetStatus();
      }  
      levelIndex++;   
      if (levelIndex <= 5) {
        saveData();
      }
    }
  }
  void resetStatus() {
    doorIsOpen = false;
  }
  void display() {
    imageMode(CENTER);
    fill(col);
    image(doorIsOpen? openDoor : closedDoor, x, y+10, size, size);
  }
}