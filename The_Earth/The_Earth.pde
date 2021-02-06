
PVector pos = new PVector();
float radius = 1000, speed = 0.005, rotAngle;
PShape earth;

void setup() {
  fullScreen(P3D);
  earth = createShape(SPHERE, 200); 
  earth.setStroke(false);
  earth.setTexture(loadImage("http://previewcf.turbosquid.com/Preview/2014/08/01__15_41_30/Earth.JPG5a55ca7f-1d7c-41d7-b161-80501e00d095Larger.jpg"));
  background(0);
  noStroke();
}

void draw() {
  background(0);
  camera(0, 1500, 350, 0, 0, 0, 0, 0, -1);

  pos.x = radius * cos(frameCount * speed);
  pos.y = radius * sin(frameCount * speed);
  rotAngle = atan2(pos.y, pos.x);

  lights();
  sphere(15);
  noLights();

  directionalLight(255, 255, 255, cos(rotAngle), sin(rotAngle), 0);

  push();
  translate(pos.x, pos.y);
  rotateX(-HALF_PI);
  rotateY(frameCount * 0.01);
  shape(earth);
  pop();
}
