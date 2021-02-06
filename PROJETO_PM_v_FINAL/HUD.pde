 class HUD {
  private PImage image, profilePic;
  private String playerName;

  HUD(String playerName, PImage profilePic) {
    game.status = false;
    image  = loadImage("data/Menu Files/Images/HUD_0.png");
    image.resize(600, 100);
    this.playerName = playerName;
    this.profilePic = profilePic;
    profilePic.resize(75, 75);
  }

  public void display(String mode) {
    if (mode.equals("classicMode")) classic();
    else if (mode.equals("timeTrial")) timeTrial();
    else if (mode.equals("limitedMoves")) limitedMoves();
  }
  public void classic() {
    imageMode(CORNER);
    image(image, 0, 590);
    textAlign(CORNER);
    textSize(20);
    fill(0);
    text(playerName, 105, 646);
    textAlign(CENTER);
    textSize(12);
    text("Classic Mode", 307, 671);
    textSize(20);
    text("Moves: "+game.fifteenPuzzle.getNumMoves(), 478, 656);
    image(profilePic, 15, 609);
  }
  public void timeTrial() {
    imageMode(CORNER);
    image(image, 0, 590);
    textAlign(CORNER);
    textSize(20);
    fill(0);
    text(playerName, 105, 646);
    textAlign(CENTER);
    textSize(12);
    text("Time Trial", 307, 671);
    textSize(20);
    game.fifteenPuzzle.clock.displayClock(478, 656, 30, color(0));
    image(profilePic, 15, 609);
  }  
  public void limitedMoves() {
    imageMode(CORNER);
    image(image, 0, 590);
    textAlign(CORNER);
    textSize(20);
    fill(0);
    text(playerName, 105, 646);
    textAlign(CENTER);
    textSize(12);
    text("Limited Moves", 307, 671);
    textSize(20);
    text(game.fifteenPuzzle.getNumMoves()+" / "+game.fifteenPuzzle.maxMoves, 478, 656);
    image(profilePic, 15, 609);
  }
}
