class Page_2 extends Page {

  Page_2(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_2\\2_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_2\\2_2_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_2\\2_2_2.mp4"));
    videoList.add(new Movie(parent, "\\pag_2\\2_3_som.mp4"));

    textList.add(loadImage("\\pag_2\\2_1_1 texto.png"));
    textList.add(loadImage("\\pag_2\\2_2_a texto.png"));
    textList.add(loadImage("\\pag_2\\2_2_b texto.png"));
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
        image(textList.get(0), 539, 894);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 1) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 260, 260);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 2) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(2), 551, 147);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 3) {

      tint(255);
      image(textList.get(2), 551, 147);

      if (currentVideoIsFinished) {
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
