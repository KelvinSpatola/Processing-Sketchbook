
PShape earth, clouds;
PImage earthTex, cloudTex, alphaTex, bumpMap, specMap;
PShader earthShader, cloudShader;

float radius = 1000, speed = 0.0025;
float earthRotation, cloudsRotation;

void setup() {
  fullScreen(P3D);
  background(0);

  earthTex = loadImage("earthmap1k.jpg");
  cloudTex = loadImage("earthcloudmap.jpg");
  alphaTex = loadImage("earthcloudmaptrans.jpg");

  bumpMap = loadImage("earthbump1k.jpg");
  specMap = loadImage("earthspec1k.jpg");

  earthShader = loadShader("EarthFrag.glsl", "EarthVert.glsl");
  earthShader.set("texMap", earthTex);
  earthShader.set("bumpMap", bumpMap);
  earthShader.set("specularMap", specMap);
  earthShader.set("bumpScale", 0.05);

  cloudShader = loadShader("CloudFrag.glsl", "CloudVert.glsl");
  cloudShader.set("texMap", cloudTex);
  cloudShader.set("alphaMap", alphaTex);

  earth = createShape(SPHERE, 200);
  earth.setStroke(false);
  earth.setSpecular(color(125));
  earth.setShininess(10);

  clouds = createShape(SPHERE, 201);
  clouds.setStroke(false);
}

void draw() {
  background(0);
  camera(0, 1500, 350, 0, 0, 0, 0, 0, -1);

  float x = radius * cos(frameCount * speed);
  float y = radius * sin(frameCount * speed);
  float rotAngle = atan2(y, x);

  directionalLight(255, 255, 255, cos(rotAngle), sin(rotAngle), 0);

  float targetAngle = frameCount * 0.005;  
  earthRotation += 0.05 * (targetAngle - earthRotation);

  translate(x, y);
  rotateX(-HALF_PI);

  shader(earthShader);
  push();
  rotateY(earthRotation);
  shape(earth);
  pop();

  shader(cloudShader);
  push();
  rotateY(earthRotation + cloudsRotation);
  shape(clouds);
  pop();

  cloudsRotation += 0.001;
}
