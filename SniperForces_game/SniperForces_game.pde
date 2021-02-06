// *********** SNIPER FORCES ********** // 
// ****** Created by Kelvin Clark ***** //
// ************************************ //

import ddf.minim.*;
Minim myMinim;

Landscape landscape;
TargetListHandler targetList;
SniperRifle sniper;

void settings() {
  size(int(1366*0.7), int(768*0.7), P2D);
  //fullScreen(P2D);
}
void setup() {
  noCursor();

  landscape = new Landscape();
  targetList = new TargetListHandler(20);
  sniper = new SniperRifle(this, targetList);
}
void draw() {
  landscape.display();
  targetList.display();  
  sniper.display();

  //println((int)frameRate);
}
void mouseReleased() {
  if (mouseButton == LEFT) sniper.shoot();
  if (mouseButton == RIGHT) sniper.changeZoom();
}
void keyPressed() {
  if (key == ' ') {
    targetList = new TargetListHandler(10);
    sniper.targetList = targetList;
  }
  if (key == 'a') targetList.addTarget(5);
}
