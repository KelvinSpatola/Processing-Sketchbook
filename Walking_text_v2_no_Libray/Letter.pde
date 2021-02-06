
final char[] charTable = new char[]{
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
};

class Circle {
  float x, y, r, angle;
  char ch;
  boolean isVisible, stopRotate;

  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    ch = charTable[(int)random(charTable.length)];
  }

  void display() {
    if (isVisible) {
      if (!stopRotate) {
        stopRotate = true;
        angle = atan2(mouseY-pmouseY, mouseX-pmouseX);
      }
      textSize(2*r*1.2);

      push();
      translate(x, y - r*0.4f);
      rotate(angle);
      text(ch, 0, -r*0.25f);
      pop();

      x += cos(angle);
      y += sin(angle);
    }
  }
}
