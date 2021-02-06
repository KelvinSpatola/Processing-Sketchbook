
PImage img;
ArrayList <LightSpot> wave = new ArrayList();

int num;

void setup() {
  fullScreen(P2D);
  
  img = loadImage("LightSpot.png");
  for (int i = 0; i < 200; i++) wave.add(new LightSpot(num));
  imageMode(CENTER);
}


void draw() {
  background(0);

  for (int i = 0; i < 6; i ++) wave.add(new LightSpot(num));

  for (int i = 0; i < wave.size(); i++) {
    wave.get(i).update();
    wave.get(i).display();
    if (wave.get(i).isDead()) wave.remove(i);
  }

  if (frameCount % 300 == 0) num++;

  println((int)frameRate);
}
