
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
final int spacing = 2;

PGraphics pg;

void setup() {
  fullScreen(P2D);
  //size(800, 1070, P2D);
  //noCursor();

  srcImg = loadImage("kelvin2.png");
  srcImg.resize(height, width);

  //surface.setLocation(100, 10);

  //bgImg = loadImage("k.png");
  //bgImg.resize(width, height);
  //pg = createGraphics(width, height);

  pixelGrid = new ArrayList();
  pixelPos = new ArrayList();


  //originalState();
  disperse(false, true);

  println("number of squares to draw:", pixelGrid.size());

  //  setupVideoExport("pixelSorting8.mp4", 60, 90);

  background(255);

  //last = pixelGrid.size()-1;
  last = 0;
}

int last;
void draw() {
  //background(255);

  // pixel sorting (baixo p/ cima)

  translate(0, height);
  rotate(PI+HALF_PI);

  for (Pixel p : pixelGrid) p.display();
  for (int i = 0; i < last && i < pixelGrid.size(); i++) pixelGrid.get(i).update();

  if (last >= pixelGrid.size()-1) last = pixelGrid.size()-1;
  else last += 150; 


  // pixel sorting (cima p/ baixo)
  /* fill(255, 10);
   rect(0, 0, width, height);
   translate(0, height);
   rotate(PI+HALF_PI);
   
   for (Pixel p : pixelGrid) p.display();
   for (int i = pixelGrid.size()-1; i >= 0 && i > last; i--) {
   pixelGrid.get(i).update();
   if (pixelGrid.get(i).isDead) pixelGrid.remove(i);
   }
   
   if (last <= 0) last = 0;
   else last -= 100; */


  // usar com a fotografia da cara
  /*// pixel sorting (cima p/ baixo)
   background(bgImg);
   
   pg.beginDraw();
   //pg.clear();
   pg.translate(0, height);
   pg.rotate(PI+HALF_PI);
   
   for (Pixel p : pixelGrid) p.display();
   for (int i = pixelGrid.size()-1; i >= 0 && i > last; i--) {
   pixelGrid.get(i).update();
   if (pixelGrid.get(i).isDead) pixelGrid.remove(i);
   }
   
   if (last <= 0) last = 0;
   else last -= 50;
   */

  // pixel sorting (baixo p/ cima)
  /*background(bgImg);
   
   pg.beginDraw();
   //pg.clear();
   pg.translate(0, height);
   pg.rotate(PI+HALF_PI);
   
   for (Pixel p : pixelGrid) p.display();
   for (int i = 0; i < last && i < pixelGrid.size(); i++) {
   pixelGrid.get(i).update();
   if (pixelGrid.get(i).isDead) pixelGrid.remove(i);
   }
   
   if (last >= pixelGrid.size()-1) last = pixelGrid.size()-1;
   else last += 40;
   */

  /*for (Pixel p : pixelGrid) {
   p.update();
   p.display();
   }*/

  // pg.endDraw();
  //image(pg, 0, 0);

  //videoExport.saveFrame();
}

void keyPressed() {
  if (key == ' ') explode(30);
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
