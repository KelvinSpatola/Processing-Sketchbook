class DeathScreenAnimation {
  int animationTime;

  void playAnimation() {    //####################### Animation Starts ########################//
    frameRate(10);
    textFont(menu.menuFont);
    textSize(100);
    fill(255);
    text("DEAD!", width/2, height/2);
    animationTime += seconds;
    player.speed = 0;
    spot.inc = 0;  

    //##################### Animation Finishes ######################//
    if (animationTime > 20) {
      frameRate(60);
      animationTime = 0;

      player.resetStatus();
      controlRoom1.resetStatus();
      controlRoom2.resetStatus();
      bank.resetStatus();
      exitDoor.resetStatus();
      spot.inc = radians(1);
      pause = false;
      enemyBoss.resetStatus();
      
      for (int i=0; i < agent.length; i++) {
        agent[i].resetStatus();
      }
      for (int i=0; i < enemyPause.length; i++) {
        enemyPause[i].resetStatus();
      }
      for (int i=0; i < coins.length; i++) {
        coins[i].resetStatus();
      }
      coins[4].coinValue = 10;
      coins[5].coinValue = 10;
      coins[6].coinValue = 10;
      coins[0].coinValue = 25;
      coins[1].coinValue = 25;
    }
  }
}