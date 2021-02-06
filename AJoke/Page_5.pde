class Page_5 extends Page {
  PImage bgImg;
  PVector[] site = new PVector[6];
  ArrayList<Footstep> feet = new ArrayList();
  int index;
  boolean switchFoot = false;


  Page_5(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_5\\5_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_5\\5_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_5\\5_3.mp4"));
    videoList.add(new Movie(parent, "\\pag_5\\5_4.mp4"));

    textList.add(loadImage("\\pag_5\\5_1 texto.png"));
    textList.add(loadImage("\\pag_5\\5_2 texto.png"));
    textList.add(loadImage("\\pag_5\\5_3 texto.png"));

    bgImg = loadImage("\\pag_5\\snow.png");
    site[0] = new PVector(113, 595);
    site[1] = new PVector(396, 399);
    site[2] = new PVector(852, 649);
    site[3] = new PVector(1180, 408);
    site[4] = new PVector(1625, 557);
    site[5] = new PVector(2000, 557);
    
    contextInteraction = false;
  }

  void mousePressed() {
    if (contextInteraction) {
      switchFoot = !switchFoot;
      feet.add(new Footstep(mouseX, mouseY, switchFoot));
      if (index >= site.length -1) {
        index = site.length-1;
        contextInteraction = false;
      } else index++;
    }
    changeText = true;
  }

  void display() {

    if (contextInteraction) {
      image(bgImg, 0, 0);
      push();
      fill(255, 50);
      circle(site[index].x, site[index].y, 100);
      for (Footstep f : feet) f.display();
      pop();
    } else {
      videoList.get(videoIndex).play();
      tint(255);
      image(videoList.get(videoIndex), 0, 0);
      snowFalling.render();

      boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

      if (videoIndex == 0) {
        if (currentVideoIsFinished) {
          tint(255, fadeInText());
          image(textList.get(0), 538, 110);
        }

        if (currentVideoIsFinished && textIsFinished() && changeText) {
          textAlpha = 0;
          videoIndex++;
        }
      } else if (videoIndex == 1) {
        if (currentVideoIsFinished) {
          tint(255, fadeInText());
          image(textList.get(1), 183, 860);
        }

        if (currentVideoIsFinished && textIsFinished() && changeText) {
          textAlpha = 0;
          videoIndex++;
        }
      } else if (videoIndex == 2) {
        if (currentVideoIsFinished) {
          tint(255, fadeInText());
          image(textList.get(2), 1008, 860);
        }

        if (currentVideoIsFinished && textIsFinished() && changeText) {
          textAlpha = 0;
          videoIndex++;
        }
      } else if (videoIndex == 3) {

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


  class Footstep {
    PImage leftFoot, rightFoot, theImg;
    PVector pos;
    float angle;
    AudioPlayer audio;

    Footstep(float x, float y, boolean foot) {
      leftFoot = loadImage("\\pag_5\\pegada esquerda.png");
      rightFoot = loadImage("\\pag_5\\pegada direita.png");
      theImg = rightFoot;
      pos = new PVector(x, y);
      theImg = foot ? rightFoot : leftFoot;
      audio = theMinim.loadFile("\\pag_5\\pegada.mp3");
      audio.play();
    }

    void display() {
      push();
      imageMode(CENTER);
      image(theImg, pos.x, pos.y);
      pop();
    }
  }
}
