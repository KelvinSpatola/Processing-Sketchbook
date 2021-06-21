/* ******************************************** /
 *  UNIVERSIDADE DE COIMBRA                     *
 *  LICENCIATURA EM DESIGN E MULTIMÉDIA         *
 *                                              *
 *  TIPOGRAFIA EM MEIOS DIGITAIS                *
 *  SETEMBRO DE 2019                            *
 *  META 1                                      *
 *                                              *
 *                 "FRUSTRAÇÃO"                 *
 *           por KELVIN CLARK SPÁTOLA           *
 *                  2017230108                  *
 / ******************************************** */

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.AudioPlayer;

Minim minim;
Gain gain;
AudioOutput out;
TickRate rateControl;
FilePlayer bassSound;
FilePlayer clockTick;
float rate;

Character[] chars;

final String TEXT = "FRUSTRATION";
final int[] KERNING = {7, -5, -5, -3, 1, -4, -2, 2, 15, -4, -5}; // ADJUSTING THE KERNING ("FRUSTRATION")
//final int[] KERNING = {7, -4, -4, -2, 3, -4, -2, -4, -1, -4, 0}; // ADJUSTING THE KERNING ("FRUSTRAÇÃO")
float LEFT_MARGIN;

int timer = 0;
final int TIME_LIMIT = 2000;
float vibrationX, vibrationY;
boolean shake = false;

public void setup() {
  fullScreen();

  minim = new Minim(this);
  bassSound = new FilePlayer(minim.loadFileStream("Low Bass.mp3"));
  clockTick = new FilePlayer(minim.loadFileStream("clock-tick.mp3"));

  gain = new Gain(0.f);
  out = minim.getLineOut();
  bassSound.patch(gain).patch(out);

  rateControl = new TickRate(1.f);
  out = minim.getLineOut();
  clockTick.patch(rateControl).patch(out);
  rate = 1f;

  chars = new Character[TEXT.length()];

  textFont(createFont("impact", 150));
  textAlign(CENTER, CENTER);

  LEFT_MARGIN = width/2 - textWidth(TEXT) * 0.47;

  float xx = LEFT_MARGIN;
  for (int i = 0; i < TEXT.length(); i++) {
    char c = TEXT.charAt(i);

    float w = textWidth(c);
    if (i > 0) xx += w;

    chars[i] = new Character(c, xx + KERNING[i], height/2, 0);
  }
}

public void draw() {
  float GB = map(timer, 0, TIME_LIMIT, 255, 0);
  background(255, GB, GB);

  bassSound.play();
  gain.setValue(map(timer, 0, TIME_LIMIT, -40, 5));

  clockTick.play();
  rateControl.value.setLastValue(rate);

  /* 
   * ******* BACKGROUNG TEXT ******* 
   */

  float xx = LEFT_MARGIN;
  for (int i = 0; i < TEXT.length(); i++) {
    char c = TEXT.charAt(i);
    float w = textWidth(c);
    if (i > 0) xx += w;

    fill((mousePressed && mouseX >= xx - w/2 && mouseX <= xx + w/2) ? color(23, 187, 206, 110) : color(0, 40));
    text(c, xx + KERNING[i] + vibrationX, height/2 - chars[i].charHeight * .28 + vibrationY);
  }


  /* 
   * ******* RENDERING, UPDATING AND CHECKING FOR COLLISIONS ******* 
   */

  for (int i = 0; i < chars.length; i++) {
    if (timer >= 40) chars[i].update();
    chars[i].render();

    for (int j = 0; j < chars.length; j++) {
      if (i != j && chars[i].intersects(chars[j].pos.x, chars[j].pos.y)) {
        chars[i].changeDirection(chars[j]);
        chars[i].playCollisionSFX();

        if (chars[i].vel.x == 0 && chars[i].vel.y == 0) {
          chars[i].vel.set(1, 1);
          chars[i].rot = random(-radians(2), radians(2));
        }
      }
    }

    // ********** VIBRATION ********** // 

    if (timer >= TIME_LIMIT/2) {
      chars[i].vibrate(timer, TIME_LIMIT/2, TIME_LIMIT, 5);
      rate = map(timer, TIME_LIMIT/2, TIME_LIMIT, 1f, 1.5f);
      shake = true;
    }
  }

  if (shake) {
    if (frameCount % 3 == 0) vibrationX = -1;
    if (frameCount % 4 == 0) vibrationX = 1;
    if (frameCount % 5 == 0) vibrationY = -1;
    if (frameCount % 6 == 0) vibrationY = 1;
  }

  /* 
   * ******* MOUSE INTERACTION ******* 
   */

  for (int i = 0; i < chars.length; i++) {
    if (mousePressed && chars[i].intersects(mouseX, mouseY)) {
      chars[i].pos.x = mouseX;
      chars[i].pos.y = mouseY;
      chars[i].vel.set(0, 0);
      chars[i].angle = 0;
      chars[i].rot = 0;
      break;
    }
  }


  /* 
   * ******* BACKGROUNG TIMER / RESET EVERYTHING ******* 
   */

  if (timer >= TIME_LIMIT) reset();
  else timer++;

  println((int) frameRate);
}

void reset() {
  timer = 0;
  bassSound.pause();
  bassSound.rewind();
  clockTick.pause();
  clockTick.rewind();
  vibrationX = 0;
  vibrationY = 0;
  shake = false;
  setup();
}

void keyPressed() {
  if (key == ' ') reset();
}
