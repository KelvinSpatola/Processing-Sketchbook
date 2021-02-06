public interface MenuActions {
  public abstract void buttom(float x, float y, PImage normal, PImage highlight, float xoff2);
  public abstract boolean isInside(float x, float y, float w, float h);
  public abstract void display();
  public abstract void run();
}

////***************************//***************************//***************************//***************************
abstract class Menu implements MenuActions {
  protected PImage[] image, source;
  protected boolean state;
  protected boolean isSubMenu;
  protected String subMenu;
  protected boolean inputNameBox;
  protected boolean takePicture;
  protected boolean playerConfirmed;
  protected boolean saveImage;
  protected boolean clicked_1, clicked_2, nameIsReady;
  protected boolean modeSelected;
  protected String gameMode;
  protected String profileName;
  protected PImage selfie;
  protected PImage puzzleImage;
  protected boolean selfieConfirmed;
  protected boolean gridConfirmed;
  protected boolean imageConfirmed;
  protected boolean disableButtom;
  protected boolean disableTimeTrial, disableLimitedMoves, disableClassic;
  protected boolean loadingProfile;

  protected int btnTxtSize;
  protected int x = width;
  protected int h = 385;  
  protected int h2 = 410;
  protected int grid, value, min, sec;

  protected PFont myFont = createFont("Montserrat Bold", 30);


  // CONTRUTOR
  public Menu () {
    this.state = false;
    this.subMenu = "";
    this.isSubMenu = false;
    this.inputNameBox = false;
    this.takePicture = false;
    this.saveImage = false;
    this.clicked_1 = true;
    this.clicked_2 = true;
    disableTimeTrial = true; 
    disableLimitedMoves = true; 
    disableClassic = true;
    btnTxtSize = 50;
    textFont(myFont);
  }
  public void display() {
  }

  public void setSeconds(int sec) {
    this.sec = sec;
  }
  public void setMinutes(int min) {
    this.min = min;
  }
  public int getSeconds() {
    return this.sec;
  }
  public int getMinutes() {
    return this.min;
  }
  public void setImageConfirmed(boolean state) {
    this.imageConfirmed = state;
  }
  public void setPuzzleImage(PImage img) {
    this.puzzleImage = img;
  }
  public PImage getPuzzleImage() {
    return this.puzzleImage;
  }
  public void setGridConfirmed(boolean state) {
    this.gridConfirmed = state;
  }
  public void setGrid(int num) {
    this.grid = num;
  }
  public int getGrid() {
    return this.grid;
  }
  public void setGameMode(String mode) {
    this.gameMode = mode;
  }
  public String getGameMode() {
    return this.gameMode;
  }
  public void setProfileSelfie(PImage selfie) {
    this.selfie = selfie;
  }
  public PImage getProfileSelfie() {
    return this.selfie;
  }
  public void setSelfieConfirmed(boolean confirmation) {
    this.selfieConfirmed = confirmation;
  }
  public void setPlayerIsConfirmed(boolean confirmation) {
    this.playerConfirmed = confirmation;
  }
  public boolean playerIsConfirmed() {
    return this.playerConfirmed;
  }
  public void setProfileName(String name) {
    this.profileName = name;
  }
  public String getProfileName() {
    return this.profileName;
  }
  public void setInputNameBox(boolean state) {
    this.inputNameBox = state;
  }
  public boolean nameIsReady() {
    return this.nameIsReady;
  }
  public void setNameIsReady(boolean nameIsReady) {
    this.nameIsReady = nameIsReady;
  }
  public void setTakePicture(boolean state) {
    this.takePicture = state;
  }
  public boolean isSubMenu() {
    return this.isSubMenu;
  }
  public void setSubMenu(boolean isSubMenu) {
    this.isSubMenu = isSubMenu;
  }
  public String getSubMenu() {
    return this.subMenu;
  }
  public void setSubMenu(String subMenu) {
    this.subMenu = subMenu;
  }
  public void swapClickedSFX() {
    this.clicked_1 = !clicked_1;
  }
  public void swapClickedMusic() {
    this.clicked_2 = !clicked_2;
  }
  public boolean getSFX() {
    return this.clicked_1;
  }
  public boolean getMusic() {
    return this.clicked_2;
  }
  public boolean getState() {
    return this.state;
  }
  public void setState(boolean state) {
    this.state = state;
  }
  public boolean isInside(float x, float y, float w, float h) {
    return (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2);
  }
  public void buttom(float x, float y, PImage original, PImage highlight, float xoff2) {
    pushMatrix();
    translate(x, y);    
    imageMode(CENTER);    
    image(isInside(x, y, 185, 73)? highlight : original, 0, 0);
    popMatrix();
  }
  public void textButtom(String text, float x, float y, int size, boolean state) {
    pushMatrix();
    translate(x, y);
    textMode(CENTER);
    textSize(size);
    fill(state && isInside(x+textWidth(text)/2, y-size/2, textWidth(text), size)? color(255) : color(0));
    text(text, 0, 0);
    popMatrix();
  }
  public void disableButton(String name) {
    if (name.equals("classicMode")) this.disableClassic = true;
    if (name.equals("timeTrial")) this.disableTimeTrial = true;
    if (name.equals("limitedMoves")) this.disableLimitedMoves = true;
  }
  public void run() {
    display();
  }
}
