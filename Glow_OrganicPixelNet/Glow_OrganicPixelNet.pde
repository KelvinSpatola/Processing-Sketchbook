/* ****************************************
 *           ORGANIC PIXEL NET            *
 *        by Kelvin Clark Spátola         *
 *             December 2018              *
 **************************************** */


import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;
import com.hamoid.*;

VideoExport videoExport;

DwPixelFlow context;
DwFilter filter;

PGraphics2D pg_a, pg_b; // just another buffer for temporary results


Point[] points = new Point[500];
PVector[] cir = new PVector[points.length/2];
PImage light;

float cX, cY;
float redCircle = 375;

void setup() {
  fullScreen(P2D);
  noCursor();

  setupVideoExport("hd_video_v6.mp4", 60, 95);

  context = new DwPixelFlow(this);
  filter = DwFilter.get(context);

  pg_a = (PGraphics2D) createGraphics(width, height, P2D);
  pg_b = (PGraphics2D) createGraphics(width, height, P2D);

  light = loadImage("light.png");
  light.resize(width, height);

  cX = width/2;
  cY = height/2;

  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(random(.0004f, .004f), i % 100 == 0 ? 120 : (int)random(35, 55));
  }

  for (int i = 0; i < cir.length; i++) {
    float x = redCircle * sin(i * TWO_PI / cir.length) + cX;
    float y = redCircle * cos(i * TWO_PI / cir.length) + cY;
    cir[i] = new PVector(x, y);
  }
}

void draw() {
  float lightStep = oscillate(0, frameCount, 1020, 0.01);
  //float val = constrain(lightStep, 0, 255);
  float alpha = constrain(lightStep, 0, 255);//255 - abs(cos(frameCount * radians(0.8)) * 255);
  color from = color(255, 0, 0);
  color to = color(#00E3FF);
  color finalColor = lerpColor(from, to, map(lightStep, -510, 510, 0, 1));

  pg_a.beginDraw();
  {
    pg_a.background(0);
    pg_a.tint(255, alpha);
    pg_a.image(light, 0, 0);

    for (int i = 0; i < points.length; i++) {
      float distToCenter = dist(points[i].pos.x, points[i].pos.y, cX, cY);
      float size = map(distToCenter, 200, 0, 6, 17);

      for (int j = 0; j < cir.length; j++) {

        // circunferencia vermelha
        if (i != j && j % 2 == 0 && points[i].isNear(cir[j], (int)map(alpha, 0, 255, 55, 200))) { //55
          pg_a.stroke(#FA2217);
          pg_a.line(points[i].pos.x, points[i].pos.y, cir[j].x, cir[j].y);
        }

        // por dentro da circunferencia vermelha
        if (i != j && distToCenter <= redCircle-65 && points[i].isNear(points[j])) {
          if (distToCenter < 150) {
            color glow = lerpColor(to, color(255), map(size, 6, 17, 0, 1));

            pg_a.noStroke();
            pg_a.fill(glow, map(distToCenter, 0, 165, 255, 0));
            pg_a.circle(points[i].pos.x, points[i].pos.y, size);
            pg_a.circle(points[j].pos.x, points[j].pos.y, size);
          } else {
            pg_a.strokeWeight(map(alpha, 0, 255, 0.3f, 1f));
            pg_a.stroke(finalColor);
            pg_a.line(points[i].pos.x, points[i].pos.y, points[j].pos.x, points[j].pos.y);

            pg_a.noStroke();
            pg_a.fill(finalColor, 30);
            pg_a.circle(points[i].pos.x, points[i].pos.y, 6);
            pg_a.circle(points[j].pos.x, points[j].pos.y, 6);
          }
        }
      }
      points[i].update();
      if (distToCenter > redCircle) {
        points[i].display();
        points[i].size = map(alpha, 0, 255, 3, 10);
      }
    }
  }
  pg_a.endDraw();

  pg_b.beginDraw();
  pg_b.clear();
  pg_b.endDraw();

  filter.bloom.param.mult   = map(lightStep, -510, 510, 1, 10);//6;//map(mouseX, 0, width, 0, 10);
  filter.bloom.param.radius = 1; //map(mouseY, 0, height, 0, 1);

  filter.luminance_threshold.param.threshold = 0.3f;
  filter.luminance_threshold.param.exponent = 10;

  filter.luminance_threshold.apply(pg_a, pg_b);
  filter.bloom.apply(pg_b, pg_b, pg_a);

  image(pg_a, 0, 0);
  println((int) frameRate);

  //videoExport.saveFrame();
  fps();

 // if (frameCount >= 1800) {
   // videoExport.endMovie();
   // exit();
  //}
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

float oscillate(float target, float time, float range, float scale) {
  return (float)(Math.cos(time * scale) * range/2 + target);
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}

void fps() {
  push();
  textSize(50);
  fill(#FF0000);
  text((frameCount * 100) / 1800, 50, 50);
  pop();
}
