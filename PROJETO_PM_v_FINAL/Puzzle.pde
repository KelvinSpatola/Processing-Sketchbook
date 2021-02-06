public interface Gameplay {
  public abstract void buildPuzzle();
  public abstract void shuffle();
  public abstract void swap(int row, int col);
  public abstract String emptyLocation(int row, int col);
  public abstract void run();
  public abstract boolean isCompleted();
}
////***************************//***************************//***************************//***************************
final class Puzzle implements Gameplay {
  private PImage source, frame, background, temp, lost;

  private float micSound;

  private int rows, cols;
  private int numMoves, maxMoves, shuffleMoves; 
  private int count, increment, timer, inc;
  private int saveTimer, firstShotTimer;

  private boolean animation;
  private boolean gameOver;
  private boolean applyEffect, expand;
  private boolean saveImage;
  private boolean sfx, clicked;
  private boolean startShuffle;

  private String gameMode;
  private String[] file;

  private int[][] correctOrder;
  private String[] pathTaken, returningPath;
  private ArrayList <String> myPath = new ArrayList();

  private Piece[][] piece;
  private Piece[][] initialState;
  private Clock clock;

  // CONSTRUTOR
  public Puzzle(int num, PImage source, int min, int sec) {
    game.status = false;
    file = loadStrings("data/Menu Files/Saved Files/Puzzle Files/saveFile3.txt");

    this.shuffleMoves = int(file[0]);

    if (game.menu[1].getGrid() == 3) this.maxMoves = int(file[1]);
    else if (game.menu[1].getGrid() == 4) this.maxMoves = int(file[2]);
    else if (game.menu[1].getGrid() == 5) this.maxMoves = int(file[3]);

    this.rows = num;
    this.cols = num;
    this.correctOrder = new int[rows][cols];
    this.piece = new Piece[rows][cols];
    this.initialState = new Piece[rows][cols];

    this.source = source;
    source.resize(width, height);
    this.frame = loadImage("data/Menu Files/Images/gameFrame.png");
    frame.resize(width, height);
    this.background = loadImage("data/Menu Files/Images/gameBackground.jpg");
    background.resize(width, height+90);
    this.lost = loadImage("data/Menu Files/Images/lost.png");
    lost.resize(width, height+90);

    this.pathTaken = new String[shuffleMoves];
    this.returningPath = new String[shuffleMoves];

    this.animation = false;
    this.increment = 15;

    clock  =  new Clock();
    clock.setClock(min, sec);
    clock.start();

    shuffle();
  }
  public void setGrid(int rows, int cols ) {
    this.correctOrder = new int[rows][cols];
    this.piece = new Piece[rows][cols];
    this.initialState = new Piece[rows][cols];
  }
  public int getShuffleMoves() {
    return this.shuffleMoves;
  }
  public void setShuffleMoves(int num) {
    this.shuffleMoves = num;
  }
  public int getRows() {
    return this.rows;
  }
  public int getCols() {
    return this.cols;
  }
  public int getNumMoves() {
    return this.numMoves;
  }
  public void setSFX(boolean state) {
    this.sfx = state;
  }
  public void buildPuzzle() {
    int pieceIndex = 0;
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {   
        int x = j*width/cols;
        int y = 0;
        if (count == 0) {
          y = i*height/rows;
          temp = source.get(x, y, width/cols, height/rows);
        } else {
          y = i*(height-90)/rows;
          temp = source.get(x, y, width/cols, (height-90)/rows);
        }

        boolean exist = true;
        if (i==rows-1 && j==cols-1) exist = false;

        correctOrder[i][j] = pieceIndex;
        piece[i][j] = new Piece(temp, x, y, pieceIndex++, exist);
      }
    }
    count++;
  }

  public void shuffle() {  
    // A primeira tarefa a ser feita neste método é construir todo o puzzle recorrendo ao método «buildPuzzle()».
    // De seguida, é feito uma serie de sorteios que definirão que direção o lugar vazio do puzzle irá tomar em cada movimento "imaginário".
    // É preciso ressaltar que se faz sempre uma avaliação que valida se a direção sorteada é uma direção válida, relativamente à posição 
    // atual do lugar vazio. Equanto a direção sorteada for inválida, o sorteador sorteará uma nova direção até que cumpra os requisitos da avaliação
    // e prossiga nas tarefas seguintes.
    buildPuzzle();
    myPath.clear();
    numMoves = 0;
    clock.restart();
    clock.start();


    int fakeMove = 0; // número de movimentos imaginários
    int currentRow = rows-1; // linha atual do lugar vazio do puzzle
    int currentCol = cols-1; // coluna atual do lugar vazio do puzzle
    PVector inc = new PVector();
    String direction = "", previousDirection = "";
    boolean out_of_the_edge, wrongMove; 

    while (fakeMove < shuffleMoves) {
      // *********************************************** SORTEADOR *********************************************** //
      do {                                                                                                         //
        previousDirection = oppositeDirection(direction);
        //                                                                                                         //
        int raffle = int(random(4));                                                                               //
        if (raffle == 0) direction = "up";                                                                         //
        if (raffle == 1) direction = "down";                                                                       //
        if (raffle == 2) direction = "left";                                                                       //
        if (raffle == 3) direction = "right";                                                                      // 
        //                                                                                                         //
        if (currentRow == 0  && direction == "up" || currentRow == (rows-1) && direction == "down"                 //
          || currentCol == 0 && direction == "left"|| currentCol == (cols-1)  && direction == "right") {           //
          out_of_the_edge = true;                                                                                  //
          direction = oppositeDirection(direction);                                                                //
        } else out_of_the_edge = false;                                                                            //
        //                                                                                                         //        
        if (direction.equals(previousDirection)) {                                                                 //
          wrongMove = true;                                                                                        // 
          direction = oppositeDirection(direction);                                                                //
        } else {                                                                                                   //
          wrongMove = false;                                                                                       //
        }                                                                                                          //
        //                                                                                                         //
      } while (out_of_the_edge || wrongMove);                                                                      //
      // ********************************************************************************************************* //

      // Guardando o registo de todos os movimentos (válidos) feitos pelo sorteador num array de Strings. 
      pathTaken[fakeMove] = direction;
      returningPath[(shuffleMoves-1)-fakeMove] = oppositeDirection(direction);

      // definindo os incrementos que depois modificarão o valor das variáveis «currentRow» e «currentCol», relativas a posição do lugar vazio no puzzle
      if (direction.equals("up")) inc.set(0, -1);
      if (direction.equals("down")) inc.set(0, 1);
      if (direction.equals("left")) inc.set(-1, 0);
      if (direction.equals("right")) inc.set(1, 0);

      // fazendo as trocas de imagem
      PImage tempImage = piece[currentRow + int(inc.y)][currentCol + int(inc.x)].getImage();
      piece[currentRow + int(inc.y)][currentCol + int(inc.x)].setImage(piece[currentRow][currentCol].getImage());  
      piece[currentRow][currentCol].setImage(tempImage); 

      // fazendo as trocas do index de cada peça
      int tempIndex = piece[currentRow + int(inc.y)][currentCol+ int(inc.x)].getIndex();
      piece[currentRow + int(inc.y)][currentCol + int(inc.x)].setIndex(piece[currentRow][currentCol].getIndex());
      piece[currentRow][currentCol].setIndex(tempIndex);

      // fazendo as trocas do estado exist, entre as peças
      piece[currentRow][currentCol].setExist(true);
      piece[currentRow + int(inc.y)][currentCol + int(inc.x)].setExist(false);  

      // atualizando «currentRow» e «currentCol»
      currentRow += int(inc.y);
      currentCol += int(inc.x);

      // atualizando o número de movimentos imagiários
      fakeMove++;
    } 
    println("\n\n======= TAKE THIS PATH =======");                                             //
    for (int i = 0; i < returningPath.length; i++) print("|"+i+". "+returningPath[i]+" ");     //   
    // *************************************************************************************** //
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {
        initialState[i][j] = piece[i][j].copy();
      }
    }
    firstShotTimer = 0;
  }
  // ************************************* SWAP FUNCTIONS ************************************* //
  public void swap(int row, int col) {
    clicked = true;
    applyEffect = true;
    boolean write = false;
    String path = "";
    PVector inc = new PVector(); 
    if (emptyLocation(row, col).equals("above")) {
      path = "above";
      inc.set(0, -1);
    } else if (emptyLocation(row, col).equals("below")) {
      path = "below";
      inc.set(0, 1);
    } else if (emptyLocation(row, col).equals("left")) {
      path = "left";
      inc.set(-1, 0);
    } else if (emptyLocation(row, col).equals("right")) {
      path = "right";
      inc.set(1, 0);
    } else {
      path = "";
      return;
    }

    PImage tempImage = piece[row][col].getImage(); //tempImage
    int tempIndex = piece[row][col].getIndex(); //tempIndex

    if (applyEffect) {
      if (piece[row][col].size < 0) {
        piece[row + int(inc.y)][col + int(inc.x)].setImage(tempImage);
        piece[row + int(inc.y)][col + int(inc.x)].setIndex(tempIndex);
        piece[row][col].setExist(false);  
        expand = true;
      } else {
        if (expand) piece[row][col].size += increment;
        else {
          piece[row][col].rotate = true;
          piece[row][col].size -= increment;
        }
      }
      if (expand) {
        if (piece[row][col].size >= piece[row][col].img.width) {
          piece[row][col].size += 0;
          piece[row][col].rotate = false;
          piece[row][col].setSize(piece[row][col].img.width);

          piece[row + int(inc.y)][col + int(inc.x)].setExist(true);

          expand = false;
          applyEffect = false;
          write = true;

          game.music.playSFX("swap");
          numMoves++;
        } else {
          piece[row][col].size += increment;
        }
      }
    }
    if (write) {
      myPath.add(oppositeDirection(path));
      saveImage = true;
      write = false;
    }
    clicked = false;
  }
  // ************************************* CHECK EMPTY SPACE LOCATION ************************************* //
  public String emptyLocation(int row, int col) {
    String side = "";
    //#################################### FIRST ROW ####################################//
    if (row == 0) {  // for the first row...
      if (col == 0) {  // it checks if we've clicked on the first column of the first row
        if (piece[row][col+1].getExist() == false) side = "right";
        if (piece[row+1][col].getExist() == false) side = "below";
      } else if (col == cols-1) {  // it checks if we've clicked on the last column of the first row
        if (piece[row][col-1].getExist() == false) side = "left";
        if (piece[row+1][col].getExist() == false) side = "below";
      } else {  // it checks all the other positions of the first row, between the first and the last columns
        if (piece[row+1][col].getExist() == false) side = "below";
        if (piece[row][col-1].getExist() == false) side = "left";
        if (piece[row][col+1].getExist() == false) side = "right";
      }
    }
    //#################################### LAST ROW ####################################//
    else if (row == rows-1) {  // for the last row...
      if (col == 0) {  // it checks if we've clicked on the first column of the last row
        if (piece[row][col+1].getExist() == false) side = "right";
        if (piece[row-1][col].getExist() == false) side = "above";
      } else if (col == cols-1) {  // it checks if we've clicked on the last column of the last row
        if (piece[row][col-1].getExist() == false) side = "left";
        if (piece[row-1][col].getExist() == false) side = "above";
      } else {  // it checks all the other positions of the last row, between the first and the last columns
        if (piece[row-1][col].getExist() == false) side = "above";
        if (piece[row][col-1].getExist() == false) side = "left";
        if (piece[row][col+1].getExist() == false) side = "right";
      }
    }
    //#################################### FIRST COLUMN ####################################//
    else if (col == 0) {  // for the first column...
      if (piece[row-1][col].getExist() == false)side = "above";
      if (piece[row+1][col].getExist() == false)side = "below";
      if (piece[row][col+1].getExist() == false)side = "right";
    } 
    //#################################### LAST COLUMN ####################################//
    else if (col == cols-1) {  // for the last column...
      if (piece[row-1][col].getExist() == false) side = "above";
      if (piece[row+1][col].getExist() == false) side = "below";
      if (piece[row][col-1].getExist() == false) side = "left";
    }
    //################################# ALL OTHER POSITIONS #################################//
    else {
      if (piece[row-1][col].getExist() == false) side = "above";
      if (piece[row+1][col].getExist() == false) side = "below";
      if (piece[row][col-1].getExist() == false) side = "left";
      if (piece[row][col+1].getExist() == false) side = "right";
    }
    if (side.equals("")) side = "nothing";
    return side;
  }
  private String oppositeDirection(String direction) {
    String opposite = "";
    if (direction.equals("up") || direction.equals("above")) opposite =  "down";                                            
    if (direction.equals("down") || direction.equals("below")) opposite = "up";                                       
    if (direction.equals("left")) opposite = "right";                                    
    if (direction.equals("right")) opposite = "left";                                    
    return opposite;
  }
  void showInitialState() {
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {
        initialState[i][j].display();
      }
    }
  }

  boolean isCompleted() {
    int numCorrectPieces = 0;
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {
        if (piece[i][j].getIndex() == correctOrder[i][j]) numCorrectPieces++;
      }
    }
    return numCorrectPieces == (rows*cols)-1;
  }

  boolean stop;

  public void animation() {
    String win = "PUZZLE\nSOLVED";
    String lose = "GAME\nOVER";
    timer += 1;
    if (isCompleted() && stop == false) {
      stop = true;
      game.music.playSFX("clapping");
    }

    if (gameOver && stop == false) {
      stop = true;
      game.music.playSFX("boo");
      game.end.eraseImgeFolder();
    }

    image(isCompleted()? source : lost, 0, 0, width, height-90);

    if (timer > 50) inc++; 
    if (timer > 200) noFill();

    rectMode(CORNER);  
    fill(255, 255-inc*4);
    rect(0, 0, width, height);

    fill(0, 255-timer*4);
    textAlign(CENTER);
    textSize(100);
    text(isCompleted()? win : lose, width/2, height/2-100);

    if (timer > 300) {
      if (!gameOver) animation = true;
      else {
        game.data.getREPORT();
        reset();
        inc = 0;
        timer = 0; 
        stop = false;
      }
    }
  }

  public void reset() {
    gameOver = false;

    println("======= YOUR MOVES =======");
    printArray(myPath);

    myPath.clear();
    shuffle();
    numMoves = 0;
    clock.restart();
    clock.start();
  }

  public void timeTrial() {
    clock.run();
    if (clock.getSeconds() == 0 && clock.getMinutes() == 0 ) gameOver = true;
    if (isCompleted()) clock.stop();
  }

  public void limitedMoves() {
    if (numMoves == maxMoves) gameOver = true;
  }
  public void setGameMode(String mode) {
    this.gameMode = mode;
  }

  public void gameMode(String mode) {
    if (mode.equals("timeTrial")) timeTrial();
    else if (mode.equals("limitedMoves")) limitedMoves();
  }

  public void run() {

    if (isCompleted() == false) surface.setSize(600, 690);
    surface.setTitle("FIFTEEN PUZZLE |                                                 Classic Mode");
    firstShotTimer++;
    imageMode(CORNER);
    tint(160);
    image(background, 0, 0);
    tint(255); 

    if (isCompleted() || gameOver) {
      animation();
    } else {
      for (int i = 0; i<rows; i++) {
        for (int j = 0; j<cols; j++) {
          piece[i][j].display();
        }
      }
    }
    if (firstShotTimer == 5) {
      save("data/Menu Files/Saved Files/Puzzle Files/Video/img_"+0+".jpg");
    }

    swap(game.num[0], game.num[1]);

    if (saveImage) {
      saveTimer ++;
      if (saveTimer > 5) {
        save("data/Menu Files/Saved Files/Puzzle Files/Video/img_"+numMoves+".jpg");
        saveImage = false;
        saveTimer = 0;
      }
    }

    imageMode(CORNER);
    image(frame, 0, 0);
    gameMode(gameMode);

    micSound = amp.analyze()*1000;
    if (game.music.sound[10].isPlaying() == false && !isCompleted() && !gameOver && micSound > 250) startShuffle = true;

    if (startShuffle) {
      if (frameCount%5 == 0) {
        shuffle();
        num ++;
      }
      if (num > 10) {
        startShuffle = false;
        num = 0;
      }
    }
  }
}
int num = 0;
