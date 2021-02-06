
import com.hamoid.*;
VideoExport videoExport;

import traer.physics.*;

ParticleSystem physics;
ArrayList<Pixel> imgPixels;
Particle mouse;

PImage srcImg;
int spacing = 3;

void setup() {
  //size(900, 600, P2D);
  fullScreen(P2D);
  noSmooth();
  cursor(CROSS);

  srcImg = loadImage("kelvin2.jpg");
  srcImg.resize(width, height);

  physics = new ParticleSystem(0, 0.1);
  mouse = physics.makeParticle();
  mouse.makeFixed();

  imgPixels = new ArrayList();
  for (int x = 0; x < srcImg.width; x++) {
    for (int y = 0; y < srcImg.height; y++) {
      if (x % spacing == 0 && y % spacing == 0 && alpha(srcImg.get(x, y)) != 0) {     
        imgPixels.add(new Pixel(x, y, srcImg.get(x, y)));
      }
    }
  }

  //setupVideoExport("kelvin2b.mp4", 60, 50);

  println(imgPixels.size());
  noStroke();
  background(255);
}

void draw() {
  background(255);
  physics.tick();

  for (Pixel p : imgPixels) {
    p.display();
  }
  //filter(ERODE);
  //videoExport.saveFrame(); 
  fps();
}

void keyPressed() {
  if (key == ' ') setup();

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
    for (Pixel p : imgPixels) physics.makeAttraction(mouse, p.particle, 7500, 30);

  if (mouseButton == RIGHT) 
    for (Pixel p : imgPixels) physics.makeAttraction(mouse, p.particle, -7500, 30);

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

void fps() {
  push();
  textSize(50);
  fill(#FF0000);
  text((int)frameRate, 50, 50);
  pop();
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
