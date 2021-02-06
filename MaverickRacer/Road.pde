class Road {
  int y, speed;
  PImage img1;

  Road() {
    img1 = loadImage("road.jpg");
    img1.resize(width, 2*height);
    speed = 0;
  }
  void scroll() {    
    y -= speed;
    if (y < 0) y = img1.height/2;
  }
  void display() {
    copy(img1, 0, y, img1.width, img1.height/2, 0, 0, width, height);
  }
}