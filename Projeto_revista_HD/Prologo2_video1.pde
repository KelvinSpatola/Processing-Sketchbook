class Prologo2 extends Page {
  int frameW, frameH;

  Prologo2(PApplet app, int id, String imgPath, String videoPath) {
    super(app, id, imgPath);

    mov = new Movie(app, videoPath);
    frameW = 1280/2;
    frameH = 720/2;

    videoBtn = new Button(app, width/2, height/2, frameW, frameH);
    videoBtn.setBackgroundImage("/botoes/video1_normal.jpg", "/botoes/video1_clicked.jpg");
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
      image(mov, x+width/2, height/2, frameW*1.5, frameH*1.5);
    } else if(!estiloInternacionalTipografico.goPreviousPage && !estiloInternacionalTipografico.goNextPage) videoBtn.display();

    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    text(getId(), width - 30, height - 30);

    popStyle();

    //previousPage.display();
    //nextPage.display();
  }

  void resetPage() {
    x = 0;
    alpha = 255;
    isClicked = false;
    mov.stop();
  }
}
