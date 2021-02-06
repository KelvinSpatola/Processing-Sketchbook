
/* ****************************************
 *             MOVING PIXELS              *
 *        by Kelvin Clark Spátola         *
 *             December 2019              *
 
 TODO:
 - colisão entre pixeis?
 
 - função shuffle -> a ideia é baralhar os pixeis dentro do ArrayList (pixelPos) para que eles comecem 
 em ordem baralhada, mas dentro da grelha de pixeis. No fundo estarão apenas começando em posiçoes trocadas,
 mas com efeito diferente do implode(), onde os pixeis partem de posiçoes aleatorias por todo o espaço.
 
 - Classe Brush!!!!!!!!
 **************************************** */


import com.hamoid.*;
VideoExport videoExport;

import java.util.Collections;

PImage srcImg, bgImg;
ArrayList<Pixel> pixelGrid;
ArrayList<PVector> pixelPos;
final int spacing = 5;

Brush brush;

void setup() {
  fullScreen(P2D);
  hint(DISABLE_DEPTH_TEST);

  srcImg = loadImage("foto.png");
  srcImg.resize(width, height);
  
  pixelGrid = new ArrayList();
  pixelPos = new ArrayList();


  //originalState();
  implode(true, true);
  ///disperse(true, true);

  println("number of pixels to draw:", pixelGrid.size());
  //setupVideoExport("text.mp4", 60, 50);

  last = 0;
}

int last;
void draw() {
  background(0);


  /*  for (Pixel p : pixelGrid) {
   p.update();
   p.display();
   } */

  /* // build-up horizontal
   for (int i = 0; i < last && i < pixelGrid.size(); i++) {
   pixelGrid.get(i).display();
   pixelGrid.get(i).update();
   }
   
   if (last >= pixelGrid.size()-1) last = pixelGrid.size()-1;
   else last += 10;
   */

  for (Pixel p : pixelGrid) {
    p.update();
    noStroke();
    fill(p.pixelColor());
    square(p.pos().x, p.pos().y, p.size());
    //text(p.pixelChar(), p.pos().x, p.pos().y);
  } 

  //videoExport.saveFrame(); 

  stroke(#FF0000);
  noFill();
  circle(mouseX, mouseY, 100*2);

  //fps();
}

void mouseDragged() {
  if (mouseButton == RIGHT) brush(mouseX, mouseY, 100, 300, false);
  if (mouseButton == LEFT)  brush(mouseX, mouseY, 100, 300, true);
}

void mousePressed() {
  if (mouseButton == RIGHT) brush(mouseX, mouseY, 100, 300, false);
  if (mouseButton == LEFT)  brush(mouseX, mouseY, 100, 300, true);
}

void keyPressed() {
  if (key == ' ') explode(50);
  if (key == 'b') for (int i = 0; i < 10; i++) brush(width/2, height/2, 1000, 1000, true);
  if (key == 'm') rearrange();
  if (key == ENTER) setup();
  if (key == 'p') save("img_"+frameCount+".png");

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
  fill(255);
  rect(50, 0, 60, 50);
  fill(#FF0000);
  text((int)frameRate, 50, 50);
  pop();
}
