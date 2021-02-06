// ** FIFTEEN PUZZLE **
// PROJETO FEITO POR:
// KELVIN CLARK SPÁTOLA - Nº 2017230108
// PEDRO PINTO TAVARES - Nº 2017269091
// DOCENTE RESPONSÁVEL: FERNANDO AMÍLCAR BANDEIRA CARDOSO
// UNIVERSIDADE DE COIMBRA - LICENCIATURA EM DESIGN E MULTIMÉDIA - 2017/2018 - DISCIPLINA DE PROGRAMAÇÃO E MULTIMÉDIA

import processing.video.*;
import processing.sound.*;
import ddf.minim.*;
import javax.swing.*; 
import java.io.File;

AudioIn in;
Amplitude amp;
Minim myMinim;
Capture capture;
Movie optionsVid;

Game game;

public void setup() {
  size(600, 600);
  myMinim = new Minim(this);
  capture = new Capture(this, 640, 480);
  optionsVid = new Movie(this, "Menu Files/Videos/OptionsMenu.mp4");
  game = new Game();
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
}
public void draw() {
  game.run();
}
public void keyPressed() {
  game.key_INTERFACE(key);
}
public void mousePressed() {
  game.mouse_INTERFACE(mouseX, mouseY);
}
public void movieEvent(Movie optionsVid) {
  optionsVid.read();
}
