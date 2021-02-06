
void originalState() {
  for (int x = 0; x < srcImg.width; x++) {
    for (int y = 0; y < srcImg.height; y++) {
      if (x % spacing == 0 && y % spacing == 0 && alpha(srcImg.get(x, y)) != 0) {     
        pixelGrid.add(new Pixel(x, y, srcImg.get(x, y)));
        pixelPos.add(new PVector(x, y));
      }
    }
  }
}

void disperse(boolean smooth, boolean random) {
  float val = 0;
  for (int x = 0; x < srcImg.width; x++) {
    for (int y = 0; y < srcImg.height; y++) {

      if (x % spacing == 0 && y % spacing == 0 && alpha(srcImg.get(x, y)) > 5) {
        float xx = 0;
        float yy = y;// + random(-val, val);
        pixelGrid.add(new Pixel(x, y, srcImg.get(x, y)));
        pixelPos.add(new PVector(xx, yy));
      }
    }
  }

  for (int i = 0; i < pixelGrid.size(); i++) {
    pixelGrid.get(i).setDestination(pixelPos.get(i).x, pixelPos.get(i).y, smooth, random);
  }
}

void explode(int intensity) {
  for (Pixel p : pixelGrid) {  
    float x = p.pos.x + random(-intensity, intensity);
    float y = p.pos.y + random(-intensity, intensity);
    p.setDestination(x, y, true, true);
  }
}

void rearrange() {
  for (int i = 0; i < pixelGrid.size(); i++) {
    pixelGrid.get(i).setDestination(pixelPos.get(i).x, pixelPos.get(i).y, false, false);
  }
}
