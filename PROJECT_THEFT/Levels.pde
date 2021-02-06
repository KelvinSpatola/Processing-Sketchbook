class Level5 {
  PImage brightRoom5;
  boolean alertPhase;
  int timer;

  Level5() {
    brightRoom5 = loadImage("BrightRoom5.jpg");
    timer = 0;
    pause = false;
  }
  //############################ BANK FUNCTIONS ############################//
  void bankFunctions(float x, float y) {
    bank.location(x, y);
    bank.display();
    if (bank.diamondStolen()) {
      collectionDiamond.play();
      bank.gotStolen = true;
      exitDoor.doorIsOpen = true;
    }
  }
  //############################ COIN FUNCTIONS ############################//
  void coinFunctions(String state) {
    coins[0].displayGold();
    coins[1].displayGold();
    
    coins[4].displaySilver();
    coins[5].displaySilver();
    coins[6].displaySilver();
    
    coins[2].displayBronze();
    coins[3].displayBronze();
    coins[7].displayBronze();
    coins[8].displayBronze();
    coins[9].displayBronze();
    
    for (int i = 0; i < coins.length; i++) { 
      coins[i].spin(i);
      if (state.equalsIgnoreCase("move")) {
        coins[i].movement();
        coins[i].restriction();
      }
      if (player.intersectCoin(i)) {
        collectCoin.rewind();
        collectCoin.play();
        coins[i].disappear();
        coins[i].passesValue();
        if (coins[i].isGone()) {
          coins[i].coinValue = 0;
        }
      }
    }
  }
  //############################ PLAYER FUNCTIONS ############################//
  void playerFunctions() {
    player.display();
    player.movementRestriction();
    if (player.isInside(controlRoom1) && player.value != 0 || controlRoom1.value == 0) {
      controlRoom1.isWorking = true;
      controlRoom1.getValue();
    } else {
      controlRoom1.isWorking = false;
    }
    if (player.isInside(controlRoom2) && player.value != 0 || controlRoom2.value == 0) {
      controlRoom2.isWorking = true;
      controlRoom2.getValue();
    } else {
      controlRoom2.isWorking = false;
    }
    if (exitDoor.doorIsOpen && player.passesThroughTheDoor()) {
      exitDoor.setNextLevel();
    }
  }
  //############################ CONTROL ROOM FUNCTIONS ############################// 
  void controlRoomFunctions(float x1, float y1, float x2, float y2) {
    controlRoom1.location(x1, y1);
    controlRoom1.display();

    controlRoom2.location(x2, y2);
    controlRoom2.display();

    if (controlRoom1.value == 0 && controlRoom2.value == 0) {
      bank.isLocked = false;
    }
  }
  //############################ ENEMY FUNCTIONS ############################//
  void agent_Functions(int numAgents) {  // "numAgents" sets the number of agents
    for (int i = 0; i < numAgents; i++) {
      if (agent[i].killsPlayer()) {
        background(255, 0, 0);
        exitDoor.resetStatus();
        deathScreen.playAnimation();
      }
      if (agent[i].alertPhase) {
        timer += seconds;
        agent[i].sirensOn = true;
        agent[i].alertPhase();
        if (timer > 500) {
          agent[i].sirensOn = false;
          agent[i].alertPhase = false;
          agent[i].changeColor = false;
        }
      } else {
        timer = 0;
        agent[i].movement();
      }
      agent[i].restriction();
      agent[i].display();

      for (int j = 0; j < numAgents; j++) { 
        if (i != j && agent[i].intersects(agent[j])) {
          agent[i].changeDirection(agent[j]);
        }
      }
    }
  }
  void enemyPause_Functions(int numPause) {
    for (int i = 0; i < numPause; i++) {
      if (enemyPause[i].killsPlayer()) {
        background(255, 0, 0);
        exitDoor.resetStatus();
        pause = false;
        deathScreen.playAnimation();
      }
      enemyPause[i].movement();
      enemyPause[i].restriction();
      enemyPause[i].display();
      for (int j = 0; j < numPause; j++) { 
        if (i != j && enemyPause[i].intersects(enemyPause[j])) {
          enemyPause[i].changeDirection(enemyPause[j]);
        }
      }
    }
  }
  void enemySpotlight_Functions(String path, String alert) {
    spot.move(path);
    spot.display();
    if (spot.catchesPlayer()) {
      spot.alert();
      if (alert.equalsIgnoreCase("alert")) {
        for (int i = 0; i < agent.length; i++) {
          agent[i].alertPhase = true;
        }
      }
    }
  }
  void enemyBoss_Functions() {
    enemyBoss.stalking();
    enemyBoss.display();
    if (enemyBoss.killsPlayer()) {
      background(255, 0, 0);
      exitDoor.doorIsOpen = false;
      alertPhase = false;
      deathScreen.playAnimation();
    }
  }
  void exitDoor_Functions() {
    exitDoor.display();
  }
  void runLevel() {
    imageMode(CORNER);
    gameSong.pause();
    gameSong.rewind();
    if (beginLevel.timer <600) {
      beginLevel.display();
      if (beginLevel.timer > 300) {
        alertSong.play();
      }
    } else {
      image(brightRoom5, 0, 0, width, height-80);
      exitDoor_Functions();
      bankFunctions(width/2, height/2);
      coinFunctions("move");
      playerFunctions();
      controlRoomFunctions((width/12)+30, (height/20)+70, (width-width/12)-30, (height-80)-height/20);
      agent_Functions(1);
      enemyPause_Functions(1);
      enemySpotlight_Functions("ellipse", "alert");
      enemyBoss_Functions();
      hud.display();
    }
  }
}
//#########################################################################################################################################################//
//**************************************************************** LEVEL 1 ********************************************************************************//
//#########################################################################################################################################################//
class Level1  extends Level5 {
  PImage brightRoom1, darkRoom1;

