class Page_0 extends Page {
  PImage srcImg, txtImg;
  ArrayList<Pixel> pixelGrid;
  ArrayList<PVector> pixelPos;
  final int spacing = 8;
  int brushRadius = 100;


  Page_0(int id) {
    super(id);

    txtImg = loadImage("\\pag_0\\text.png");
    txtImg.resize(width, height);
    srcImg = loadImage("\\pag_0\\snow.png");
    srcImg.resize(width, height);

    pixelGrid = new ArrayList();
    pixelPos = new ArrayList();

    for (int x = 0; x < srcImg.width; x++) {
      for (int y = 0; y < srcImg.height; y++) {
        if (x % spacing == 0 && y % spacing == 0) {
          pixelGrid.add(new Pixel(x, y, srcImg.get(x, y)));
          pixelPos.add(new PVector(x, y));
        }
      }
    }    
  }

  void display() {
    background(txtImg);

    for (Pixel p : pixelGrid) {
      p.display();
      p.update();
    }
    stroke(#FF0000);
    noFill();
    circle(mouseX, mouseY, brushRadius*2);

  }

  void mouseDragged() {
    explode(true);
  }

  void mousePressed() {
    explode(false);
  }

  // bounderies of the checking box
  float x1 = 490, y1 = 380;
  float x2 = 1450, y2 = 650;

  boolean contextCompleted() {
    int count = 0;
    for (int i = 0; i < pixelGrid.size(); i++) {
      if (pixelGrid.get(i).isInsideBox()) count++;
    }
    return count < 500;
  } 

  void explode(boolean type) {
    int explosionRange = 350;
    float mx = mouseX;
    float my = mouseY;

    for (int i = 0; i < pixelGrid.size(); i++) {
      float px = pixelGrid.get(i).pos.x;
      float py = pixelGrid.get(i).pos.y;
      float d = dist(mx, my, px, py);
      if (d <= brushRadius) {
        pixelGrid.add(pixelGrid.get(i));
        pixelGrid.remove(i);    
        pixelPos.add(pixelPos.get(i));
        pixelPos.remove(i);

        float angle = atan2(py - my, px - mx);
        float newRadius = type ? d + map(d, 0, brushRadius, explosionRange + random(explosionRange), random(explosionRange/4)) : d + random(explosionRange);
        float newX = newRadius * cos(angle) + mx;
        float newY = newRadius * sin(angle) + my;
        pixelGrid.get(pixelGrid.size()-1).setDestination(newX, newY, true, true); // true, true
        pixelGrid.get(pixelGrid.size()-1).killColor(true);
      }
    }
  }



  class Pixel {
    PVector pos, vel;
    PVector destination;

    float distX, distY, speedX, speedY;
    float speedRatio;

    boolean smooth;
    color cor, originalColor, deadColor = #EAFEFF;
    float lerpInc = 0;
    boolean killColor;

    int size = spacing - 0;

    Pixel(float x, float y, color c) {
      pos = new PVector(x, y);
      destination = pos.copy();
      vel = new PVector();
      speedRatio = 50.0f;
      cor = c;
      originalColor = cor;
    }

    void display() {
      setColor();
      push();
      translate(pos.x, pos.y);
      noStroke();
      fill(cor);
      noStroke();
      square(0, 0, size);
      pop();
    }

    void update() {
      if (pos.equals(destination) == false) { 
        if (smooth) {
          distX = destination.x - pos.x;
          distY = destination.y - pos.y;

          speedX = distX / speedRatio;
          speedY = distY / speedRatio;
        }
        vel.set(speedX, speedY);
        pos.add(vel);

        if (smooth) return;
        float d = PVector.dist(pos, destination);    
        if (d < 1) {
          vel.set(0, 0);
          pos.set(destination);
        }
      }
    }

    void setDestination(float x, float y, boolean smooth, boolean random) {
      destination = new PVector(x, y);
      this.smooth = smooth;
      speedRatio = 100.0f;
      if (random) speedRatio = random(10, 100);

      if (smooth == false) {
        distX = destination.x - pos.x;
        distY = destination.y - pos.y;

        speedX = distX / speedRatio;
        speedY = distY / speedRatio;
      }
    }

    void killColor(boolean state) {
      killColor = state;
    }

    void setColor() {
      if (killColor) {
        if (lerpInc >= 1) lerpInc = 1;
        else lerpInc += 0.05;
      } else {
        if (lerpInc <= 0) lerpInc = 0;
        else lerpInc = PVector.dist(pos, destination) * 0.1;
      }
      cor = lerpColor(originalColor, deadColor, lerpInc);
    }

    boolean isInsideBox() {
      boolean horizontal = pos.x > x1 && pos.x < x2;
      boolean vertical = pos.y > y1 && pos.y < y2;
      return horizontal && vertical;
    }
  }
}
