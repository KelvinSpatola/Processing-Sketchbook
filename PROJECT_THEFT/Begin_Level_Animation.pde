class BeginLevel {
  int timer;

  //************* ANIMATION BEFORE LEVEL START ****************
  BeginLevel() {
    timer = 0;
  }
  void display() {
    background(255, 0, 0);
    textFont(menu.introFont);
    textAlign(CENTER, CENTER);
    textSize(100);
    timer += seconds;

    if (timer < 2) {
      player.resetStatus();
      for (int i=0; i<coins.length; i++) {
        coins[i].resetStatus();                     //************* COIN RESET BEFORE LEVEL STARTS ****************
      }
    }
    //************* STORY TEXT DEPENDING ON LEVEL ****************

    switch(levelIndex) {
    case 1:
      if (timer<300) {
        background(0);
        fill(255);
        textSize(50);
        text("Hurry!\nThere's the Diamond!\n...Quick! HIDE!", width/2, height/2);
      } else {
        textFont(menu.menuFont);
        textSize(100);
        text("Level "+levelIndex, width/2, height/2);
      }
      break;
    case 2:
      if (timer<300) {
        background(0);
        fill(255);
        textSize(50);
        text("You've got some\nmoves! But there's\nstill more to steal!!", width/2, height/2);
      } else {
        textFont(menu.menuFont);
        textSize(100);
        text("Level "+levelIndex, width/2, height/2);
      }
      break;
    case 3:
      if (timer<300) {
        background(0);
        fill(255);
        textSize(50);
        text("PHEW!\nThat was close...\nwait.. shhhhhhhhh!", width/2, height/2);
      } else {
        textFont(menu.menuFont);
        textSize(100);
        text("Level "+levelIndex, width/2, height/2);
      }
      break;
    case 4:
      if (timer<300) {
        background(0);
        fill(255);
        textSize(50);
        text("HAHA!\nThey really do suck\nat protecting Jewels!", width/2, height/2);
      } else {
        textFont(menu.menuFont);
        textSize(100);
        text("Level "+levelIndex, width/2, height/2);
      }
      break;
    case 5:
      if (timer<300) {
        background(0);
        fill(255);
        textSize(50);
        text("I hope you decided\nto wear your\nBIG BOY PANTS!!", width/2, height/2);
      } else {
        textFont(menu.menuFont);
        textSize(100);
        text("Level "+levelIndex, width/2, height/2);
      }
      break;
    }
  }
}