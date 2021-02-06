Background fundo;
Player p;

public void setup() {
  size(500, 500);
  //fullScreen(P2D);

  fundo = new Background();
  p = new Player();
}
public void draw() {
  background(255, 255, 0);

  fundo.display();
  fundo.updateBorderValues();

  p.display();
  p.move();

  println((int)frameRate);
}
