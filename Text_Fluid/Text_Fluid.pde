
import com.hamoid.*;
VideoExport videoExport;

import traer.physics.*;

ParticleSystem physics;
ArrayList<Letter> letters;
Particle mouse;


void setup() {
  fullScreen(P2D);
  String[] txt = loadStrings("Os Lusiadas.txt");

  physics = new ParticleSystem(0, 0.1);
  mouse = physics.makeParticle();
  mouse.makeFixed();

  letters = new ArrayList();

  int size = 20;
  int x = size/2, y = size;
  textFont(createFont("Monospaced.bold", size));
  textAlign(CENTER);

  letters = new ArrayList();
  for (int i = 0; i < txt.length; i++) {
    for (int j = 0; j < txt[i].length(); j++) {

      char c = txt[i].charAt(j);
      letters.add(new Letter(c, x, y));

      x += textWidth(c);
      if (x >= width) {
        x = size/2;
        y += size;
      }
      if (y > height) break;
    }
  }
  println(letters.size());
  noStroke();
  //setupVideoExport("text.mp4", 60, 50);
}

void draw() {
  background(255);
  physics.tick();

  fill(0);
  for (Letter l : letters) {
    l.display();
    l.update();
  }

  fill(0, 50);
  circle(mouseX, mouseY, 30);

  //videoExport.saveFrame(); 
}

void keyPressed() {
  if (key == ' ') for (Letter m : letters) m.resetPosition = !m.resetPosition;
  if (key == ENTER) setup();
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

void mouseDragged() {
  mouse.position().set( mouseX, mouseY, 0 );
}

void mousePressed() {
  if (mouseButton == LEFT) 
    for (Letter l : letters) physics.makeAttraction(mouse, l.particle, 25000, 75);

  if (mouseButton == RIGHT) 
    for (Letter l : letters) physics.makeAttraction(mouse, l.particle, -20000, 75);

  mouse.position().set( mouseX, mouseY, 0 );
}

void mouseReleased() {
  for ( int i = 0; i < physics.numberOfAttractions(); i++ ) {
    Attraction t = physics.getAttraction(i);
    t.setStrength(-100);
  }

  for ( int i = 0; i < physics.numberOfAttractions(); i++ ) {
    physics.removeAttraction(i);
  }
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
