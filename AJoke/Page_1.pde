class Page_1 extends Page {

  Page_1(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_1\\1_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_1\\1_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_1\\1_3.mp4"));
    videoList.add(new Movie(parent, "\\pag_1\\1_4.mp4"));
    videoList.add(new Movie(parent, "\\pag_1\\1_5.mp4"));

    textList.add(loadImage("\\pag_1\\1_2 texto.png"));
    textList.add(loadImage("\\pag_1\\1_3 texto.png"));
    textList.add(loadImage("\\pag_1\\1_4 texto juntos no monte.png"));

  }

  void display() {
    wind.update();
    videoList.get(videoIndex).play();
    tint(255);
    image(videoList.get(videoIndex), 0, 0);
    snowFalling.render();

    boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

    if (videoIndex == 0 || videoIndex == 1) {
      if (currentVideoIsFinished || videoIndex == 1) {
        tint(255, fadeInText());
        image(textList.get(0), 650, 300);
      }

      if (wind.blow() && currentVideoIsFinished) {
        videoIndex = 1;
        if (currentVideoIsFinished) videoList.get(videoIndex).stop();
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex = 2;
      }
    } else if (videoIndex == 2) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 711, 959);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex = 3;
      }
    } else if (videoIndex == 3) {
      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(2), 551, 147);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex = 4;
      }
    } else if (videoIndex == 4) {
      if (currentVideoIsFinished) videoIndex++;
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
