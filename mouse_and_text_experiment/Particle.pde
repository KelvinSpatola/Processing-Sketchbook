
char[] charTable = { // length = 63;
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
  'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
  ' '
};

class Particle {
  PVector pos, vel;
  float alpha = 255;
  float maxSpeed, speed, angle, size;
  char ch;
  boolean clockwise;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    //vel = PVector.random2D().normalize();
    //angle = atan2(mouseY-pmouseY, mouseX-pmouseX) + random(-PI/10, PI/10); // arrow
    angle = atan2(mouseY-pmouseY, mouseX-pmouseX);
    clockwise = random(1) < 0.5;

    vel = new PVector(1, 0).rotate(angle);
    maxSpeed = random(1, 4); //random(2, 6);
    speed = maxSpeed;

    ch = charTable[(int)random(charTable.length)];
    size = random(12, 50);
  }

  void display() {
    push();
    translate(pos.x, pos.y);
    rotate(angle);
    fill(0, alpha);
    textSize(size);
    text(ch, 0, -size*.2); // '→'
    pop();
  }

  void update() {
    vel.setMag(speed);
    pos.add(vel);

    alpha = map(speed, maxSpeed, 0, 255, -1);
    angle += map(speed, maxSpeed, 0, TAU, 0) * (1/size) * (clockwise ? 1 : -1);
    speed -= 0.017;//speed -= 0.025;
  }
}
