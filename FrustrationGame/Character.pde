
class Character {
  char letter;
  PVector pos, vel;
  float angle, rot;
  float charWidth, charHeight;
  color defaultColor = 0;
  color mouseoverColor = #00FF00;

  AudioPlayer collisionSFX;

  // CONSTRUCTOR
  Character(char c, float x, float y, float angle) {
    letter = c;
    pos = new PVector(x, y);
    vel = new PVector(random(-2, 2), random(-2, 2));

    this.angle = angle;
    rot = random(-radians(2), radians(2));

    charWidth = textWidth(letter);
    charHeight = (textAscent() + textDescent()) * .32;

    collisionSFX = minim.loadFile("click.mp3");
    //collisionSFX.setGain(-15);
  }

  void render() {
    push();
    textAlign(CENTER, CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    fill(intersects(mouseX, mouseY) ? mouseoverColor : defaultColor);
    text(letter, 0, -charHeight * .28);
    pop();
  }

  void update() {
    pos.add(vel);
    angle += rot;
    restriction();
  }

  boolean intersects(float x, float y) {
    float d = dist(x, y, pos.x, pos.y);
    return d < charWidth * 0.8;
  }

  void changeDirection(Character other) {
    if (pos.x < other.pos.x) {
      vel.x = -abs(vel.x);
      other.vel.x = abs(other.vel.x);
    } else {
      vel.x = abs(vel.x);
      other.vel.x = -abs(other.vel.x);
    }
    if (pos.y < other.pos.y) {
      vel.y = -abs(vel.y);
      other.vel.y = abs(other.vel.y);
    } else {
      vel.y = abs(vel.y);
      other.vel.y = -abs(other.vel.y);
    }
  }

  void restriction() {
    if (pos.x >= width - charHeight || pos.x <= charHeight) vel.x = -vel.x;
    if (pos.y >= height - charHeight || pos.y <= charHeight) vel.y = -vel.y;
  }

  void playCollisionSFX() {
    collisionSFX.rewind();
    collisionSFX.play();
  }

  void vibrate(int count, int start, int finish, int intensity) {
    float min = map(count, start, finish, 0, -intensity);
    float max = map(count, start, finish, 0, intensity);
    pos.x += random(min, max);
    pos.y += random(min, max);
  }
}
