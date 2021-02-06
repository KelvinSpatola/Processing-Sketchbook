
import kelvinclark.utils.SpriteSheet;

Player player;

void setup() {
  size(1000, 700);
  player = new Player(this, 150, 4);
}

void draw() {
  background(255);

  player.display();
  player.update();
}

void keyPressed() {
  player.setMove(key, true);
}
void keyReleased() {
  player.setMove(key, false);
}
