
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

final char[] charTable = new char[]{
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
  'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
  'à', 'á', 'â', 'ã', 'é', 'ê', 'í', 'ó', 'ô', 'õ', 'ú', 'ç', 'ñ', 
  'À', 'Á', 'Â', 'Ã', 'É', 'Ê', 'Í', 'Ó', 'Ô', 'Õ', 'Ú', 'Ç', 'Ñ', 
};

PImage srcImg, bgImg;
ArrayList<Pixel> pixelGrid;
ArrayList<PVector> pixelPos;
final int spacing = 10;

Brush brush;

void setup() {
  fullScreen(P2D);
  // size(1200, 675, P2D);
  hint(DISABLE_DEPTH_TEST);
  //size(800, 1070, P2D);
  //noCursor();

  srcImg = loadImage("BB.jpg");
  srcImg.resize(width, height);

  // brush = brush.setupBrush(srcImg);
  //println(brush.test());
  /* int w = int(srcImg.width * 1);
   int h = int(srcImg.height * 1);
   surface.setSize(w, h);
   surface.setLocation(500,0);
   srcImg.resize(width, height); 
   */

  pixelGrid = new ArrayList();
  pixelPos = new ArrayList();


  originalState();
  //implode(true, true);
  //disperse(true, true);

  //for (int i = 0; i < 10; i++) brush(width/2, height/2, 1000, 100, true);

  println("number of pixels to draw:", pixelGrid.size());
  //setupVideoExport("women2.mp4", 30, 70);

  //last = pixelGrid.size()-1;
  last = 0;

  textFont(createFont("Space Mono Bold", spacing + 5));
  textAlign(CENTER, CENTER);
  background(0);
}

int last;
void draw() {
  background(0);
  //fill(0, 50);
  //rect(0, 0, width, height);

  /*  for (Pixel p : pixelGrid) {
   p.update();
   p.display();
   } */

  /* // build-up horizontal
   for (int i = 0; i < last && i < pixelGrid.size(); i++) {
   pixelGrid.get(i).update();
   noStroke();
   fill(pixelGrid.get(i).pixelColor());
   square(pixelGrid.get(i).pos().x, pixelGrid.get(i).pos().y, pixelGrid.get(i).size());
   }
   
   if (last >= pixelGrid.size()-1) last = pixelGrid.size()-1;
   else last += 20; */


  for (Pixel p : pixelGrid) {
    p.update();
    p.display();
    //noStroke();
    //fill(p.pixelColor());
    //square(p.pos().x, p.pos().y, p.size());
    //text(p.pixelChar(), p.pos().x, p.pos().y);
  } 

  //videoExport.saveFrame(); 

  stroke(#FF0000);
  noFill();
  circle(mouseX, mouseY, 100*2);

  //fps();
}

void mouseDragged() {
  brush(mouseX, mouseY, 100, 300, false);
}

void mousePressed() {
  brush(mouseX, mouseY, 100, 300, false);
}

void keyPressed() {
  if (key == ' ') explode(1000);
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
