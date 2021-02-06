import com.hamoid.*;
VideoExport videoExport;


Circle[] circles = new Circle[5000];
float rMin = 2;
float rMax = 50;
boolean record = true;

void setup() {
  fullScreen(P2D);
  hint(DISABLE_DEPTH_TEST);
  textFont(createFont("Georgia", 100));
  textAlign(CENTER, CENTER);

  for (int i = 0; i < circles.length; i++) {
    float r = random(rMin, rMax);
    float x = random(r, width-r);
    float y = random(r, height-r);

    // avoid overlaping when creating the circles
    if (i != 0) { 
      for (int j = 0; j < i; j++) {
        float d = dist(x, y, circles[j].x, circles[j].y);
        if (d < r + circles[j].r) { 
          r = random(rMin, rMax);
          x = random(r, width-r);
          y = random(r, height-r);
          j = -1;
        }
      }
    }
    circles[i] = new Circle(x, y, r);
  }
  frameRate(30);
  if (record) setupVideoExport("Walking_text_2.mp4", 30, 75);
  record = false;
}

void draw() {
  background(255);
  fill(0);
  for (Circle c : circles) c.display();
  videoExport.saveFrame();
}

void mouseMoved() {
  if (frameCount > 1) {
    float brushRadius = dist(mouseX, mouseY, pmouseX, pmouseY)*0.7;

    for (Circle c : circles) {
      float d = dist(mouseX, mouseY, c.x, c.y);
      if (d <= 10 + brushRadius) c.isVisible = true;
    }
  }
} 

void keyPressed() {
  if (key == ' ') setup();
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
