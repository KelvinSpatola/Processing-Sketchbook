// ############################################################################################################### //
// **************************************           NEW GAME MENU           ************************************** //
// ############################################################################################################### //
private class NewGame_Menu extends Menu {        
  private String imagePath;
  private String[] tempString;
  private boolean change;
  private boolean stateImg, info;
  private PImage img_1, img_2, img_3;
  private int timer;

  // CONSTRUTOR
  public NewGame_Menu() {
    image  = new PImage[18];
    source = new PImage[3];
    tempString = new String[1];
    stateImg = true;
    info = true;

    for (int i = 0; i<image.length; i++) {
      image[i] = loadImage("data/Menu Files/Images/newGame_"+i+".png");
    }
    source[0] = image[14].copy();
    source[1] = image[15].copy();
    source[2] = image[16].copy();

    image[0].resize(width, height);
    image[1].resize(200, 80);
    image[2].resize(200, 80);
    image[3].resize(220, 90);
    image[4].resize(220, 90);
    image[5].resize(150, 120);
    image[6].resize(150, 120);
    image[7].resize(width, height);
    image[8].resize(160, 80);
    image[9].resize(160, 80);
    image[10].resize(130, 60);
    image[11].resize(130, 60);
    image[12].resize(600, 500);
    image[13].resize(width, height);

    image[14].resize(100, 100);
    image[15].resize(100, 100);
    image[16].resize(100, 100);

    image[17].resize(width, height);

    setInputNameBox(false);
  }
  public void display() {
    surface.setTitle("FIFTEEN PUZZLE |                                                 New game");
    imageMode(CORNER);
    tint(255);
    image(image[0], 0, 0); //BACKGROUND   

    if (subMenu.equals("createProfile")) {
      createProfile();
    } else if (subMenu.equals("loadProfile")) {
      LoadProfile();
    } else if (subMenu.equals("selectMode")) {
      selectMode();
    } else {
      buttom(280, 280, image[1], image[2], 0.001);
      buttom(300, 390, image[3], image[4], 0.001);
    }
    buttom(535, 60, image[5], image[6], 0.001);   //***return button***//
  }
  public void createProfile() {
    setSubMenu(true);
    rectMode(CENTER);
    imageMode(CORNER);
    textAlign(CORNER);
    noStroke();

    image(image[7], 0, 0);

    fill(nameIsReady? color(0, 72) : color (0));
    text("ENTER NAME:", 177, 268);
    textSize(30);

    fill(nameIsReady? color(67, 194, 67, 50) : color(235, 217, 93, 148));
    rect(300, 292, 246, 35);

    fill(0);
    if (nameIsReady == false) { 
      if (frameCount%30 == 0) change = !change;
      text(change? "_" : "", 177, 304);
    } else {
      text(getProfileName(), 177, 305);
    }
    if (nameIsReady) {
      fill(0);
      text("Take a selfie!", 202, 399);
      buttom(300, 448, image[8], image[9], 0.001);
    }

    if (inputNameBox) {
      setProfileName(JOptionPane.showInputDialog(null, "NAME:", 
        "Input a profile name", JOptionPane.QUESTION_MESSAGE));

      if (getProfileName() == null) setProfileName("---");

      Object[] options = { "Ok", "Rename" };
      int confirmation = JOptionPane.showOptionDialog(null, "Your name is: "+getProfileName(), "Profile Name", 
        JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, null, options, options[0]);

      if (confirmation == JOptionPane.YES_OPTION) {
        setInputNameBox(false);
        nameIsReady = true;
      } else setInputNameBox(false);
    } else if (takePicture) {
      capture.start();
      if (capture.available()) capture.read();

      setProfileSelfie(capture.copy());
      copy(getProfileSelfie(), 0, 0, 640, 480, width-100, 174, -(width-200), height-200);

      buttom(300, 543, image[10], image[11], 0.001);

      if (selfieConfirmed) {
        timer += frameCount-(frameCount-1);
        fill(255, 200-timer*10);
        rect(width/2, height/2, width, height);

        if (timer > 20) {
          setTakePicture(false);
          timer = 0;
        }
      }
    } else {
      capture.stop();
      if (selfieConfirmed) {
        timer += 3;
        fill(0, 0, 0);
        rect(300, 456, 234, 271);

        tint(timer < 255 ? color(255, timer) : color(255));
        image(getProfileSelfie(), 300, 456, 217, 251);

        if (timer > 300) {
          setSubMenu("selectMode");
          timer = 0;
        }
      } else timer = 0;
    }
  }

