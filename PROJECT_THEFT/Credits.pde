class Credits {
  float x, y;
  int inc;
  float timer;

  Credits() {
    x = width/2;
    y = height+250;
    timer = 0;
  }
  void rollCredits() {
    alertSong.pause();
    menuSong.rewind();
    menuSong.play();
    background(0);

    //########################################## CREDITS TEXT ##########################################//
    textAlign(CENTER);
    textFont(menu.menuFont);
    textMode(CENTER);
    textSize(20);
    fill(255);
    text("Done in Processing.: ", x, y+100);
    text("Developed by: ", x, y+200);
    text("Pedro Tavares and Kelvin Clark. ", x, y+250);
    text("Directors: ", x, y+350);
    text("Kelvin Clark and Pedro Tavares. ", x, y+400);
    text("Screenwriters: ", x, y+500);
    text("Pedro Tavares and Kelvin Clark. ", x, y+550);
    text("Programmers: ", x, y+650);
    text("Kelvin Clark and Pedro Tavares. ", x, y+700);
    text("Designers: ", x, y+800);
    text("Pedro Tavares and Kelvin Clark. ", x, y+850);
    text("Animators: ", x, y+950);
    text("Kelvin Clark and Pedro Tavares. ", x, y+1000);
    text("Assistant Producers: ", x, y+1100);
    text("Pedro Tavares and Kelvin Clark. ", x, y+1150);
    text("Audio Engineers: ", x, y+1250);
    text("Kelvin Clark and Pedro Tavares. ", x, y+1300);
    text("Creative Directors: ", x, y+1400);
    text("Pedro Tavares and Kelvin Clark. ", x, y+1450);
    text("Game Artists: ", x, y+1550);
    text("Kelvin Clark and Pedro Tavares. ", x, y+1600);
    text("Lead Artists: ", x, y+1700);
    text("Pedro Tavares and Kelvin Clark. ", x, y+1750);
    text("Level Editors: ", x, y+1850);
    text("Kelvin Clark and Pedro Tavares. ", x, y+1900);
    text("Testers: ", x, y+2000);
    text("Pedro Tavares and Kelvin Clark. ", x, y+2050);
    text("Writers: ", x, y+2150);
    text("Kelvin Clark and Pedro Tavares. ", x, y+2200);
    text("1st Timers: ", x, y+2300);
    text("Pedro Tavares and Kelvin Clark. ", x, y+2350);
    text("Music and Sound: ", x, y+2450);
    text("Kelvin Clark and Pedro Tavares. ", x, y+2500);
    text("Metal Gear Solid V. ", x, y+2550);
    text("Konami. ", x, y+2600);
    text("Special thanks to: ", x, y+2700);
    text("Pedro Tavares and Kelvin Clark. ", x, y+2750);
    text("Noah the Cat... ", x, y+2800);
    text("Images created in PhotoShop. ", x, y+2900);
    text("KP Studios. ", x, y+3600);

    //########################################## RESET GAME ##########################################//

    if (y < -3225) {
      inc = 0;
      timer += seconds;
      if (timer>400) {
        menu.nameReady = false;
        menu.avatar1Chosen = false;
        menu.avatar2Chosen = false;
        gameLoaded = false;
        menu.timer = 0;
        menu.skipIntro = false;
        menu.firstMenu = true;
        y = height+250;
        levelIndex = 0;
      }
    } else {
      inc = 2;
      y -= inc;
      timer = 0;
    }
  }
}