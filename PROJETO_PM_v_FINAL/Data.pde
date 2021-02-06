class Data {
  private Table saveFile;
  private TableRow row;
  private String[] saveFile2;

  private ArrayList<String> playerName = new ArrayList();
  private ArrayList<String> picturePath = new ArrayList();  
  private ArrayList lastPic = new ArrayList();
  private ArrayList<String> gameMode = new ArrayList(3);
  private ArrayList puzzleGrid = new ArrayList();
  private ArrayList numMoves = new ArrayList();
  private ArrayList<String> gameTime = new ArrayList();

  public boolean firstProfileExist, secondProfileExist, thirdProfileExist;
  public boolean profileFinalised;

  // CONSTRUTOR //
  public Data() {
    this.profileFinalised = false;

    this.saveFile = loadTable("data/Menu Files/Saved Files/saveFile.csv", "header"); // TABLE
    this.saveFile2 = loadStrings("data/Menu Files/Saved Files/saveFile2.txt"); // STRING[]

    if (saveFile.getRowCount() == 0) {// NÃO LÊ OS DADOS POR NÃO EXISTIR UMA ÚNICA LINHA GUARADA NA TABLE SAVEFILE
      firstProfileExist = false;
      secondProfileExist = false;      
      thirdProfileExist = false;
    } else if (saveFile.getRowCount() == 1) {// SOMENTE LÊ OS DADOS SE EXISTIR PELO UMA UMA LINHA DE DADOS GUARDADOS NA TABLE SAVEFILE
      firstProfileExist = true;
      secondProfileExist = false;      
      thirdProfileExist = false;
    } else if (saveFile.getRowCount() == 2) {
      firstProfileExist = true;
      secondProfileExist = true;      
      thirdProfileExist = false;
    } else {
      firstProfileExist = true;
      secondProfileExist = true;      
      thirdProfileExist = true;
    }

    for (int i = 0; i < saveFile.getRowCount(); i++) {
      row = saveFile.getRow(i);

      playerName.add(row.getString("PlayerName"));
      picturePath.add(row.getString("PlayerPicture"));
      lastPic.add(row.getInt("LastPic"));
      gameMode.add(row.getString("GameMode"));
      puzzleGrid.add(row.getInt("PuzzleGrid"));
      numMoves.add(row.getInt("NumMoves"));
      gameTime.add(row.getString("GameTime"));
    }
  }

  public void saveData(PImage selfie, String name, String path, int num1, String mode, int grid) {     
    game.temp2 = false;

    playerName.add(num1, name);
    picturePath.add(num1, path);
    lastPic.add(num1, num1);
    gameMode.add(num1, mode);
    puzzleGrid.add(num1, grid);

    selfie.save(picturePath.get(num1));

    if (saveFile.getRowCount() > 2) {  // força o swap dos elementos da Table quando o getRowCount() é maior que 3!
      saveFile.getRow(0).setString("PlayerName", playerName.get(1));
      saveFile.getRow(2).setString("PlayerPicture", picturePath.get(0));
      saveFile.getRow(0).setInt("LastPic", (int)lastPic.get(0)); 
      saveFile.getRow(0).setString("GameMode", gameMode.get(1)); 
      saveFile.getRow(0).setInt("PuzzleGrid", (int)puzzleGrid.get(1)); 

      saveFile.getRow(1).setString("PlayerName", playerName.get(2));
      saveFile.getRow(0).setString("PlayerPicture", picturePath.get(1));
      saveFile.getRow(1).setInt("LastPic", (int)lastPic.get(1)); 
      saveFile.getRow(1).setString("GameMode", gameMode.get(2)); 
      saveFile.getRow(1).setInt("PuzzleGrid", (int)puzzleGrid.get(2));

      saveFile.getRow(2).setString("PlayerName", playerName.get(3));
      saveFile.getRow(1).setString("PlayerPicture", picturePath.get(2));
      saveFile.getRow(2).setInt("LastPic", (int)lastPic.get(2));
      saveFile.getRow(2).setString("GameMode", gameMode.get(3));
      saveFile.getRow(2).setInt("PuzzleGrid", (int)puzzleGrid.get(3));
    } else {
      row = saveFile.addRow();
      row.setString("PlayerName", playerName.get(num1));
      row.setString("PlayerPicture", picturePath.get(num1));
      row.setInt("LastPic", (int)lastPic.get(num1));
      row.setString("GameMode", gameMode.get(num1));
      row.setInt("PuzzleGrid", (int)puzzleGrid.get(num1));
    }
    // ULTIMO PASSO DO MÉTODO SAVEDATA *** faz o save de toda a informação para dentro da Table file
    saveTable(saveFile, "data/Menu Files/Saved Files/saveFile.csv");
  }


  public void saveData(String profileName, String mode, int grid) {
    game.temp2 = false;

    String[] file = loadStrings("data/Menu Files/Saved Files/saveFile.csv");
    int rowNum = getRowNum(file, profileName);

    saveFile.getRow(rowNum-1).setString("GameMode", mode);
    saveFile.getRow(rowNum-1).setInt("PuzzleGrid", grid);

    saveTable(saveFile, "data/Menu Files/Saved Files/saveFile.csv");
  }

  String t = "";

  public void saveData(String profileName, int nMoves, String timer) {
    println("profileName: "+profileName+" | numMoves: "+nMoves+" | timer: "+timer);
    String[] file = loadStrings("data/Menu Files/Saved Files/saveFile.csv");
    int rowNum = getRowNum(file, profileName);

    saveFile.getRow(rowNum-1).setInt("NumMoves", nMoves);
    saveFile.getRow(rowNum-1).setString("GameTime", timer);

    saveTable(saveFile, "data/Menu Files/Saved Files/saveFile.csv");
    profileFinalised = true;
    t = timer;
  }

  public int getRowNum(String[] file, String nome) {
    int result = 0;
    for (int i = 1; i<file.length; i++) {
      String row = file[i];
      String[] elements = split(row, ",");

      for (int j = 0; j<elements.length; j++) {
        if (elements[j].equals(nome)) result = i;
      }
    }
    return result;
  }

  public ArrayList <String> get_Player(char letter) {
    ArrayList <String> result = new ArrayList();
    int num = 0;
    switch(letter) {
    case 'A':
      num = 0;
      break;
    case 'B':
      num = 1;
      break;
    case 'C':
      num = 2;
      break;
    }    
    result.add(playerName.get(num));
    result.add(picturePath.get(num));
    result.add(gameMode.get(num));
    result.add(puzzleGrid.get(num).toString());      
    result.add(numMoves.get(num).toString());
    result.add(gameTime.get(num));
    return result;
  }
  public int getLastPic() {
    return lastPic.size();
  }
  public PImage getImage_1() {
    return loadImage(picturePath.get(picturePath.size()-1));
  }
  public PImage getImage_2() {
    return loadImage(picturePath.get(picturePath.size()-2));
  }  
  public PImage getImage_3() {
    return loadImage(picturePath.get(picturePath.size()-3));
  }

  public String getProfileName_1() {   
    return playerName.get(playerName.size()-1);
  }
  public String getProfileName_2() {   
    return playerName.get(playerName.size()-2);
  }
  public String getProfileName_3() {   
    return playerName.get(playerName.size()-3);
  }

  public void getREPORT() {
    String result = "";
    if (game.fifteenPuzzle.isCompleted()) result = "#                     *.*.*.*.*.*.*.* !!! PUZZLE COMPLETED !!! *.*.*.*.*.*.*.*";
    if (game.fifteenPuzzle.gameOver) result = "#                        *.*.*.*.*.*.*.* !!! GAME OVER !!! *.*.*.*.*.*.*.*#";

    println("\n\n\n######################################################################################################");
    println("# ================================================================================================== #");
    println("#  REPORT            REPORT            REPORT            REPORT            REPORT            REPORT  #");
    println("# ================================================================================================== #");
    println("# ************************************************************************************************** #");
    println("#                             ************** PLAYER INFO **************                              #");
    println("# ************************************************************************************************** #");
    println("# Player name: "+playerName.get(playerName.size()-1));
    println("# Game mode selected: "+gameMode.get(gameMode.size()-1));
    println("# Grid selected: "+(int)puzzleGrid.get(puzzleGrid.size()-1));
    println("# ************************************************************************************************** #");
    println("#                            ************** SHUFFLE INFO **************                              #");
    println("# ************************************************************************************************** #");
    println("# Number of movements: "+game.fifteenPuzzle.getShuffleMoves());
    println("# Movements made by shuffling:");
    print("# [");
    print(game.fifteenPuzzle.pathTaken);    
    print("]");
    println("\n# Movements you should have taken:");
    print("# [");
    print(game.fifteenPuzzle.returningPath);
    print("]");
    println("\n# ************************************************************************************************** #");
    println("#                            ************** GAMEPLAY INFO **************                             #");
    println("# ************************************************************************************************** #");
    println(result);
    println("# Number of movements: "+game.fifteenPuzzle.getNumMoves());
    println("# Your time: "+game.fifteenPuzzle.clock.getTimer());
    println("# Movements made by you:");
    printArray(game.fifteenPuzzle.myPath);    
    println("# ================================================================================================== #");
    println("######################################################################################################");
    println("\n\n");
  }
}
