
import com.hamoid.*;
import processing.video.*;

VideoExport videoExport;
Capture cam;

color FG = #111111;
color BG = #f1f1f1;
PImage img; 
float ratio = 1;

void setup() {
  //size(500, 700); 
  //img = loadImage("ana2.jpg");
  //int imgW = int(img.width * ratio);
  //int imgH = int(img.height * ratio);
  //img.resize(imgW, imgH);

  //surface.setSize(imgW, imgH);

  size(1280, 720, P3D);
  //fullScreen();
  cam = new Capture(this, 1280, 720);
  cam.start();

  //setupVideoExport("output\\hd_output_.mp4", 10);

  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(0);
  //fill(FG);

  translate(width/2, height/2);
  directionalLight(255, 255, 255, 0, 0, -1);
  rotateY(frameCount*0.01);

  float tilesX = 100;//map(mouseX, 0, width, 10, 100);
  float tileSize = width / tilesX;

  for (int y = 0; y < cam.height; y += tileSize) {
    for (int x = 0; x < cam.width; x += tileSize) {
      color c = cam.get(x, y);
      float b = map(brightness(c), 0, 255, 0, 15);

      pushMatrix();
      translate(x-width/2, y-height/2);
      fill(c);
      box(7, 7, b * tileSize);
      //circle(0, 0, b * tileSize);
      popMatrix();
    }
  }
  //videoExport.saveFrame();
  println((int)frameRate);
}
void captureEvent(Capture c) {
  c.read();
}

void keyPressed() {
  if (key == ' ') {
    save("output\\"+frameCount+".jpg");
    exit();
  }
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(95, 0);
  videoExport.startMovie();
}
