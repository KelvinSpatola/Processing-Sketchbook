
int total = 600;

void setup() {
  fullScreen(FX2D);
  noCursor();
  background(0);
}
void draw() {
  noStroke();
  fill(0, 50);
  rect(0, 0, width, height);

  translate(width/2, height/2); // change these values if you wanna put the center elsewhere

  for (float i = 1; i < total; i += .75) { // don't start from zero because of strokeWeight()
    pushMatrix();
    rotate(i * frameCount*.0005);
    strokeWeight(i);
    stroke(0, map(i, 1, total/2, 255, 0), 255);
    point(0, i*2.5);
    popMatrix();
  }
}
void keyPressed() {
  if (key == ' ') {
    save(frameCount + ".png");
    exit();
  }
}
