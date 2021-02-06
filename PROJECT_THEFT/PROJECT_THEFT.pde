//######################## THEFT ########################//
//******* created by Kelvin Clark and Pedro Tavares *******//
//######################## 2018 #########################//
//3026 lines
//2457 lines
import ddf.minim.*;
Minim myMinim;

AudioPlayer mouseOverOptions;
AudioPlayer enterOption;
AudioPlayer returnOption;
AudioPlayer collectCoin;
AudioPlayer collectionDiamond;
AudioPlayer menuSong;
AudioPlayer gameSong;
AudioPlayer alertSong;

MainMenu menu;
Coin[] coins = new Coin[10];
Enemy_Spotlight spot;
Enemy_Agent[] agent = new Enemy_Agent[3];
Enemy_Pause[] enemyPause = new Enemy_Pause[3];
Enemy_Boss enemyBoss;

Bank bank;
ControlRoom controlRoom1, controlRoom2;
ExitDoor exitDoor;
HUD hud;
Player player;

DeathScreenAnimation deathScreen;
BeginLevel beginLevel;

Level1 lvl1;
Level2 lvl2;
Level3 lvl3;
Level4 lvl4;
Level5 lvl5;
Credits credits;

int levelIndex = 0;
int seconds = frameCount-(frameCount-1);
int playingTime = 0;

boolean pause, pauseGame, noDataFound;
boolean gameLoaded = false;

Table saveFile;
TableRow row;
String loadedName;
int loadedLevel;
String loadedAvatar;

String playerName = "";
String avatarType;

