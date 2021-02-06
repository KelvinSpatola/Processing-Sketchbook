class Page_6 extends Page {

  Page_6(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_6\\6_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_6\\6_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_6\\6_3.mp4"));
    videoList.add(new Movie(parent, "\\pag_6\\6_4.mp4"));
    videoList.add(new Movie(parent, "\\pag_6\\6_5.mp4"));
    videoList.add(new Movie(parent, "\\pag_6\\6_6.mp4"));

    textList.add(loadImage("\\pag_6\\6_1 texto.png"));
    textList.add(loadImage("\\pag_6\\6_2 texto.png"));
    textList.add(loadImage("\\pag_6\\6_4 texto.png"));
  }

  void display() {
    wind.update();
    videoList.get(videoIndex).play();
    tint(255);
    image(videoList.get(videoIndex), 0, 0);
    snowFalling.render();

    boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

    if (videoIndex == 0) {
      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(0), 127, 116);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 1) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 263, 164);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 2) {
      if (currentVideoIsFinished) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 3 || videoIndex == 4) {
      if (currentVideoIsFinished || videoIndex == 4) {
        tint(255, fadeInText());
        image(textList.get(2), 551, 150);
      }

      if (wind.blow() && currentVideoIsFinished) {
        videoIndex = 4;
        if (currentVideoIsFinished) videoList.get(videoIndex).stop();
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex = 5;
      }
    } else if (videoIndex == 5) {

      if (currentVideoIsFinished) {
        videoIndex++;
      }
    }


    if (videoIndex > videoList.size()-1) {
      videoIndex = videoList.size()-1;
      pageIsFinished = true;
    }
  }

  boolean contextCompleted() {
    return pageIsFinished;
  }
}
