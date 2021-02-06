class Akzidenz extends Page {
  PImage img2;

  Akzidenz(PApplet app, int id, String imgPath, String img2, int x, int y, int w, int h) {
    super(app, id, imgPath);

    this.img2 = loadImage(img2);
    this.img2.resize(600, 709);

    videoBtn = new Button(app, x, y, w, h);
    videoBtn.setBackgroundImage(img2);
  }

  void display() {
    pushStyle();
    imageMode(CORNER);
    tint(255, alpha);
    image(bgImg, x, y, PAGE_W, PAGE_H);

    if (isClicked) {
      background(0);
      imageMode(CENTER);
      tint(255);
      image(img2, x+width/2, height/2);
    } else if (!estiloInternacionalTipografico.goPreviousPage && !estiloInternacionalTipografico.goNextPage) videoBtn.display();

    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    text(getId(), width - 30, height - 30);

    popStyle();

    //previousPage.display();
    //nextPage.display();
  }
}
