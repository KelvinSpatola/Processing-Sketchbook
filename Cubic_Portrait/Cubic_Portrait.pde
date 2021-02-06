/* ****************************************
 *             CUBIC PORTRAIT             *
 *        by Kelvin Clark Spátola         *
 *              January 2019              *
 **************************************** */

import processing.video.*;

ArrayList<PVector> pvDots = new ArrayList();
ArrayList<Point> points = new ArrayList();

Capture cam;

public void setup() {
  size(640, 480, FX2D);
  //fullScreen(FX2D);
  cam = new Capture(this, width, height);
  cam.start();

  int numPoints = 500;
  for (int i = 0; i < numPoints; i++) 
    points.add(new Point(new PVector(random(width), random(height)), 0.005, i < numPoints-3 ? random(30) : 50));

  background(0);
}

void draw() {
  background(0);
  //fill(0, 10);
  //rect(0, 0, width, height);

  image(cam, 0, 0);

  pvDots.clear();
  final float threshold = 105;//map(mouseX, 0, width, 10, 200);
  //println(threshold);

  cam.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = y * width + x;

      if (brightness(cam.pixels[loc]) <= threshold && brightness(cam.pixels[loc]) >= threshold - 5) {
        pvDots.add(new PVector(x, y));
      }
    }
  }

  cam.updatePixels();
  println(pvDots.size());

  //image(cam, 0, 0);
  //strokeWeight(2);
  //stroke(255);
  //for (PVector p : pvDots) point(p.x, p.y);

  showLines();

  for (Point pt : points) {
    pt.updateNoise();
    //pt.display();
  }
  //println((int)frameRate);
}
void captureEvent(Capture c) {
  c.read();
}
void keyPressed() {
  saveFrame("video_#####.png");
}

void showLines() {
  stroke(-1);
  strokeWeight(.1f);
  for (int i = 0; i < points.size(); i++) {
    for (int j = 0; j < pvDots.size(); j++) {
      if (points.get(i).isNear(pvDots.get(j))) {
        line(points.get(i).pos.x, points.get(i).pos.y, pvDots.get(j).x, pvDots.get(j).y);
      }
    }
  }
}
