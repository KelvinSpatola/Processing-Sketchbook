/* ****************************************
 *          SUPERNOVA EXPLOSION           *
 *        by Kelvin Clark Spátola         *
 *            Novermber 2018              *
 **************************************** */

import com.hamoid.*;
import queasycam.*;

VideoExport videoExport;
QueasyCam cam;

ArrayList<Asteroid> asteroids = new ArrayList(); // The biggest ones
ArrayList<Asteroid> meteoroids = new ArrayList(); // The smallest ones

PImage backImg, frontImg;
float rot; // stands for "rotation". It's being use to rotate the background images
float centerX, centerY; // this is where the "viewer" is located


void setup() {
  fullScreen(P3D);
  hint(DISABLE_OPENGL_ERRORS);
  cam = new QueasyCam(this);
  cam.sensitivity = 0.5;
  cam.speed = 0.1;
  //setupVideoExport("SuoernovaExplosion.mp4", 30);

  // These are the images i use for the background. They are the same BUT with the only difference
  // being that the backImg is a 100% opaque image, and it is intended to be still (no rotation applied).
  // The frontImg is the very same picture as the backImg but I removed the black background to save only the lighter colors (the light rays) and have transparency.
  // This image is intended to be rotated and to give the illusion that the light rays are "moving": P: P: P (I could not think of a better idea, so ...)
  backImg = loadImage("luz.jpg");
  backImg.resize(width, height);
  frontImg = loadImage("luz.png");
  frontImg.resize(width, height);

  for (int i = 0; i < 1000; i++) 
    asteroids.add(new Asteroid(new PVector(random(-width, width), random(-height, height), -width), 4, random(15, 50)));

  for (int i = 0; i < 3000; i++) 
    meteoroids.add(new Asteroid(new PVector(random(-width, width), random(-height, height), random(-width)), 3, 2));

  // The viewer is going to start in the middle of the "rain of asteroids" (sorry for the stupid namming, my english sucks...)
  // Giving diferent values for these coordinates puts you in different places in the rainning area.
  // if, for example, you set centerX = 0, you'will be very next to scape the "rainning area" 
  centerX = width/2;
  centerY = height/2;

  //noCursor();
  imageMode(CENTER); // for the backImg and frontImg images
}
void draw() {
  // *************** BACKGROUND SECTION *************** //
  background(255); // this is the still image

  tint(255, 75);

  pushMatrix();
  translate(width/2, height/2, -width);
  rotate(rot); // clockwise...
  image(frontImg, 0, 0, 3*width, 3*height);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2, -width);
  rotate(-rot); // counterclockwise...
  image(frontImg, 0, 0, 3*width, 3*height);
  popMatrix();
  rot += radians(0.5);



  // These 3 lines bellow deals with the main translation of all objets in the space
  //centerX = map(mouseX+width/2, 0, width, -width/2, width/2); // THIS IS WHAT I THINK IT SHOULD BE IMPROVED TO PAN EVERYTHING
  //centerY = map(mouseY+height/2, 0, height, -height/2, height/2); // THIS IS WHAT I THINK IT SHOULD BE IMPROVED TO PAN EVERYTHING
  translate(centerX, centerY); 


  // *************** ASTEROIDS SECTION *************** //
  spotLight(111, 244, 255, 0, 0, -width/2, 0, 0, 0, QUARTER_PI, -10000); // adding some lights. This is only affecting the asteroids

  // Here's where the asteroids are born. I'm adding 10 asteroids each frame and whenever they reach 3000 asteroids, we stop adding it.
  if (asteroids.size() < 3000) {
    for (int i = 0; i < 10; i++) 
      asteroids.add(new Asteroid(new PVector(random(-width, width), random(-height, height), -width), 4, random(15, 50)));
  }

  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update();
    asteroids.get(i).display();
    if (asteroids.get(i).pos.z > width/2) asteroids.remove(i); // removing the asteroids as soon as they pass behind the viewers sight
  }

  // ************* METEOROIDS SECTION ************* //
  spotLight(255, 255, 255, 0, 0, 0, 0, 0, 0, QUARTER_PI, -10000); // adding some lights again. This time it's to light the meteoroids

  if (meteoroids.size() < 3000) {
    for (int i = 0; i < 100; i++) 
      meteoroids.add(new Asteroid(new PVector(random(-width, width), random(-height, height), -width), 3, 2));
  }
  for (int i = 0; i < meteoroids.size(); i++) {
    meteoroids.get(i).update();
    meteoroids.get(i).display();
    if (meteoroids.get(i).pos.z > width/2) meteoroids.remove(i);
  }


  //videoExport.saveFrame();
  println((int)frameRate);
}
void keyPressed() {
  //if (key == 'q') {
  //  videoExport.endMovie();
  //  exit();
  //}
}
void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(90, 0);
  videoExport.startMovie();
}
