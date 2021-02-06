/* *****************************************
 *                "A JOKE"                 *
 *                   by                    *
 *                                         *
 * Kelvin Spátola                          *
 * Artem Basok                             *
 * Ricardo Marques                         *
 * Pedro Tavares                           *
 *                                         *
 *            december 2019                *
 ******************************************/

PApplet parent;
Minim theMinim;

Book aJoke;
PImage cover;

void setup() {
  fullScreen();
  background(255);
  frameRate(1000);
  parent = this;
  cover = loadImage("\\pag_0\\snow.png");
  theMinim = new Minim(parent);

  thread("loadBook");
}

void draw() {
  if (bookIsReady) {
    aJoke.read();
  } else {
    loadingScreen();
  }

  //displayFps();
}

void keyPressed() {
  if (bookIsReady) aJoke.changePage();
  if (key == ENTER) setup();
}

void mousePressed() {
  if (bookIsReady) aJoke.mousePressed();
}

void mouseReleased() {
  if (bookIsReady) aJoke.mouseReleased();
}

void mouseDragged() {
  if (bookIsReady) aJoke.mouseDragged();
}
