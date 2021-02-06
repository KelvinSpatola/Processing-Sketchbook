import kelvinclark.utils.SpriteSheet;

static final int GOLDEN = 0;
static final int SILVER = 1;
static final int BRASS = 2;

int totalCoins = 10, totalObjects = 0;

PApplet parent;

GameMap map;
Player thief;
ArrayList <Coin> coins;
//GameObject[] obj = new GameObject[totalObjects];

void setup() {
  size(800, 500);
  //fullScreen(P2D);
  
  parent = this;
 
  map = new GameMap("world_map_a.jpg");
  thief = new Player(150, 5, DOWN);

  map.deploy(thief, -3000, -1000, 60, 60);
  thief.facing(RIGHT);

  thread("loadGameObjects");
}

void draw() {
  background(255);

  if (load) loadingBar();
  else {
  map.displayMap();

  for (int i = 0; i < coins.size(); i++) {
    coins.get(i).run();
    coins.get(i).borderRestriction(map.getLeftSide(), map.getRightSide(), map.getUpperSide(), map.getLowerSide());

    if (thief.intersects(coins.get(i))) { 
      coins.get(i).collected();
      coins.get(i).isMoving(false);
    }
    if (coins.get(i).disappeared()) coins.remove(i);

    if (keyPressed && key == 't') {
      stroke(0);
      line(thief.location.x, thief.location.y, coins.get(i).location.x, coins.get(i).location.y);
    }
  }

  //for (GameObject o : obj) {
  //  fill(o.contains(thief) ? color(255, 0, 0) : color(255));
  //  o.display();
  //}

  thief.display();
  thief.update();

  //println(coins.size());
  //println(thief.speed);
  println((int)frameRate);
  }
}

void keyPressed() {
  thief.setMove(key, true);

  if (key == 'm') {
    for (Coin c : coins) {
      c.setVelocity((int)random(-5, 5), (int)random(-5, 5));
      c.isMoving(true);
    }
  }
  if (key == 'p') for (Coin c : coins) c.isSpinning(false);
  if (key == 'o') for (Coin c : coins) c.isSpinning(true);
  if (key == 'r') map.deploy(thief, random(map.left_side, map.right_side), random(map.top, map.bottom), random(width), random(height));

}
void keyReleased() {
  thief.setMove(key, false);
}


boolean load;
int bar_X;

void loadGameObjects() {
  load = true;

  coins = new ArrayList();
  for (int i = 0; i < totalCoins; i++) {
    int x = (int)random(-map.WIDTH/2, map.WIDTH/2);
    int y = (int)random(-map.HEIGHT/2, map.HEIGHT/2);
    coins.add(new Coin((int)random(3), 50));
    map.deploy(coins.get(i), x, y);
    bar_X++;
  }

  //for (int i = 0; i < obj.length; i++) {
  //  obj[i] = new GameObject((int)random(100, 600), (int)random(100, 300));
  //  int x = (int)random(-map.WIDTH/2, map.WIDTH/2);
  //  int y = (int)random(-map.HEIGHT/2, map.HEIGHT/2);
  //  map.deploy(obj[i], 0, -400);
  //  bar_X++;
  //}

  load = false;
}
void loadingBar() {
  background(0);
  noFill();
  stroke(#E3F766);
  rect(width/3, height/2, width/3, 20);
  fill(#E3F766);
  rect(width/3, height/2, map(bar_X, 0, totalCoins + totalObjects, 0, width/3), 20);
  text("Loading data", width/2-38, height/2-10);
}
