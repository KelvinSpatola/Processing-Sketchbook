class MainMenu {
  boolean firstMenu, newGame, continueGame, instructions, settings, returnButton;
  boolean typing, insideBox, nameReady, change, black, white, avatar1Chosen, avatar2Chosen, finishing;
  boolean continueLastSave, chooseLevel;
  boolean disableOption1, disableOption2;
  boolean runTimer, controls, skipIntro;

  color txtColor, nameBox;
  color soundColor, hudColor;

  float txt_x, txt_y, txt_h, x;
  float[] txt_w = {97, 130, 103, 76, 95};

  float num = 0;
  float red, green, blue, alpha;
  float xoff_r = 1000;
  float xoff_g = 5000;
  float xoff_b = 10000;

  int timer, timerBk, timerWh;
  int index, levelSelected;

  PFont introFont = createFont("Impact", 30);
  PFont menuFont = createFont("Gotham Light", 30);
  String textIntro = "THEFT";

  PImage[] img = new PImage[8];
  PImage[] insImgs = new PImage[3];

  String name = "";

  playSoundEffect enterOptionSFX;


  MainMenu() {
    for (int i = 0; i < img.length; i++) {
      img[i] = loadImage("AvatarNG_"+i+".png");
    }
    for (int i = 0; i < insImgs.length; i++) {
      insImgs[i] = loadImage("Ins"+i+".png");
    }

    txt_x = width/2;
    txt_h = 15;

    firstMenu = true;
    returnButton = false;

    timer = 0;
    runTimer = true;
    alpha = 255;

    typing = false;
    change = false;
    avatar1Chosen = false;
    avatar2Chosen = false;

    enterOptionSFX = new playSoundEffect("QuickChange.mp3");
  }
  void display() {
    background(0);
    textFont(menuFont);
    textSize(30);
    fill(160);

    if (firstMenu) {
      firstMenu();
    } else if (newGame) {
      newGame();
    } else if (continueGame) {
      continueGame();
    } else if (instructions) {
      instructions();
    } else if (settings) {
      settingsMenu();
    }
  }
  void firstMenu() {
    background(0);
    textAlign(CENTER, CENTER);

    //########################################## INTRO ANIMATION ##########################################//
    if (timer<400  && skipIntro == false) {
      timer += frameCount - (frameCount - 1);  // intiates the animation time
      int length = 350;  // sets the value for the animation time
      if (timer < length) {
        textFont(introFont);
        textSize(100);
        // using the "noise" function to set the values for the Red, Green, and Blue colors of the introduction text
        // red, green, and blue are constantly changing over time
        red = noise(xoff_r)*255;
        xoff_r += 0.02;
        green = noise(xoff_g)*255;
        xoff_g += 0.02;
        blue = noise(xoff_b)*255;
        xoff_b += 0.02;
        // the variable "num" corresponds to the currently brighter character
        num += 0.1;  // this makes "num" change it's position (value) over time
        if (num > 20) {  // this puts "num" into a loop
          num = 0;
        }
        // "previous", "previous2", "posterior" and "posterior2" correspond to 2 characters before "num", and 2 characters after "num"
        int previous = floor(num)-1;
        int previous2 = previous-1;
        int posterior = ceil(num);
        int posterior2 = posterior+1;

        float x = width/10+150;
        for (int i = 0; i < textIntro.length(); i++) {
          char c = textIntro.charAt(i);  // this splits up the the "textIntro" string into single characters
          x += textWidth(c);

          if (num >= i && num <= i+1) {
            fill(red, green, blue, alpha);
          } else if (previous == i) {
            fill(red, green, blue, alpha-50);
          } else if (posterior == i) {
            fill(red, green, blue, alpha-50);
          } else if (previous2 == i) {
            fill(red, green, blue, alpha-100);
          } else if (posterior2 == i) {
            fill(red, green, blue, alpha-100);
          } else {
            fill(red, green, blue, alpha-150);
          }    
          text(c, x, height/2);
        }
        int time = 80;  // sets the time for the fadeIn and fadeOut effect
        float fadeIn = map(timer, 20, time+20, 255, 0);
        float fadeOut = map(timer, (length-20)-time, length-20, 0, 255);
        if (timer <= 50) {
          fill(0, fadeIn);
        } else {
          fill(0, fadeOut);
        }
        rect(0, 0, width, height);
        controls = false;  // turns off the options selection
      }
    } else {
      //######################################### MAIN MENU APPEARS #########################################//
      String[] firstMenu_options = {"New Game", "Continue Game", "Instructions", "Settings", "Exit Game"};
      controls = true;  // turns on the options selection 

      for (int i = 0; i < firstMenu_options.length; i++) {
        if (mouseX > txt_x-txt_w[i] && mouseX < txt_x+txt_w[i] &&
          mouseY > (height/5+i*(height/7))-txt_h && mouseY < (height/5+i*(height/7))+txt_h) {
          index = i;
          playSound("options");

          //enterOptionSFX.playSound(mouseX, mouseY, txt_x-txt_w[i], txt_x+txt_w[i], (height/5+i*(height/7))-txt_h, (height/5+i*(height/7))+txt_h);

          txtColor = color(255, 0, 0);
        } else {
          txtColor = color(160);
        }
        fill(txtColor);
        text(firstMenu_options[i], txt_x, height/5+i*(height/7));
      }
    }
  }
  //############################################ NEW GAME MENU ############################################//
  void newGame() { 
    rectMode(CORNER);
    textAlign(CORNER, CENTER);
    textFont(introFont);
    text("New Game", width/15, height/15);
    // ****************************** Player name input ******************************//
    textFont(menuFont);
    fill(160);
    text("Type your name", width/10, height/5);
    char k = '_';
    if (typing) {
      fill(50);
      rect(width/10, height/5+30, 480, 35);

      timer += frameCount-(frameCount-1);
      if (timer%10 == 0) {
        change = !change;
      }
      if (change) {
        fill(255);
        text(k, (width/10+10)+x, height/5+45);
      }
      fill(255);
      text (name, width/10+10, height/5+45);
    } else {
      // this changes the background color of the input text box whenever the mouse is over the box.
      if (mouseX >= width/10 && mouseX <= width/10+480 && mouseY >= height/5+30 && mouseY <= (height/5+30)+35) {  
        nameBox = color(50);
      } else {
        nameBox = color(10);
      }
      fill(nameBox);
      rect(width/10, height/5+30, 480, 35);
      fill(50, 255, 50);
      text(playerName, width/10+10, height/5+45);

      if (playerName.length() >= 1) {  // Sets the boolean "nameReady" to true if there's at least one character written
        nameReady = true;
      } else {
        nameReady = false;
      }
    }
    // ===================================================== Avatar Animation ===================================================== //
    fill(160);
    text("Choose your avatar", width/10, 2*height/5);
    rectMode(CENTER);
    imageMode(CENTER);
    // *************************************** BLACK AVATAR ***************************************//
    // ********************************** while mouseOver is true *********************************//
    if (mouseX >= (width/2-100)-75 && mouseX <= (width/2-100)+75 && mouseY >= (height/2+80)-100 && mouseY <= (height/2+80)+100) {
      black = true; // it will prepare this variable for the mousePressed() function. This boolean is specifc for the above line
      timerBk += frameCount-(frameCount-1);
      if (timerBk%12 == 0) {
        change = !change;
        fill(80);
        rect(width/2-100, height/2+80, 150, 200);
      } 
      if (avatar1Chosen) {
        fill(50, 255, 50);
        rect(width/2-100, height/2+80, 150, 200);
        image(img[6], width/2-100, height/2+80, 130, 130);
      } else {
        fill(80);
        rect(width/2-100, height/2+80, 150, 200);
      }
      if (avatar1Chosen == false) {
        image(change ? img[1] : img[2], width/2-100, height/2+80, 130, 130);
      }
    } 
    // **************************** while mouseOver is false ****************************//
    else {
      black = false;
      timerBk = 0;
      fill(avatar1Chosen ? color(50, 255, 50) : color(10));
      rect(width/2-100, height/2+80, 150, 200);
      image(avatar1Chosen ? img[6] : img[0], width/2-100, height/2+80, 130, 130);
    }
    // *************************************** WHITE AVATAR ***************************************//
    // ********************************** while mouseOver is true *********************************//
    if (mouseX >= (width/2+100)-75 && mouseX <= (width/2+100)+75 && mouseY >= (height/2+80)-100 && mouseY <= (height/2+80)+100) {
      white = true; // it will prepare this variable for the mousePressed() function. This boolean is specifc for the above line
      timerWh += frameCount-(frameCount-1);
      if (timerWh%12 == 0) {
        change = !change;
        fill(80);
        rect(width/2+100, height/2+80, 150, 200);
      }
      if (avatar2Chosen) {
        fill(50, 255, 50);
        rect(width/2+100, height/2+80, 150, 200);
        image(img[7], width/2+100, height/2+80, 130, 130);
      } else {
        fill(80);
        rect(width/2+100, height/2+80, 150, 200);
      }
      if (avatar2Chosen == false) { // changes image while player is running
        image(change ? img[4] : img[5], width/2+100, height/2+80, 130, 130);
      }
    }
    // **************************** while mouseOver is false ****************************//
    else {
      white = false;      
      timerWh = 0;
      fill(avatar2Chosen ? color(50, 255, 50) : color(10));
      rect(width/2+100, height/2+80, 150, 200);
      image(avatar2Chosen ? img[7] : img[3], width/2+100, height/2+80, 130, 130);
    }
    //println("avatar1Chosen = "+str(avatar1Chosen)+" | avatar2Chosen = "+str(avatar2Chosen));

    // ======================================= FINAL STEP BEFORE STARING LEVEL 1 ============================================//
    if (nameReady && avatar1Chosen || nameReady && avatar2Chosen) {
      textAlign(CENTER);
      textSize(50);

      if (mouseX > width/2-85 && mouseX < width/2+85 &&
        mouseY > height-90 && mouseY < height-50) {
        txtColor = color(255, 0, 0);
        finishing =  true;
        playSound("options");
      } else {
        finishing =  false;
        txtColor = color(160);
      }
      fill(txtColor);
      text("START", width/2, height-50);
    }
    returnButtonOption();
  }
  //######################################### CONTINUE GAME MENU ###########################################//
  void continueGame() {
    loadData();  //This calls the loadData() function, and sets all the information to the their respective variables
    rectMode(CORNER);
    textAlign(CORNER, CENTER);
    textFont(introFont);
    text("Continue Game", width/15, height/15);
    color option1Color, option2Color;
    textFont(menuFont);
    if (menu.chooseLevel == false && continueLastSave == false) {
      if (mouseX >  width/10 && mouseX < 340 && mouseY > height/2-62 && mouseY < height/2-37) {
        playSound("options");
        option1Color = color(255, 0, 0);
      } else {
        option1Color = color(160);
      }
      fill(option1Color);
      text("Continue last save", width/10, height/2-50);
      if (mouseX >  width/10 && mouseX < 450 && mouseY > height/2+37 && mouseY < height/2+67) {
        playSound("options");
        option2Color = color(255, 0, 0);
      } else {
        option2Color = color(160);
      }
      fill(option2Color);
      text("Choose an unlocked level", width/10, height/2+50);
    }
    // Continue last save====================================================================================================
    rectMode(CENTER);
    imageMode(CENTER);
    fill(0);
    stroke(160);
    if (continueLastSave) {
      if (noDataFound) {  // if no data is stored in the saveFile (the textFile), it will show a "NO DATA WAS FOUND" message
        textAlign(CENTER, CENTER);
        rect(width/2, height/2, 500, 300);
        fill(255, 0, 0);
        text("NO DATA WAS FOUND", width/2, height/2);
      } else {
        rect(width/2, height/2, 500, 300);
        fill(160);
        text("Player name: "+loadedName, 2*width/10, height/2-100);
        text("Last level: "+loadedLevel, 2*width/10, height/2-55);
        image(loadedAvatar.equals("blackAvatar") ? img[6] : img[7], 3*width/5+50, height/2+20);

        if (mouseX > 2*width/10-15 && mouseX < (2*width/10)+110 &&
          mouseY > height/2+75 && mouseY < height/2+120) {
          txtColor = color(255, 0, 0);
          finishing =  true;
          playSound("options");
        } else {
          finishing =  false;
          txtColor = color(160);
        }
        fill(10);
        rect((2*width/10)+50, height/2+100, 120, 40);
        fill(txtColor);
        text("START", 2*width/10, height/2+100);
      }
    }
    // Choose Unlocked Level==================================================================================================
    if (chooseLevel) {
      rect(width/2, height/2, 500, 300);
      fill(160);
      text("Select level", 2*width/10, height/2-100);

      textAlign(CENTER, CENTER);
      textFont(introFont);
      float a = 50;
      for (int i = 1; i <= loadedLevel; i++) {  
        color c1, c2;
        if (mouseX < (a+i*100)+25 && mouseX > (a+i*100)-25 && mouseY > height/2-25 && mouseY < height/2+25) {
          playSound("options");
          c1 = color(255);
          c2 = color(160, 0, 0);
          //println("Está dentro | i = "+i+" | finishing = "+str(finishing)+" | chooseLevel = "+str(chooseLevel));
        } else {
          c1 = color(10);
          c2 = color(255);
          //println("Está fora | i = "+i+" | finishing = "+str(finishing)+" | chooseLevel = "+str(chooseLevel));
        }
        fill(c1);
        rect(a+i*100, height/2, 50, 50);
        fill(c2);
        text(i, a+i*100, height/2-5);
      }
    }
    returnButtonOption();
  }
  //######################################### INSTRUCTIONS MENU ###########################################//
  void instructions() {
    textAlign(CORNER, CENTER); 
    rectMode(CENTER); 
    imageMode(CENTER);
    textFont(introFont);
    text("Instructions", width/15, height/15);
    textFont(menuFont);
    fill(160);
    float x = width/15;
    float y = ((2*height/15));
    String[] instructionsText = {"Controls:", "'W' - move in an upwards motion.", "'S' - move in a downward motion.", "'A' - move towards the right.", 
      "'D' - move towards the left."};
    text(instructionsText[0], x, y);
    String[] enemyInfo = {"Enemy info:", "Agents", "Pause Circles", "Spotlight"};    
    text(enemyInfo[0], x, y+200);

    textSize(20);
    for (int i = 1; i < instructionsText.length; i++) {
      text(instructionsText[i], x+50, y+i*40);
    }
    textAlign(CENTER);
    for (int i = 1; i < enemyInfo.length; i++) {
      text(enemyInfo[i], width/5, (y+210)+i*95);
    }
    for (int i = 0; i < insImgs.length; i++) {
      image(insImgs[i], width/5, height/2+i*90, 50, 50);
    }
    textAlign(CORNER);
    textSize(15);
    String[] insTxt = {"Your general a#%holes. Don´t let the spotlight show your \nposition to them. You'll know by the fancy sirens...", 
      "A.K.A Amateur agents. Giving them a click with the mouse \nwill make them too scared to move! Wimps...", 
      "Always looking to ruin the fun. Getting caught will alert \neveryone to you, and your points will be gone too!"};
    for (int i = 0; i < insTxt.length; i++) {
      text(insTxt[i], width/5+50, (height/2-10)+i*90);
    }
    returnButtonOption();
  }
  //########################################### SETTINGS MENU ############################################//
  void settingsMenu() {
    textAlign(CORNER, CENTER);
    rectMode(CENTER);
    textFont(introFont);
    text("Settings", width/15, height/15);

    // ********************************* enable/disable boxes **************************************//
    textFont(menuFont);
    textSize(25);
    stroke(160);
    fill(0);
    rect(width/2, height/2, 600, 300);
    fill(160);
    text("Enable/disable sound effects", width/10, height/2-50);
    text("Enable/disable HUD", width/10, height/2+50);

    if (disableOption1) {  //********** disable sound effects **************//
      soundColor = color(255, 0, 0);
      mouseOverOptions.mute();
      enterOption.mute();
      returnOption.mute();
      collectCoin.mute();
      collectionDiamond.mute();
      gameSong.mute();
      alertSong.mute();
      menuSong.mute();
      menuSong.pause();
      menuSong.rewind();
    } else {  //********** enable sound effects **************//
      soundColor = color(50, 255, 50);
      mouseOverOptions.unmute();
      enterOption.unmute();
      returnOption.unmute();
      menuSong.unmute();
      collectCoin.unmute();
      collectionDiamond.unmute();
      gameSong.unmute();
      alertSong.unmute();
    }
    fill(soundColor);
    rect((8*width/10)-20, height/2-50, 25, 25);

    //********** enable/disable HUD **************//
    fill(disableOption2 ? color(255, 0, 0) : color(50, 255, 50));
    rect((8*width/10)-20, height/2+50, 25, 25);

    returnButtonOption();
    //println("disableOption1 = "+str(disableOption1)+" | is muted? = "+str(menuSong.isMuted())+" | is playing? = "+str(menuSong.isPlaying()));
  }
  void run() {  //This is the main function. It runs and displays all the other functions
    shortcut();
    display();
  }
  void returnButtonOption() {
    // ****************** RETURN BUTTON ******************//
    textAlign(CORNER, CENTER);
    textFont(introFont);
    if (mouseX > width/15 && mouseX < width/15+82 &&  
      mouseY > (14*height/15)-10 && mouseY < (14*height/15)+16) {
      returnButton = true;
      index = 9;
      fill(255, 0, 0);
    } else {
      returnButton =  false;
      fill(160);
    }
    text("Return", width/15, 14*height/15);
  }
  void shortcut() {
    if (keyPressed && typing == false) {
      if (controls) {
        if (key == '1') {
          returnOption.rewind();
          returnOption.play();
          firstMenu = true;
          newGame = false;
          continueGame = false;
          instructions = false;
          settings = false;
        }
      }
      if (key == ' ') {
        skipIntro =  true;
      }
    }
  }
  void playSound(String type) {
    if (type.equalsIgnoreCase("options")) {
      mouseOverOptions.rewind();
      mouseOverOptions.play();
    }
    if (type.equalsIgnoreCase("return")) {
      returnOption.rewind();
      returnOption.play();
    }
  }
  class playSoundEffect {
    AudioPlayer audioFile;
    boolean isDone, isPlaying, stillPlaying;

    playSoundEffect(String audioFile) {
      this.audioFile = myMinim.loadFile(audioFile);
    }

    boolean check(float x, float y, float width_left, float width_right, float height_up, float height_down) {
      return (x >= width_left && x <= width_right && y >= height_up && y <= height_down);
    }
    void playSound(float x, float y, float width_left, float width_right, float height_up, float height_down) {
      int audioFileTime = audioFile.position();
      if (audioFileTime < 500) {
        isDone = false;
      } else {
        isDone = true;
        isPlaying = false;
      }
      if (check( x, y, width_left, width_right, height_up, height_down)) {
        if (stillPlaying) {
          audioFile.rewind();
          audioFile.play();
        }
        if (isDone == false) {
          audioFile.play();
          isPlaying = true;
        } else {
          audioFile.pause();
        }
      } else {
        if (isPlaying && isDone == false) {
          audioFile.play();
          stillPlaying = true;
        } else {
          audioFile.pause();
          audioFile.rewind();
          stillPlaying = false;
        }
      }
    }
  }
}