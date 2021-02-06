
Tile[] tiles = new Tile[1000];
PImage srcImg;

void setup() {
  fullScreen(P2D);
  srcImg = loadImage("brasil.jpg");
  srcImg.resize(width, height);

  int size;
  for (int i = 0; i < tiles.length; i++) {
    if (i < tiles.length/6 || i > tiles.length*0.6 && i < (2*tiles.length)/3) size = (int)random(15, 50);
    else size = (int)random(50, 150);

    float x = random(size, width-size);
    float y = random(size, height-size);

    float distance = map(i, 0, tiles.length-1, 2, 15);

    tiles[i] = new Tile(x, y, size, (int)random(50, 200), (int)random(-5, 5), (int)random(-5, 5), distance, i);
  }
  tiles[tiles.length-1] = new Tile(width/2-100, height/2-100, 300, 100, 5, -3, 8, tiles.length-1);

  noCursor();
  rectMode(CENTER);
  background(0);
}

void draw() {
background(0);

  for (int i = 0; i < tiles.length; i++) {
    tiles[i].render();
    tiles[i].update();
  }
  fps();
}

void fps() {
  push();
  textSize(50);
  fill(#FF0000);
  text((int)frameRate, 50, 50);
  pop();
}
