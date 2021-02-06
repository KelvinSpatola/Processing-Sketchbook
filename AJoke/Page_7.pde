class Page_7 extends Page {
  PImage mountains, girl, fence, boy, light;
  float x0, x1, x2, x3;
  float zoomInc = 1;
  PImage love;

  Page_7(int id) {
    super(id);

    mountains = loadImage("\\pag_7\\montanhas.png");
    girl = loadImage("\\pag_7\\rapariga.png");
    fence = loadImage("\\pag_7\\cerca.png");
    boy = loadImage("\\pag_7\\fig.png");
    light = loadImage("\\pag_7\\light.png");

    videoList.add(new Movie(parent, "\\pag_7\\7_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_7\\7_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_7\\7_3.mp4"));

    textList.add(loadImage("\\pag_7\\7_1 texto.png"));
    textList.add(loadImage("\\pag_7\\7_1_1 texto.png"));
    textList.add(loadImage("\\pag_7\\7_2 texto.png"));

    love = loadImage("\\pag_7\\i love you nadya texto.png");
    contextInteraction = true;
  }

  int gray = 255;
  boolean loveYou;

  void display() {
    if (contextInteraction) {
      push();
      if (mousePressed) {
        imageMode(CENTER);
        translate(width/2, height/2);
        scale(zoomInc);
        zoomInc += 0.1;
        x0 -= 2;
        gray -= 15;
        if (zoomInc > 1.7) contextInteraction = false;
      } else {
        zoomInc = 1;
        x0 = 0;
        gray = 255;
        imageMode(CORNER);
        translate(0, 0);
      }

      float parallaxRatio = map(mouseX, -width/2, 0, -30, 30);
      tint(gray);
      image(mountains, x3 + parallaxRatio * 0.1, 0);
      tint(255);
      image(girl, x2 + parallaxRatio * 0.2, 0);
      tint(gray);
      image(fence, x1 + parallaxRatio * 0.4, 0);
      image(boy, x0 + parallaxRatio, 0);
      image(light, 0, 0);
      pop();

      translate(0, 0);
      image(textList.get(0), 150, 150);
    } else {
      videoList.get(videoIndex).play();
      tint(255);
      image(videoList.get(videoIndex), 0, 0);

      boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

      if (videoIndex == 0 && loveYou == false) {
        if (currentVideoIsFinished) {
          tint(255, fadeInText());
          image(textList.get(1), 1159, 835);
        }

        if (currentVideoIsFinished && textIsFinished() && changeText) {
          textAlpha = 0;
          loveYou = true;
        }
      } else if (videoIndex == 0 && loveYou) {
        background(255);
        push();
        imageMode(CENTER);
        tint(255, fadeInText());
        image(love, width/2, height/2);
        pop();

        if (textIsFinished() && changeText) {
          textAlpha = 0;
          videoIndex++;
        }
      } else if (videoIndex == 1) {
        if (currentVideoIsFinished) {
          tint(255, fadeInText());
          image(textList.get(2), 874, 512);
        }

        if (currentVideoIsFinished && textIsFinished() && changeText) {
          textAlpha = 0;
          videoIndex++;
        }
      } else if (videoIndex == 2) {
        if (currentVideoIsFinished) {
          videoIndex++;
        }
      } 

      if (videoIndex > videoList.size()-1) {
        videoIndex = videoList.size()-1;
        pageIsFinished = true;
      }
    }
  }

  boolean contextCompleted() {
    return pageIsFinished;
  }
}
