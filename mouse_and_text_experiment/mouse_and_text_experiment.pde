import com.hamoid.*;
VideoExport videoExport;

ArrayList<Particle> particles;

void setup() {
  fullScreen(P2D);
  particles = new ArrayList();
  textFont(createFont("Georgia", 50));
  textAlign(CENTER, CENTER);
  //setupVideoExport("output.mp4", 60, 65);
}

void draw() {
  background(255);

  for (int i = particles.size()-1; i >= 0; i--) {
    particles.get(i).display();
    particles.get(i).update();
    if (particles.get(i).alpha < 0) particles.remove(i);
  }
  //videoExport.saveFrame();
}

void mouseMoved() {
  if (frameCount > 10) particles.add(new Particle(mouseX, mouseY));
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
