class Page_3 extends Page {

  Page_3(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_3\\3_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_3\\3_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_3\\3_3.mp4"));
    videoList.add(new Movie(parent, "\\pag_3\\3_4.mp4"));
    videoList.add(new Movie(parent, "\\pag_3\\3_5.mp4"));

    textList.add(loadImage("\\pag_3\\3_1 texto.png"));
    textList.add(loadImage("\\pag_3\\3_2 texto.png"));
    textList.add(loadImage("\\pag_3\\3_3 texto.png"));
    textList.add(loadImage("\\pag_3\\3_4 texto.png"));
  }

  void display() {
    videoList.get(videoIndex).play();
    tint(255);
    image(videoList.get(videoIndex), 0, 0);
    snowFalling.render();

    boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

    if (videoIndex == 0) {
      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(0), 976, 411);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 1) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 551, 431);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 2) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(2), 143, 710);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 3) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(3), 925, 800);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex = 4;
      }
    } else if (videoIndex == 4) {

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
