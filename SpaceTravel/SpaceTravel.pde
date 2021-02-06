/* ****************************************
 *              SPACE TRAVEL              *
 *        by Kelvin Clark Spátola         *
 *             October 2020               *
 **************************************** */

import com.hamoid.*;
VideoExport videoExport;

PVector center, camMov;
float acc, loss, sensibility = 0.0125;

ArrayList<Asteroid> asteroids = new ArrayList();
float scl = 2.5;

PShape earth, clouds;
PImage earthTex, cloudTex, alphaTex, bumpMap, specMap, asteroidTex, asteroidBump, asteroidSpec;
PShader earthShader, cloudShader, asteroidShader;


void setup() {
  fullScreen(P3D);
  //setupVideoExport("SpaceTravel_2.mp4", 60);

  earthTex = loadImage("earthmap1k.jpg");
  cloudTex = loadImage("earthcloudmap.jpg");
  alphaTex = loadImage("earthcloudmaptrans.jpg");
  bumpMap = loadImage("earthbump1k.jpg");
  specMap = loadImage("earthspec1k.jpg");

  asteroidTex = loadImage("asteroid_color.jpg");
  asteroidBump = loadImage("asteroid_bump.jpg");
  asteroidSpec = loadImage("asteroid_spec2.jpg");

  earthShader = loadShader("EarthFrag.glsl", "EarthVert.glsl");
  earthShader.set("texMap", earthTex);
  earthShader.set("bumpMap", bumpMap);
  earthShader.set("specularMap", specMap);
  earthShader.set("bumpScale", 0.05);

  cloudShader = loadShader("CloudFrag.glsl", "CloudVert.glsl");
  cloudShader.set("texMap", cloudTex);
  cloudShader.set("alphaMap", alphaTex);

  asteroidShader = loadShader("EarthFrag.glsl", "EarthVert.glsl");
  asteroidShader.set("texMap", asteroidTex);
  asteroidShader.set("bumpMap", asteroidBump);
  asteroidShader.set("specularMap", asteroidSpec);
  asteroidShader.set("bumpScale", 0.2);

  earth = createShape(SPHERE, 200);
  earth.setStroke(false);
  earth.setSpecular(color(125));
  earth.setShininess(10);

  clouds = createShape(SPHERE, 202);
  clouds.setStroke(false);

  for (int i = 0; i < 3000; i++) {
    float x = random(-width * scl, width * scl);
    float y = random(-width * scl, width * scl);
    float z = random(-width);
    if (i < 1500) asteroids.add(new Asteroid(new PVector(x, y, z), 3, 2));
    else          asteroids.add(new Asteroid(new PVector(x, y, z), 4, random(15, 50)));
  }

  center = new PVector(width/2, height/2);
  camMov = new PVector();

  background(0);
}

void draw() {
  background(0);
  perspective(PI/map(frameCount, 0, 1000, 1f, 8f), (float) width/height, 1, 1000000);
  directionalLight(255, 255, 255, 1, 1, 0);

  earth();
  cameraMovement();
  translate(center.x, center.y); 

  shader(asteroidShader);
  asteroids();

  //videoExport.saveFrame();
}

void earth() {
  push();
  { 
    float earthRotation = -frameCount * 0.005;
    translate(width/2, height/2, -width*2);

    push();
    rotateY(earthRotation);
    shader(earthShader);
    shape(earth);
    pop();

    push();
    rotateY(earthRotation * 2);
    shader(cloudShader);
    shape(clouds);
    pop();
  }
  pop();
}

void asteroids() {
  if (asteroids.size() < 5000) {
    for (int i = 0; i < 100; i++) {
      float x = random(-width * scl, width * scl);
      float y = random(-width * scl, width * scl);
      float z = -width;
      if (i < 50)           asteroids.add(new Asteroid(new PVector(x, y, z), 3, 2));
      if (i >= 50 && i < 97) asteroids.add(new Asteroid(new PVector(x, y, z), 4, random(15, 50)));
      else                  asteroids.add(new Asteroid(new PVector(x, y, z), 3, random(70, 85)));
    }
  }

  for (int i = asteroids.size()-1; i >= 0; i--) {
    asteroids.get(i).update();
    asteroids.get(i).display();
    if (asteroids.get(i).pos.z > width/2) asteroids.remove(i); // removing the asteroids as soon as they pass behind the viewers sight
  }
}

void cameraMovement() {
  if (acc <= 0) acc = 0;
  else acc -= loss;
  camMov.setMag(acc);
  center.add(camMov);
}

void mouseDragged() {
  camMov.x += (mouseX - pmouseX) * sensibility;
  camMov.y += (mouseY - pmouseY) * sensibility;
  acc = camMov.mag();
  loss = acc * sensibility;
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(90, 0);
  videoExport.startMovie();
}
