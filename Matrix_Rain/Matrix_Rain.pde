/* ****************************************
 *            THE MATRIX RAIN             *
 *        by Kelvin Clark Spátola         *
 *             December 2018              *
 **************************************** */

import com.hamoid.*;
VideoExport videoExport;

ArrayList<Stream> streams = new ArrayList();
int maxStreams = 80; // 65 is ideal for (1366x768). Gotta increase this number for higher resolutions
int[] heights = new int[50];
final int FPS = 60;

void setup() {
  fullScreen(P2D);
  frameRate(FPS);
  noCursor();

  textFont(createFont("matrix code nfi.ttf", 40));
  textAlign(CENTER, CENTER);
  imageMode(CENTER);

  //setupVideoExport("The_Matrix_Rain.mp4", FPS);

  for (int i = 0; i < heights.length; i++) 
    heights[i] = -i * 31 ;

  for (int i = 0; i < maxStreams; i++) 
    streams.add(new Stream((int)random(15, 75), i* width/maxStreams +  width/(maxStreams*2), heights[(int)random(heights.length)], (int)random(5, 20)));

  background(0);
}

void draw() {
  fill(5, 15, 5, 140);
  rect(0, 0, width, height);

  for (int i = 0; i < streams.size(); i++) {
    streams.get(i).scroll();

    if (streams.get(i).isFinished()) {
      int currentX = streams.get(i).x;
      streams.remove(i);
      streams.add(new Stream((int)random(15, 75), currentX, heights[(int)random(heights.length)], (int)random(5, 20)));
    }
  }
  //videoExport.saveFrame();
  println((int)frameRate);
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  } else noLoop();
}
void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(90, 0);
  videoExport.startMovie();
}
