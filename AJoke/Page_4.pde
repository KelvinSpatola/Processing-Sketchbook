class Page_4 extends Page {

  Page_4(int id) {
    super(id);

    videoList.add(new Movie(parent, "\\pag_4\\4_1.mp4"));
    videoList.add(new Movie(parent, "\\pag_4\\4_2_som.mp4"));
    videoList.add(new Movie(parent, "\\pag_4\\4_3.mp4"));
    videoList.add(new Movie(parent, "\\pag_4\\4_4.mp4"));
    videoList.add(new Movie(parent, "\\pag_4\\4_5.mp4"));
    videoList.add(new Movie(parent, "\\pag_4\\4_6_som.mp4"));

    textList.add(loadImage("\\pag_4\\4_1 texto.png"));
    textList.add(loadImage("\\pag_4\\4_3 texto.png"));
    textList.add(loadImage("\\pag_4\\4_4 texto.png"));
    textList.add(loadImage("\\pag_4\\4_5 texto.png"));
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
        image(textList.get(0), 998, 197);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 1) {
      if (currentVideoIsFinished) {
        videoIndex++;
      }
    } else if (videoIndex == 2) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(1), 96, 497);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 3) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(2), 524, 868);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 4) {

      if (currentVideoIsFinished) {
        tint(255, fadeInText());
        image(textList.get(3), 552, 780);
      }

      if (currentVideoIsFinished && textIsFinished() && changeText) {
        textAlpha = 0;
        videoIndex++;
      }
    } else if (videoIndex == 5) {

      if (currentVideoIsFinished) {
        videoIndex++;
      }
    }

    if (videoIndex > videoList.size()-1) {
      videoIndex = videoList.size()-1;
      pageIsFinished = true;
      aJoke.pageList.get(5).contextInteraction = true;
    }
    
  }

  boolean contextCompleted() {
    return pageIsFinished;
  }
}
