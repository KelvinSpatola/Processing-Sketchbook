
GameSystem system;
Player player;
ArrayList<Entity> walls= new ArrayList();

PImage fundo;

void setup() {
  //size(1000, 500);
  size(850, 708);
  //size(683, 384); // fullScreen()/2
  //fullScreen();

  fundo = loadImage("top-down_map.png");
  fundo.resize(width, height);

  system = new GameSystem();
  //player = new Player(50, 50, 50, 50, 7, 7);
  player = new Player(50, 50, 15, 15, 3, 3);
  system.setEntitiesLocation("top-down_map3.png", walls, 0xFFFFFFFF);
  println(walls.size());
}

void draw() {
  background(fundo);

  for (Entity w : walls) {
    fill(player.touch(w) ? color(255, 0, 0, 100) : color(255, 100));
    w.display();
  } 

  player.display();

  system.update(player, walls);

  if (player.location.x < 50 && player.location.y > height) {
    fill(255, 0, 0);
    rectMode(CORNER);
    rect(0, 0, width, height);
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("WINNER", width/2, height/2);
  }
  //println((int)frameRate);
}
void keyPressed() {
  system.setMove(key, true);
}
void keyReleased() {
  system.setMove(key, false);
}
