class Landscape {
  PImage img;
  int size = 300;
  int zoom = size;

  Landscape() {
    img = loadImage("Landscape - city2.jpg");
  } 

  void display() {
    pushStyle();
    if (sniper.crosshair.zoomLevel == 0) {
      image(img, 0, 0, width, height);
    } else {
      int xx = (int)map(mouseX, 0, width, 0, img.width);
      int yy = (int)map(mouseY, 0, height, 0, img.height);

      int srcSize = zoom / (sniper.crosshair.zoomLevel == 1 ? 1 : 2);

      background(0);
      copy(img, xx-srcSize/2, yy-srcSize/2, srcSize, srcSize, 
        mouseX-size/2, mouseY-size/2, size, size);
    }
    popStyle();
  }
}
