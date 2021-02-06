void setup() {
  size(683, 384);
  background(0);

  rectMode(CENTER);
  for (int i = 0; i < 5; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    int w = (int)random(20, 100);
    int h = (int)map(w, 20, 100, 100, 20);
    fill(255);
    rect(x, y, w, h);
  }
}
void draw() {
}
void keyPressed() {
  if (key == ' ') setup();
  if (key == 's') saveFrame("map-####.png");
}
