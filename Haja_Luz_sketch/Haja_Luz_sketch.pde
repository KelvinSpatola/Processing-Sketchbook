/* ****************************************
 *               HAJA LUZ                 *
 *        by Kelvin Clark Spátola         *
 *             December 2019              *
 **************************************** */

import com.hamoid.*;
VideoExport videoExport;

String TEXT = "HELLO";
ArrayList<Text> texts = new ArrayList();

float fontColor = 0;
float bgColor = 255;

void setup() {
  fullScreen(P3D);
  hint(DISABLE_DEPTH_TEST);
  noCursor();
  textFont(createFont("Montserrat SemiBold", 100));
  //setupVideoExport("exportedVideo_hi-res.mp4", 60);
}

void draw() {
  background(bgColor);
  translate(width/2, height/2); 

  for (int i = 0; i < 45; i++) 
    texts.add(new Text(TEXT));


  for (int i = 0; i < texts.size(); i++) {
    texts.get(i).update();
    texts.get(i).display();
    if (texts.get(i).pos.z > width || texts.get(i).pos.x < -width*1.5 || texts.get(i).pos.x > width*1.5
      || texts.get(i).pos.y < -height*1.5 || texts.get(i).pos.y > height*1.5) 
      texts.remove(i); // removing the texts as soon as they pass behind the viewers sight
  }

  //videoExport.saveFrame(); 
}

void keyPressed() {
  if (key == 's') save("img_"+frameCount+".png");
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
  if (key == 't') noLoop();
}

void switchColors(int val) {
  if (fontColor >= 255) fontColor = 255;
  else fontColor += val;

  bgColor = map(fontColor, 0, 255, 255, 0);
}

void setupVideoExport(String fileName, int fps) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(90, 0);
  videoExport.startMovie();
}

void fps() {
  push();
  textSize(50);
  fill(#FF0000);
  text((int)frameRate, 50, 50);
  pop();
}
