
import processing.video.*;
import processing.sound.*;

import ddf.minim.Minim;
import ddf.minim.AudioPlayer;

void displayFps() {
  push();
  textSize(50);
  fill(#FF0000);
  text((int)frameRate, 50, 50);
  pop();
}

boolean startLoading, bookIsReady;
int loadingProgress = 0;

void loadBook() {
  startLoading = true;
  aJoke = new Book();
  bookIsReady = true;
}

void loadingScreen() {
  push();
  tint(255, loadingProgress);
  image(cover, 0, 0);
  pop();
  loadingProgress++;
}

void movieEvent(Movie m) {
  m.read();
}
