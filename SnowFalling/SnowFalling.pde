
PApplet app;

Wind wind;
PImage img;
ArrayList <Snowflake> snow = new ArrayList();

void setup() {
  app = this;
  fullScreen(P2D);

  img = loadImage("snowFlake.png");
  for (int i = 0; i < 200; i++) snow.add(new Snowflake());

  wind = new Wind();
  imageMode(CENTER);
}

void draw() {
  background(0);

  wind.update();
  if (wind.blow()) {
    for (Snowflake s : snow) s.blow = true;
  }

  for (int i = 0; i < 6; i ++) snow.add(new Snowflake());

  for (int i = 0; i < snow.size(); i++) {
    snow.get(i).update();
    snow.get(i).display();
    if (snow.get(i).isDead()) snow.remove(i);
  }

  println((int)frameRate);
}
