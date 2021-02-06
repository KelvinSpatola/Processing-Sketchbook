/* by Kelvin Spátola */

void setup() {
  fullScreen();
  noStroke();
  background(0);
}
float ang;
void draw() {
  rectMode(CORNER);
  fill(0, 50);
  rect(0, 0, width, height);

  int num = 37;  //número total de aneis
  float size = 10;  //tamanho dos objetos

  for (int j = 0; j < num; j++) {
    float y = j*20;  //espaçamento entre linhas. Mexer no multiplicador do size!
    int value = j*3;  //espaçamento entre objetos (na mesma linha). Quanto maior o multiplicador, mais juntos estarão os objetos

    ang += (j%2 == 0) ? radians(map(j, 1, num, 0.1, 1)) : -radians(map(j, 1, num, 0.1, 1));

    for (int i = 1; i < value; i++) {
      pushMatrix();
      translate(width/2, height/2);
      rotate((-PI+i*TWO_PI/value)*ang);

      float strokeWeight = (int)map(j, 1, num, 40, 10);

      fill(0, 180, 0);
      ellipse(0, y, strokeWeight, strokeWeight/2);
      popMatrix();
    }
  }
}
void keyPressed() {
  if (key == ' ') saveFrame("PrintScreen_#####.png");
}
