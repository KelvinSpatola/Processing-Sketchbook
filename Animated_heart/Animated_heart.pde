/* ****************************************
 *             ANIMATED HEART             *
 *        by Kelvin Clark Spátola         *
 *             February 2019              *
 **************************************** */

import com.hamoid.*;
VideoExport videoExport;

Heart[] hearts = new Heart[150];

void setup() {
  fullScreen(P2D);
  noCursor();
  //setupVideoExport("Animated_heart.mp4", 60, 90);

  float red = 0;
  for (int i = hearts.length-1; i >= 0; i--) {
    hearts[i] = new Heart(500-i*2, 5+i*0.3, i%2==0? 1 : -1, color(red, 0, 0), map(i, hearts.length-1, 0, 1, 5));
    red += 1.7;
  }
  //strokeWeight(7);
}

void draw() {
  background(0);
  translate(width/2, height/2-50);

  for (Heart h : hearts) {
    h.render();
    h.update();
  }

  //videoExport.saveFrame();

  println((int)frameRate);
}

//void keyPressed() {
//  if (key == 'q') {
//    videoExport.endMovie();
//    exit();
//  }
//}
void setupVideoExport(String fileName, int fps, int kk) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(kk, 0);
  videoExport.startMovie();
}