void loadData() {    // This function loads the data from a textfile named "saveFile.csv" in the data folder
  saveFile = loadTable("data/saveFile/saveFile.csv", "header");
  if (saveFile.getRowCount() == 0) {
    noDataFound = true;
  } else {
    for (int i = 0; i < saveFile.getRowCount(); i++) {
      row = saveFile.getRow(i);
      loadedName = row.getString("PlayerName");  //this loads the last player name written from the text file
      loadedLevel = row.getInt("LevelIndex");  //this loads the data from the last level played by the player, in the text file
      loadedAvatar = row.getString("Avatar"); //this loads the data from the last avatar chosen by the player, in the text file
    }
  }
}
void saveData() {
  saveFile.removeRow(saveFile.getRowCount()-1);
  row = saveFile.addRow();       //************* SAVING DATA ************//
  row.setString("PlayerName", playerName);
  row.setInt("LevelIndex", levelIndex);
  row.setString("Avatar", menu.avatar1Chosen ||  gameLoaded && loadedAvatar.equals("blackAvatar") ? avatarType = "blackAvatar" : "whiteAvatar");
  saveTable(saveFile, "data/saveFile/saveFile.csv");  //**********************************//
  if (saveFile.getRowCount() > 5) {
    // Delete the oldest row
    saveFile.removeRow(0);
  }
}
void setup() {
  size(700, 700);
  loadData();  //This calls the loadData() function, and sets all the information to the their respective variables

  myMinim = new Minim(this);
  mouseOverOptions = myMinim.loadFile("sounds/QuickChange.mp3");
  enterOption = myMinim.loadFile("sounds/TerminalEnter.mp3");
  returnOption = myMinim.loadFile("sounds/TerminalCancel.mp3");
  menuSong = myMinim.loadFile("sounds/menuSong.mp3");
  gameSong = myMinim.loadFile("sounds/gameSong.mp3");
  alertSong = myMinim.loadFile("sounds/alertSong.mp3");
  collectionDiamond = myMinim.loadFile("sounds/diamond.mp3");

  menu = new MainMenu();
  bank = new Bank();
  controlRoom1 = new ControlRoom();
  controlRoom2 = new ControlRoom();
  for (int i=0; i < coins.length; i++) {
    coins[i]=new Coin();
  }
  for (int i = 0; i < agent.length; i++) {
    agent[i]=new Enemy_Agent(25);
  }
  for (int i = 0; i < enemyPause.length; i++) {
    enemyPause[i]=new Enemy_Pause(random(20, 35));
  }
  spot = new Enemy_Spotlight();
  enemyBoss=new Enemy_Boss();
  player = new Player();
  hud=new HUD();
  beginLevel = new BeginLevel();
  deathScreen = new DeathScreenAnimation();
  lvl1 = new Level1();
  lvl2 = new Level2();
  lvl3 = new Level3();
  lvl4 = new Level4();
  lvl5 = new Level5();
  exitDoor = new ExitDoor();
  credits= new Credits();

  menu.name = loadedName;
  if (loadedName == null) menu.name = "";
}
//##########################################################################  VOID DRAW() #################################################################### //
void draw() {
  if (levelIndex == 0) {
    menuSong.play();
    menu.run();
  } else if (levelIndex == 1) {
    lvl1.runLevel();
  } else if (levelIndex == 2) {
    lvl2.runLevel();
  } else if (levelIndex == 3) {
    lvl3.runLevel();
  } else if (levelIndex == 4) {
    lvl4.runLevel();
  } else if (levelIndex == 5) {   
    lvl5.runLevel();
  } else if (levelIndex == 6) {    
    credits.rollCredits();
  } 

  //float x = mouseX;
  //float y = mouseY;
  //line(x, 0, x, height);
  //line(0, y, width, y);
  //println("x = "+x+" y = "+y);

  println(frameRate);
  //println("levelIndex = "+levelIndex);
  //println("playerName = "+playerName+" | menu.name = "+menu.name);
  //println("menu.avatar1Chosen = "+menu.avatar1Chosen+" | menu.avatar2Chosen = "+menu.avatar2Chosen+"\ngameLoaded = "+gameLoaded+" | loadedAvatar = "+loadedAvatar+"\n\n");
  //println("menu.skipIntro = "+menu.skipIntro);
}
//#################################################################  VOID MOUSEPRESSED() ########################################################### //
void mousePressed() {
  if (menu.firstMenu) {
    enterOption.rewind();
    if (menu.typing == false) {
      if (menu.controls) {
        if (menu.index == 0) {
          menu.firstMenu = false;
          menu.newGame = true;
          menu.continueGame = false;
          menu.instructions = false;
          menu.settings = false;
          enterOption.play();
        } else if (menu.index == 1) {
          menu.firstMenu = false;
          menu.newGame = false;
          menu.continueGame = true;
          menu.instructions = false;
          menu.settings = false;
          enterOption.play();
        } else if (menu.index == 2) {
          menu.firstMenu = false;
          menu.newGame = false;
          menu.continueGame = false;
          menu.instructions = true;
          menu.settings = false;
          enterOption.play();
        } else if (menu.index == 3) {
          menu.firstMenu = false;
          menu.newGame = false;
          menu.continueGame = false;
          menu.instructions = false;
          menu.settings = true;
          enterOption.play();
        } else if (menu.index == 4 && menu.firstMenu) {
          exit();
        }
      }
      if (key == ' ') {
        menu.skipIntro =  true;
      }
    }
  }
  // ============ RETURN BUTTON ================= //
  else if (menu.returnButton && menu.index == 9) {
    menu.playSound("return");
    menu.returnButton = false;
    menu.firstMenu = true;
    menu.newGame = false;
    menu.continueGame = false;
    menu.instructions = false;
    menu.settings = false;
  }
  if (menu.newGame && mouseX >= width/10 && mouseX <= width/10+480 && mouseY >= height/5+30 && mouseY <= (height/5+30)+35) {
    menu.typing = true;
    menu.name = "";
    menu.x = 0;
  } else {
    menu.typing = false;
    playerName = menu.name;
  }
  if (menu.newGame && menu.black) {  // Black avatar was chosen 
    menu.avatar1Chosen = true;
    menu.avatar2Chosen = false;
  }
  if (menu.newGame && menu.white) {  // White avatar was chosen 
    menu.avatar1Chosen = false;
    menu.avatar2Chosen = true;
  }

  //========================================== CONTINUE LAST SAVE ==========================================//
  if (menu.finishing && menu.continueGame) {
    gameLoaded = true;
    menu.continueGame=false;
    menu.finishing=false;
    levelIndex = loadedLevel;
    menuSong.pause();
    gameSong.play();
  }
  //===================================== SELECT AN UNLOCKED LEVEL ========================================//
  if (menu.chooseLevel) {
    float a = 50;
    for (int i = 1; i <= loadedLevel; i++) {  
      if (mouseX < (a+i*100)+25 && mouseX > (a+i*100)-25 && mouseY > height/2-25 && mouseY < height/2+25) {
        gameLoaded = true;
        if (i == 1) {
          menu.continueGame = false;
          menu.finishing=false;
          levelIndex = 1;
          menuSong.pause();
          gameSong.play();
        } else if (i == 2) {
          menu.continueGame = false;
          menu.finishing=false;
          levelIndex = 2;
          menuSong.pause();
          gameSong.play();
        } else if (i == 3) {
          menu.continueGame = false;
          menu.finishing=false;
          levelIndex=3;
          menuSong.pause();
          gameSong.play();
        } else if (i == 4) {
          menu.continueGame = false;
          menu.finishing=false;
          levelIndex = 4;
          menuSong.pause();
          gameSong.play();
        } else if (i == 5) {
          menu.continueGame = false;
          menu.finishing=false;
          levelIndex = 5;
          menuSong.pause();
          gameSong.play();
        }
      }
    }
  }
  //===================================== STARTING A NEW GAME ========================================//  
  if (menu.finishing) {
    menu.newGame = false;
    menu.finishing = false;
    levelIndex = 1;  //*****************first Level begins*****************//
    noDataFound = false;

    row = saveFile.addRow();  // this will write all the data into the text file. The information to write is: 
    row.setString("PlayerName", playerName);// - the player name inputted;
    row.setInt("LevelIndex", levelIndex); // - the last level played;
    row.setString("Avatar", menu.avatar1Chosen ? avatarType = "blackAvatar" : "whiteAvatar");
    saveTable(saveFile, "data/saveFile/saveFile.csv");// this is the path of the text file 
    if (saveFile.getRowCount() > 5) {
      // Delete the oldest row
      saveFile.removeRow(0);
    }
  }
  if (menu.continueGame && mouseX >  width/10 && mouseX < 340 && mouseY > height/2-62 && mouseY < height/2-37) { // Continue last save====================
    menu.continueLastSave = true;
    menu.chooseLevel = false;
  } else if (mouseX >  width/10 && mouseX < 450 && mouseY > height/2+37 && mouseY < height/2+67) {  // Choose Unlocked Level====================
    menu.chooseLevel = true;
    menu.continueLastSave = false;
  } else if (menu.continueGame) {
    menu.continueLastSave = false;
    menu.chooseLevel = false;
  }
  // ================================ SETTINGS OPTIONS ====================================== //

  if (menu.settings && mouseX > (8*width/10)-34 && mouseX < (8*width/10)-7 && mouseY > height/2-63 && mouseY < height/2-38) {
    menu.disableOption1 = !menu.disableOption1;
  }
  if (menu.settings && mouseX > (8*width/10)-34 && mouseX < (8*width/10)-7 && mouseY > height/2+38 && mouseY < height/2+63) {
    menu.disableOption2 = !menu.disableOption2;
  }
  //=================================================================================================//
  //=================================================================================================//

  for (int i = 0; i < enemyPause.length; i++) {  //This pauses all the enemyPause's
    if (enemyPause[i].mouseIntercept()) {
      pause =! pause;
    }
  }
}
//#########################################################  VOID KEYPRESSED() ############################################################ //
void keyPressed() {
  if (menu.typing) {  //runs this code only when the user clicks inside the box where he has to input a player name
    final int len = menu.name.length();
    if (menu.name.length() >= 20 || key == CODED) {  // it won't let the user input more than 20 characters into the "name" variable
      menu.name += "";
      menu.x += 0;
    } else { 
      if (key == ENTER || key == RETURN) {
        menu.typing = false;
        menu.name += "";
        playerName = menu.name;
      }
      menu.name += key;
      menu.x += textWidth(key);  // adds a spacing between the characters by their width
    }
    if (key == BACKSPACE) {
      menu.name = menu.name.substring(0, max(0, len-1));  // remove the previous character inputted
      if (menu.name.length() == 0) {
        menu.x = 0;
      } else {
        menu.x -= 2*textWidth(key);
      }
    } else if (key == DELETE) {  //this deletes the whole string
      menu.name = "";
      menu.x = 0;
    }
  }
  if (!menu.typing && key == 'm' || !menu.typing && key == 'M') {  //type "m" or "M" and this will lead the user to the main menu, independently from where he is in the game
    levelIndex = 0;
    menu.firstMenu = true;
    gameSong.pause();
    alertSong.pause();
    menuSong.play();
  }
  if (!menu.typing && key == 'p' || !menu.typing && key == 'P') pauseGame = !pauseGame;
  if (pauseGame) {
    textFont(menu.menuFont);
    textAlign(CENTER, CENTER);
    textMode(CENTER);
    textSize(100);
    rectMode(CENTER);
    fill(0, 100);
    rect(width/2, height/2, 500, 300);
    fill(255);
    text("PAUSE", width/2, height/2);
    noLoop();
  } else loop();
}
