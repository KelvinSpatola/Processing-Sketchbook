class Page_8 extends Page {

  Page_8(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_8\\8_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_8\\8_2.mp4"));

    textList.add(loadImage("\\pag_8\\8_1 texto.png"));
    textList.add(loadImage("\\pag_8\\8_2 texto.png"));
  }

  void display() {
    videoList.get(videoIndex).play();
    tint(255);
    image(videoList.get(videoIndex), 0, 0);

    boolean currentVideoIsFinished = (videoList.get(videoIndex).time() >= videoList.get(videoIndex).duration()-0.1);

    if (videoIndex == 0) {
      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(0), 367, 80);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 1) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 657, 94);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
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
