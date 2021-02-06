/* ****************************************
 *           ORGANIC PIXEL NET            *
 *        by Kelvin Clark Spátola         *
 *             December 2018              *
 **************************************** */


import com.hamoid.*;
VideoExport videoExport;

Point[] points = new Point[550];
PVector[] cir = new PVector[points.length/2];
PImage light;

float cX, cY;
float redCircle = 375;

void setup() {
  fullScreen();
  noCursor();

  //setupVideoExport("hd_video_v3.mp4", 60, 95);

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
  float alpha = 255 - abs(cos(frameCount * radians(0.8)) * 255);
  color from = color(255, 0, 0);
  color to = color(#64ECFF);
  color finalColor = lerpColor(from, to, map(alpha, 0, 255, 0, 1));

  background(0);
  /* noStroke();
   fill(0, 100);
   rect(0, 0, width, height); */
  tint(255, alpha);
  image(light, 0, 0);

  for (int i = 0; i < points.length; i++) {
    float distToCenter = dist(points[i].pos.x, points[i].pos.y, cX, cY);
    float size = map(distToCenter, 200, 0, 6, 17);

    for (int j = 0; j < cir.length; j++) {

      // circunferencia vermelha
      if (i != j && j % 2 == 0 && points[i].isNear(cir[j], 55)) {
        strokeWeight(6);
        stroke(#FA2217, 10);
        line(points[i].pos.x, points[i].pos.y, cir[j].x, cir[j].y);

        strokeWeight(3);
        stroke(#FA2217, 30);
        line(points[i].pos.x, points[i].pos.y, cir[j].x, cir[j].y);

        strokeWeight(.3f);
        stroke(#FA2217);
        line(points[i].pos.x, points[i].pos.y, cir[j].x, cir[j].y);
      }

      // por dentro da circunferencia vermelha
      if (i != j && distToCenter <= redCircle-65 && points[i].isNear(points[j])) {
        if (distToCenter < 150) {
          noStroke();
          
          color glow = lerpColor(to, color(255), map(size, 6, 17, 0, 1));

          fill(255, map(size, 7, 17, 0, 50));
          circle(points[i].pos.x, points[i].pos.y, size+6);
          circle(points[j].pos.x, points[j].pos.y, size+6);

          fill(255, map(size, 7, 17, 0, 15));
          circle(points[i].pos.x, points[i].pos.y, size+3);
          circle(points[j].pos.x, points[j].pos.y, size+3);

          fill(glow, map(distToCenter, 0, 165, 255, 0));
          circle(points[i].pos.x, points[i].pos.y, size);
          circle(points[j].pos.x, points[j].pos.y, size);
          
        } else {
          strokeWeight(map(alpha, 0, 255, 0.1f, 0.5f));
          stroke(finalColor, 160);
          line(points[i].pos.x, points[i].pos.y, points[j].pos.x, points[j].pos.y);

          noStroke();
          fill(finalColor, 30);
          circle(points[i].pos.x, points[i].pos.y, 6);
          circle(points[j].pos.x, points[j].pos.y, 6);
        }
      }
    }
    points[i].update();
    if (distToCenter > redCircle) points[i].display();
  }

  //videoExport.saveFrame();
  //fps();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
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
  text((int)frameRate, 50, 50);
  pop();
}
