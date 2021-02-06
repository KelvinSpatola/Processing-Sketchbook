
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

void implode(boolean smooth, boolean random) {
  for (int x = 0; x < srcImg.width; x++) {
    for (int y = 0; y < srcImg.height; y++) {

      if (x % spacing == 0 && y % spacing == 0  && alpha(srcImg.get(x, y)) > 5) {
        float xx = random(-5*width, 6*width);
        float yy = random(-5*height, 6*height);
        pixelGrid.add(new Pixel(xx, yy, srcImg.get(x, y)));
        pixelPos.add(new PVector(x, y));
      }
    }
  }

  for (int i = 0; i < pixelGrid.size(); i++) {
    pixelGrid.get(i).setDestination(pixelPos.get(i).x, pixelPos.get(i).y, smooth, random);
  }
}

void disperse(boolean smooth, boolean random) {
  float val = 10;
  for (int x = 0; x < srcImg.width; x++) {
    for (int y = 0; y < srcImg.height; y++) {

      if (x % spacing == 0 && y % spacing == 0 && alpha(srcImg.get(x, y)) > 5) {
        float xx = x + random(-val, val); // -150
        float yy = y + random(-val, val);
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
    pixelGrid.get(i).setDestination(pixelPos.get(i).x, pixelPos.get(i).y, true, false);
  }
}

void brush(float x, float y, int size, int intensity, boolean type) { // size = 300
  for (int i = 0; i < pixelGrid.size(); i++) {
    float px = pixelGrid.get(i).pos.x;
    float py = pixelGrid.get(i).pos.y;
    float d = dist(x, y, px, py);

    if (d <= size) {
      pixelGrid.add(pixelGrid.get(i));
      pixelGrid.remove(i);    
      pixelPos.add(pixelPos.get(i));
      pixelPos.remove(i);

      float angle = atan2(py - y, px - x);
      float newRadius = type ? d + map(d, 0, size, intensity + random(intensity), random(intensity/4)) : d + random(intensity);
      float newX = newRadius * cos(angle) + x;
      float newY = newRadius * sin(angle) + y;
      pixelGrid.get(pixelGrid.size()-1).setDestination(newX, newY, true, true); // true, true
      //pixelGrid.get(pixelGrid.size()-1).setDestination(px, random(height, height + height/2), true, true); // true, true
    }
  }
}
