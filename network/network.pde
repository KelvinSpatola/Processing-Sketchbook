
Point[] points = new Point[200]; 

void setup() {
  fullScreen(FX2D); // FX2D works better for this sketch
  
  for (int i = 0; i < points.length; i++)
    points[i] = new Point(random(width), random(height), 0.002f, 50);
}

void draw() {
  background(0);
  stroke(#45DFE3);
  strokeWeight(0.3f);

  for (int i = 0; i < points.length; i++) {
    points[i].update();

    for (int j = 0; j < points.length; j++) {
      if (i != j && points[i].isNear(points[j])) {
        line(points[i].x, points[i].y, points[j].x, points[j].y);
        points[i].show();
      }
    }
  }
  //println((int) frameRate);
}
