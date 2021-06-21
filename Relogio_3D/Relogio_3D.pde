/* ****************************************
 *              RELÓGIO 3D                *
 *        by Kelvin Clark Spátola         *
 *             February 2021              *
 **************************************** */

final int OUTER_RADIUS = 250;
final int POINTER_WIDTH = 15;
final int POINTER_HEIGHT = 30;
final int DEPTH = 30;
final float THETA = radians(20);

final String[] ROMAN = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII"};
final int[] colors = {#FF0554, #7DFF3E, #00D7FF}; // RED, GREEN, BLUE

void setup() {
  fullScreen(P3D);
  smooth(16);
  hint(DISABLE_DEPTH_TEST);
  textFont(createFont("Times new roman bold", 50));
  textAlign(CENTER, CENTER);
  strokeCap(SQUARE);
}

void draw() {
  background(0);
  perspective(PI/3f, (float) width/height, 1, 1000000);

  // ******************** CAMRERA ********************
  translate(width/2, height/2, -DEPTH);
  rotateY(map(mouseX, 0, width, -THETA, THETA));
  rotateX(map(mouseY, 0, height, THETA, -THETA));


  // *************** CIRCUNFERENCIAS E ARCOS ***************
  blendMode(SCREEN);

  translate(0, 0, DEPTH);
  noFill();
  stroke(255);
  strokeWeight(12);
  circle(0, 0, OUTER_RADIUS * 2);

  strokeWeight(3);
  stroke(colors[0]);
  arc(0, 0, OUTER_RADIUS * 2 - 30, OUTER_RADIUS * 2 - 30, -HALF_PI, (TWO_PI/12) * (hour()%12) -HALF_PI);
  stroke(colors[1]);
  arc(0, 0, OUTER_RADIUS * 2 - 40, OUTER_RADIUS * 2 - 40, -HALF_PI, (TWO_PI/60) * minute() - HALF_PI);
  stroke(colors[2]);
  arc(0, 0, OUTER_RADIUS * 2 - 50, OUTER_RADIUS * 2 - 50, -HALF_PI, (TWO_PI/60) * second() - HALF_PI);


  // ******************** MARCADORES ********************
  translate(0, 0, DEPTH);
  textSize(25);
  noStroke();
  fill(255);

  for (int i = 12; i >= 1; i--) {
    float x = (OUTER_RADIUS - 50) * cos(i * (TWO_PI/12) - PI/2);
    float y = (OUTER_RADIUS - 50) * sin(i * (TWO_PI/12) - PI/2);
    text(ROMAN[i-1], x, y);
  }

  for (int i = 0; i < 60; i++) {
    float x = (OUTER_RADIUS - 73) * cos(i * (TWO_PI/60) - PI/2);
    float y = (OUTER_RADIUS - 73) * sin(i * (TWO_PI/60) - PI/2);
    circle(x, y, i <= second() ? 4 : 1);
  }


  // ******************** PONTEIROS ********************
  translate(0, 0, DEPTH);
  int offset = 120;

  // ponteiro das horas
  fill(colors[0]);
  pointer((TWO_PI/12)*hour(), POINTER_WIDTH, POINTER_HEIGHT, OUTER_RADIUS - offset);

  // ponteiro dos minutos
  fill(colors[1]);
  pointer((TWO_PI/60)*minute(), POINTER_WIDTH, POINTER_HEIGHT, OUTER_RADIUS - offset);

  // ponteiro dos segundos
  fill(colors[2]);
  pointer((TWO_PI/60)*second(), POINTER_WIDTH, POINTER_HEIGHT, OUTER_RADIUS - offset);


  // ******************** MOSTRADOR DIGITAL ********************
  noFill();
  stroke(255);
  circle(0, 0, 150);
  fill(255);
  circle(0, 0, 140);

  String s = nf(second(), 2);
  String m = nf(minute(), 2);
  String h = nf(hour(), 2);

  translate(0, 0, DEPTH);
  blendMode(DARKEST);
  textSize(30);
  fill(0);
  text(h+":"+m+":"+s, 0, 0);
}

void pointer(float angle, float sx, float sy, float radius) {
  noStroke();
  push();
  rotate(angle);
  translate(0, -radius);
  scale(sx, sy);
  beginShape();
  vertex(-1, 1);
  vertex( 1, 1);
  vertex( 0, -1);
  endShape(CLOSE);
  pop();
}
