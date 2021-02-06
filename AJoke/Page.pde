abstract class Page {

  final int PAGE_W;
  final int PAGE_H;

  int pageId;
  int x, y;

  int alpha = 255;
  int textAlpha = 0;

  int slideSpeed = 75, alphaSpeed = 15;
  boolean transitionFinished, isSlidingIn = true;

  boolean pageIsFinished, changeText, contextInteraction;
  ;

  ArrayList<Movie> videoList = new ArrayList();
  int videoIndex;

  ArrayList<PImage> textList = new ArrayList();
  int textIndex;

  SnowFalling snowFalling;
  Wind wind;


  // CONSTRUCTOR
  Page(int id) {
    pageId = id;

    PAGE_W = width;
    PAGE_H = height;

    snowFalling = new SnowFalling();
    wind = new Wind();

    contextInteraction = false;

    videoIndex = 0;
    textIndex = 0;
  }

  abstract void display();

  void showPagination() {
    push();
    textSize(50);
    fill(0);
    text(pageId, width - 50, height - 50);
    pop();
  }

  void transitionToPreviousPage() {
    //slidePrevious();
  }
  void transitionToNextPage() {
    //slideNext();
  }

  boolean contextCompleted() {
    return false;
  }

  int fadeInText() {
    if (textAlpha >= 255) textAlpha = 255;
    else textAlpha += 3;
    return textAlpha;
  }

  boolean textIsFinished() {
    return textAlpha >= 255;
  }

  void mouseDragged() {
  }

  void mousePressed() {
    changeText = true;
  }

  void mouseReleased() {
    changeText = false;
  }

  void slideNext() {   
    x -= slideSpeed;
    if (x + PAGE_W < 0) transitionFinished = true;
    else transitionFinished = false;
  }
  void slidePrevious() {   
    x += slideSpeed;
    if (x > width) transitionFinished = true;
    else transitionFinished = false;
  }  

  void fadeOut() {
    alpha -= alphaSpeed;
    if (alpha <= 0) transitionFinished = true;
    else transitionFinished = false;
  }

  void slideIn() {
    if (x + PAGE_W <= 0) {
      isSlidingIn = false;
      x = 0;
    } else x -= slideSpeed;
  }

  void reset() {
    videoIndex = 0;
    textIndex = 0;
    pageIsFinished = false;
    for (Movie m : videoList) m.stop();
    snowFalling = new SnowFalling();
    contextInteraction = false;
  }
}
