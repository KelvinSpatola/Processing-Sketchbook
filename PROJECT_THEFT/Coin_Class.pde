class Coin {
  PImage brassCoin, silverCoin, goldenCoin;
  float  h, w, speedRotation;
  float coinValue;
  PVector location, velocity;
  float difference;
  float inc;

  //########################################## COINS ##########################################//
  Coin() {
    brassCoin = loadImage("BrassCoin.png");
    silverCoin = loadImage("SilverCoin.png");
    goldenCoin = loadImage("GoldenCoin.png");
    collectCoin = myMinim.loadFile("sounds/GetItem.mp3");
    h = 40;
    w = h/2;
    coinValue = 4;
    speedRotation = 0.5;
    inc=3;
    location = new PVector(width/2, height/2);
    velocity = new PVector(round(random(-inc, inc)), round(random(-inc, inc)));
  }
  void spin(int index) {          //************* SPIN MOVEMENT ****************
    if (index%2 == 0) {
      w += speedRotation;
    } else {
      w -= speedRotation;
    }  
    if (w < 0 || w > h) {
      speedRotation = -speedRotation;
    }
  }
  void disappear() {             //************* PLAYER COLLECTED COIN ****************
    w = 0;    
    h = 0;
    location.x = 0;
    location.y = 0;
  }
  boolean isGone() {
    return (w <= 0);
  }
  void passesValue() {          //************* COIN GIVES POINTS TO PLAYER ****************
    player.value += coinValue;
    collectCoin.play();
  }
  void movement() {                 //************* COIN MOVEMENT IN LATER LEVELS ****************
    location.add(velocity);
  }
  void restriction() {              //************* COIN BOUNCES ON BORDERS ****************
    if (location.x >= width - h/2 || location.x <= h/2) { 
      velocity.x = -velocity.x;
    }
    if (location.y >= height - h/2 -80 || location.y <= h/2 +40) {
      velocity.y = -velocity.y;
    }
  }
  void displayGold() {
    imageMode(CENTER);
    tint(255);
    image(goldenCoin, location.x, location.y, w, h);
  }
  void displaySilver() {
    imageMode(CENTER);
    tint(255);
    image(silverCoin, location.x, location.y, w, h);
  }
  void displayBronze() {
    imageMode(CENTER);
    tint(255);
    image(brassCoin, location.x, location.y, w, h);
  }
  void resetStatus() {          //************* COINS RESET ****************
    h = 40;
    w = h/2;
    coinsLocation();
    coinsValues();
  }
  void coinsLocation() {
    switch (levelIndex) {  
    case 1:
      coins[0].location.set(160, 140);
      coins[1].location.set(560, 560);
      coins[2].location.set(540, 140);
      coins[3].location.set(140, 560);
      coins[4].location.set(420, 420);     
      coins[5].location.set(420, 280);
      coins[6].location.set(280, 420);
      coins[7].location.set(280, 280); 
      coins[8].location.set(230, 350);
      coins[9].location.set(470, 350);
      break; 
    case 2:
      coins[0].location.set(350, 140);
      coins[1].location.set(350, 560);
      coins[2].location.set(272, 254);
      coins[3].location.set(140, 350);
      coins[4].location.set(200, 100);     
      coins[5].location.set(350, 500);
      coins[6].location.set(350, 200);
      coins[7].location.set(500, 100); 
      coins[8].location.set(272, 400);
      coins[9].location.set(400, 350);
      break; 
    case 3:
      coins[0].location.set(100, 100);
      coins[1].location.set(550, 100);
      coins[2].location.set(100, 550);
      coins[3].location.set(550, 550);
      coins[4].location.set(100, 250);     
      coins[5].location.set(100, 400);
      coins[6].location.set(250, 100);
      coins[7].location.set(400, 100); 
      coins[8].location.set(550, 250);
      coins[9].location.set(550, 400);
      break; 
    case 4:
      coins[0].location.set(100, 100); 
      coins[1].location.set(550, 100);
      coins[2].location.set(100, 550);
      coins[3].location.set(550, 550);
      coins[4].location.set(100, 250);     
      coins[5].location.set(100, 400);
      coins[6].location.set(250, 100);
      coins[7].location.set(400, 100); 
      coins[8].location.set(550, 250);
      coins[9].location.set(550, 400);
      break; 
    case 5:                                  
      coins[0].location.set(100, 100);
      coins[1].location.set(550, 100);
      coins[2].location.set(100, 550);
      coins[3].location.set(550, 550);
      coins[4].location.set(100, 250);     
      coins[5].location.set(100, 400);
      coins[6].location.set(250, 100);
      coins[7].location.set(400, 100); 
      coins[8].location.set(550, 250);
      coins[9].location.set(550, 400);
      break;
    }
  }
  void coinsValues() {
    for (int i = 0; i<coins.length; i++) {
      switch (i) {
      case 0:    //************* GOLD COIN VALUE RESET ************//
        coins[0].coinValue = 25;
        break;
      case 1:   
        coins[1].coinValue = 25;
        break;
      case 4:    //************* SILVER COIN VALUE RESET ************//     
        coins[4].coinValue = 10;
        break;
      case 5:         
        coins[5].coinValue = 10;
        break;
      case 6:  
        coins[6].coinValue = 10;
        break;
      default:  //************* BRONZE COIN VALUE RESET ************//
        coins[i].coinValue = 4;
        break;
      }
      //switch (i) {
      //case 0: case 1:   //************* GOLD COIN VALUE RESET ************//
      //  coins[1].coinValue = 25;
      //  break;
      //case 4: case 5: case 6:  //************* SILVER COIN VALUE RESET ************//
      //  coins[6].coinValue = 10;
      //  break;
      //default:  //************* BRONZE COIN VALUE RESET ************//
      //  coins[i].coinValue = 4;
      //  break;
      //}
    }
  }
}