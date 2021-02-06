
int rows, cols;
int tileSize = 20;
int wolrdWidth, worldHeight;
float[][] terrain;
float flyingSpeed;

void setup() {
  fullScreen(P3D);
  //size(900, 600, P3D);

  wolrdWidth = 3200;
  worldHeight = 1500;
  cols = wolrdWidth / tileSize;
  rows = worldHeight / tileSize;
  terrain = new float[cols][rows];
}

void draw() {
  float inc = 0.05;
  float yoff = flyingSpeed;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += inc;
    }
    yoff += inc;
  }
  flyingSpeed -= inc/2;

  background(0);
  translate(width/2, height/2 - 100);
  rotateX(PI/3);
  translate(-wolrdWidth/2, -worldHeight/2);

  stroke(255);

  for (int y = 0; y < rows-2; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * tileSize, y * tileSize, terrain[x][y]);
      vertex(x * tileSize, y * tileSize, terrain[x][y+2]);
    }
    endShape();
  }

  println((int)frameRate);
}
