
ArrayList <Mover> movers;

void setup() {
  fullScreen(FX2D);
  colorMode(HSB, 360, 100, 100, 100);
  movers = new ArrayList();

  for (int i = 0; i < 400; i++) {  
    movers.add(new Star(random(10, 35)));
    movers.add(new Bubble(random(3, 23)));
  }
}
void draw() {
  background(movers.size() == 0 ? color(255, 0, 0) : #FFFFFF);

  for (int i = 0; i < movers.size(); i++) {
    movers.get(i).move().display();

    Mover m1 = movers.get(i);

    for (int j = 0; j < movers.size(); j++) {
      Mover m2 = movers.get(j);

      if (i != j && m1.type != m2.type && !m1.dying && !m2.dying && (m1.intersects(m2) || m2.intersects(m1))) {
        m1.die();
        m2.die();
      }
    }
    if (movers.get(i).strokeLifespan > 360) movers.remove(i);
  }
  fill(0);
  text((int)frameRate, 50, 50);
}

void keyPressed() {
  setup();
}
