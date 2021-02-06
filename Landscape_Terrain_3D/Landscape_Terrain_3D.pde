
import com.hamoid.*;
VideoExport videoExport;

int rows, cols;
int tileSize = 20;
int wolrdWidth, worldHeight;
float[][] terrain;
float[][] rainDrops;
float flyingSpeed;

PImage bg;

void setup() {
  fullScreen(P3D);

  wolrdWidth = 2700;
  worldHeight = 1300;
  cols = wolrdWidth / tileSize;
  rows = worldHeight / tileSize;
  terrain = new float[cols][rows];
  rainDrops = new float[cols][rows];

  for (int y = 0; y < rows; y++)
    for (int x = 0; x < cols; x++)
      rainDrops[x][y] = random(-width/4, 0);

  bg = createImage(width, height, RGB);
  bg.loadPixels();
  int count = 0;
  for (int i = 0; i < bg.pixels.length; i++) {
    color c = lerpColor(#1588FF, #FFFFFF, map(count, 0, 2*height/3, 0f, 1f));
    bg.pixels[i] = c;
    if (i % width == 0) count++;
  }
  bg.updatePixels();

  strokeCap(ROUND);

  //setupVideoExport("Terrain_3D_2.mp4", 30, 90);
}


void draw() {
  perspective(PI/map(mouseX, 0, width, 2.0, 8f), (float) width/height, 1, 1000000);

  if (frameCount%100==0 || frameCount%102==0) background(255);
  else background(bg);

  float inc = 0.04;
  float yoff = flyingSpeed;

  // CLOUDS

  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -250, 300);
      xoff += inc;
    }
    yoff += inc;
  }
  flyingSpeed -= inc;

  //camera(width/2, height, 120.0,  mouseX, mouseY, 0.0,   0.0, 1.0, 0.0);
  translate(width/2, height/2 - 100);
  rotateX(PI/2);
  //rotateX(map(mouseY, 0, height, 0, PI/2));
  //rotateZ(map(mouseX, 0, width, PI/2, -PI/2));
  translate(-wolrdWidth/2, -worldHeight*0.4);
  lights();
  sphereDetail(8);
  noStroke();

  color near = #FFFFFF;
  color far  = #C3C6C9;

  for (int y = 0; y < rows; y++) {
    float alpha = map(y, 0, rows, 0, 255);
    fill(lerpColor(far, near, map(y, 0, rows, 0, 1)), alpha);

    for (int x = 0; x < cols; x++) {

      if (terrain[x][y] >= 0) {
        push();
        translate(x * tileSize, y * tileSize, terrain[x][y]/2);
        sphere(terrain[x][y]/2);

        if (startRaining) {
          strokeWeight(map(alpha, 0, 255, 0.1, 4));
          stroke(#D7F6FA, 180);
          line(0, 0, rainDrops[x][y], 0, 0, rainDrops[x][y]+map(alpha, 0, 255, 1, 10));
        }
        pop();
      }
      rainDrops[x][y] -= 15;
      if (rainDrops[x][y] < -height/4) rainDrops[x][y] = 0;
    }
  }

  // TERRAIN

  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -50, 200);
      xoff += inc;
    }
    yoff += inc;
  }

  translate(0, height/5, -height/4);
  directionalLight(255, 255, 255, 0, height, width);
  rotateX(-PI/110);

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      push();
      translate(x * tileSize, y * tileSize, terrain[x][y]);
      float alpha = map(y, 0, rows/2, 0, 255);
      color desert = color(lerpColor(#000000, #81593B, map(terrain[x][y], -50, 100, 0, 1)));
      color forest = color(lerpColor(#000000, #1B8128, map(terrain[x][y], -50, 100, 0, 1)));
      fill(lerpColor(desert, forest, startRaining ? count*0.005 : 0), alpha);
      box(tileSize, tileSize, tileSize*2);
      pop();
    }
  }
  println((int)frameRate);
  if (startRaining) count++;

  //videoExport.saveFrame();
}
int count;
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
  if (key == ' ') {
    startRaining = !startRaining;
  }
}
boolean startRaining;

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
