/* *************************************************** /
 *            PROJETO DE HISTÓRIA DO DESIGN            *
 *               *** REVISTA DIGITAL ***               *
 *                      2018/2019                      *
 * --------------------------------------------------- *
 *           ESTILO TIPOGRÁFICO INTERNACIONAL          *
 * --------------------------------------------------- *
 *                     autores:                        *
 *        Kelvin Spátola  (programação/conteúdo)       *
 *        Francisco Silva      (design/conteúdo)       *
 *        Mariana Silva        (design/conteúdo)       *
 *        Rafael Lopes         (design/conteúdo)       *
 * *************************************************** */

import processing.video.*;
//Movie mov;

Revista estiloInternacionalTipografico;

public void setup() {
  fullScreen();
  //mov = new Movie(this, "/videos/International Typographic Style.mp4");

  estiloInternacionalTipografico = new Revista(this);
}

public void draw() {
  background(255);
  estiloInternacionalTipografico.ler();

  println((int)frameRate);
}


public void mousePressed() {
  estiloInternacionalTipografico.mousePressedContext();
  estiloInternacionalTipografico.mudarPagina();
}
public void keyPressed() {
  estiloInternacionalTipografico.keyPressedContext();
}
void movieEvent(Movie m) {
  m.read();
}
