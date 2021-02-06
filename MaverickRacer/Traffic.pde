class Traffic {
  PImage img;  
  float x, y, w, h;
  float speedY;

  Traffic() {
    img = loadImage("bentley.png");
    img.resize(30, 0);

    this.y = -100;
    this.w = 40;
    this.h = 60;
    this.x = sortRoad();
    this.speedY = velocity();
    rectMode(CENTER);
  }
  float velocity() {
    float speed = map(road.speed, 0, player.max_speed, 0, 15);
    return speed;
  }
  void scrollVelocity() {
    y += velocity();
  }
  float sortRoad() {
    int num = int(random(4));
    float x = 0;
    if (num == 0) x = width/5;
    else if (num == 1) x = 2*width/5;   
    else if (num == 2) x = 3*width/5;  
    else if (num == 3) x = 4*width/5;
    return x;
  }
  boolean isOffScreen() {
    return y > height;
  }
  void display() {
    //rect(x, y, w, h);
    imageMode(CENTER);
    image(img, x, y);
  }
  void run() {
    display();
    scrollVelocity();
  }
}