  public void selectMode() {
    setSubMenu(true);
    imageMode(CORNER);
    image(image[13], 0, 0); //BACKGROUND   
    image(image[12], x, 135);
    if (x <= 0) { 
      x = 0;
      timer++;
    } else  x -= 10;

    fill(modeSelected? color(120) : color(0, constrain(timer, 0, 255)));
    textButtom("Classic", 138, h, 22, true);
    textButtom("Time trial", 252, h, 22, true);
    textButtom("Limited", 388, h, 22, true);

    if (modeSelected) {
      if (h <= 300) h = 300;
      else h -= 2;
      if (gridConfirmed) {
        if (h2 <= 330) h2 = 330;
        else h2 -= 2;
      }
      fill(gridConfirmed? color(120) : color(0));
      textButtom("3x3", 158, h2, 22, true);
      textButtom("4x4", 281, h2, 22, true);
      textButtom("5x5", 405, h2, 22, true);
    }
    if (gridConfirmed) {
      if (game.data.saveFile.getRowCount() > 2) {
        int num1 = 3;
        int num2 = int(game.data.saveFile2[0]);
        value = num1-num2;
        imagePath = "data/Menu Files/Saved Files/Player Pics/ScreenShot_"+value+".jpg";

        if (num2 == 0) {
          tempString[0] = "3";
        } else {
          tempString[0] = str(num2-1);
        }
        if (info) {
          saveStrings("data/Menu Files/Saved Files/saveFile2.txt", tempString);
          info = false;
        }
      } else imagePath = "data/Menu Files/Saved Files/Player Pics/ScreenShot_"+game.data.saveFile.getRowCount()+".jpg";

      if (!loadingProfile) {
        if (game.temp2) game.data.saveData(getProfileSelfie(), getProfileName(), imagePath, game.data.saveFile.getRowCount(), getGameMode(), getGrid());
      } else {
        if (game.temp2) {
          game.data.saveData(getProfileName(), getGameMode(), getGrid());
        }
      }

      imageMode(CENTER);
      tint(isInside(150, 330, 100, h2+70)? color(255) : color(160));
      image(image[14], 150, h2+70);

      tint(isInside(300, 330, 100, h2+70)? color(255) : color(160));
      image(image[15], 300, h2+70);

      tint(isInside(450, 330, 100, h2+70)? color(255) : color(160));
      image(image[16], 450, h2+70);
      tint(255);
    }
    // *********************************************************************************************** //
    //     ***      ULTIMA COMANDO ANTES DE SAIR DO MENU E CHAMAR FINALMENTE O PUZZLE        ***       //
    if (imageConfirmed) setPlayerIsConfirmed(true);
  }

  public void LoadProfile() {
    setSubMenu(true);
    imageMode(CORNER);
    image(image[17], 0, 0);

    imageMode(CENTER);
    textAlign(CENTER);
    textSize(20);
    fill(0);


    if (game.data.firstProfileExist) {
      if (stateImg) stateImg = false;
      img_1 = game.data.getImage_1().copy();
      img_1.resize(150, 150);

      tint(isInside(width/6, 300, 150, 150)? color(255) : color(100));
      image(img_1, width/6, 300); 
      text(game.data.getProfileName_1(), width/6, 400);
    } else text("No Profile \nFound", width/6, 300);

    if (game.data.secondProfileExist) {
      if (stateImg) stateImg = false;
      img_2 = game.data.getImage_2().copy();
      img_2.resize(150, 150);

      tint(isInside(width/2, 300, 150, 150)? color(255) : color(100));
      image(img_2, width/2, 300, 150, 150);  
      text(game.data.getProfileName_2(), width/2, 400);
    } else text("No Profile \nFound", width/2, 300);

    if (game.data.thirdProfileExist) {
      if (stateImg) stateImg = false;
      img_3 = game.data.getImage_3().copy();
      img_3.resize(150, 150);

      tint(isInside(5*width/6, 300, 150, 150)? color(255) : color(100));
      image(img_3, 5*width/6, 300, 150, 150);
      text(game.data.getProfileName_3(), 5*width/6, 400);
    } else text("No Profile \nFound", 5*width/6, 300);
    tint(255);
  }
}
