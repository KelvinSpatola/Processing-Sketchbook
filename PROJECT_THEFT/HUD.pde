class HUD {
  float l;
  color col;

  HUD() {
    l = 80;
    col = color(0);
  }
  void display() {
    rectMode(CORNER);
    textFont(menu.menuFont);
    strokeWeight(2);
    stroke(255);
    fill(0);
    rect(0, height-l, width, l);

    textSize(25);
    fill(menu.disableOption2 ? 0 : 255);
    text(menu.continueGame && menu.finishing ? loadedName : playerName, width/5, height-30);
    text("Level " +levelIndex, width/2-width/5, height-30);
    text("Points "+player.value, width-2*(width/5), height-30);
  }
}
