class Tile {
  int size, zoom = 400;
  float x, y, speedX, speedY;

  Tile(float x, float y, int size, int speedX, int speedY) {
    this.x = x; 
    this.y = y;
    this.size = size;
    this.speedX = speedX;
    this.speedY = speedY;
  }

  Tile update() {
    x += speedX;
    y += speedY;
    if (x < size/2 || x > width-size/2) speedX = -speedX;
    if (y < size/2 || y > height-size/2) speedY = -speedY;
    return this;
  }

  Tile render() {
    int xx = (int)map(x, 0, width, 0, srcImg.width);
    int yy = (int)map(y, 0, height, 0, srcImg.height);
    copy(srcImg, xx-zoom/2, yy-zoom/2, zoom, zoom, (int)x-size/2, (int)y-size/2, size, size);

    //noFill();
    //stroke(100);
    //square(x, y, size);
    return this;
  }
}
