Player player;
Road road;
ArrayList<Traffic> cars = new ArrayList();

void setup() {
  size(300, 700);
  road = new Road();
  player = new Player();
}
void draw() {
  road.display();
  road.scroll();

  for (int i = 0; i < cars.size(); i++) {  
    cars.get(i).run();
    if (cars.get(i).isOffScreen()) {
      cars.remove(i);
      cars.add(new Traffic());
    }
  }
  player.run();

  println("\n\n\n"+mouseX);

  textSize(13);
  fill(255);
  text("fps: "+(int)frameRate, 0, 20);
  text("road.speed: "+(int)road.speed, 0, 35);
}
void keyPressed() {
  if (keyCode == UP) player.accelerate();
  if (keyCode == DOWN) player.decelerate(); 
  if (key == ' ') cars.add(new Traffic());
}