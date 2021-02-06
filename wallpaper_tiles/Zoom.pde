class Tile {
  int size = 200;
  int zoom = size;
  float x, y, speedX, speedY, distance;
  int inc, index;

  Tile(float x, float y, int size, int inc, int speedX, int speedY, float distance, int index) {
    this.speedX = speedX;
    this.speedY = speedY;
    this.size = size;
    this.inc = inc;
    this.x = x; 
    this.y = y;
    this.distance = distance;
    this.index = index;
  }

  void update() {
    x += speedX;
    y += speedY;
    if (x < 0 || x > width) speedX = -speedX;
    if (y < 0 || y > height) speedY = -speedY;
  }
  
  void render() {
    noStroke();
    fill(0, 120);
    square(x+distance, y+distance, size); 

    int xx = (int)map(x, 0, width, 0, srcImg.width);
    int yy = (int)map(y, 0, height, 0, srcImg.height);
    copy(srcImg, xx-(zoom+inc)/2, yy-(zoom+inc)/2, zoom, zoom, (int)x-size/2, (int)y-size/2, size, size);

    //noFill();
    float alpha = map(index, 0, tiles.length-1, 255, 0);
    fill(0, alpha);
    //stroke(100);
    noStroke();
    rect(x, y, size, size);
  }
}
