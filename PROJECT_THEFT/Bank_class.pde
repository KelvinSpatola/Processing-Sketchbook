class Bank {
  PImage bankLocked, bankUnlocked, diamond; 
  float bank_x, bank_y, bank_w, bank_h;
  float diamond_x, diamond_y, diamond_w, diamond_h;
  boolean isLocked, gotStolen;

  //************* BANK WITH DIAMOND ****************
  Bank() {
    bankLocked = loadImage("BankLocked.png");
    bankUnlocked = loadImage("BankUnlocked.png");
    diamond = loadImage("Diamond.png");
    bank_w = 100;
    bank_h = (bank_w*87.35)/100;
    diamond_w = 45;
    diamond_h = (diamond_w*87.35)/100;
    isLocked = true;
    gotStolen = false;
  }
  void location(float x, float y) {
    bank_x = x;
    bank_y = y;
    diamond_x = x;
    diamond_y = y;
  }
  boolean diamondStolen() {
    float d = dist(diamond_x, diamond_y, player.x, player.y);
    return (isLocked == false && d <= diamond_w/2+player.size/2);
  }
  void resetStatus() {                      //************* CLOSE BANK ****************
    isLocked = true;
    gotStolen = false;
    collectionDiamond.rewind();
  }
  void display() {
    imageMode(CENTER);
    image(isLocked ? bankLocked : bankUnlocked, bank_x, bank_y, bank_w, bank_h);
    if (isLocked == false && gotStolen == false) {         //************* DIAMOND APPEARS ONLY IF BANK OPENS ****************
      image(diamond, diamond_x, diamond_y+15, diamond_w, diamond_h);
    }
  }
}