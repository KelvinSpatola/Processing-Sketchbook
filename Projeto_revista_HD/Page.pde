class Page {

  final int PAGE_W;
  final int PAGE_H;
  final int PAGE_HALF_W;
  final int PAGE_HALF_H;

  int x, y, alpha = 255;
  int slideSpeed = 75, alphaSpeed = 15;
  boolean transitionFinished, isSlidingIn = true;

  PImage bgImg;
  int pageId;

  //Button previousPage, nextPage, videoBtn;
  boolean isClicked = false;
Button videoBtn;  

  //Button[] indexesBtns = new Button[15];
  //String[] pageNames = {"Editorial", "Prólogo", "Video (Intro)", "Ernst Keller", "Armin Hofmann", "Sistemas de Grelha", "Emil Ruder", 
  //  "Akzidenz Grotesk", "Max Bill", "Adrian Frutiger", "Univers", "Joseph Muller Brockman", "Die Neue GrafiK", "Max Miedinger", "Helvetica"};

  Movie mov;

  // CONSTRUCTOR
  Page(PApplet app, int id, String imgPath) {
    pageId = id;
    bgImg = loadImage(imgPath);
    bgImg.resize(width, height);

    PAGE_W = width;
    PAGE_H = height;
    PAGE_HALF_W = PAGE_W / 2;
    PAGE_HALF_H = PAGE_H / 2;


    //previousPage = new Button(app, 50, 50, 100, 100);
    //previousPage.setBackgroundImage("/botoes/previousSmall.png", "/botoes/previousLarge.png");

    //nextPage = new Button(app, width-50, 50, 100, 100);
    //nextPage.setBackgroundImage("/botoes/nextSmall.png", "/botoes/nextLarge.png");
  }

  void display() {
    pushStyle();
    tint(255, alpha);
    image(bgImg, x, y, PAGE_W, PAGE_H);

    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    text(getId(), width - 30, height - 30);

    popStyle();

    //previousPage.display();
    //nextPage.display();
  }

  void transitionPrevious() {
    slidePrevious();
  }
  void transitionNext() {
    slideNext();
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

  void resetPage() {
    x = 0;
    alpha = 255;
  }

  int getId() {
    return pageId;
  }
}
