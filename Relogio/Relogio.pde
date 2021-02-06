import kelvinclark.utils.Converter;

float outerRadius = 250;
float pointerLength = 60;
float pointerWidth = 30;

void setup() {
  fullScreen(FX2D);
  //size(550, 550);
  surface.setTitle("Relógio " + nf(day(), 2) + "/" + nf(month(), 2) + "/" + year());

  textFont(createFont("Times new roman bold", 50));
  textAlign(CENTER, CENTER);
  strokeCap(SQUARE);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  blendMode(SCREEN);

  /*
   * CIRCUNFERENCIAS E ARCOS
   */
  noFill();
  stroke(255);
  strokeWeight(12);
  circle(0, 0, outerRadius * 2);

  strokeWeight(3);
  stroke(#00D7FF);
  arc(0, 0, outerRadius * 2 - 30, outerRadius * 2 - 30, -HALF_PI, (TWO_PI/60) * second() -HALF_PI);
  stroke(#7DFF3E);
  arc(0, 0, outerRadius * 2 - 40, outerRadius * 2 - 40, -HALF_PI, (TWO_PI/60) * minute() -HALF_PI);
  stroke(#FF0554);
  arc(0, 0, outerRadius * 2 - 50, outerRadius * 2 - 50, -HALF_PI, (TWO_PI/12) * (hour()%12) -HALF_PI);

  /*
   * MARCADORES
   */
  textSize(25);
  fill(255);
  noStroke();

  for (int i = 12; i >= 1; i--) {
    float x = (outerRadius - 50) * cos(i * (TWO_PI/12) - PI/2);
    float y = (outerRadius - 50) * sin(i * (TWO_PI/12) - PI/2);
    text(Converter.toRoman(i), x, y);
  }
  textSize(20);
  for (int i = 0; i < 60; i++) {
    float x = (outerRadius - 73) * cos(i * (TWO_PI/60) - PI/2);
    float y = (outerRadius - 73) * sin(i * (TWO_PI/60) - PI/2);
    circle(x, y, i <= second() ? 3 : 1);
  }

  /*
   * PONTEIROS
   */
  int offset = 90;
  // ponteiro dos segundos
  fill(#00D7FF);
  pointer((TWO_PI/60)*second(), outerRadius - offset, -pointerLength, pointerWidth);

  // ponteiro dos minutos
  fill(#7DFF3E);
  pointer((TWO_PI/60)*minute(), outerRadius - offset, -pointerLength, pointerWidth);

  // ponteiro das horas
  fill(#FF0554);
  pointer((TWO_PI/12)*hour(), outerRadius - offset, -pointerLength, pointerWidth);

  /*
   * MOSTRADOR DIGITAL
   */
  noFill();
  stroke(255);
  circle(0, 0, 150);
  fill(255);
  circle(0, 0, 140);

  String s = nf(second(), 2);
  String m = nf(minute(), 2);
  String h = nf(hour(), 2);

  blendMode(DARKEST);
  textSize(30);
  fill(0);
  text(h+":"+m+":"+s, 0, 0);
}

void pointer(float angle, float radius, float length, float w) {
  push();
  rotate(angle);
  beginShape();
  vertex(0, -radius);
  vertex(-w/2, -radius - length);
  vertex( w/2, -radius - length);
  endShape(CLOSE);
  pop();
}