  Level1() {
    super();
    brightRoom1= loadImage("BrightRoom1.jpg");
    darkRoom1= loadImage("DarkRoom1.jpg");
    player.center(width/2, height/2);

    coins[0].location.set(160, 140);
    coins[1].location.set(560, 560);
    coins[2].location.set(540, 140);
    coins[3].location.set(140, 560);
    coins[4].location.set(420, 420);     
    coins[5].location.set(420, 280);
    coins[6].location.set(280, 420);
    coins[7].location.set(280, 280); 
    coins[8].location.set(230, 350);
    coins[9].location.set(470, 350);
    
    for (int i=0; i < coins.length; i++) {  
      coins[i].coinValue=4;
    }
    coins[4].coinValue=10;
    coins[5].coinValue=10;
    coins[6].coinValue=10;
    
    coins[0].coinValue=25;
    coins[1].coinValue=25;
    
       coins[2].displayBronze();
    coins[3].displayBronze();
    coins[7].displayBronze();
    coins[8].displayBronze();
    coins[9].displayBronze();
  }
  void runLevel() {
    imageMode(CORNER);
    menuSong.pause();

    if (beginLevel.timer<600) {
      beginLevel.display();
      if (beginLevel.timer>300) {
        gameSong.play();
      }
    } else { 
      for (int i = 0; i < agent.length; i++) {
        if (agent[i].alertPhase ) {
          pause = false;
          gameSong.pause();
          alertSong.play();
          image(brightRoom1, 0, 0, width, height-80);
        } else {
          alertSong.pause();
          alertSong.rewind();
          gameSong.play();
          image(darkRoom1, 0, 0, width, height-80);
        }
      }
      exitDoor_Functions();
      bankFunctions(width/2, height/2);
      coinFunctions("static");
      playerFunctions();
      controlRoomFunctions((width/12)+30, (height/20)+70, (width-width/12)-30, (height/20)+70);
      //agent_Functions(0);
      //enemyPause_Functions(0);
      enemySpotlight_Functions("ellipse", "noAlert");
      hud.display();
      //spot.display2();
    }
  }
}
//#########################################################################################################################################################//
//**************************************************************** LEVEL 2 ********************************************************************************//
//#########################################################################################################################################################//
class Level2  extends Level5 {
  PImage brightRoom2, darkRoom2;

