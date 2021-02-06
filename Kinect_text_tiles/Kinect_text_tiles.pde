import com.hamoid.*;
VideoExport videoExport;

Tile[] tiles = new Tile[250];
PImage srcImg, img2;

void setup() {
  fullScreen(P2D);
  //setupVideoExport("output\\output8.mp4", 60);

  srcImg = loadImage("kelvin.png");
  //srcImg.resize(width, height);
  img2 = loadImage("kelvin.png");
  img2.resize(width, height);

  int size;
  for (int i = 0; i < tiles.length; i++) {
    if (i < tiles.length/6 || i > tiles.length*0.6 && i < (2*tiles.length)/3) size = (int)random(15, 50);
    else size = (int)random(50, 150);

    float x = random(size, width-size);
    float y = random(size, height-size);
    tiles[i] = new Tile(x, y, size, (int)random(-5, 5), (int)random(-5, 5));
  }
  tiles[tiles.length-1] = new Tile(width/2-100, height/2-100, 300, 5, -3);

  noCursor();
  rectMode(CENTER);
  time = millis() / 1000;
}
int time;

void draw() {
  background(255); 
  //tint(190);
  image(img2, 0, 0);
  blendMode(SUBTRACT);

  for (int i = 0; i < tiles.length; i++) {
    tiles[i].render().update();
  }

  //if (!keyPressed) noLoop();
  if (save) {
    save = false;
    saveFrame("output\\img-####.png");
  }

  //videoExport.saveFrame();

  //if (frameCount >= 1200) {
    //videoExport.endMovie();
    //exit();
  //}
  info(time);
}

boolean save;
void keyPressed() {
  //setup();
  if (key == ' ') loop();
  if (key == 's') save = true;
}

void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(90, 0);
  videoExport.startMovie();
}

void info(int what) {
  push();
  translate(100, 100);
  textSize(60);
  fill(#FF0000);
  text(what, 0, 0);
  pop();
}
