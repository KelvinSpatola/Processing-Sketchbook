
import com.hamoid.*;
VideoExport videoExport;

int rows, cols;
int tileSize = 10;
int worldWidth, worldHeight;
float[][] terrain;
float flyingSpeed;
float noiseDetail = 0.015;
int bgColor = #FFFFFF;
int fgColor = #a0FF00;


void setup() {
  fullScreen(P3D);

  worldWidth = 3200;
  worldHeight = 2500;
  cols = worldWidth / tileSize;
  rows = worldHeight / tileSize;
  terrain = new float[cols][rows];

  //setupVideoExport("Terrain_3D_v3.mp4", 60, 60);
}

void draw() {
  float yoff = flyingSpeed;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
      xoff += noiseDetail;
    }
    yoff += noiseDetail;
  }
  flyingSpeed -= noiseDetail/2; // use (noiseDetail/4) for recording

  background(bgColor);
  translate(width/2, height/2, -height/2);
  rotateX(PI/2.29); //70
  rotateZ(PI/8.35); //730
  //rotateX(map(70, 0, height, PI/2, -PI/2)); //70
  //rotateZ(map(730, 0, width, PI/2, -PI/2)); //730
  translate(-worldWidth/2, -worldHeight/2);

  noFill();
  float alpha = 255;
  for (int y = 0; y < rows-1; y++) {
    if (y <= rows/2) alpha = map(y, 0, rows/2, 0, 255);
    else alpha = map(y, rows/2, rows, 255, 0);

    beginShape(TRIANGLE);
    for (int x = 0; x < cols; x++) {
      stroke(fgColor, alpha);
      strokeWeight(map(alpha, 0, 255, 0.0, 1.5));
      vertex(x * tileSize, y * tileSize, terrain[x][y]);
      vertex(x * tileSize, (y+1) * tileSize, terrain[x][y+1]);
    }
    endShape();
  }

  //videoExport.saveFrame();
  println((int)frameRate);
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