  Level2() {
    super();
    brightRoom2=loadImage("BrightRoom2.jpg");
    darkRoom2=loadImage("DarkRoom2.jpg");
  }
  void runLevel() {
    imageMode(CORNER);

    if (beginLevel.timer<600) {  
      beginLevel.display();
      if (beginLevel.timer<50) {
        gameSong.rewind();
      } else {
        gameSong.play();
      }
    } else {
      for (int i = 0; i < agent.length; i++) {
        if (agent[i].alertPhase || spot.catchesPlayer()) {
          pause=false;
          gameSong.pause();
          alertSong.play();
          image(brightRoom2, 0, 0, width, height-80);
        } else {
          alertSong.pause();
          alertSong.rewind();
          gameSong.play();
          image(darkRoom2, 0, 0, width, height-80);
        }
      }
      exitDoor_Functions();
      bankFunctions(272, 327);
      coinFunctions("static");
      playerFunctions();
      controlRoomFunctions((width/12)+30, (height-30)-80, (width-width/12)-30, (height/20)+70);
      //agent_Functions(0);

      enemyPause_Functions(3);
      enemySpotlight_Functions("ellipse", "noAlert");
      hud.display();
      //spot.display2();
    }
  }
}
//#########################################################################################################################################################//
//**************************************************************** LEVEL 3 ********************************************************************************//
//#########################################################################################################################################################//
class Level3  extends Level5 {
  PImage brightRoom3, darkRoom3;

  Level3() {
    super();
    brightRoom3=loadImage("BrightRoom3.jpg");
    darkRoom3=loadImage("DarkRoom3.jpg");
  }
  void runLevel() {
    imageMode(CORNER);

    if (beginLevel.timer<600) {
      beginLevel.display();
      if (beginLevel.timer<50) {
        gameSong.rewind();
      } else {
        gameSong.play();
      }
    } else {
      for (int i = 0; i < agent.length; i++) {
        if (agent[i].alertPhase || spot.catchesPlayer()) {//BUG BUG BUG BUG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          pause = false;
          gameSong.pause();
          alertSong.play();
          image(brightRoom3, 0, 0, width, height-80);
        } else {
          alertSong.pause();
          alertSong.rewind();
          gameSong.play();
          image(darkRoom3, 0, 0, width, height-80);
        }
      }
      exitDoor_Functions();
      bankFunctions(351, 557);
      coinFunctions("move");
      playerFunctions();
      controlRoomFunctions((width/12)+30, (height/20)+70, (width-width/12)-30, (height-80)-height/20);
      agent_Functions(2);
      enemyPause_Functions(2);
      enemySpotlight_Functions("ellipse", "alert");
      hud.display();
    }
  }
}
//#########################################################################################################################################################//
//**************************************************************** LEVEL 4 ********************************************************************************//
//#########################################################################################################################################################//
class Level4 extends Level5 {
  PImage brightRoom4, darkRoom4, dtrees, btrees;

  Level4() {
    super();
    brightRoom4=loadImage("BrightRoom4.jpg");
    darkRoom4=loadImage("DarkRoom4.jpg");
    dtrees=loadImage("DarkRoom4_trees.png");
    btrees=loadImage("BrightRoom4_trees.png");
  }
  void runLevel() {
    imageMode(CORNER);

    if (beginLevel.timer<600) {
      beginLevel.display();
      if (beginLevel.timer<50) {
        gameSong.rewind();
      } else {
        gameSong.play();
      }
    } else {
      for (int i = 0; i < agent.length; i++) {
        if (agent[i].alertPhase || spot.catchesPlayer()) {
          pause = false;
          gameSong.pause();
          alertSong.play();
          image(brightRoom4, 0, 0, width, height-80);
        } else {
          alertSong.pause();
          alertSong.rewind();
          gameSong.play();
          image(darkRoom4, 0, 0, width, height-80);
        }
      }
      exitDoor_Functions();
      bankFunctions(438, 374);
      coinFunctions("move");
      playerFunctions();
      controlRoomFunctions(70, 100, 645, 579);
      agent_Functions(1);
      enemyPause_Functions(3);
      enemySpotlight_Functions("ellipse", "alert");
      imageMode(CORNER);
      image(dtrees, 0, 0, width, height-80);
      hud.display();
    }
  }
}
