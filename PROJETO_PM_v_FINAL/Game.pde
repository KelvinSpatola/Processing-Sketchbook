public class Game {
  private Menu[] menu = new Menu[4];
  private ArrayList <Leaf> leaves = new ArrayList();
  private Puzzle fifteenPuzzle;
  private Player player;
  private EndAnimation end;
  private Music music;
  private Data data;
  private HUD hud;

  private int[] num;
  private boolean status, status2, temp2;

  // CONSTRUTOR
  public Game() {
    surface.setIcon(loadImage("icon.png"));

    this.status = true;
    this.status2 = true;
    this.temp2 = true;
    this.num = new int[2];

    this.menu[0] = new MainMenu_Menu();
    this.menu[1] = new NewGame_Menu();
    this.menu[2] = new Leaderboard_Menu();
    this.menu[3] = new Options_Menu();
    this.player = new Player();
    this.data = new Data();
    this.music = new Music();
    for (int i = 0; i < 15; i++) leaves.add(new Leaf());

    player.setState(false);
    menu[0].setState(true);
  }

  public void run() {
    if (player.isPlaying()) {
      music.stopSong("menuSong");
      music.playSong("gameSong");
      music.stopSFX("playing");

      player.play(fifteenPuzzle);
      hud.display(menu[1].getGameMode());

      if (fifteenPuzzle.animation) player.setWins(true);
    } else {
      music.playSong("menuSong");
      if (menu[0].getState() == true) menu[0].run();        
      else if (menu[1].getState() == true) menu[1].run();
      else if (menu[2].getState() == true) menu[2].run();
      else if (menu[3].getState() == true) menu[3].run();
    }


    if (menu[1].playerIsConfirmed()) {
      timer_selectImage = 0;
      timer_selectMode = 0;
      if (status) {
        fifteenPuzzle = new Puzzle(menu[1].getGrid(), menu[1].getPuzzleImage(), menu[1].getMinutes(), menu[1].getSeconds());
        fifteenPuzzle.setGameMode(menu[1].getGameMode());
        hud = new HUD(menu[1].getProfileName(), menu[1].getProfileSelfie());
      }
      player.setState(true);
    }
    for (int i = 0; i < leaves.size(); i++) {
      leaves.get(i).update();
      leaves.get(i).display();

      if (leaves.get(i).disappear()) {
        if (leaves.get(i).isNormal) {
          leaves.remove(i);
          leaves.add(new Leaf());
        } else leaves.remove(i);
      }
    }
    if (mousePressed) leaves.add(new Leaf(mouseX, mouseY));

    if (player.wins()) {
      if (status2) end = new EndAnimation(fifteenPuzzle.getNumMoves());
      end.run();
    }
  }

  // ######################################################################################################################################################################### //
  // ************************************************************           MOUSE PRESSED FUNCTIONALITY           ************************************************************ //
  // ######################################################################################################################################################################### //

  public void mouse_INTERFACE(float mouse_x, float mouse_y) {   

    if (player.wins()) {
      if (end.isInside(545, 565, 75, 30)) {  //***************** CONTINUE BUTTON ********************//
        game.data.saveData(menu[1].getProfileName(), fifteenPuzzle.getNumMoves(), fifteenPuzzle.clock.getTimer());
        game.data.getREPORT();
        end.eraseImgeFolder();
        status = true;
        status2 = true;
        temp2 = true;
        music.stopSong("all");
        music = new Music();
        setup();
      }
    }
    if (player.isPlaying() && player.wins() == false) {
      int row = (int)map(mouse_y, 0, height-90, 0, fifteenPuzzle.getRows());  // O height esta a subtrair 90 por cause do resize da janela que esta a ser feito no puzzle
      int col = (int)map(mouse_x, 0, width, 0, fifteenPuzzle.getCols());

      if (mouseY < 600 && !fifteenPuzzle.gameOver && !fifteenPuzzle.isCompleted() && fifteenPuzzle.clicked == true) {
        if (fifteenPuzzle.emptyLocation(row, col).equals("nothing")) music.playSFX("error");
        num[0] = row;
        num[1] = col;
      }
    } else {
      //                                              ************************************************                                             //
      //                                       ************           MENUS PRINCIPAIS           ************                                      //
      //                                              ************************************************                                             //

      // ############################################       MAIN MENU       ############################################ //
      if (menu[0].getState() == true) {  // MAIN MENU

        if (menu[0].isInside(298, 311, 187, 70)) {  // NEW GAME BUTTON INTERFACE
          menu[0].setState(false);
          menu[1].setState(true);  // entrando no menu «New Game»
          menu[2].setState(false);
          menu[3].setState(false);
          if (menu[3].getSFX()) music.playSFX("button");
        } else if (menu[0].isInside(272, 409, 212, 72)) {  // LEADERBOARD BUTTON INTERFACE
          menu[0].setState(false);
          menu[1].setState(false);
          menu[2].setState(true);  // entrando no menu «Leaderboard»
          menu[3].setState(false);
          if (menu[3].getSFX()) music.playSFX("button");
        } else if (menu[0].isInside(352, 506, 185, 69)) {  // OPTIONS BUTTON INTERFACE
          menu[0].setState(false);
          menu[1].setState(false);
          menu[2].setState(false);
          menu[3].setState(true);  // entrando no menu «Options»
          if (menu[3].getSFX()) music.playSFX("button");
        }

        // ############################################       NEW GAME MENU       ############################################ //
      } else if (menu[1].getState()) {  // NEW GAME MENU
        if (menu[1].isInside(280, 280, 191, 69) && menu[1].isSubMenu() == false) {  // CREATE PROFILE BUTTON INTERFACE
          menu[1].setSubMenu("createProfile");
          if (menu[3].getSFX() == true) music.playSFX("button");
        } else if (menu[1].isInside(296, 387, 210, 68) && menu[1].isSubMenu() == false) {  // LOAD PROFILE BUTTON INTERFACE
          menu[1].setSubMenu("loadProfile");
          if (menu[3].getSFX()) music.playSFX("button");
        } else if (menu[0].isInside(532, 68, 92, 77)) {  // RETURN BUTTON INTERFACE
          menu[1].setSubMenu("");
          menu[1].setSubMenu(false);
          menu[1].setProfileName("");
          menu[1].setNameIsReady(false);
          menu[1].setTakePicture(false);
          menu[1].setSelfieConfirmed(false);
          menu[1].setGameMode("");
          menu[1].modeSelected = false;
          menu[1].setGridConfirmed(false);
          menu[1].x = width;
          menu[1].h = 385;  
          menu[1].h2 = 410;
          menu[1].setState(false);
          menu[0].setState(true);
          if (menu[3].getSFX()) music.playSFX("button");
        }

        // ############################################       LEADERBOARD MENU       ############################################ //
      } else if (menu[2].getState()) {  // LEADERBOARD MENU
        if (menu[0].isInside(15, 61, 75, 77)) {  // RETURN BUTTON INTERFACE
          menu[0].setState(true);
          menu[1].setState(false);
          if (menu[3].getSFX()) music.playSFX("button");
        }

        // ############################################       OPTIONS MENU       ############################################ //
      } else if (menu[3].getState()) {  // OPTIONS MENU
        if (menu[3].isInside(298, 347, 210, 71)) {
          menu[3].swapClickedSFX();
          if (menu[3].getSFX() == false) music.muteSFX();
          else  music.unmuteSFX();
        } else if (menu[3].isInside(369, 446, 210, 72)) {
          menu[3].swapClickedMusic();
          if (menu[3].getMusic() == false) music.muteSongs();
          else music.unmuteSongs();
        } else if (menu[0].isInside(67, 68, 92, 77)) {  // RETURN BUTTON INTERFACE
          menu[0].setState(true);
          menu[1].setState(false);
          if (menu[3].getSFX()) music.playSFX("button");
        }
      }
    }

    //                                              ************************************************                                             //
    //                                       ************               SUB MENUS              ************                                      //
    //                                              ************************************************                                             //

    // ############################################       CREATE PROFILE MENU       ############################################ //
    // abre a janela pop-up de introdução para o nome do perfil
    if (menu[1].getSubMenu().equals("createProfile") && menu[1].isSubMenu() && menu[1].isInside(300, 292, 246, 35)) { 
      menu[1].setInputNameBox(true);
      menu[1].setTakePicture(false);
      if (menu[3].getSFX()) music.playSFX("button");
    }
    if (menu[1].getSubMenu().equals("createProfile") && menu[1].isSubMenu() && menu[1].nameIsReady() && menu[1].isInside(298, 449, 154, 76)) { 
      menu[1].setTakePicture(true);
      if (menu[3].getSFX()) music.playSFX("button");
    }
    if (menu[1].getSubMenu().equals("createProfile") && menu[1].isSubMenu() && menu[1].takePicture && menu[1].isInside(300, 543, 110, 52)) {
      menu[1].setSelfieConfirmed(true);
      if (menu[3].getSFX()) music.playSFX("snap");
    }

    // ************************************************      selecionando o modo de jogo      *************************************************** //
    if (menu[1].getSubMenu().equals("selectMode") && menu[1].isSubMenu() && menu[1].isInside(179, 377, 81, 23) &&  menu[1].modeSelected == false) { 
      menu[1].setGameMode("classicMode");
      menu[1].modeSelected = true;
    }
    if (menu[1].getSubMenu().equals("selectMode") && menu[1].isSubMenu() && menu[1].isInside(307, 377, 109, 24) &&  menu[1].modeSelected == false) {  
      menu[1].setGameMode("timeTrial");
      menu[1].modeSelected = true;
    }
    if (menu[1].getSubMenu().equals("selectMode") && menu[1].isSubMenu() && menu[1].isInside(434, 377, 89, 24) &&  menu[1].modeSelected == false) { 
      menu[1].setGameMode("limitedMoves");
      menu[1].modeSelected = true;
    }
    // ****************************************************      selecionando a grelha      **************************************************** //
    if (menu[1].modeSelected) {
      if (menu[1].gridConfirmed == false) timer_selectMode++;
      if (menu[1].isInside(179, 402, 81, 23) &&  timer_selectMode > 1) { 
        menu[1].setGrid(3);
        if (menu[1].getGameMode().equals("timeTrial")) {
          menu[1].setSeconds(0);
          menu[1].setMinutes(3);
        }
        menu[1].setGridConfirmed(true);
      }
      if (menu[1].isInside(307, 402, 109, 24) &&  timer_selectMode > 1) {  
        menu[1].setGrid(4);
        if (menu[1].getGameMode().equals("timeTrial")) {
          menu[1].setSeconds(0);
          menu[1].setMinutes(5);
        }
        menu[1].setGridConfirmed(true);
      }
      if (menu[1].isInside(434, 402, 89, 24) &&  timer_selectMode > 1) { 
        menu[1].setGrid(5);
        if (menu[1].getGameMode().equals("timeTrial")) {
          menu[1].setSeconds(0);
          menu[1].setMinutes(10);
        }
        menu[1].setGridConfirmed(true);
      }
    }
    // ***********************************************      selecionando a imagem do puzzle      *********************************************** //
    if (menu[1].gridConfirmed) {
      timer_selectMode = 0;
      timer_selectImage++;
      if (menu[1].isInside(150, 400, 100, 100) && timer_selectImage > 1) { 
        menu[1].setPuzzleImage(menu[1].source[0]);
        menu[1].setImageConfirmed(true);
      }
      if (menu[1].isInside(300, 400, 100, 100) && timer_selectImage > 1) {  
        menu[1].setPuzzleImage(menu[1].source[1]);
        menu[1].setImageConfirmed(true);
      }
      if (menu[1].isInside(450, 400, 100, 100) && timer_selectImage > 1) { 
        menu[1].setPuzzleImage(menu[1].source[2]);
        menu[1].setImageConfirmed(true);
      }
    }
    // ############################################       SELECT PROFILE MENU       ############################################ //
    // abre a janela de seleção de um profile já existente
    if (game.data.saveFile.getRowCount() > 0) {
      if (menu[1].getSubMenu().equals("loadProfile") && menu[1].isSubMenu() && menu[1].isInside(width/6, 300, 150, 150)) { 
        menu[1].loadingProfile = true;
        menu[1].setSubMenu("createProfile");
        menu[1].setProfileName(data.getProfileName_1());
        menu[1].setNameIsReady(true);
        menu[1].setProfileSelfie(data.getImage_1());
        menu[1].setSelfieConfirmed(true);
        if (menu[3].getSFX()) music.playSFX("button");
      }
    }
    if (game.data.saveFile.getRowCount() > 1) {
      if (menu[1].getSubMenu().equals("loadProfile") && menu[1].isSubMenu() && menu[1].isInside(width/2, 300, 150, 150)) {    
        menu[1].loadingProfile = true;
        menu[1].setSubMenu("createProfile");
        menu[1].setProfileName(data.getProfileName_2());
        menu[1].setNameIsReady(true);
        menu[1].setProfileSelfie(data.getImage_2());
        menu[1].setSelfieConfirmed(true);
        if (menu[3].getSFX()) music.playSFX("button");
      }
    }
    if (game.data.saveFile.getRowCount() > 2) {
      if (menu[1].getSubMenu().equals("loadProfile") && menu[1].isSubMenu() && menu[1].isInside(5*width/6, 300, 150, 150)) { 
        menu[1].loadingProfile = true;
        menu[1].setSubMenu("createProfile");
        menu[1].setProfileName(data.getProfileName_3());
        menu[1].setNameIsReady(true);
        menu[1].setProfileSelfie(data.getImage_3());
        menu[1].setSelfieConfirmed(true);
        if (menu[3].getSFX()) music.playSFX("button");
      }
    }
  }

  int timer_selectImage = 0;
  int timer_selectMode = 0;

  // ######################################################################################################################################################################### //
  // *************************************************************           KEY PRESSED FUNCTIONALITY           ************************************************************* //
  // ######################################################################################################################################################################### //
  public void key_INTERFACE(char KEY) {  
    if (player.isPlaying()) {
      if (KEY == ' ') fifteenPuzzle.shuffle();
      if (KEY == 's' || KEY == 'S') fifteenPuzzle.showInitialState();
    }
  }
}
